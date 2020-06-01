Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0234AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90C9206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOjOj+Nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90C9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfgNq-0007aA-1C
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfgLo-0005f1-0p
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:03:20 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfgLn-0000fk-4D
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:03:19 -0400
Received: by mail-ed1-x541.google.com with SMTP id g1so5821790edv.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pLJQJAYNX05mxOU2IQgzR7RZWCacxTEMAJ7IXwM1EWc=;
 b=DOjOj+NukxCmTs/fUAC8mZ6yP8KoynxAlTn3ZwGslAalHR9lR6NoiX4ucYyUotr0cN
 +sr1NN6AXVdhANYRN7QisoUz0J4dS9zPOQTsL8NVLCEz8D1gM2/f72RsYNmsHRPbP2Dp
 033OVxxZ2m6uZXEh/oM4mTtD8bVqx93aHl3gvCDj1XSNAA9zcISPgojBMCYhkRN0dYtA
 XYzeXhapcXP9dvIqvkJdhe48NFqPgUvW2S49AlaGiN4aupwl2lBjTInKhpRosbJj26I+
 zF/sloGUCVpNGPDOCdczczOMzDAYr7J2yzUr2QO70UqihEsm4vOwH0iPV1mFdXDaDEK2
 uEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pLJQJAYNX05mxOU2IQgzR7RZWCacxTEMAJ7IXwM1EWc=;
 b=RmciKRpuuMr7ZrY5XuLxrlqqCl2cr3j3QsQHd8JIF555+nbUjTiEv2nvJXyqYObGQr
 Fpk3eDICqLzW46gpzULggcZ9j2YjL+bnbWfLGm+Z2R1TOTVXVneHjxAJzKkGPe06suhW
 IXlylc53aVANMebqS+BOhdzRv24Q/yTh2pPLhrTkISC/5BQWeDZCoWBZf9+fJf41FPhm
 ddIDlN6KJy8h9sUgc46Gqy9Nd59JdKkNnuUF7qAXr365Xl4l0bT04Mk5if5c3a7VD7TO
 qBtaiNypVh1SHDm5qp9yWme+6jY+51BmxRMBBC7SIvsEKgqoBvrgCx4mKk/RY9o3yV1q
 hjgQ==
X-Gm-Message-State: AOAM532EJz3gAzTEfXhCFTNtgdsvK2MKVOkCPME8pT4A7ttOeYMRSzcb
 pPHOoR/6CaOCGwIN0FM7LXEp3FxPlOXW1uyBxF4=
X-Google-Smtp-Source: ABdhPJyEfBU47CNoi0ZHAqNbSL2VR/1yB1QPitWAVDQcG994nRYdS82oC8+LNeWQJ02koB3Q7RPa17pNUQxQp3+YqSY=
X-Received: by 2002:a50:a68f:: with SMTP id e15mr21249314edc.285.1591002197593; 
 Mon, 01 Jun 2020 02:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <1588501221-1205-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 11:03:06 +0200
Message-ID: <CAL1e-=iL-MnAdYsnB0zcvbbwnOvwYF1o8UR+B0u2ypBxM0djqw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 1/7] configure: Add KVM target support for
 MIPS64
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 3, 2020 at 12:23 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
>
> Preparing for Loongson-3 virtualization, add KVM target support for
> MIPS64 in configure script.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Applied to MIPS queue.

May health be with you and all people of China!

Aleksandar

>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 23b5e93..7581e65 100755
> --- a/configure
> +++ b/configure
> @@ -198,7 +198,7 @@ supported_kvm_target() {
>          arm:arm | aarch64:aarch64 | \
>          i386:i386 | i386:x86_64 | i386:x32 | \
>          x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
> -        mips:mips | mipsel:mips | \
> +        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
>          ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
>          s390x:s390x)
>              return 0
> --
> 2.7.0
>
>

