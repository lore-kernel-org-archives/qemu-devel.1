Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4917AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E731206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 01:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwvC26Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E731206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAken-00031a-Bo
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 21:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkeG-0002bA-F2; Tue, 25 Aug 2020 21:54:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAkeE-0004Em-OF; Tue, 25 Aug 2020 21:54:48 -0400
Received: by mail-oi1-x243.google.com with SMTP id z22so198278oid.1;
 Tue, 25 Aug 2020 18:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aPLE8Qfnk+g9L/ojTdv32kO/sfWmMpScTrsW46d+wrA=;
 b=nwvC26YhiBM54/wzWu5FKk5mozafZw9s/8cXw+L1Rgj1GqIl5b0S3mlQizNspy7qDN
 lUCOm4zHN3Rx8dBzLT435m8EKzkQqwoF8NQX7hoLS4h1SpQTUFhRdex/KfBJ2bDXwB7V
 hQw7Muw6/LQhpKRz6MDMaSdyYob8id86FM9TWej3mzza84UHFSt5NPa3CZnFjvFCEJuX
 x43dp4Zub6AZbcfUjrJbbbBvZ42xQai0CSlVUFQh66rykedmqz8i/eziyEwRhmKD3Upf
 WmqXMcKd/NFHYwM3kaFcPk2kFA0trsIe26a9B1h/MMxmQK8hhx3jq2NNcisPJBr6+wB6
 9vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aPLE8Qfnk+g9L/ojTdv32kO/sfWmMpScTrsW46d+wrA=;
 b=ezejlhDQonvU23Up7XRBLfNSXnJKTS17dcnINdkA5qod38pBNn3Os+Y5WeGc26kiXm
 a3OFJRchhu+qmc5UoYobIMVb4SLQuKLiIsekgiFHyUBBTrapDSS0IGFL4MpsQVJHDyBf
 4/eoI1ExgA5Zrg6VzBTy4ZhG4XQ0U3IQn/ZgvUP7RbFgrdi8F2R63UTq2LdJRS4smk3P
 RNGPrZLD0AIiX3nuio+izvBMFWSNdmbyDYRwPsXUJsiEbPCRCz6v1/QLCiZbgWb41hh8
 jNOQWPhL6H/3fyQDSEag35/Dyzi6uf3/4lJ0hInJWvLEmiHPzDWEoW17TO5U2YfyzJN/
 ejjw==
X-Gm-Message-State: AOAM530Gse1f+V3H451i76IYkhyBGB/hOw07NUL0coTX2RVuKBsQefmk
 x6ktrvKJJReJNXV8+akv66eYR+sFm6A7HL0/PUA=
X-Google-Smtp-Source: ABdhPJwDh6uaIYs/FvyEG8EjfS0FLDz06QCSKJGVsMvnfPeXMHIV7bEv8PH3S2mxUkcILAl9dIOsX298XcXzUxUz/CM=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr2818045oif.56.1598406885123; 
 Tue, 25 Aug 2020 18:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-11-kuhn.chenqun@huawei.com>
In-Reply-To: <20200825112447.126308-11-kuhn.chenqun@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 09:54:09 +0800
Message-ID: <CAKXe6SL60EqjnpjOjM7meHex0bqYnbaGS+UTTLp0VduRWtzK=A@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] hw/display/vga:Remove redundant statement in
 vga_draw_graphic()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-trivial@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Qun <kuhn.chenqun@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:33=E5=86=99=E9=81=93=EF=BC=9A
>
> Clang static code analyzer show warning:
> hw/display/vga.c:1677:9: warning: Value stored to 'update' is never read
>         update =3D full_update;
>         ^        ~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 061fd9ab8f..836ad50c7b 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1674,7 +1674,6 @@ static void vga_draw_graphic(VGACommonState *s, int=
 full_update)
>          if (!(s->cr[VGA_CRTC_MODE] & 2)) {
>              addr =3D (addr & ~0x8000) | ((y1 & 2) << 14);
>          }
> -        update =3D full_update;
>          page0 =3D addr & s->vbe_size_mask;
>          page1 =3D (addr + bwidth - 1) & s->vbe_size_mask;
>          if (full_update) {
> --
> 2.23.0
>
>

