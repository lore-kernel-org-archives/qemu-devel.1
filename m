Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6618C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B9320760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m95+HDyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B9320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2us-0008KL-QO
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr2ti-0006xZ-98
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:21:18 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:45175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jr2tf-0003J6-Po
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:21:17 -0400
Received: by mail-il1-x141.google.com with SMTP id o3so7517463ilo.12
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dH2QFJUY15pZrEGNFbt3MblgFn0+Rhi/ksQruyVDNuE=;
 b=m95+HDyA8EUFhaTama6QmfE+KHm+9obd9N1L+hPJvntYs7VHh6KR2uPf/hpNqB0iwO
 oNKjzLTVH9xa0gYfaR9ds7j96gaYYwjqAVMpbAGPKEPKznzTW1MD3h/uGaXXQ43l7CW8
 31zIqjWbS3oXg69wkeQzyKpVG5bfxZ3rZe/YDtUvVg1yQNSKAO++Dh3ST5r8mtGDKz8/
 sHXbtaGO9BAyerljjZby+/DHzSyAnXsUL5imsivPB93tG7MUPKWWM8nFjBq2xT78iztb
 A6WTfO5Bbxwa7dExGp+ZzUCyZD6/zzEJgfe4j57Q6Vs41ORbzqHwGBEtja829Y6T3dyC
 CE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dH2QFJUY15pZrEGNFbt3MblgFn0+Rhi/ksQruyVDNuE=;
 b=SP6b52uNDswX0G7iBI7FtVa+BiG+mAsa87d4rw4b3HkX9JnzN2CeEkPflzkdRfziO5
 uryUm/cPhbP5dfP94DCbt88XcWzhfKCaEEqv/NlmwHDUd1MOr/w0cJxP0oNdINxcJAgL
 CQSFDSro6lROsUtNOr6bSd/w86qJulDsgLzXmeujHcwZp4rYtQKnMT/XTl0U/MZWnmk6
 988TQLfYIKeK6MRoFStEh8FWcy4qdgnI9qrUB+ipflCbqWxza/zb8VqnFg9MpFTrbmL5
 WPIhssbLxiounrzLng3plW/kMleUMt6JmsRMz0eHKeEiiGnFQGYxFXsWxAeOaeV4hysd
 l55Q==
X-Gm-Message-State: AOAM530948cszY999EC8x1dRliQAvksoNOqHfeJVpBDoGDaM1aUyERzD
 J7mGwRw+ES+c1LbFCxLZdoOk1afWFganiWx3EGE=
X-Google-Smtp-Source: ABdhPJydO11w9jEwF9nxZc10QNI8PCVSxJx5QdUTev0PQBZ4rkLstDWunepVdfq2ID50kXsMW87eVH6MoLvejjbeTWM=
X-Received: by 2002:a92:c213:: with SMTP id j19mr13869386ilo.40.1593710474515; 
 Thu, 02 Jul 2020 10:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <1593177220-28143-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1593177220-28143-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jul 2020 10:11:27 -0700
Message-ID: <CAKmqyKPDqvCaAS9D_aG3J7VrmD_y7K=_SGJOcGQ3yD8Fcb8hyA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add an entry for OpenSBI firmware
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 6:15 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> List me as the maintainer for OpenSBI firmware related files.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b40446..b0e2dd2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2609,6 +2609,13 @@ F: tests/uefi-test-tools/
>  F: .gitlab-ci.d/edk2.yml
>  F: .gitlab-ci.d/edk2/
>
> +OpenSBI Firmware
> +M: Bin Meng <bmeng.cn@gmail.com>
> +S: Supported
> +F: pc-bios/opensbi-*
> +F: .gitlab-ci.d/opensbi.yml
> +F: .gitlab-ci.d/opensbi/
> +
>  Usermode Emulation
>  ------------------
>  Overall usermode emulation
> --
> 2.7.4
>
>

