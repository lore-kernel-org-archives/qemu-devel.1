Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652C9C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CD521E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiFitDSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CD521E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQUu-0004Yv-F9
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvQUI-00042b-AA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvQUD-0002Jy-Gj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:16:35 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvQUD-0002Ha-7k
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:16:33 -0400
Received: by mail-ot1-x342.google.com with SMTP id j19so31357799otq.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1NHsKJO7D2MJzWRTGF95uuoJZ5g7HBLubckVRHO3rys=;
 b=eiFitDSzHjsHRQY+BIhi64E4z8aP94vvImqhcEo8wox+h5Vfo+yW9FmxsSwNH/sdMH
 PzbFzz7owk/Q/qLLJrgFOAyQ2o+G8MIienLSbaqkXDtEiKi+G4jYbaiNn4o0+G9G9VOd
 Cmlt2GbVn1YgmtFSS55UKxkPb/EXXe9PlUo+PAuMsFPcwBvqCAxxzI+VKrAnMehRMK50
 vem32PxqKrsICec3Axay+d++8ZhETcnlerX1oyZABypT/GZyDOAUWESNZT8AF4r8nXYQ
 tuTZT1+iBRkxDBqzTKaERqmvJ6R3UNM5PXXzL36UjefIeqxwA/zZWplS9j9Sr4We7kju
 4Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1NHsKJO7D2MJzWRTGF95uuoJZ5g7HBLubckVRHO3rys=;
 b=h3OSxmflWJwoB9FaYBAHMzYlo97verjGPS+LcxCs+RuXp2pR9umjPnDm0J8N2yO+w8
 gUMdVlA6bp0E7OcV3/39xrviIs9nnc9HR4cM7W570ZRBFTiDwqC04cT+mi5V4zikI4R6
 xYwWLjUkRprNr5E0YVsez3jRUiio8WVOPpm7seNbOEVwLQx+8XbrikIQQLGFDdXZwDoj
 8RER5SCJZ595XhJcIRMidO8mlH+c60A6hY92wVI5dVLyRfPO1hyLZjvDVXkXrRl1pSqI
 aKJPcoERBxbFpTRQUfJhlu4B2xQVXxZTUal2ua2RB3XFGU5RgtBsBhC8JHl24Fb3TMrf
 ydJQ==
X-Gm-Message-State: APjAAAUOKvybdm7Hw+bqUzSCBRYeknsNt0DHe95CNfLjiXX98yE/Rh1u
 ZSkHUXJeV0jXX3gmBw5Br2lV0RppIBJuNTPG+4KEUQ==
X-Google-Smtp-Source: APXvYqxviOrvGJCJUJfdRmeEGS2UvXQtugkELP3MsDEsv8aZ6UvO+EAsc7N63vvEwZbGNdfblTO/+D1zCrl5I+hL5U4=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr8299729otj.97.1565201792249; 
 Wed, 07 Aug 2019 11:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <20190807045335.1361-4-richard.henderson@linaro.org>
 <CAFEAcA_MFg1_gpaT5+X71s8r5SYZFTizdXs2vQ_6mLooP7E+kg@mail.gmail.com>
 <061145be-4cd4-b8e6-ae5c-562a59e8088f@linaro.org>
In-Reply-To: <061145be-4cd4-b8e6-ae5c-562a59e8088f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 19:16:21 +0100
Message-ID: <CAFEAcA8fCL4VTJYdWGbDySzT9zkgmjcMGqBj0fo9gN4x4B-WcQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 03/11] target/arm: Introduce read_pc
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 at 19:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/7/19 10:27 AM, Peter Maydell wrote:
> >> +/* The architectural value of PC.  */
> >> +static uint32_t read_pc(DisasContext *s)
> >> +{
> >> +    return s->pc_curr + (s->thumb ? 4 : 8);
> >> +}
> >> +
> >>  /* Set a variable to the value of a CPU register.  */
> >>  static void load_reg_var(DisasContext *s, TCGv_i32 var, int reg)
> >>  {
> >>      if (reg == 15) {
> >> -        uint32_t addr;
> >> -        /* normally, since we updated PC, we need only to add one insn */
> >> -        if (s->thumb)
> >> -            addr = (long)s->pc + 2;
> >> -        else
> >> -            addr = (long)s->pc + 4;
> >> -        tcg_gen_movi_i32(var, addr);
> >> +        tcg_gen_movi_i32(var, read_pc(s));
> >
> > So previously:
> >  * for A32 we would return s->pc + 4, which is the same as s->pc_curr + 8
> >  * for T16 we would return s->pc + 2, which is the same as s->pc_curr + 4
> >  * for T32 we would return s->pc + 2 -- but that's not the same as
> >    s->pc_curr + 4, it's s->pc_curr + 6...
> >
> > Since s->pc_curr + 4 is the right architectural answer, are we
> > fixing a bug here? Or are all the places where T32 code calls
> > this function UNPREDICTABLE for the reg == 15 case ?
>
> I believe that this is UNPREDICTABLE.
>
> The T32 cases that reference the PC that are not UNPREDICTABLE, literal memory
> references and adr, are all of the form (s->pc & ~3) and do not come through
> load_reg_var().  Those will be unified by add_reg_for_lit() in the next patch.

Yeah, that was my assumption -- at some previous point rather
than making load_reg/load_reg_var do the right thing for 32-bit
Thumb insns we just fixed up all the callsites to specialcase 15...

How about we add this to the commit message?

This changes the behaviour for load_reg() and load_reg_var()
when called with reg==15 from a 32-bit Thumb instruction:
previously they would have returned the incorrect value
of pc_curr + 6, and now they will return the architecturally
correct value of PC, which is pc_curr + 4. This will not
affect well-behaved guest software, because all of the places
we call these functions from T32 code are instructions where
using r15 is UNPREDICTABLE. Using the architectural PC value
here is more consistent with the T16 and A32 behaviour.

thanks
-- PMM

