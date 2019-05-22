Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E97C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2245020879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK18w8Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2245020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTY8-0000YZ-H6
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:53:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hTTMB-0007Zk-RV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hTT7m-0002i2-AM
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:25:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hTT7l-0000kG-UJ; Wed, 22 May 2019 11:25:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id x64so2656545wmb.5;
	Wed, 22 May 2019 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=l7MNNmBynGEXpG/v5Du+4c7MG15VBOlXL7Lg2uQB1oo=;
	b=mK18w8SltxJ5KM+nmoit0PoThifyuZkrX69wv1wrP/tf9Qe6MFnGoN0hYL61xPWAyH
	4fgLM+hMR5nAddteMeq6Ohz+UUw/m/Voo5x4e7LPNIZQ6K6le79wKAeFrxaPyvH7A5At
	hdY0pnc1xkWCJZRo6ft+V5Xl7eYfB0nXnOboJsDq7JBHk35dC2UD3zMElWU2Z5Gm9jhF
	ueQq9PMBIQrXx6Ux45UCYqTpshWoTi6Lwh3JZS4/TfQhgbhw733dTaLWaixdCvw6Stlu
	uiJpk1TyLnLiWaejjCC/o62Pav4V0HixL8/Z7TeZ+ysoHm8jQh1GYYik7+Rc92G/mhh4
	ahxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=l7MNNmBynGEXpG/v5Du+4c7MG15VBOlXL7Lg2uQB1oo=;
	b=WISsc4CKAuNeYiMe2Kaxqw7FFuLdDsv+fiyrrHHOej2eRtnyJ80CKPavCij4FGtPFw
	PYd6HTDOBPIvOlwBTLWjlnpjEx379SOHs7DVJ3wjqk6GYY6OVzicRW75efWQRmCgbJKp
	6GOJqEaE6UY2CDwJybVgk3L0uz3A1QQ6pR9aMG4EV6ZchBUReENmlpIe0vR+kWva18uC
	e1Pdb8Py5eArjGJPg6TWMfZIO5pnPF4Xqry2pExT5ZKPBCptuN8fQXt+LuFQwAxLEeMv
	19Z7x0L/M/WzjlA5cI7/GIPx0TLxMx4zl7Ey8RSLLXLv08DMPXBtwyrmpSrdKoNsbt3/
	M9mw==
X-Gm-Message-State: APjAAAXCRfuaU/hXoMxpgfrufRRIKwFK9DvVj6vdYVXZNcbBh8ACDu09
	apXK/N2f9dRxmy5EZ12no4rXq5D8KMz4466dexg=
X-Google-Smtp-Source: APXvYqwErQCSeDISd79446qPKaEwW5S7mGhscrEJhr7QeQCybU1HMSHQokz4VY7YdqBmKeaDastRaN1B07jSquw1LhA=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr8020829wmk.56.1558538713519; 
	Wed, 22 May 2019 08:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190522000617.21945-1-programmingkidx@gmail.com>
	<b90278ec-ee66-76c6-32b5-d5aca1fb8d24@linaro.org>
In-Reply-To: <b90278ec-ee66-76c6-32b5-d5aca1fb8d24@linaro.org>
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 22 May 2019 11:25:02 -0400
Message-ID: <CAKyx-3M_zMPBuS3BntUGMd21d7xX_d1KOq_Yc21MVjEp+fZbRQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] Implement Fraction Rounded bit in FPSCR
 for PowerPC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	"qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
	qemu-devel qemu-devel <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for the suggestion.

For the added note, did you want specific places listed? If so please let
me know these places.

Thank you.

On Tue, May 21, 2019 at 11:30 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/21/19 8:06 PM, John Arbuckle wrote:
> > Implement the PowerPC floating point status and control register flag
> Fraction Rounded.
> >
> > Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> > ---
> >  fpu/softfloat.c               | 15 ++++++++++++---
> >  include/fpu/softfloat-types.h |  1 +
> >  target/ppc/fpu_helper.c       |  4 ++++
> >  3 files changed, 17 insertions(+), 3 deletions(-)
>
> Please split the target/ppc part away from the softfloat part.
>
> Also, we should note that there are more places within softfloat that need
> to
> be adjusted so that float_float_rounded is fully supported.
>
>
> r~
>
