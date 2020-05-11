Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F5C38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1065D20746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddqlv29m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1065D20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXx17-0000zb-7t
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXwzy-00089n-3a
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:12:50 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXwzx-0007ey-6U
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:12:49 -0400
Received: by mail-lf1-x141.google.com with SMTP id 188so6039029lfa.10
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 18:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jpcqyqvgUy9zcNCAtH07HIIihJz6L4Jt7RYE9e9z0LQ=;
 b=Ddqlv29m4Ay8/4r8fhVW7xPKKfqxnH9qfhQK0WealnbYCtLA/+vaVk404aQH9lh3jp
 S9So1RoNT3XXyUURKDhiQMDy2UVm8hYhSidw/f8l7kEzan2w/W3UhJMXyLnrl21OfY3Q
 RNtRViSTUgX5H25rNmZsUniW9Fczq5X37Bzec4i60cz+0Nx/g+04OjOuE3ZrR3HBaVu7
 0EgYzDteL9IR3z+QuzYwYQdxmq/nlmvV/UUpgEuU+cvNA6NSICtjkt0bMbpj7kuak5d2
 SIKGaMsY2k2sYupdyH73jBFnXzZf9KXmwOUY/ZI+8xtx6nBBYIS4f+cOnT/3Tl+5uOWJ
 vBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jpcqyqvgUy9zcNCAtH07HIIihJz6L4Jt7RYE9e9z0LQ=;
 b=pTYc8fTZ33WCEJVNERMYWTChajE6+8/+Suw06K0jmuLA1YkGGtKWYUVxsY+hZJfY32
 YY9PtbzroxllgEO51xZ0oGavgZLeUswT5PbFF7PmHWwRwZHgdmy1F4BTXx0Yj6egxBaB
 +UgGwvvQhOGiR4iPw3Y+UbPIqGLK3YQioBhu4N3XyoesdI/+oEslcFu/EPpa/W+YqyMg
 CEmLu/U23dM+BlNGcyZFCv9T2GfqKQGjmD4EoYFtNKk/ri8LMaryL87Kw8VolKYITI2V
 iwbGMTHbf+wfvPOmbWEmoIRmP2TGbWlUMyFXJ+pTtmjxfeDGj2s6fX1J68vxYbZgvFXe
 95Jg==
X-Gm-Message-State: AOAM531Q89WOLo8q/vHwkAAgex/5wRmg3zmjXjhDUKFc5jQULx9DS96C
 15vsiy8/9Aotz6S1wo9nDR+SCDaWi1zwXbH5Wng=
X-Google-Smtp-Source: ABdhPJzeISaV8VAPEYJcqWy9Q1srDAUK3jIfTpOyihR8Z4nTUjQKyQA1Rp9pdjzz1YIbSvX8Lp7YB2wSmvAbhZH2s28=
X-Received: by 2002:a19:d97:: with SMTP id 145mr9002017lfn.193.1589159567581; 
 Sun, 10 May 2020 18:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-7-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-7-f4bug@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Mon, 11 May 2020 09:20:30 +0800
Message-ID: <CABDp7VqY1v8AiJbM8_owP5wk1ZBODDTNsZVjkxdhtmfuhufq+g@mail.gmail.com>
Subject: Re: [PATCH 06/12] hw/pci-host/bonito: Fix DPRINTF() format strings
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x141.google.com
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
 Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Huacai Chen <chenhc@lemote.com>

On Mon, May 11, 2020 at 5:07 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index b9bfe3c417..10ead31e4f 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -239,7 +239,7 @@ static void bonito_writel(void *opaque, hwaddr addr,
>
>      saddr =3D addr >> 2;
>
> -    DPRINTF("bonito_writel "TARGET_FMT_plx" val %x saddr %x\n",
> +    DPRINTF("bonito_writel "TARGET_FMT_plx" val %lx saddr %x\n",
>              addr, val, saddr);
>      switch (saddr) {
>      case BONITO_BONPONCFG:
> @@ -327,7 +327,7 @@ static void bonito_pciconf_writel(void *opaque, hwadd=
r addr,
>      PCIBonitoState *s =3D opaque;
>      PCIDevice *d =3D PCI_DEVICE(s);
>
> -    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %x\n", addr, val=
);
> +    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %lx\n", addr, va=
l);
>      d->config_write(d, addr, val, 4);
>  }
>
> @@ -474,7 +474,7 @@ static void bonito_spciconf_write(void *opaque, hwadd=
r addr, uint64_t val,
>      uint32_t pciaddr;
>      uint16_t status;
>
> -    DPRINTF("bonito_spciconf_write "TARGET_FMT_plx" size %d val %x\n",
> +    DPRINTF("bonito_spciconf_write "TARGET_FMT_plx" size %d val %lx\n",
>              addr, size, val);
>
>      pciaddr =3D bonito_sbridge_pciaddr(s, addr);
> --
> 2.21.3
>
>


--=20
Huacai Chen

