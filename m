Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEDDC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D9D2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYfrDRcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D9D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53261 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJth-0001cS-0b
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 08:11:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJsg-0000sg-VJ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWJsf-0003vi-7B
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:10:02 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:42125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWJse-0003XU-Ck
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:10:01 -0400
Received: by mail-oi1-x22d.google.com with SMTP id v25so4168666oic.9
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=OrFTzN+jqMqcIP2JrzmuuxQexNH9DUV3WVSk0vtUHFo=;
	b=iYfrDRcLdciAOVQOWBlSrW2dP5TdwdVDSWuBbZhUHwq4lyRqlItfDPsgXyARQv07H4
	ov6UQNO+4eDtcHX6m7L75NnMSlI5B9f2HBZObnoaXBZGj4y7S0cxojM/1GnYorPF3Ndh
	1c99oKEfMmjCBji/Rk6FE4jBNR5ctLq97eUq9C+2R0jiE7Cy6S50GSzFsyf0xnZPpemd
	8SpRIXuYbwzM2LpH5ryEkLJNiZAFJHjr9vSJ6alQqpS8c0tt7K4VCXfbomIuOlSZRqEc
	DIlzkCIlWmmC3qwQ2h1Q6AOQQnKbiCYN556uYfNDqwluuznUVBf6YP/vhQkru8yPjtjR
	XWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=OrFTzN+jqMqcIP2JrzmuuxQexNH9DUV3WVSk0vtUHFo=;
	b=TtmQt7NMRPQM3tPgU5IimaVECU3CoxBm7G+Wh1szlRFq20tscuxDXC1YPL/AqMTb1O
	Ozpto8W3RlsImGqi9Kq8J/VEb1cFopn0V7wBS+wy8UrkoLRED38tQv5Q3Cp1NnqX06Zx
	AV9MqmLQQw41g6YwZoxpGdcP3wuHLfIFQi3VwO34kn5eC7DK/e+/zcSFSFxI5qLLKYnH
	1CIEIuxOW57gnddk4VCBtP/fTo5ynn+5C0lbBxvBX2r3MaKztg9NZz01bt7AQVN93U/l
	2aKOlzqDDwVnqKB9ruGMh9bVLQ8zuo1KjTtzpW7SET+KMq0jN9vZ/3z+jju3KkBxFFmd
	qT1A==
X-Gm-Message-State: APjAAAXk92uUYZHKF/w9kSs9xejpbFe7Ra4g2CzqCTcBvt/7blXcuk7C
	9nkKqKdX4RRpIPlE7c6Js2n1vofvZk3Y12vqsuJo/g==
X-Google-Smtp-Source: APXvYqxR0aJwsiQhNRMAcOqLWS90cAOINMw2zL3IKbka/udHh58Po83I1HDDmSxG5qMMrtbK4fv3jt71e2Frn6duYUc=
X-Received: by 2002:aca:cd12:: with SMTP id d18mr2141955oig.146.1559218195118; 
	Thu, 30 May 2019 05:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235842.29453-1-jsnow@redhat.com>
In-Reply-To: <20190528235842.29453-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 13:09:43 +0100
Message-ID: <CAFEAcA9jKBsH0m0mp5_ExtdRbATZ2t7638YVZ-hXzPiq3MCg1w@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL 0/3] Bitmaps patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
	qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 at 00:58, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to 403bb8185ec18267fe47a0e304d26a17263572dc:
>
>   iotests: test external snapshot with bitmap copying (2019-05-28 19:33:31 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

