Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA846C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14C7206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14C7206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIcsr-0007AE-SZ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 14:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIcro-0005uR-Qi
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIcrn-00040V-Pi
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIcrn-00040N-HP
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:08:47 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A64712BF73
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 18:08:46 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o8so2962188wmc.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fQDz1oDruGyS52AzLiEXTpW1VZB4PAAKFZAgQe0HdRk=;
 b=V6S7cjwuCS+UrKnxq1QwkBlT/RgxYzmNS79tojna4nBIMbJcG2sJcW0/t02t/nggHd
 o3UFkWSgB9511TjLRaBg8MzQ9MMQnNm9HjVeF8PEq0ntECYe5krSZO/0PguKuWimuTke
 +/cPz9fZwzfeC4W6V+USfba5yKmKYWyj5kwFD11DCcAB2rQC69jeiibVIwQYmNvz2QpL
 4vXQK6ULHFqKUCC+Kl0sSiHLJn1nrqFli6QOzXm5mN4BgyIDTrNy6BYgsYPdAcxfwDxL
 DLEDCu6Cs5VqAGS3aqsM+yIOfD4Yy652JjzD8L96qjca/6VFhI4aalVeDXcklev1l4kQ
 3Vyg==
X-Gm-Message-State: APjAAAXEWkvFmbUsQpddBdDQFl1iQ/dfrhP9Xmx3OQa3OAw+IOYjRHrf
 6haeRnItUvhZVu18rm+Hw6qO9vBd0V2q5JhW9oX7QtBpciW3I7kXgwP/PiBT+T7e0uz21v7e2/K
 isnjcjjZTQXSKU4s=
X-Received: by 2002:a5d:420c:: with SMTP id n12mr9320095wrq.85.1570730925458; 
 Thu, 10 Oct 2019 11:08:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAVC8K25Hk6J9oAD1JUH47vm1yJmhG9q+EzO/SlDnxqOz9zXCc4QzTBI2g/PfFPILwG8v5dg==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr9320083wrq.85.1570730925271; 
 Thu, 10 Oct 2019 11:08:45 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 i7sm8965518wrm.87.2019.10.10.11.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 11:08:44 -0700 (PDT)
Date: Thu, 10 Oct 2019 14:08:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
Message-ID: <20191010140724-mutt-send-email-mst@kernel.org>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <20191008175931.483af366@redhat.com>
 <20191010055733-mutt-send-email-mst@kernel.org>
 <20191010144812.20fd8b5d@redhat.com>
 <0032ef80-4e75-5802-8a7a-098e9ff57cfa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0032ef80-4e75-5802-8a7a-098e9ff57cfa@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 06:23:00PM +0200, Laszlo Ersek wrote:
> On 10/10/19 14:48, Igor Mammedov wrote:
> 
> > it doesn't really matter if it's ACPI blob or fw_cfg,
> > what firmware needs is a table of possible CPUs with APIC IDs.
> 
> To repeat my previous point:
> 
> Not necessarily taking sides between "data table" and "register block",
> but *if* we opt for "data table", then it *must* be fw_cfg.
> 
> > But if we go this route (i.e. not reuse CPU hotplug interface),
> > the table alone is not enough, one would need to build a protocol
> > between ACPI and firmware to communicate what CPUs to (un)hotplug.
> 
> That's for sure, yes -- for finding out what CPU has been hotplugged,
> the hotplug SMI handler in the firmware has to look at the register
> block no matter what.

I thought all that's done by ACPI, with ACPI returning an event
to the OSPM reporting what happened.

> The "data table" vs "register block" question only arises *afterwards*,
> for translating the CPU selector (fetched from the register block) to
> the APIC-ID domain. (The generic edk2 infrastructure requires APIC-IDs).
> 
> Thanks
> Laszlo

