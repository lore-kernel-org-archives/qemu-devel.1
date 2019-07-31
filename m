Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A0C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D079A206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/ltVPnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D079A206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsuvi-0003dO-6u
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsuvI-00039z-VK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsuvH-0007WY-Rq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:10:08 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hsuvH-0007Vw-Il
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:10:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so33060703otq.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BvAQ6YAx8bL3BPaHFYj/zdum3ri8Dn+Qy263vGadGAk=;
 b=L/ltVPnfksNE5LJ6MBpCmSdWGb2z8H/1jVLt63uflySpCryMrdh42i+sEfc9uYF5d2
 qcYI9fJvNkXFPJAU/LHOVOh5NXWrZ732316GWGaIHNGpBSoXv35++5ePBSzogBBR4plX
 s0Gj6WZIDjN75WtsPVli5CrhUowGS3x+N7oQTKebcmG+O5DEqty5fLIWWBHSFIaV6T7G
 piqUckZu9/y8ycrCFCz9CNrXRDPKpM57cLllcQ+6jbfGWFO1vfHqb+y2Een3SqIclmG+
 JJTFNzcOV0jfRbHORBpGhiHAZg5M6TJ8Kw1IngKWR1UCTrgtavyWMSAheBzMIHqQlP0E
 TLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BvAQ6YAx8bL3BPaHFYj/zdum3ri8Dn+Qy263vGadGAk=;
 b=L+M5KHR41rvl7/rSoXomffTDyOYoSYrqa3uNDVUSxRM7xCTogHkDnk8As6CB64N1ga
 nNrjTCSQQwKXOvwZzAAgnEJ/5p3dHE/bk+MK0nrACQU1qnuZqfVBW4LVLM/SWU4HLVbf
 YQ5PKXt1oN09q2NT0u/Qmpl6VWdUcvBO3XLtQMD/KHlg+jY1GAkPg1hhNC+kQVMEIklY
 Rradyd2CKxkT9yJZvbq6x+qv4sg9K8P4O1MpNceiMdo2UkuTh/SNksCRz6twfvhHJXgd
 9QbLo9ErlZ2zD7Jx5SBPhCZdMZnrjrux0TXXj7McSb+cOvwTueQvDtUc+k4qnufQy7TU
 lK7A==
X-Gm-Message-State: APjAAAXCHDOEBNzVXGRnwTdHm6DwSSJkiV73FRHjBippDzGEf37nGffk
 S3crRp/eZiWgNoqVrtLIJKxrjW8EvPPk4Idl+ww=
X-Google-Smtp-Source: APXvYqx1SprTLe/fHOxvA/RMZqdjtrhvfOU1Ol2YHJEFCgqLoPGN4sCGdRk8/g0L/R57k9BocMg4k982f5RjQZm0ojw=
X-Received: by 2002:a05:6830:c6:: with SMTP id
 x6mr41891529oto.64.1564603806765; 
 Wed, 31 Jul 2019 13:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-23-jan.bobek@gmail.com>
 <1691a32a-e0a2-931b-2d17-4dae8dde7c7e@linaro.org>
In-Reply-To: <1691a32a-e0a2-931b-2d17-4dae8dde7c7e@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 31 Jul 2019 22:09:56 +0200
Message-ID: <CAL1e-=h2eHpH2KAtT+orB9gbqnaqTVYf+W_eVfmNrj+jxVsnnA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v1 22/22] target/i386: reimplement
 (V)P(EQ, CMP)(B, W, D)
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

On Wed, Jul 31, 2019 at 9:51 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/31/19 10:57 AM, Jan Bobek wrote:
> > +static inline void gen_gvec_cmpeq(unsigned vece, uint32_t dofs,
> > +                                  uint32_t aofs, uint32_t bofs,
> > +                                  uint32_t oprsz, uint32_t maxsz)
> > +{
> > +    tcg_gen_gvec_cmp(TCG_COND_EQ, vece, dofs, aofs, bofs, oprsz, maxsz);
> > +}
> ...
> > +static inline void gen_gvec_cmpgt(unsigned vece, uint32_t dofs,
> > +                                  uint32_t aofs, uint32_t bofs,
> > +                                  uint32_t oprsz, uint32_t maxsz)
> > +{
> > +    tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz);
> > +}
>
> Drop the inlines.
>
>
Why? The compiler will decide at the end of the day, but at least "inline"
here
says that the code author thinks that inlining is desirable, logical, and
expected
in these cases, which is in turn a valuable information for the code reader.

Yours,
Aleksandar



> > +#define gen_pcmpgt_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm
> ((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0112)
> > +#define gen_pcmpgt_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm
> ((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0112)
> > +#define gen_vpcmpgt_xmm(env, s, modrm, vece)
> gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0123)
> > +#define gen_vpcmpgt_ymm(env, s, modrm, vece)
> gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0123)
> ...
> > +    case 0x64 | M_0F:                  gen_pcmpgt_mm(env, s, modrm,
> MO_8); return;
> > +    case 0x64 | M_0F | P_66:           gen_pcmpgt_xmm(env, s, modrm,
> MO_8); return;
> > +    case 0x64 | M_0F | P_66 | VEX_128: gen_vpcmpgt_xmm(env, s, modrm,
> MO_8); return;
> > +    case 0x64 | M_0F | P_66 | VEX_256: gen_vpcmpgt_ymm(env, s, modrm,
> MO_8); return;
>
> Looks like my comments vs PAND apply to all of the subsequent patches as
> well.
>  But everything else looks good.
>
>
> r~
>
>
