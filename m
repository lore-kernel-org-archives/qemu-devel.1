Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B5EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D30220734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgAVXbc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D30220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifJI-0005Dy-9I
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jifFz-0001Eg-Cu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:29:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jifFy-0002Fn-D8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591712977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0USdHpMbKzoYHsGne0Lo5roc61VBs0kn/4rmMW0QFzQ=;
 b=BgAVXbc3X0IIM4uYXsViIviqrJ0T4I3XbXosla4eWzkh9i8B84FX4vIRassY0p566Zi2cU
 g4dMFukDLDz4dUUZb/0ydwIjR5VHZZTMo6BvzTU+Qcq/x2eZ3TAcRaq3O92gVWzMngKWae
 bcrehGZaY3Y7tfZjUZlurT/SfFt3ULg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-3p_YCs7tPiuBpLopkwgcQQ-1; Tue, 09 Jun 2020 10:29:36 -0400
X-MC-Unique: 3p_YCs7tPiuBpLopkwgcQQ-1
Received: by mail-wr1-f70.google.com with SMTP id w16so8673232wru.18
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 07:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0USdHpMbKzoYHsGne0Lo5roc61VBs0kn/4rmMW0QFzQ=;
 b=gn1Vjo6Cqi/Iw7pNpDGXVvQnzkXFeuJBapvgORFkcE4ysAnrNzq5jYaxQkEoYNuwjM
 ZBUFUVplBepmNGh2iWbIzoNgthGWa/mjzCJgsRO8ylHGSRV6qhw7UfBPu55RCDB9NBlH
 sVV/Fo89fmnAIeWNnzBr7s7CVVNvzfOKQlPIIofzBFiFQrIqWmXsysGVVFqqUrFAo/Iw
 LbxtWVH2AdLLW3frVluUpqU5GUmfdsGumzwdzuPIXLsbzEuuw4+vySEY6rISGKpiTvVY
 TVIWo1cX+hGqflH2Eiq/9o6aZMYLbzC4U5on0vUCip5DNEHFIarIR7itoX+uxl85POtL
 5gug==
X-Gm-Message-State: AOAM533zUmM1irlKUTCnxLy1R0rb7J85/fzxyE9Epef6ZFqcXbniAuLP
 QBIMHBz7yPfYlnAVxEJvbj7bg/R5y73KRL5kZVEEHlNJd8Hy8wgjsbQNWBTkzXPfxgVRV8uNQci
 V7tCuw8CKb3rmPdE=
X-Received: by 2002:a1c:2045:: with SMTP id g66mr4238069wmg.53.1591712974776; 
 Tue, 09 Jun 2020 07:29:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF4/o0d4NSiV0Ybl9/z2Kx5wx+pebyQNKIauHjBKpVstMr31YZMo5PTlG3Xso6oPTbN/gn5A==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr4238045wmg.53.1591712974525; 
 Tue, 09 Jun 2020 07:29:34 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id h12sm3514783wro.80.2020.06.09.07.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 07:29:33 -0700 (PDT)
Date: Tue, 9 Jun 2020 10:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 00/16] acpi: i386 tweaks
Message-ID: <20200609102846-mutt-send-email-mst@kernel.org>
References: <20200515150421.25479-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200515150421.25479-1-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 05:04:05PM +0200, Gerd Hoffmann wrote:
> First batch of microvm patches, some generic acpi stuff.
> Split the acpi-build.c monster, specifically split the
> pc and q35 and pci bits into a separate file which we
> can skip building at some point in the future.


Applied patch 1-7. Rest all look ok but couldn't apply
since they seem to be on top of some other cleanups
which are not upstream. Pls rebased and post and I'll apply.



> v2 changes: leave acpi-build.c largely as-is, move useful
> bits to other places to allow them being reused, specifically:
> 
>  * move isa device generator functions to individual isa devices.
>  * move fw_cfg generator function to fw_cfg.c
> 
> v3 changes: fix rtc, support multiple lpt devices.
> 
> v4 changes:
>  * drop merged patches.
>  * split rtc crs change to separata patch.
>  * added two cleanup patches.
>  * picked up ack & review tags.
> 
> v5 changes:
>  * add comment for rtc crs update.
>  * add even more cleanup patches.
>  * picked up ack & review tags.
> 
> v6 changes:
>  * floppy: move cmos_get_fd_drive_type.
>  * picked up ack & review tags.
> 
> take care,
>   Gerd
> 
> Gerd Hoffmann (16):
>   qtest: allow DSDT acpi table changes
>   acpi: move aml builder code for rtc device
>   acpi: rtc: use a single crs range
>   acpi: serial: don't use _STA method
>   acpi: move aml builder code for serial device
>   acpi: parallel: don't use _STA method
>   acpi: move aml builder code for parallel device
>   acpi: move aml builder code for floppy device
>   floppy: make isa_fdc_get_drive_max_chs static
>   floppy: move cmos_get_fd_drive_type() from pc
>   acpi: move aml builder code for i8042 (kbd+mouse) device
>   acpi: factor out fw_cfg_add_acpi_dsdt()
>   acpi: simplify build_isa_devices_aml()
>   acpi: drop serial/parallel enable bits from dsdt
>   acpi: drop build_piix4_pm()
>   acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
> 
>  hw/i386/fw_cfg.h                            |   1 +
>  include/hw/block/fdc.h                      |   3 +-
>  include/hw/i386/pc.h                        |   1 -
>  tests/qtest/bios-tables-test-allowed-diff.h |  17 ++
>  hw/block/fdc.c                              | 111 ++++++-
>  hw/char/parallel.c                          |  22 ++
>  hw/char/serial-isa.c                        |  22 ++
>  hw/i386/acpi-build.c                        | 312 +-------------------
>  hw/i386/fw_cfg.c                            |  28 ++
>  hw/i386/pc.c                                |  25 --
>  hw/input/pckbd.c                            |  31 ++
>  hw/rtc/mc146818rtc.c                        |  24 ++
>  stubs/cmos.c                                |   7 +
>  stubs/Makefile.objs                         |   1 +
>  14 files changed, 269 insertions(+), 336 deletions(-)
>  create mode 100644 stubs/cmos.c
> 
> -- 
> 2.18.4


