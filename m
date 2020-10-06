Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0300C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C50120639
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C50120639
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPja4-0005pL-26
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kPjVM-0008LX-Ge
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:32 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:29403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kPjVJ-0002Gb-Ey
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:31 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ED2BC745953;
 Tue,  6 Oct 2020 11:43:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C3EFF74594E; Tue,  6 Oct 2020 11:43:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C2A63745702;
 Tue,  6 Oct 2020 11:43:17 +0200 (CEST)
Date: Tue, 6 Oct 2020 11:43:17 +0200 (CEST)
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] softmmu: move more files to softmmu/
In-Reply-To: <20201006091922.331832-2-pbonzini@redhat.com>
Message-ID: <27899e4f-a1a0-919b-f0b2-26c73adaa6e@eik.bme.hu>
References: <20201006091922.331832-1-pbonzini@redhat.com>
 <20201006091922.331832-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Tue, 6 Oct 2020, Paolo Bonzini wrote:
> Keep most softmmu_ss files into the system-emulation-specific
> directory.

The name of this dir may be misleading. I think it originally stood for 
the actual MMU emulation but now it seems everything related to system 
emulation is dumped here. Is it better to keep MMU emulation separate and 
put other files in a "sysemu" dir or rename this dir if it keeps mixing 
MMU emulation and system emulation parts? (I think the MMU emulation is a 
weak part of QEMU regarding performance so it would be better to keep that 
cleanly separated so that it's easier to analyse and optimise it in the 
future, which is more difficult if it's mixed with other parts where it's 
not even clear what constitutes the actual MMU emulation. So I vote for 
keeping it separate.)

Regards,
BALATON Zoltan

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> meson.build                              | 10 ----------
> bootdevice.c => softmmu/bootdevice.c     |  0
> device_tree.c => softmmu/device_tree.c   |  0
> dma-helpers.c => softmmu/dma-helpers.c   |  0
> softmmu/meson.build                      | 10 ++++++++++
> qdev-monitor.c => softmmu/qdev-monitor.c |  0
> qemu-seccomp.c => softmmu/qemu-seccomp.c |  0
> tpm.c => softmmu/tpm.c                   |  0
> 8 files changed, 10 insertions(+), 10 deletions(-)
> rename bootdevice.c => softmmu/bootdevice.c (100%)
> rename device_tree.c => softmmu/device_tree.c (100%)
> rename dma-helpers.c => softmmu/dma-helpers.c (100%)
> rename qdev-monitor.c => softmmu/qdev-monitor.c (100%)
> rename qemu-seccomp.c => softmmu/qemu-seccomp.c (100%)
> rename tpm.c => softmmu/tpm.c (100%)
>
> diff --git a/meson.build b/meson.build
> index 17c89c87c6..0e0577e81e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1360,17 +1360,7 @@ blockdev_ss.add(files(
> # os-win32.c does not
> blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
> softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
> -
> softmmu_ss.add_all(blockdev_ss)
> -softmmu_ss.add(files(
> -  'bootdevice.c',
> -  'dma-helpers.c',
> -  'qdev-monitor.c',
> -), sdl)
> -
> -softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
> -softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
> -softmmu_ss.add(when: fdt, if_true: files('device_tree.c'))
>
> common_ss.add(files('cpus-common.c'))
>
> diff --git a/bootdevice.c b/softmmu/bootdevice.c
> similarity index 100%
> rename from bootdevice.c
> rename to softmmu/bootdevice.c
> diff --git a/device_tree.c b/softmmu/device_tree.c
> similarity index 100%
> rename from device_tree.c
> rename to softmmu/device_tree.c
> diff --git a/dma-helpers.c b/softmmu/dma-helpers.c
> similarity index 100%
> rename from dma-helpers.c
> rename to softmmu/dma-helpers.c
> diff --git a/softmmu/meson.build b/softmmu/meson.build
> index 36c96e7b15..862ab24878 100644
> --- a/softmmu/meson.build
> +++ b/softmmu/meson.build
> @@ -14,3 +14,13 @@ specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files(
> specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TCG'], if_true: [files(
>   'icount.c'
> )])
> +
> +softmmu_ss.add(files(
> +  'bootdevice.c',
> +  'dma-helpers.c',
> +  'qdev-monitor.c',
> +), sdl)
> +
> +softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
> +softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
> +softmmu_ss.add(when: fdt, if_true: files('device_tree.c'))
> diff --git a/qdev-monitor.c b/softmmu/qdev-monitor.c
> similarity index 100%
> rename from qdev-monitor.c
> rename to softmmu/qdev-monitor.c
> diff --git a/qemu-seccomp.c b/softmmu/qemu-seccomp.c
> similarity index 100%
> rename from qemu-seccomp.c
> rename to softmmu/qemu-seccomp.c
> diff --git a/tpm.c b/softmmu/tpm.c
> similarity index 100%
> rename from tpm.c
> rename to softmmu/tpm.c
>

