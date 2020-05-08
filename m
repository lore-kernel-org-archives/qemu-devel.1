Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9271420870
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFuaDDju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9271420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0gH-0000n9-RF
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0fj-0000NP-2W
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:56:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0fi-0007da-9K
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:56:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id z8so1348762wrw.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lthHnKv1xa7dAMrPglbDildZVLksCVCONvJYe6xZSkM=;
 b=rFuaDDjuIxkm3BEAh39hhXMNZEKBSZom2kyRejJhylcVac4esFQiv4lkl3zuEXgw/7
 RMoDPBwnrQ9D/NIIBK6Cp9Y6Z7tM6ml1pnuus6J3k+m700UG+CvtBYIfGCO/QZWDQxgw
 9d6JvukiWhq6Jfyi5iEC5lI3BFUyqi2igZ4C+nJWwBDSXA4/Ag2tZVWMTxjoOuSWFVA3
 u4gKyJIJxRCXYsGjFm4ijwFHb2snu6vm+1TYL5zm949FiGMmXSR29Xm4noiAUJZL1w8h
 G3JmoWrAOdlKRSo6CvM3t0EVkcYUznX4PTIOEZ1lPpF1P3vqqr7Pz7rtdphmQkH4rHcD
 REIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lthHnKv1xa7dAMrPglbDildZVLksCVCONvJYe6xZSkM=;
 b=E3YnD9bjuzbFhwicibq/6PLP7Tx4d7iGSGORFv9BW5DDgmasb69uGURDRHAkfb9nwj
 dvfRyLNSls79kA0ZgULyErFAbTSOiq+K8v559GCByLJBegg2FpUhiqL82vlqCMbt/nSA
 ykFvgyL6q2mdnVdfMxqRST7HgZrI1LAyLrvKuEpzg1/6hPxanLgF7XyQeArulGoaXfi7
 pmsg0uNlWfx69pBsnG0VwQGP0iSiel15H61em0cC2QRzmfsA4Eu+hJCebRH1wUD4J52F
 9ek1dmppTA6ChHw3iIYwC2P6MdgEQhBh0BaB3ab0Knwc9vDojCMFOPwiaFLJlG9WXwd5
 WU3g==
X-Gm-Message-State: AGi0PuZfWK9XlSgQFMErxGBooYt7/VWteh5L2DtXW9B+o+lp7zY58+Bk
 wkOLJbef/mU/hBW9oCvTPRy3QpMgoaJwCQdXzTQ=
X-Google-Smtp-Source: APiQypIIMIfUa+K2nKmANtc3Gp+42ZJ4YJxs91z7+lmWMPX2JbO8AkvjFrQVzZZGb8eWQl1f1YghymmN2lZW1j0n1+I=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr2307167wrj.329.1588935360993; 
 Fri, 08 May 2020 03:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-9-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-9-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:55:34 +0200
Message-ID: <CAHiYmc65ctQgGicSJ4sB+pC1ZaGGLbJi7QWAERs2jDZb_8rWEg@mail.gmail.com>
Subject: Re: [PATCH V3 08/14] KVM: MIPS: Let indexed cacheops cause guest exit
 on Loongson-3
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:13 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> Loongson-3's indexed cache operations need a node-id in the address,
> but in KVM guest the node-id may be incorrect. So, let indexed cache
> operations cause guest exit on Loongson-3.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kvm/vz.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
> index f9fbbc16..ab320f0 100644
> --- a/arch/mips/kvm/vz.c
> +++ b/arch/mips/kvm/vz.c
> @@ -2853,8 +2853,12 @@ static int kvm_vz_hardware_enable(void)
>         write_c0_guestctl0(MIPS_GCTL0_CP0 |
>                            (MIPS_GCTL0_AT_GUEST << MIPS_GCTL0_AT_SHIFT) |
>                            MIPS_GCTL0_CG | MIPS_GCTL0_CF);
> -       if (cpu_has_guestctl0ext)
> -               set_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
> +       if (cpu_has_guestctl0ext) {
> +               if (current_cpu_type() !=3D CPU_LOONGSON64)
> +                       set_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
> +               else
> +                       clear_c0_guestctl0ext(MIPS_GCTL0EXT_CGI);
> +       }
>
>         if (cpu_has_guestid) {
>                 write_c0_guestctl1(0);
> --
> 2.7.0
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

