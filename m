Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47309C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E1220661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E1220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathieu-daude.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyY9n-0008Rp-77
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyY9E-00082j-Fr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyY9C-0000P2-8p
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:36:04 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyY9C-0000NP-4s
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:36:02 -0500
Received: by mail-yw1-f66.google.com with SMTP id z141so12547502ywd.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jR+3C6owDKeBbnee9aFu6WSnG7yKSTuB3fTHGIPUC+Y=;
 b=HHMY5XU1TihOnm8/Wa2Y2dw0tdHp/gKmifsyhXdIRU/SDTaM3rGS/J/O5CaTu3064b
 h0ajhsxei1FES1mMDksR2C/cvEd8GrjlyNIhhVSldiGM4DdxC3MkVEqi1H+vy3pJjr9k
 rnIToJDLsQbri1bHlnMzFs97x77QA8R4w+Iaxv3szgmWAfsDbqirOZN3IEcq8TwusMbr
 +wQQswxzjN01h6svNwUhnXycy04KxPJ2G3q8RhaHDCmwfxfAAKh7oQQt3HMzYRJyAYnv
 giE3E/LTLYXF3FPzBRR0fT0Cy+RTYEIs3LRfSsdBFte52ZtwqQwfs+6pmiAJDf2k/oC2
 c2nw==
X-Gm-Message-State: APjAAAXCCefkp4fAnK9twIjKUAgmA3FPeT7S96s4ld/THRJYzt9w75lg
 +6Sb69fpY2zqtz8jI55LAJG3cir6ygfCF4AWzt0=
X-Google-Smtp-Source: APXvYqxUqRUTihNA4wixBHG7BATvqfTZ9zlWizu2I7pmvoa7xZmlM0pSlZPqKB2mt6qBib6SnLERUkaK60dmwAK+rTk=
X-Received: by 2002:a25:d0c3:: with SMTP id h186mr7676135ybg.376.1580722561525; 
 Mon, 03 Feb 2020 01:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20200202153409.28534-1-jrtc27@jrtc27.com>
 <75960e9f-3d28-4db6-ba9a-098b576c6d9d@linaro.org>
In-Reply-To: <75960e9f-3d28-4db6-ba9a-098b576c6d9d@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 3 Feb 2020 10:35:50 +0100
Message-ID: <CAAdtpL4hH_ogA4jqsd=U2Xt58q2c_1OqnaM-oLpLqqfeX9_RFQ@mail.gmail.com>
Subject: Re: [PATCH] target/mips: Fix ll/sc after
 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f
To: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 James Clarke <jrtc27@jrtc27.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 3, 2020 at 8:52 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 2/2/20 3:34 PM, James Clarke wrote:
> > From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> >
> > After 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f the env->llval value is
> > loaded as an unsigned value (instead of sign-extended as before).
> > Therefore, the CMPXCHG in gen_st_cond() in translate.c fails if the sig=
n
> > bit is set in the loaded value.
> > Fix this by sign-extending the llval value for the 32-bit case.

Thanks!

This fix the problem I spent my Saturday debugging:
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00071.html
Too bad we crossed by few hours, you'd have saved my Saturday.

Thomas, I think this also fixes the problem you reported here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg676025.html

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> >
> > I discovered this issue because FreeBSD MIPS64 was looping forever in a=
n
> > atomic helper function when trying to start /sbin/init.
> >
> > Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> > Fixes: 7dd547e5ab6b ("target/mips: Use cpu_*_mmuidx_ra instead of MMU_M=
ODE*_SUFFIX")
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1861605
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> > ---
> >  target/mips/op_helper.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> My fault.  Sorry about that.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>

