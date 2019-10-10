Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF7DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66CF206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66CF206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZmP-0004B3-QF
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIZlW-0003D3-9x
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIZlS-0007zV-FR
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50697)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIZlS-0007yo-6f
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:50:02 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA8CD3C919
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 14:50:00 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id o34so5946621qtf.22
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 07:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D9P2x8khvleJxoMsMwWaZQfUZ3Ws1agI574y32w8VbQ=;
 b=lf8jzj/+PEIPmraHS7Po4JhEaA4nh6GJwyIR2gjZ3BhFxgmLujMtIKMHqIaftk6jkd
 XITFc4MdEjcVRgLwRvfrGGeWlFgixCJzEVI/8ww3a1IRb2/PJn8t74/NdG+BjmogJHf/
 P+EP87Y4Yv0a5jZtjoXy527XlFWFOT1XJg1RWp4qMtPOhlI4ZNY6NSTEO02deLkZqd1/
 eRGl0OXt+GlSdM9/Rnz8QupLO7yPANLod5nk+zHrsB9qLp3w0vJvqnJirdpex6pdX6Wg
 63cw6rSRMp2z0K7L+r05peN8jJ6bpIVU1dFO4b1utEf1TI0TN/neZKQX/xrV76tAQcdv
 s/aQ==
X-Gm-Message-State: APjAAAXreaC6xufENTP/3t3YaZnwIc9mcAboM7sobKvGGGiHfPT11qU/
 GoEK8pTsyORwq59Mh9ELs6JAvJ5SD1fCuE4AExtJ/4M6kqT6zxYSDsLKi/6NvO3Nmf8OHfe7CuX
 KFRJ6YBsa2yqrDT8=
X-Received: by 2002:a37:6d04:: with SMTP id i4mr10293852qkc.88.1570718999991; 
 Thu, 10 Oct 2019 07:49:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyXQlOrOrLSgLQR2e9k2IVv7wMraC7EmudSPCvvcC7OQlaQUuoZxhP7lJomtyeqn0ILM12EA==
X-Received: by 2002:a37:6d04:: with SMTP id i4mr10293824qkc.88.1570718999717; 
 Thu, 10 Oct 2019 07:49:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 v4sm2280524qkj.28.2019.10.10.07.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 07:49:58 -0700 (PDT)
Date: Thu, 10 Oct 2019 10:49:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
Message-ID: <20191010104818-mutt-send-email-mst@kernel.org>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
 <20191010141652.GD21666@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010141652.GD21666@habkost.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 11:16:52AM -0300, Eduardo Habkost wrote:
> On Thu, Oct 10, 2019 at 03:39:12PM +0200, Igor Mammedov wrote:
> > On Thu, 10 Oct 2019 05:56:55 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Wed, Oct 09, 2019 at 09:22:49AM -0400, Igor Mammedov wrote:
> > > > As an alternative to passing to firmware topology info via new fwcfg files
> > > > so it could recreate APIC IDs based on it and order CPUs are enumerated,
> > > > 
> > > > extend CPU hotplug interface to return APIC ID as response to the new command
> > > > CPHP_GET_CPU_ID_CMD.  
> > > 
> > > One big piece missing here is motivation:
> > I thought the only willing reader was Laszlo (who is aware of context)
> > so I skipped on details and confused others :/
> > 
> > > Who's going to use this interface?
> > In current state it's for firmware, since ACPI tables can cheat
> > by having APIC IDs statically built in.
> > 
> > If we were creating CPU objects in ACPI dynamically
> > we would be using this command as well. It would save
> > us quite a bit space in ACPI blob but it would be a pain
> > to debug and diagnose problems in ACPI tables, so I'd rather
> > stay with static CPU descriptions in ACPI tables for the sake
> > of maintenance.
> > 
> > > So far CPU hotplug was used by the ACPI, so we didn't
> > > really commit to a fixed interface too strongly.
> > > 
> > > Is this a replacement to Laszlo's fw cfg interface?
> > > If yes is the idea that OVMF going to depend on CPU hotplug directly then?
> > > It does not depend on it now, does it?
> > It doesn't, but then it doesn't support cpu hotplug,
> > OVMF(SMM) needs to cooperate with QEMU "and" ACPI tables to perform
> > the task and using the same interface/code path between all involved
> > parties makes the task easier with the least amount of duplicated
> > interfaces and more robust.
> > 
> > Re-implementing alternative interface for firmware (fwcfg or what not)
> > would work as well, but it's only question of time when ACPI and
> > this new interface disagree on how world works and process falls
> > apart.
> > 
> > > If answers to all of the above is yes, then I don't really like it: it
> > > is better to keep all paravirt stuff in one place, namely in fw cfg.
> > Lets discuss, what cpu hotplug fwcfg interface could look like in 
> >  [PATCH 3/4] hw/i386: add facility to expose CPU topology over  fw-cfg
> > mail thread and clarify (dis)likes with concrete reasons.
> > 
> > So far I managed to convince myself that we ought to reuse
> > and extend current CPU hotplug interface with firmware features,
> > to endup with consolidated cpu hotplug process without
> > introducing duplicate ABIs, but I could be wrong so
> > lets see if fwcfg will be the better approach.
> > 
> 
> I was more inclined towards the approach in this patch, because I
> see it as just a bug fix in the CPU hotplug interface (which
> should have been using the hardware CPU identifier as the CPU
> selector since the beginning).

Well if ACPI is going to be using this, then that's different.
Igor do you see any need for that?

> Providing the missing information in fw_cfg isn't necessarily
> bad, but please document it explicitly as a
>   hotplug_cpu_selector => cpu_hardware_id
> mapping, so people won't use "CPU index" as a generic identifier
> elsewhere.
> 
> -- 
> Eduardo

