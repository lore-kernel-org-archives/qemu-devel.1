Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144D6C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4B1207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhLsxzIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4B1207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jty35-00014i-UW
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jty2P-0000cc-41; Fri, 10 Jul 2020 14:46:21 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:36560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jty2N-0008Aw-79; Fri, 10 Jul 2020 14:46:20 -0400
Received: by mail-il1-x142.google.com with SMTP id x9so5951468ila.3;
 Fri, 10 Jul 2020 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=74PRxuwVQhYKAeFYZ/fJ9AQ94hWBTbTARAGzqRn6L6Q=;
 b=jhLsxzIVio/KldHc+nTKEFBOLHzlwdUC3BUWRAYCX3MOqw6VNaH25SYBMD4sfaw4+b
 U7Cxo0VMBALLUp/7UzFQUoN9ayC6uIYMseZlj53fOx+eCALtpJ6jNi+1ZwBG1oBj7EAD
 6OZBSfxOH78sWASUveMxx754jIcOMThDpStAZ4X1WKI9OIC29EVFrSXZ81mqxPrqkzYq
 PVhnx/shXTRiq0AB/T5qK2j9lXvr6JVfrppCo43jJliSu63Ei8PYlZhIoi5tnyco1FWV
 UpdzG5AfpYlQW0kzoVdcPU7wY7o6nc4zmfyNRS2U9FF0iQZi88wy1XBG27OY0xgKklD3
 lmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=74PRxuwVQhYKAeFYZ/fJ9AQ94hWBTbTARAGzqRn6L6Q=;
 b=nTTXsNutjMnyHFIApUZx11kKA/8FACmE7QxMJ1XOMOs10IIMfiGLxbHfH+XpiMNnnl
 7ewnV2ic4M6Go5yYPDg0Y+xRBPFNly3tDhUhCC2lhIkHMz6cLTk981vRtjz3WPo8Gh+2
 n9CF8XXNo3ecHZzHLAUhSlCCQ8rVNJzLZyu/sf2GdTHQysE4FDOzqz0sFkwJNugPlfFU
 5fTYwnNqVTU0mZ9+7hfp0pRsTGe+r8epNvCchcva+oXHCEoYalwzfGAjejXGN9sgx+ht
 pCMl+al49oeyDmNSFSUpjJBVihzrcpMML0dvVVUZNx3PaRYKI/bHeWL7dwnmO4Yu8vf7
 hsAA==
X-Gm-Message-State: AOAM533kO0z+rXGXM+VqKILfe6rUidIRu//iivvIuQbKvJXnvkzDU0IQ
 sAR47aMRN2hD8Wt1kHnAhwr0sDjL+xRHA0vI8CM=
X-Google-Smtp-Source: ABdhPJyxU/4bU23xfHtn4O1MWIDux9riBbVRSttITXs1Kx8vhIgPecyvE+AEhzwmWgNgYIKHi1gNmyksLKFdOGvQg8A=
X-Received: by 2002:a92:d186:: with SMTP id z6mr56528745ilz.227.1594406777569; 
 Fri, 10 Jul 2020 11:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-8-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594357499-29068-8-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jul 2020 11:36:24 -0700
Message-ID: <CAKmqyKPf4YH9Ut1mTLRoRdk-aja6wTKS-FhA-5LynbCeajh-_Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] Makefile: Ship the generic platform bios images
 for RISC-V
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 10:11 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Update the install blob list to include the generic platform
> fw_dynamic bios images.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

You didn't address the comments in v3.

Thinking about this more though it looks like we currently don't
install anything, so this is an improvement.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - change fw_jump to fw_dynamic in the Makefile
>
> Changes in v2:
> - new patch: Makefile: Ship the generic platform bios images for RISC-V
>
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f06b3ae..05e05bb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -840,7 +840,9 @@ palcode-clipper \
>  u-boot.e500 u-boot-sam460-20100605.bin \
>  qemu_vga.ndrv \
>  edk2-licenses.txt \
> -hppa-firmware.img
> +hppa-firmware.img \
> +opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv32-generic-fw_dynamic.elf \
> +opensbi-riscv64-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.elf
>
>
>  DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
> --
> 2.7.4
>
>

