Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C78CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89487208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89487208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0PH-0006Iy-OC
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iP0OO-0004wa-Mb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iP0OL-0003XD-VA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:28:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iP0OL-0003WN-La
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:28:45 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B488D3688E
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:28:43 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id u23so10122611qtb.22
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 01:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0d6tHsZ6xj7MncVChi2UMTdxKJ1Dhsfr4PdJX86n9PE=;
 b=nn0ewV9aDp20veI2/b0Ay+KQNEGKd7bn5tlJNkhHZgIR0K7hoR+zp0XXn+RGvx+gRy
 TolY/XaTrtI7t+xN2ILr53ALqn25faFZuA3bPfJL40vJ1zt+kG6koFZPaJV+P1QqD/ud
 6HfhGXi/VloQTLDKckeQ7vfII4hYE+2Gk6kVwL1FVRtlZ5esmOh3T6uJuPhoY8/yP6bO
 fE6gSBvBfigZixpt3P3vHIl/luejTYPtMDIkRkxWdlapcFLC89VYEDQOhlJcNKr3bfu8
 V6fW3GHjvl2KnMd5fksludix40uoXKkz80qajyqyNeMT/HAhkdOQhN/Uoqpz26hyPsr+
 hL6g==
X-Gm-Message-State: APjAAAX8gBGiud8pLTpE1/ob+kP4bjD4wMa9m/7ln11E53oOk2fsDQKz
 vXDVkr0wtDNpiwLtwvgtJQVfYQpFOQ6wtKzaG4AaJVWUMIBcSED4WMRQRKeCsLm0SxDlgOKGUQE
 e5WclusTzvDv0//g=
X-Received: by 2002:a0c:eda9:: with SMTP id h9mr1914663qvr.41.1572251322985;
 Mon, 28 Oct 2019 01:28:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKICV1hgQVg6QMNOdCvcA3eRj2FfsiWKX8EXyv4rbgWqrjHUMNvsCmeXLdzvuC5cD6QpBC8g==
X-Received: by 2002:a0c:eda9:: with SMTP id h9mr1914644qvr.41.1572251322701;
 Mon, 28 Oct 2019 01:28:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 x26sm5104286qto.21.2019.10.28.01.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 01:28:41 -0700 (PDT)
Date: Mon, 28 Oct 2019 04:28:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v20 0/5] Add ARMv8 RAS virtualization support in QEMU
Message-ID: <20191028042645-mutt-send-email-mst@kernel.org>
References: <20191026032447.20088-1-zhengxiang9@huawei.com>
 <20191027061450-mutt-send-email-mst@kernel.org>
 <6c44268a-2676-3fa1-226d-29877b21dbea@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c44268a-2676-3fa1-226d-29877b21dbea@huawei.com>
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 wanghaibin.wang@huawei.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm@nongnu.org, james.morse@arm.com,
 jonathan.cameron@huawei.com, imammedo@redhat.com, pbonzini@redhat.com,
 xuwei5@huawei.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 12:01:34PM +0800, gengdongjiu wrote:
> Hi Michael/All
> 
> On 2019/10/27 18:17, Michael S. Tsirkin wrote:
> > On Sat, Oct 26, 2019 at 11:24:42AM +0800, Xiang Zheng wrote:
> >> In the ARMv8 platform, the CPU error types are synchronous external abort(SEA)
> >> and SError Interrupt (SEI). If exception happens in guest, sometimes it's better
> >> for guest to perform the recovery, because host does not know the detailed
> >> information of guest. For example, if an exception happens in a user-space
> >> application within guest, host does not know which application encounters
> >> errors.
> >>
> >> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
> >> After user space gets the notification, it will record the CPER into guest GHES
> >> buffer and inject an exception or IRQ into guest.
> >>
> >> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
> >> treat it as a synchronous exception, and notify guest with ARMv8 SEA
> >> notification type after recording CPER into guest.
> >>
> >> This series of patches are based on Qemu 4.1, which include two parts:
> >> 1. Generate APEI/GHES table.
> >> 2. Handle the SIGBUS signal, record the CPER in runtime and fill it into guest
> >>    memory, then notify guest according to the type of SIGBUS.
> >>
> >> The whole solution was suggested by James(james.morse@arm.com); The solution of
> >> APEI section was suggested by Laszlo(lersek@redhat.com).
> >> Show some discussions in [1].
> >>
> >> This series of patches have already been tested on ARM64 platform with RAS
> >> feature enabled:
> >> Show the APEI part verification result in [2].
> >> Show the BUS_MCEERR_AR SIGBUS handling verification result in [3].
> > 
> > This looks mostly OK to me.  I sent some minor style comments but they
> > can be addressed by follow up patches.
> > 
> > Maybe it's a good idea to merge this before soft freeze to make sure it
> > gets some testing.  I'll leave this decision to the ARM maintainer.  For
> > ACPI parts:
> > 
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Got it, Thanks for the Reviewed-by from Michael.
> 
> Hi Michael,
>   According to discussion with QEMU community, I finished and developed the whole ARM RAS virtualization solution, and introduce the ARM APEI table in the first time.
> For the newly created files, which are mainly about ARM APEI/GHES part,I would like to maintain them. If you agree it, whether I can add new maintainers[1]? thanks a lot.
> 
> 
> [1]:
> +ARM APEI Subsystem
> +M: Dongjiu Geng <gengdongjiu@huawei.com>
> +M: Xiang zheng <zhengxiang9@huawei.com>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/acpi/acpi_ghes.c
> +F: include/hw/acpi/acpi_ghes.h
> +F: docs/specs/acpi_hest_ghes.rst
> 

I think for now you want to be a designated reviewer.  So I'd use an R:
tag.

> > 
> > 
> >> ---

