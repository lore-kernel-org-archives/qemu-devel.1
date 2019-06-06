Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63900C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC9820693
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBjXiBCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC9820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35424 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvqI-0005xT-Ny
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:06:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYvoJ-0004cY-Cq
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYvoF-0005Es-OD
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:04:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYvoD-0004wi-82
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:04:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id f204so699005wme.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=MFZwjqngAKMBaP+xnH3h39P7c7M9bUKbHgKuvIcCFk0=;
	b=lBjXiBCXDmOoEFGOV+PD/hzXb5MdRoLp8xUaT+B95k//r03SP73U+sqDpZXTcqN/E6
	tkvWRYhfUtWORT/5j4JnW0OUPyx64JrKrOuugrgBx9QD8cIdYInZv5CsOY0NuhRoLwrc
	oguARcohr3ZZsfVSa6P4R0RFevZfWFPM/BwnbRdV9+S6AfjmNmbblWMZPysZPeX7nF1L
	8iiwtgNbAPdEQw4LLlRPLok3aWo/Nn7WZsHuXV0lCj0kIS3SXz4WvCyQrNVnCrrfWetB
	1Ai2PNrJTIC59Ru3uNc3cjRZuCgugMjL2zbNeRiAh8e4lpwfrnXDc2O8gC4Q/alO/J3t
	m+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=MFZwjqngAKMBaP+xnH3h39P7c7M9bUKbHgKuvIcCFk0=;
	b=rLjEIh6RWW27nXppodqQ+r3VJw2sIftPTHhnbBEhhoVcewJ/+Pqzive+VinDepvjnT
	qNA1v72vThoSHxFTuUnk80BVI7DC+feXb+iU1XwlR4svsjfgmR7j/qnaIbKESB+uzVhn
	WcXFy+zWavzQOpRapI+1I1Jj/GkuMXAHreYedJqM3Ga+GUN+x3fMdES/yU78FJSPtFGy
	vK7gkuNUZ3dVkTRN5KhQtpJ0nwKfjlMB+DLKeoMFT+mbxm7EM3Mox753eVLfAHCk0DHo
	B5w5xhk1+HrdXnxQ9HAcuK1sXcUxneJhz1RDAnhldWQR9sFIg6x5uKh2idTwLRIcrLze
	2UEA==
X-Gm-Message-State: APjAAAUrp28WFdBDD/euWZHY1THwCsQCAJRyYBCmRfyjCopqQTKQGjZf
	268BiF5yao2ARQqeQWaG+NBnBQ==
X-Google-Smtp-Source: APXvYqwPmUmY8SVZVyoqsH83iXhMQHzuMtSM4QfqTTzEtvSOicP7n/6ycDWdAu4eSqaEF/C2eD81Ew==
X-Received: by 2002:a1c:a483:: with SMTP id n125mr684666wme.3.1559840648723;
	Thu, 06 Jun 2019 10:04:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id w3sm2423151wmc.8.2019.06.06.10.04.08
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 06 Jun 2019 10:04:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id AEB141FF87;
	Thu,  6 Jun 2019 18:04:07 +0100 (BST)
References: <20190606154310.15830-1-alex.bennee@linaro.org>
	<201906061857.12470.randrianasulu@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
In-reply-to: <201906061857.12470.randrianasulu@gmail.com>
Date: Thu, 06 Jun 2019 18:04:07 +0100
Message-ID: <87k1dysl14.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] cputlb: cast size_t to target_ulong before
 using for address masks
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Andrew Randrianasulu <randrianasulu@gmail.com> writes:

> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 06 June 2019 18:43:10 Alex Benn=C3=A9e =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>> addr1 =3D addr & ~((target_ulong)size - 1);
>
> yes, this fixes my hang! Thanks!

Can I take that as a:

Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>

?

--
Alex Benn=C3=A9e

