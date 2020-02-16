Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0F0C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 17:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2047A20659
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPHNz0oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2047A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3NS7-0001lE-BH
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 12:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ardb@kernel.org>) id 1j3Mth-0000tb-3q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 11:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ardb@kernel.org>) id 1j3Mtf-0007k8-N1
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 11:35:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ardb@kernel.org>) id 1j3Mtf-0007jF-EF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 11:35:55 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 56B3C24649
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581870953;
 bh=1PK16Intcsfsl5Z8c29vMomjWbSOsBdD0Y66sZ9++Yg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QPHNz0oVBZW1PXI5QzHDQh9GIeUDAoFYEMXrODDd1Faxwx4sqtqdu7jrm6n482wJN
 MwMvemhKIvpfk/zZh4bHA4ldKPcTvgpz26z5mDixK7FHNWLz6K6/5fd6GBTZywa2L9
 IVi5WAa/6IvhE5eNanOclswgAORfmwE6IpEErN7M=
Received: by mail-wr1-f45.google.com with SMTP id g3so16738135wrs.12
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 08:35:53 -0800 (PST)
X-Gm-Message-State: APjAAAXUlsfSmOMao0NTu6hU4ZHMNfJUVKPkQPEeq4SyrPhjYzZpTjVN
 kRWth8rJHFvhEi7aB/NLJ+xRVryRY82vXYralueupA==
X-Google-Smtp-Source: APXvYqzwGmWKA6QL11n/ulD0wp88BMoWyrMbNbiexTeO0Y/AP2r+aX6r3h8XDRKithGul+nI/QcXnKuNTEbIvdaGw0o=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr16497625wrv.151.1581870951630; 
 Sun, 16 Feb 2020 08:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20200214183704.14389-1-eric.auger@redhat.com>
In-Reply-To: <20200214183704.14389-1-eric.auger@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 16 Feb 2020 17:35:40 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_JsLdLV2JWCoFaw=3MR4DPKxOzE1mv-0h0nUikoGmZ7w@mail.gmail.com>
Message-ID: <CAKv+Gu_JsLdLV2JWCoFaw=3MR4DPKxOzE1mv-0h0nUikoGmZ7w@mail.gmail.com>
Subject: Re: [RFC v2 0/6] vTPM for aarch64
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
X-Mailman-Approved-At: Sun, 16 Feb 2020 12:10:47 -0500
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger.pro@gmail.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 19:37, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series adds the capability to instantiate an MMIO TPM TIS
> in ARM virt.
>
> The existing TPM TIS code is reshuffled into a generic part,
> the ISA device and the sysbus device. The last patch allows
> the instantiation of the TPM TIS sysbus device in ARM virt.
>
> The series was tested with the swtpm/libtpms emulator.
> Automatic guest LUKS volume unlocking (tpm2) was successful.
> EDK2 support is under development [3]. Thanks to Ard
> for supporting me when setting up the test environment.
>
> Best Regards
>
> Eric
>
> Testing:
>
> mkdir /tmp/tpm
> swtpm socket \
> --tpm2 \
> -t -d \
> --tpmstate dir=/tmp/tpm \
> --ctrl type=unixio,path=/tmp/swtpm-sock
>
> qemu command line must be augmented with the following options:
>
> -chardev socket,id=chrtpm,path=/tmp/swtpm-sock \
> -tpmdev emulator,id=tpm0,chardev=chrtpm \
> -device tpm-tis-device,tpmdev=tpm0 \
>
> References:
> [1] libtpms: https://github.com/stefanberger/libtpms/wiki
> [2] swtpm: https://github.com/stefanberger/swtpm/wiki
> [3] [PATCH 0/4] ArmVirtPkg: implement measured boot for ArmVirtQemu
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v4.2.0-tpm-rfc-v2
>
> History:
>
> RFC v1 -> RFC v2:
> - restructure the existing code with common, ISA and sysbus part.
> - both ARM and x86 integration were tested.
> - acknowledgement: migration has not been tested
>
> Eric Auger (6):
>   tpm: rename TPM_TIS into TPM_TIS_ISA
>   tpm: Use TPMState as a common struct
>   tpm: Separate tpm_tis common functions from isa code
>   tpm: Separate TPM_TIS and TPM_TIS_ISA configs
>   tpm: Add the SysBus TPM TIS device
>   hw/arm/virt: vTPM support
>

Many thanks to Eric for his work on this.

I have tested this with my EDK2 code and a Linux/arm64 VM booting in
DT mode with the tpm-tis driver enabled, and it works as expected. I
can observe the firmware taking measurements during boot, and can dump
the PCRs from Linux using tpm2_pcrlist.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Note that the UEFI firmware is itself a consumer of the DT
description, so we need the DT related changes regardless of whether
the VM boots in DT or ACPI mode.



>  default-configs/i386-softmmu.mak       |   2 +-
>  hw/arm/Kconfig                         |   1 +
>  hw/arm/sysbus-fdt.c                    |  36 +++++
>  hw/arm/virt.c                          |   7 +
>  hw/i386/Kconfig                        |   2 +-
>  hw/i386/acpi-build.c                   |   6 +-
>  hw/tpm/Kconfig                         |  12 +-
>  hw/tpm/Makefile.objs                   |   4 +-
>  hw/tpm/tpm_tis.h                       |  91 +++++++++++++
>  hw/tpm/{tpm_tis.c => tpm_tis_common.c} | 181 ++-----------------------
>  hw/tpm/tpm_tis_isa.c                   | 170 +++++++++++++++++++++++
>  hw/tpm/tpm_tis_sysbus.c                | 159 ++++++++++++++++++++++
>  include/sysemu/tpm.h                   |   7 +-
>  tests/qtest/Makefile.include           |   4 +-
>  14 files changed, 502 insertions(+), 180 deletions(-)
>  create mode 100644 hw/tpm/tpm_tis.h
>  rename hw/tpm/{tpm_tis.c => tpm_tis_common.c} (85%)
>  create mode 100644 hw/tpm/tpm_tis_isa.c
>  create mode 100644 hw/tpm/tpm_tis_sysbus.c
>
> --
> 2.20.1
>

