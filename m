Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D356DC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B50206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyQ0ckzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B50206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvCc-00005R-Jj
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsvC9-00081b-RE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsvC7-0004bA-Th
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:27:33 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hsvC5-0004Yw-VE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:27:31 -0400
Received: by mail-oi1-x242.google.com with SMTP id w79so51814620oif.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JCP7uvR3g8IBIpYyhI3BS860O1ceIRi23RsvklMOKM4=;
 b=OyQ0ckzZx8UjUcZ0QKvK8Rby0eDAsh0pLcxPYUv2GKNumJ5p2NDCgQQEmVL05pi+w+
 MEA3zDTQSCt6I5EzAqxx4fwDYH6UD2fB/m+NlJw4fXbhIUcu/FJN3sZazG97MQBDpjji
 DYUlXiCwJ3u97Ld7lul0brt7sVAKWczM1n7NIR/CIbq2sgNKeD64dsdd7qmCueDx02un
 CE4fTxa045Os2x7icMkex71ofDsxEA0lQVqbz8JIlToiB/bhy4rP9PLEqL9FTTSg93tU
 mQi3BZGsQumjsb9zlpDQl4t3xMmSccsB0tEMgaU3lwN63rGGtwdErjWiZVYQtXxRnrnq
 JNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JCP7uvR3g8IBIpYyhI3BS860O1ceIRi23RsvklMOKM4=;
 b=p+hJXCcAziYQGio0B/sz68FHsCD3SuX9qNAmJByJqdqWunJ2nZvg7yEYn/FxsYLPiY
 Cm+/WaBdq/OGvBGfdLHYa7to4Wh2vINC/097zDoQSbAfGh01VcPJth1CYL+n1uggWu5k
 aJs4hqisN7gaOFCIT6IjumZjDS+aZ+T098HSARbsVHHHNE+Yx1kGlJwSnbk6xSvKGbGJ
 9leaRV9ZeUvDG/0LxVNjiao2Alb6dMvwJ+46Xqx+6KCWrqfImhthCMd5oTK2cCeMX3/o
 Oe8B0bFLHl5qS5sdqEeoHvcdWuKig3uTaB99aNB8DPXTBynNQVuA70hFpDNdR0qQTKnq
 uYpw==
X-Gm-Message-State: APjAAAVPDEtjmRrva0XMcJdqvuFlYN/ssKXzRo4h8gsP2ZDdsrtKPBu4
 GrebKL83gqWdZiC8SXfz7IPuGjb4kHkxQ/lmuzI=
X-Google-Smtp-Source: APXvYqz7VPPd0Pi4/CAdAjKwhJp2QDg99rqJ9lQeof0Em1MyB7n8zvIbRdkDffwRPnb35OM/+umvPHXB0py/pqU0xFQ=
X-Received: by 2002:aca:b254:: with SMTP id b81mr26151537oif.53.1564604847859; 
 Wed, 31 Jul 2019 13:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-9-jan.bobek@gmail.com>
 <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>
In-Reply-To: <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 31 Jul 2019 22:27:17 +0200
Message-ID: <CAL1e-=io1f_6HR_rWeG7kOSKT4Bsa0S8Hop=j-45QQvT7esjzw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v1 08/22] target/i386: reimplement
 (V)PAND, (V)ANDPS, (V)ANDPD
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 9:36 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/31/19 10:56 AM, Jan Bobek wrote:
> > +#define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s),
> (modrm), MO_64, tcg_gen_gvec_and, 0112)
> > +#define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s),
> (modrm), MO_64, tcg_gen_gvec_and, 0112)
> > +#define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s),
> (modrm), MO_64, tcg_gen_gvec_and, 0123)
> > +#define gen_vpand_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s),
> (modrm), MO_64, tcg_gen_gvec_and, 0123)
> > +#define gen_andps_xmm  gen_pand_xmm
> > +#define gen_vandps_xmm gen_vpand_xmm
> > +#define gen_vandps_ymm gen_vpand_ymm
> > +#define gen_andpd_xmm  gen_pand_xmm
> > +#define gen_vandpd_xmm gen_vpand_xmm
> > +#define gen_vandpd_ymm gen_vpand_ymm
>
>
> Why all of these extra defines?
>

Because of code clarity and safety, I would say.

This line:

case 0x54 | M_0F:                  gen_andps_xmm(env, s, modrm); return;

looks much clearer than this one:

case 0x54 | M_0F:                  gen_gvec_ld_modrm_mm(env, s, modrm,
MO_64, tcg_gen_gvec_and, 0112)

and such organization is also much less prone to copy/paste bugs etc.

Needless to say there is no performance price at all, so it is a no-brainer.

Sincerely,
Aleksandar


>
> > +    enum {
> > +        M_0F    = 0x01 << 8,
> > +        M_0F38  = 0x02 << 8,
> > +        M_0F3A  = 0x04 << 8,
> > +        P_66    = 0x08 << 8,
> > +        P_F3    = 0x10 << 8,
> > +        P_F2    = 0x20 << 8,
> > +        VEX_128 = 0x40 << 8,
> > +        VEX_256 = 0x80 << 8,
> > +    };
> > +
> > +    switch(b | M_0F
> > +           | (s->prefix & PREFIX_DATA ? P_66 : 0)
> > +           | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
> > +           | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
> > +           | (s->prefix & PREFIX_VEX ? (s->vex_l ? VEX_256 : VEX_128) :
> 0)) {
>
> I think you can move this above almost everything in this function, so
> that all
> of the legacy bits follow this switch.
>
> > +    case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm);
> return;
>
> You'll want to put these on the next lines -- checkpatch.pl again.
>
> > +    case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm);
> return;
> > +    case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm);
> return;
> > +    case 0xdb | M_0F | P_66 | VEX_256: gen_vpand_ymm(env, s, modrm);
> return;
> > +    case 0x54 | M_0F:                  gen_andps_xmm(env, s, modrm);
> return;
> > +    case 0x54 | M_0F | VEX_128:        gen_vandps_xmm(env, s, modrm);
> return;
> > +    case 0x54 | M_0F | VEX_256:        gen_vandps_ymm(env, s, modrm);
> return;
> > +    case 0x54 | M_0F | P_66:           gen_andpd_xmm(env, s, modrm);
> return;
> > +    case 0x54 | M_0F | P_66 | VEX_128: gen_vandpd_xmm(env, s, modrm);
> return;
> > +    case 0x54 | M_0F | P_66 | VEX_256: gen_vandpd_ymm(env, s, modrm);
> return;
> > +    default: break;
> > +    }
>
> Perhaps group cases together?
>
>     case 0xdb | M_0F | P_66:  /* PAND */
>     case 0x54 | M_0F:         /* ANDPS */
>     case 0x54 | M_0F | P_66:  /* ANDPD */
>        gen_gvec_ld_modrm_xmm(env, s, modrm, MO_64, tcg_gen_gvec_and, 0112);
>        return;
>
> How are you planning to handle CPUID checks?  I know the currently
> handling is
> quite spotty, but with a reorg we might as well fix that too.
>
>
> r~
>
>
