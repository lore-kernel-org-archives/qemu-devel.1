Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB0F206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C54TkB66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB0F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJBG-00062U-2E
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYJAT-0005Fk-Ok
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 21:25:25 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYJAS-0006aV-9M
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 21:25:25 -0400
Received: by mail-lj1-x243.google.com with SMTP id x6so5204487ljd.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6OwTmsW2iikekZkUHbk/isHQ+QU22bBDGPnT6PRGdyo=;
 b=C54TkB66tX7Gu5ZQZw2zjEGAwW3beYpVBC4URrExbWphHdlBXIH730MX6/ukppihNZ
 Z0Sci6WOnYXd98PE5/MODEuEd1QrgGANMUUTs1wbAow8XcX3Xb/2kkqOW1Mo2Lp1ak/r
 vxdzkW1Fi7zq00KTVuJLN2CdBlwmE6EuhxVZXa4c48PYykEM76fILJqBHyHbyG4wcMxz
 mWwD7Om5FTGasVlw9gAhqwniSzEUi1n+ZKTYESVdbibIi8LAx+jgtj+jlkiFZEH8EAg7
 Rzk7kn4azhjt/2LLjF4lRz2wM5/iybapVC/OZu7V+Twa/UkvQGPdlKCaKF055w3VuJlw
 q+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6OwTmsW2iikekZkUHbk/isHQ+QU22bBDGPnT6PRGdyo=;
 b=psY/EKTN0E8Km14BX8zXEPbTyQJ2rpxpYQMxwdQ/Jc2kwMsttEpm4+wJD2aixHX6FH
 maSVny87Qf5RZwMtoyRfSMBf4Y6RWvHK7tWWR3KqT0roZCdiCWhlyPIB3H9KIIYSaxCs
 0Qpqc/+hEQcr0Lvz6LtacQDrplDMXLcVaz+l/Ihv18Z8EUoPCU9blX+mjQrcFQKz6r92
 JWKhGF1dnbRPta4cZTW0O5tNAx/0FUj/BbtAw7yP3InFWtEHqUm1qZoUsPoTvuQktvHG
 rYgdb+yn4VN+oooe0ZSXZxWaSQ8frYCKM0T2K1Qury5B/Lca2kwmb2YDrCpIyEYoG+oB
 6+4A==
X-Gm-Message-State: AOAM532WlJ3JeOuByzXenGm9lFw2+RvdOE12qJcS2UObQUSfvjdGn/fG
 VUgGicS1ENDaxe9Vx5ulcvZOmgz2lbspzbz1gik=
X-Google-Smtp-Source: ABdhPJxj51LmMiVUZsdK2lofQZr51d6URM07KcVwOE7tIqPiZduRcByJSHcVnSuvHyp/TRbt/QfH13n9q+1Js+Zp7LI=
X-Received: by 2002:a05:651c:291:: with SMTP id
 b17mr1332756ljo.34.1604021121310; 
 Thu, 29 Oct 2020 18:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
 <1603858685-30701-2-git-send-email-chenhc@lemote.com>
 <11b935d9-e701-099d-1082-adb0613116d5@linaro.org>
In-Reply-To: <11b935d9-e701-099d-1082-adb0613116d5@linaro.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Thu, 29 Oct 2020 07:10:59 +0000
Message-ID: <CABDp7VqFDqCONut_KrnrBrYGg5ztggSmONM+mEOS--kOyPHshw@mail.gmail.com>
Subject: Re: [PATCH V15 1/6] target/mips: Fix PageMask with variable page size
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Richard,

On Wed, Oct 28, 2020 at 4:48 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/27/20 9:17 PM, Huacai Chen wrote:
> > +invalid:
> > +    /*
> > +     * When invalid, ensure the value is bigger than or equal to
> > +     * the minimal but smaller than or equal to the maxium.
> > +     */
> > +    maskbits = MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));
> > +    env->CP0_PageMask = ((1 << (16 + 1)) - 1) << CP0PM_MASK;
>
> maskbits is unused.  Did you mean to use it?
This is redundant, will be removed.

Huacai
>
>
> r~



-- 
Huacai Chen

