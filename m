Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76EC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE27120659
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4TOiB2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE27120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn6xc-0002NN-6M
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 15:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hn6xS-0001yB-EI
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hn6xR-0004vh-IK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:48:22 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:32962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hn6xR-0004v5-Bl
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 15:48:21 -0400
Received: by mail-oi1-x22a.google.com with SMTP id u15so13670085oiv.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ML8d8G6SXFU6y3gpFJQ3S+SgOPRaoWQaSWxb7No3ZKY=;
 b=J4TOiB2aFvCLjIY5sR4hszWjVEy4gFh52587E3VslQwCJVD8BAMetzPPTkyUXDhtaR
 RPSX/y9QaPDtyVOhW5h2h5yOKvp55xuj5RT2N2nmx8zT7DN4DR1GKrQu5djL/PxH3n+L
 eoyS9m5dbL/QIDeisYZyqj8KWW4WqskgDOZr+uQDiRT78fnuzkVpmVeoc07IOyrHLCoH
 4Fgd9CPFiW3hy8yDTXsPiUEuWFSgDt24us2gqO6hX4Dfd08Q2efdUW225KRqI3M65SnM
 361bHwOBHQsHr3hmZKSUvH3Rg/JXqMjX9LvSzpY/pybmJ6ER5vZ9EydRWc44bsKUr2gZ
 W3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ML8d8G6SXFU6y3gpFJQ3S+SgOPRaoWQaSWxb7No3ZKY=;
 b=TM2sOlhklcUeVJkB7prkXqFBD5KVRk794hTlCvBs0lYowOwb0a11VWlEUpA+txacpn
 wAb5bRQsyfkHlGiWpnkM9o1UN+62JgK9ZUazUbmC6HJcaRpS34rO07n0eqUcc/roujLX
 i8X95aEx0zOAjkaDtXLmxbqBNXf+/o5tUKdhUEdDZjY0IA+cpWODi/L9LypiE0818m00
 3yab7P83A83gJNBm9PWTfTKeEqmiZtnYWDLqZghC+O3uBTaaZdkDLQOK2Fg3uGnLdcoJ
 EGSV43z3a/moG8WjYo8d0x1xeaMGSmM40qlh8kwyu1U8+CDHH1u1xunkK5v9KshkChQ2
 Aw0g==
X-Gm-Message-State: APjAAAVApADwDFtfI9KvZnrLDEgQBNVtjsdvm240Kll6eoGcCvxYDf4o
 oAyapLYMpUgVoAStiJJ5blJM0r6dAMxm7fywOGA=
X-Google-Smtp-Source: APXvYqw8kKvhE4iQx6ZEIUrh9D/lB+DGQRpvrL5ijazNv6LTll6I7bZSKTX2AlD+8JOwxMft3fvZHEBVQmwlT+JbMa4=
X-Received: by 2002:aca:b254:: with SMTP id b81mr14702105oif.53.1563220099858; 
 Mon, 15 Jul 2019 12:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=ixrEhBeakGDW8xJVBBzRkZTR4d69w38HHmvxVUzOCkSw@mail.gmail.com>
 <87h87q4cxr.fsf@zen.linaroharston>
In-Reply-To: <87h87q4cxr.fsf@zen.linaroharston>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 15 Jul 2019 21:48:09 +0200
Message-ID: <CAL1e-=iPzgQhFvHfeDnCHPdLvOAboYQrhZZmBGwoEARoK-S3-g@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [BUG] nanoMIPS support problem related to extract2
 support for i386 TCG target
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 13, 2019 at 9:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> Please see the fix:
>
>   Subject: [PATCH for-4.1] tcg: Fix constant folding of INDEX_op_extract2=
_i32
>   Date: Tue,  9 Jul 2019 14:19:00 +0200
>   Message-Id: <20190709121900.25644-1-richard.henderson@linaro.org>
>

Thanks, this fixed the behavior.

Sincerely,
Aleksandar

>
> >
> > Yours,
> > Aleksandar
>
>
> --
> Alex Benn=C3=A9e
>

