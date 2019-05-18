Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19305C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 12:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11AE20C01
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 12:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxxYlFHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11AE20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRyPw-0002dF-VA
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 08:26:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRyOp-0001lf-M1
	for qemu-devel@nongnu.org; Sat, 18 May 2019 08:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hRyNB-00013Y-Kd
	for qemu-devel@nongnu.org; Sat, 18 May 2019 08:23:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hRyNB-000138-Dg
	for qemu-devel@nongnu.org; Sat, 18 May 2019 08:23:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id m3so9573004wrv.2
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=0VZdUeF3Nch++wkn1pZsmjfKPt5go1Jakb+zVn6hyJU=;
	b=qxxYlFHJ8BdIwr8y9GSam22H/ZsQobC4T0Dl84k6iSuYaIqNQQkvUUzRI2g9zZe1RM
	VHLlH035l1T4nfYdiSpAZeKYaxMHYYv8d120cUjZo5E81BqpPxlK2wvPrh9Fa+6llCo1
	Zmq1I1VoU+N2s13v2f7RX4F1VgVpsJtnG76/rb3oFLTAeXfk0/6PFz/u8MeHiqaRnNQk
	2HYs8UeeRERkbRHlAJmu3C9d1NKlk6FFhNSn9vWLa4FOinLpKj8wI1DUqRO4EB1fmr5h
	zNwgd56hpWOBIDuwpyBMBfNtnXgTe/tP+35BpQlgjKU6GjqERbm6HCkkPXsur/HPERMO
	9J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=0VZdUeF3Nch++wkn1pZsmjfKPt5go1Jakb+zVn6hyJU=;
	b=ZBOGIBdPFbLd1aD147VR7pco/VSADbacAscpakBBTvPtBS/iQcFutzKNwP43ezpYyJ
	Fq52tG92W7izUAWG10D8vwRyFEobI2Y6nOGp+Bwt0GNDV6BKh9T9i3dzwrkpSy5EoVQO
	9KizoObEyWHz/mMlzm3c7kdPg8ZxNwtSw393C+2druYbDCEfdtwRTfoYT1eYzBlRIb0K
	Hl8sGH73kKmS7RLM3SPnbm+dk3ZZwL3wqbfB1DZ8lOUeDp5H7qS+8Va6IHzCvHo3X6PB
	j3DTJvNFC34T33yIRPQP4Z2hT+ysywHc+aHydiMwqZ7jxJ5LtUDEPxR8LBvvZU2U/4Hj
	mzjg==
X-Gm-Message-State: APjAAAV/STR7rNbu9NI4CuoSTmSPFydNWH1QXyrG91dZ5CWADICR4qK6
	nH/V7WyrhjEyL6ayiTEFEbSsHw==
X-Google-Smtp-Source: APXvYqwmaTPjuXIsJF7QCstiHcYeAtBoe9iOS4xYSzPZwEmQz+2Lus8psHnovYxsBkZIuWPpPtA04Q==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr35897060wrn.109.1558182211455; 
	Sat, 18 May 2019 05:23:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j206sm13547026wma.47.2019.05.18.05.23.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 18 May 2019 05:23:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 605A91FF87;
	Sat, 18 May 2019 13:23:30 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-1-jan.bobek@gmail.com>
Date: Sat, 18 May 2019 13:23:30 +0100
Message-ID: <87sgtc54u5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: Re: [Qemu-devel] [RISU v2 00/11] Support for i386/x86_64 with
 vector extensions
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> This patch series adds support for i386 and x86_64 architectures to
> RISU.  Notably, vector registers (SSE, AVX, AVX-512) are supported for
> verification of the apprentice. This is V2 of the series posted in
> [1].
>
> I decided not to drop the register definitions from the second patch
> as suggested by Alex Benn=C3=A9e [4], but replaced them in the fourth pat=
ch
> instead. This keeps the second and third patches code-motion only.
>
> I wasn't 100% sure how to acknowledge Richard's contributions in some
> of the patches, and eventually decided to include a Suggested-by:
> line. Let me know if that's (not) acceptable.

Suggested-by: is a common tag for this sort of thing ;-)

--
Alex Benn=C3=A9e

