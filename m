Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F5C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6546720735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTtJyuK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6546720735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY1JD-0003Ti-LW
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1IB-00032c-0U
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:47:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1I9-0001am-Fa
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:47:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id e26so16637761wmk.5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 22:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3Pedg90XQlWBgyxgnCF98Y+wpVS8fxJPx+tQ61KtdJc=;
 b=tTtJyuK6+Rde41/8Ghr61g17T2vGgb9n9ZH3huh8J6+mRgoBFXaAG33UsDiVrDs4cs
 jauaMUb0pAU9z+JxTh3d5vtf74+k/w1L0Pz8GTgvARv9UyT86miMIOXiL6YXCX16XlOv
 DCglkTE33qXyaMz5tqManQNnxqZQb2PRGBNKts1xzlD9pNkTZH3WXyO/ymEsm4n2POQV
 /LCRzDWAGODMPY1U0PjpMWDyvlpvB88StWshfKknrY8mpqqCdACVqinWeE/jmkLEB8yD
 /xjOR7aMg+zt+iGV7mrTpmHtaxgWaMp2knAGVSwTF1Vds7iMJr9pZ9a7fggI7lac+aI0
 iNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3Pedg90XQlWBgyxgnCF98Y+wpVS8fxJPx+tQ61KtdJc=;
 b=E7sG94tyFEeLKp4fJ+DKgiyZFqFzdkTP3WII0J30E4zEPUbHgFrlw/jWCXma6V3WVc
 rY0+zQezrgJrpQiSUW64+Zmem6zb7Kv0qAXOMycw1vtYpnXwIL/Fxt4b1CkO7o7/P8o0
 udZa2D0jkVqwJRxty4puHv/3t7AtcBO/T3RszfbbKgw8Sxq/qb0A1t/4ohXO9Qab0t49
 BpS9Lex3wkkEK66IAVctomeBA0e67lkoDmJEdn+tWxDJR1sMeHLG6BEFGf9dGT3KA+4e
 LQ4g57rgd/lmkeVAzYvkqyYxAWgMJciFQRlgMXG9nTVIGuYY5xgZgYJdKEiUkgnkTJBT
 tPWA==
X-Gm-Message-State: AGi0PuYHvsJsVgQemJcYkldpmc4Blxc39V/BLPE2natp30+v2Orr8kya
 oHef/ZGtP3x59Jpc8vF95+kQVNo7LLzQKVbkWcU=
X-Google-Smtp-Source: APiQypLFebgaoyboZgSiyJ4lJdc7+f7TyUUc94FCS0SGKgJdDaQhxO093MQ9MxTXO5UILh3YvMZ9BM7EuRv+7NCx7OY=
X-Received: by 2002:a1c:2dc7:: with SMTP id
 t190mr28145663wmt.129.1589176068173; 
 Sun, 10 May 2020 22:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-2-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-2-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 11 May 2020 07:46:42 +0200
Message-ID: <CAHiYmc4DD9+LQJzgA+WS9jD-i7FZJJZnkhJY=ZSGEQ4KEA5dfg@mail.gmail.com>
Subject: Re: [PATCH 01/12] MAINTAINERS: Add Huacai Chen as fuloong2e
 co-maintainer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 10. =D0=BC=D0=B0=D1=98 2020. =D1=83 23:01 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Huacai Chen <chenhc@lemote.com>
>
> I submitted the MIPS/fuloong2e support about ten years ago, and
> after that I became a MIPS kernel developer. Last year, Philippe
> Mathieu- Daud=C3=A9 asked me that whether I can be a reviewer of
> MIPS/fuloong2e, and I promised that I will do some QEMU work in
> the next year (i.e., 2020 and later). I think now (and also in
> future) I can have some spare time, so I can finally do some real
> work on QEMU/MIPS. And if possible, I hope I can be a co-maintainer
> of MIPS/fuloong2e.
>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Message-Id: <1586337380-25217-3-git-send-email-chenhc@lemote.com>
> [PMD: Added Jiaxun Yang as reviewer]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..aa5c54c75a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1075,8 +1075,10 @@ S: Obsolete
>  F: hw/mips/mips_r4k.c
>
>  Fulong 2E
> +M: Huacai Chen <chenhc@lemote.com>
>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> --
> 2.21.3
>

