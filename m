Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F42F207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcExE9jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F42F207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZKvp-0005op-Do
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 16:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZKuS-0003an-Ce
 for qemu-devel@nongnu.org; Thu, 14 May 2020 16:56:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZKuQ-0006Dp-Cg
 for qemu-devel@nongnu.org; Thu, 14 May 2020 16:56:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id 50so459300wrc.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 13:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OR84j6vTyfY0H84yMrQ/BQLUOCn2Mr0ZLuCBdy/+wkU=;
 b=jcExE9jFCtbRYJC6qZ7b8EPpVu4yznotAiz7dnnW/tiywdgWC7hl97WVbyRGdzpydj
 GSlXAeAnk5KjPc8ciYk0SXLGLjVULRDl13zhBsLBL3dLhSWRnLj2h8WPMsRWqB0mB5IY
 NTKKzrLVDN9DcQrs/76g674KtOyLmoHzpO72Adb2l7Uwu52N/mANHxDObv4GFKJh8Nt1
 4sVULU2XQXwalqhG7EnZsXPKyyDeBlgGHwi7JIvZk40uObozYH6SFFVsQkYHNobnwZfF
 O/v8zCllCmYunNoBcCast0OQb3tlMHp9JhxnXSUAPeLWUpUDBxFt1oiD8DVQ+MoAZL5o
 OE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OR84j6vTyfY0H84yMrQ/BQLUOCn2Mr0ZLuCBdy/+wkU=;
 b=Obz/xdeyDgsVxtv2bRB9df/iGy56/ssqanI6mxPfaSwI4/Nb1VJ1n02TX1rj5idTJz
 jq9WKSLL3EBzVUDODiTE3q4f0y2OCORejjZJAtLNQCzrovV1ZOxQ/7Tfiio9zNrmk0uH
 s+aiXSB2CjU4QzweraH2zcemRPHVonrBTiik92oAMFyDyDzcUnryCY6on0Lagwmsm5fI
 1AdJqxmGUfYuucDZd7dCQV+boBg9uJxt6IvKu179CLmSFz3B3HGthkxZltApL4mVjvuq
 P5lplc63vXR916aeRzYqjbj/hEM2+pdc7XBP894FL05HG5OCmP3Ab9d9pYPuM0whYUaM
 T6vA==
X-Gm-Message-State: AOAM531vlo7RuZWqDy9xFCMxYCbrBQuuTy4Jsj3s0HREf8X8Mx2DOvfW
 aeW5D3KCYMWr5kDqIVznUhKRg4ESjYruri19IAU=
X-Google-Smtp-Source: ABdhPJymALh2Qe+BygbWKRX8T/Yy1hWYZxN89nutE7k9pvqZFG6Ch0vXrTLdE18vLZIr8b3xZ0nOrEGoba1WyZW8W1o=
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr341480wrq.162.1589489808578; 
 Thu, 14 May 2020 13:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1586337380-25217-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 14 May 2020 22:56:33 +0200
Message-ID: <CAHiYmc6=e8Ad+stdx4vFfZ5vkysiYo5Zkdiq3reLL=McvwDt3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as fulong2e co-maintainer
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 8. =D0=B0=D0=BF=D1=80 2020. =D1=83 11:08 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> I submitted the MIPS/fulong2e support about ten years ago, and after
> that I became a MIPS kernel developer. Last year, Philippe Mathieu-
> Daud=C3=A9 asked me that whether I can be a reviewer of MIPS/fulong2e, an=
d I
> promised that I will do some QEMU work in the next year (i.e., 2020 and
> later). I think now (and also in future) I can have some spare time, so
> I can finally do some real work on QEMU/MIPS. And if possible, I hope I
> can be a co-maintainer of MIPS/fulong2e.
>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 642c8e0..3281ff2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c
>  Fulong 2E
>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> --
> 2.7.0
>

