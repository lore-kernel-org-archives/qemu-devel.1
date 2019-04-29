Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE0DC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577CD20656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRHjlkrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577CD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL58U-000437-Hz
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:11:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL57J-00037W-Kd
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL57I-000295-N4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL57I-00028A-I2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:40 -0400
Received: by mail-oi1-x242.google.com with SMTP id v23so7898037oif.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=SndB+j8luxvSoyoIFGCfGdOwjluHK3QkVJ3Fgdjq0oU=;
	b=GRHjlkrYZp9K9xvDgKfjvQ9OYiI6tJ5giL2S0BIPb6cvVR/eeNnV6Kq1nmJkN/xG5B
	CNy0yMlltPkFx7XIiZtBLPWJk3ra+hxLVBHcwPKgWuGOCxCwNjeCh5H39VtyY5MLO/Ww
	nOODpcE3mc69I0j+2UzBSNE6KdBP+PC5amYjFIELYKPDiPaSG51yDDmG2biyTyNqwEVO
	0siU6Y0uTrTrEmqzARKkqMN4MJrGf9NwMNkKWMrQAl/LX1nU5CFSzjbZiCYmNW+s1/ck
	a9m2K90kOVzIbVQAUU7kzKUKeADg0L2I7Y/WC8DPohJgfTUx76u1WSW1H0CpjEg/UCMo
	X0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=SndB+j8luxvSoyoIFGCfGdOwjluHK3QkVJ3Fgdjq0oU=;
	b=Bg943O1aVNM89/25y5mUyT6Z7GoIJ20qji3zbHLyjY/1VEngtmZuh7XVC5EpMxp4Mv
	DdFe7PnLf8xCbK+ZMfrrQ2UjwayqSVKsbhmQKG2TP5LNvr1Fm6TmesBz2neVLIPo+1+7
	xa3L+b0sTOZ2ODFFRrU0SwAte6wRGI9TxBLeTUNBpOku8bLo6g6CaTA70A1EoZu6AQs4
	mfmS5E7RdV/MN6b2h2jZ9d+iMdMIqxdGtR0K5/wCcWpYi7Ky9kU7lXaPspvbmnl/xMH3
	qZxRujqC8RAfHiVt4SQPxEJsvpYhk2DdrT4KICL20FRu/Cr5LO3H4yYi1yJxTghg03T8
	y5ZA==
X-Gm-Message-State: APjAAAXThBK3fighThq52R1XtvwEy20A++8gE4Y7h1Su0KiGDFgjpa+6
	jV55SJzO1g0u518fyCIEil8XR/jxL67RmUd0h1A96g==
X-Google-Smtp-Source: APXvYqx3/K8RCUT68dpYoAdIBFXLOWDl+bdQ8C0FYd2m0kOaTTKNyvOkKWTitpU0gbxj9V7pE1D56V1wqLPmnD0mB6o=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr12698319oie.163.1556539839315; 
	Mon, 29 Apr 2019 05:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
	<CAFEAcA-WeTRp0zs5Zu_g3uCjzXaqSf5-G3nyrxMn_n+fQAN08A@mail.gmail.com>
In-Reply-To: <CAFEAcA-WeTRp0zs5Zu_g3uCjzXaqSf5-G3nyrxMn_n+fQAN08A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:10:28 +0100
Message-ID:
 <CAFEAcA-7dLEsyhtyNatVYCpsptOB7ZXUYbxPrdXJwdAnHQ714A@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 0/3] aspeed: cleanups and extenstions
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429121028.qTOmHbITj29lSgOmSXFHG0Ukyaw_TFf1YApU7n9C7DE@z>

On Mon, 29 Apr 2019 at 13:07, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 11 Apr 2019 at 17:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > Hello,
> >
> > Here is a series adding a couple of cleanups to the Aspeed SoCs to
> > prepare ground for extensions and new SoCs.
> >
> > Thanks,
> >
> > C.
> >
> > C=C3=A9dric Le Goater (3):
> >   aspeed: add a per SoC mapping for the interrupt space
> >   aspeed: add a per SoC mapping for the memory space
> >   aspeed: use sysbus_init_child_obj() to initialize children
> >
>
>
>
> Applied to target-arm.next, thanks.

...spoke too soon. Clang doesn't like this:

/home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/aspeed_soc.c:155:25:
error: initializer element is not a
      compile-time constant
        .sdram_base   =3D aspeed_soc_ast2400_memmap[ASPEED_SDRAM],
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
/home/petmay01/linaro/qemu-from-laptop/qemu/rules.mak:69: recipe for
target 'hw/arm/aspeed_soc.o' failed

thanks
-- PMM

