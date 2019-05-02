Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5981FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CA52075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9mDzlIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CA52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDHx-0007yR-8R
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:06:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMD2a-0003qU-7Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMD2Z-00027l-DP
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:50:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMD2Z-00026R-5I
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:50:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id o4so3799896wra.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=X1mNWOmhffCzx2k9No0rkdDegd4n/3DYpoNVf3NyGFQ=;
	b=W9mDzlIcXTfLVZSjnB19VjaQsuTmBEcJqtlOHPAPqMuuma92gOw2PvpeWf8PZJZfj5
	d7h5HsNMfhR1BuyhRpoPprVSu98hVY3xwmiZ1hH/jW47P5kSeN3nEXc379oioEwSxQo7
	7Gs+VrpX2nFp/sKWEECneivXEoAr86vB+Qvgu73RAbiq89exJkL4qXMvIPvZG8kmccAL
	oDRU4ETKMTWlCCAAN4cegMnqeiWk8hPUc7xwFrnT4Cch5bXmau5ms6W4lv7ndADqbmYC
	hDsF0T0w/Xbz4zxCOE8CvKqk9He/FmNmlw2StFp/4HOxd3jhpyjLe5Geq4WsicwhznVG
	sK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=X1mNWOmhffCzx2k9No0rkdDegd4n/3DYpoNVf3NyGFQ=;
	b=U9TTyNpC2a7hw3eOR6oVROot3jjxo3pZdw/RYTWRyUJisNBpDnJVH1LCkq0xxBsHwx
	EfVFHWUseLKa8wZQlE4FLacjsFBU2btSBAjA/cJ7yPJXbTBSBHyUoNnV2K1ZNPeIL2e9
	mviTFjFaPrTeIGkMe/aAWhSZDjUwAoxRxdDxEkk5Q7EQ+T0AAN/Ngp9OoOQkXFj5++9V
	B6rwI9Iq6VhFbL5ZNtgaLXCV2NcquQRsLJ/lQxz8elK/QULTWsXmeIqsOvDWTMpM6fs6
	ZDwIIZ/xHPTHiZOrDFeeSCmbcnXG1eWA9NSLkrTehKy9bASpyznMWKiTs3lPFulyq8m8
	MoXg==
X-Gm-Message-State: APjAAAUu5e6QAETzupbCNfxiP4VKw5/PAJzI18E4lbroBfl6QKHozctX
	INX4u8mzQqQ/uwbwWun1DgVi4Q==
X-Google-Smtp-Source: APXvYqwjD7bjm1HXrfYjrPm7k7wYY9Ph9AnoAJh62U671Bh4P0hDF2v+mIzn4ajuwHRxOA0FH02PTg==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr3096577wrw.311.1556808625460; 
	Thu, 02 May 2019 07:50:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d3sm13339471wmf.46.2019.05.02.07.50.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 07:50:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7552E1FF87;
	Thu,  2 May 2019 15:50:24 +0100 (BST)
References: <20190502092728.32727-1-alex.bennee@linaro.org>
	<CABoDooPLQAGi+gtYX+jPaZk9=OgGOLwpJdwfJML-aKMiHu3Azw@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
In-reply-to: <CABoDooPLQAGi+gtYX+jPaZk9=OgGOLwpJdwfJML-aKMiHu3Azw@mail.gmail.com>
Date: Thu, 02 May 2019 15:50:24 +0100
Message-ID: <877eb86hcf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix GPROF build failure
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502145024.-GIX13TlFBDnUcTwMTD61Rw7zVkrA7PttkS28TJdv2U@z>


Laurent Desnogues <laurent.desnogues@gmail.com> writes:

> Hello,
>
> On Thu, May 2, 2019 at 11:31 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>> When linux-user/exit was introduced we failed to move the gprof
>> include at the same time. The CI didn't notice because it only builds
>> system emulation. Fix it for those that still find gprof useful.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Sadly running programs then fails because of the SIG_PROF signal getting
passed to the guest. I wonder how this ever worked?

--
Alex Benn=C3=A9e

