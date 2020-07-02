Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A565DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD8420B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpGXh3R0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD8420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxKa-0007Mh-NY
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqx9n-0005do-TW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:13:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqx9l-0002U5-RW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ts/IKAR1Odacoug5bc4yiBc2GKdluDPA2i+GTwsTGM=;
 b=JpGXh3R0J1268XIjtqjOiEHERqcfuQcPcYr0LuBxSbSybkFfRClhELToP0ZmmAxcvEy6aM
 PUM3h6xpF+J7x7OJ2vqdknRaao+Fn+WRB3fvmjZF7dkrewinLpMn/oOvVozP1Brx+5CiMD
 OGNp2Po3pUqR1Fl0QKHnRfIuG8hyccQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-vnAPGc-_MumQnhimi6MOrQ-1; Thu, 02 Jul 2020 07:13:27 -0400
X-MC-Unique: vnAPGc-_MumQnhimi6MOrQ-1
Received: by mail-wr1-f70.google.com with SMTP id j5so25097109wro.6
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 04:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2ts/IKAR1Odacoug5bc4yiBc2GKdluDPA2i+GTwsTGM=;
 b=lICIQN4BeaMcnuRLWkXH9XBYI5nga1ar1s2AXpN5WjamaD6RDni8JK3inJllcQ9u3I
 Fq4QeTMzw/rFBWq3ariYETu4x+7X9KslHdj9QiNqryx/tVFCA5gm8s9AOD6wLfbZZh94
 L+UQdZNTeMJ1e0UeHATbXaxZWI/qytWf35dboHDhSce/ZORbATYIRKNTYYrsQzFOtqDG
 ArjUN3DK0KketOThjk5g8P9Gh15J6dEHeId53lPYkPx2omhZ1Cy8l1YIDZOrZPbkJou3
 gq1DNicQqCJDqE8EOUqjd4FCHFdmyLHayumsRgkZIjErN/7OQKXOGZkD/Ca2VEU3Ngol
 F62w==
X-Gm-Message-State: AOAM531zCtQC77bglAEvmru+VF10pQRMAMYJl0Tdfqu/ZHho6tU5jePR
 bQsefzK303+m0w9cLBVtjzxKxqcEVQqf6MgoGD3uQB7cKj05cjl/AUsedl7ZMrhgbLeb/qvE8F+
 wUH/pb8NXgAFSTGg=
X-Received: by 2002:a05:6000:1cf:: with SMTP id
 t15mr33491098wrx.180.1593688406495; 
 Thu, 02 Jul 2020 04:13:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnwjFEPDLnHYVj+OCZZXjwUyzNmrVUqpAZpqXfEMbPBAXsyDsTE45AHE9ls+SuPAWAlghymQ==
X-Received: by 2002:a05:6000:1cf:: with SMTP id
 t15mr33491072wrx.180.1593688406292; 
 Thu, 02 Jul 2020 04:13:26 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id m16sm5526947wro.0.2020.07.02.04.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 04:13:25 -0700 (PDT)
Date: Thu, 2 Jul 2020 07:13:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200702071308-mutt-send-email-mst@kernel.org>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
 <20200702055245-mutt-send-email-mst@kernel.org>
 <CAFEAcA8EWAnXQ_9_S_7G0yY5EUJp0qshEPmpVuFf8943qfzn4Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8EWAnXQ_9_S_7G0yY5EUJp0qshEPmpVuFf8943qfzn4Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Andrew Jones <drjones@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 ard.biesheuvel@arm.com, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 11:16:03AM +0100, Peter Maydell wrote:
> On Thu, 2 Jul 2020 at 10:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 29, 2020 at 04:09:37PM +0200, Andrew Jones wrote:
> > > The flash device is exclusively for the host-controlled firmware, so
> > > we should not expose it to the OS. Exposing it risks the OS messing
> > > with it, which could break firmware runtime services and surprise the
> > > OS when all its changes disappear after reboot.
> > >
> > > As firmware needs the device and uses DT, we leave the device exposed
> > > there. It's up to firmware to remove the nodes from DT before sending
> > > it on to the OS. However, there's no need to force firmware to remove
> > > tables from ACPI (which it doesn't know how to do anyway), so we
> > > simply don't add the tables in the first place. But, as we've been
> > > adding the tables for quite some time and don't want to change the
> > > default hardware exposed to versioned machines, then we only stop
> > > exposing the flash device tables for 5.1 and later machine types.
> > >
> > > Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> >
> > So who's merging this? Mostly ACPI things so I guess my tree?
> > If so can I get acks from ARM maintainers pls?
> 
> This is on my to-look-at queue but in theory I'm on holiday this week :-)
> 
> -- PMM

I picked up patch 1 for now :)

-- 
MST


