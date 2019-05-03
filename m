Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A5FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC942075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McvEG3fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC942075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMdsR-0006bG-HM
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 15:29:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMdrI-000621-St
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMdrH-0007dI-U8
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMdrH-0007bI-M7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 15:28:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id m20so577724wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=+gqxTGF/ChV4o7QyQnnRHshU4JzoStasUpUagKwTS2c=;
	b=McvEG3fdFgmgzocPJLffNIamurek9wvgRK7wrS3DkBC4fGDlT04LtHbQEYKSXn0XfK
	/0AvD5phTAWjrkVwwv4GE5MjpybGB69BD0tT+ozQxATwhwVO0tLLQzbq9R0YZKbt2TDZ
	SIycuIqXcAublpmQ1wOz41ctgtGX7XnU+YMOzudosjOcLSbnPobjxWePXC5c8Bmta1pH
	nQ+jvIsJzxJttFAQ0VSdQcuYlVVdjeaNeXxclyTCdcY2y3tMQUcPxPl9CSPA5cq5W56+
	g0Y+OTZbgdrcsP+WGuj1DeimG1Op7IfFVfaBm9jR1PgaIOVtaIPF2I6c6hZ2/XQ093KE
	TU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=+gqxTGF/ChV4o7QyQnnRHshU4JzoStasUpUagKwTS2c=;
	b=FYppHDl7JRbPsjEgvEvdF41BqpwQMfq/eYP01HOS1cDOZrubWZTjhmpgjBKas3TyYR
	D4ZdUBKj086FQepBbChanqAZGjQaXh2xnbpBEO8/rx4JGdjeSS3E1MvuYVSabWAMlGLU
	Uv9CpmThn+0cFi03GHqqu8mM7cbnZFuWiEryziIB6xInITc6VcoAkISZJ6vcFTPPwWM2
	+RxFPa42ZCnrmctB30BYNpMOVpU/vRwUs/t/E8G5OJT5fe23Orfu4axLdiQsIz7S/GQA
	/CReR4WS3VMul8JePNF6iTF4S+rjpVtkR9bSOxOK7j3XhTOi5zSwKBLUP/JcXySP6kre
	EBKw==
X-Gm-Message-State: APjAAAUVNF5LHbp+Vswl+c0ORO6hDuVLJfwxN/t5QKGtSmvDZ4s7YTn+
	+iToV8qbglN6uB5MzDeS+HygLA==
X-Google-Smtp-Source: APXvYqyVGkdgsZ0RxxN/DJhNVEPjjjTlKR/KWzGsTxBQdAq21N+K1U6oZbP4tJiunj8Jm/hSvndS6w==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr7220577wmc.49.1556911713552;
	Fri, 03 May 2019 12:28:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z9sm3894156wma.39.2019.05.03.12.28.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 12:28:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7684E1FF87;
	Fri,  3 May 2019 20:28:32 +0100 (BST)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<9a538ea2-358a-dc61-b2f3-f8155c1a2283@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <9a538ea2-358a-dc61-b2f3-f8155c1a2283@linaro.org>
Date: Fri, 03 May 2019 20:28:32 +0100
Message-ID: <875zqr49sv.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus
 tests/coverage)
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
	cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503192832.rCK69VmneDvqn42K-vR1h9rMDbl549i1bkky9eCpcS0@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/19 9:52 AM, Alex Benn=C3=A9e wrote:
>> I've also moved the existing system memory test and made it multiarch
>> and added the bootstrapping for aarch64 system tests. I would like to
>> add support for Big Endian as well but I didn't want to delay the
>> posting of the series. It would also be nice to exercise the
>> ioread/write paths and other handling but I leave this as an exercise
>> for later.
>
> Somewhere in there you're adding
>
>   -chardev file,path=3Dhello.out,id=3Doutput

It's in the default runner config in tests/tcg/Makefile

> but there's no corresponding use of the chardev.
> Which, somehow doesn't seem to matter to your aarch64
> testcase,

Argh.. it's because -semihosting is different from -serial and doesn't
allow the usual redirection rules you get with a chardev..

> but when I try this for alpha I truly get
> no output at all.  I needed
>
>   -serial chardev:output

or -serial chadev,id=3Doutput?
>
> to populate the file.
>
>
> r~


--
Alex Benn=C3=A9e

