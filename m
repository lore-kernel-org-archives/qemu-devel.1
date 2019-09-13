Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E667C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 22:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE8F20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 22:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZvwAZio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE8F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8tqC-00045P-2I
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 18:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1i8tnz-0002iA-MX
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1i8tny-0004Mo-NW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:12:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1i8tny-0004Md-JK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:12:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id z26so21582579oto.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:user-agent:to
 :references:in-reply-to:message-id:subject:date;
 bh=m+QBJ7zVRfOKa3D2J0m0y3b1N94L60s/ke1B5ZIvHRs=;
 b=vZvwAZioIHPvETQjIsDkNs1QOzHhrU2cq3SdRTCBOakuWqLOyBIpPrq+vBzmZ/dg90
 V/evjYV8Cp34SN0WNLe0gCWZ0qLozyw1PuEfp8PnleZST2LzCGY78aHSfKa9KAp9tM3l
 1JqEzhdZ7YOPNxicKHVbbkufJRJi/yaABD8PZF8VqMYzbo5DZponhGxfaHMO4yaQf4Mo
 UZfIK2gQMTbvL/pBlECpRA6YdkLOoIuHEXuu2hKANmFHm+6qLnxIdczU3JW75Iaxo3gO
 47+2sIASW9nXzcM5RqdHnf+NnT9eWrFwGzCfFlnkMIDqNxqHVZygeXHvPTrbHfWzsBx2
 ZiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:user-agent:to:references:in-reply-to:message-id:subject:date;
 bh=m+QBJ7zVRfOKa3D2J0m0y3b1N94L60s/ke1B5ZIvHRs=;
 b=IvdhFhnQDOt43kJkGn1wM0APpG7nY3pFqnsDUKdgIzsVoEC0MXCSYOtwWKaTo/5Msl
 raq4velyA6eKsHPqBIlxeYNnROGwMu/Dy3WoBctBkKydAbGLigR6QxUy1veWXgV4EEwE
 uJuY8Yu881ZJdtw7G2h20jR2++tLkxRV2yloSo+4eEMmUoTcIbsBiNCY8rJnJ2EmiUAP
 04SUXLo9LYbUjG67A+pnZtBpCaKNOepTZ/3ZztkCnDdPGa9Q+2IGgpwmfiO/FHCI74OG
 rAfmFUt07+CSBzyz6RKJukjlvd0p5YzWtnx4nnWrUTPFoBxbQEVBJbvIMV3olQZ76IJI
 5Usw==
X-Gm-Message-State: APjAAAXelddLMstWnwnkCIh6W4M5lmUe1PcmtKwc84oCXTiFhb0XaUYj
 0r1yukLSzBY1K1tonJuxFYQ=
X-Google-Smtp-Source: APXvYqx+iBzVeZggv0HyEGQA9db5038sySiAidO6RMAIdg1DjrsQqN5VGlEVPSAQq3+iR+6zBP4bog==
X-Received: by 2002:a9d:6014:: with SMTP id h20mr18683882otj.306.1568412757674; 
 Fri, 13 Sep 2019 15:12:37 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x16sm1202321oie.7.2019.09.13.15.12.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Sep 2019 15:12:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20190905131040.8350-1-peter.maydell@linaro.org>
 <CAFEAcA_K_mj9A-_sMkK52h82V0CexD2Tc1RCYMxP07oCv2AXGQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_K_mj9A-_sMkK52h82V0CexD2Tc1RCYMxP07oCv2AXGQ@mail.gmail.com>
Message-ID: <156841274385.21077.13441232514102900622@sif>
Date: Fri, 13 Sep 2019 17:12:23 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: Convert invocation
 documentation to rST
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Peter Maydell (2019-09-13 08:28:36)
> On Thu, 5 Sep 2019 at 14:10, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > The qemu-ga documentation is currently in qemu-ga.texi in
> > Texinfo format, which we present to the user as:
> >  * a qemu-ga manpage
> >  * a section of the main qemu-doc HTML documentation
> >
> > Convert the documentation to rST format, and present it to
> > the user as:
> >  * a qemu-ga manpage
> >  * part of the interop/ Sphinx manual
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> > Now we're out of release we might as well get this in the tree.
> > I saw a new manpage in texi going past the other day so perhaps
> > if we have the framework for doing manpages in rst in-tree
> > we can avoid adding too many more files we need to convert later.
> =

> I'm planning to put this into a target-arm pullreq since
> I'm doing one anyway.

Ok, sounds good to me.

> =

> thanks
> -- PMM

