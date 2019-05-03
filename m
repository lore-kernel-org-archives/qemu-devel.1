Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0CCC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8468B2070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEDK/eaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8468B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZkT-00042B-T3
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:05:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZi5-0002Pf-4T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZi0-0008Si-UY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:47 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:44625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMZhx-0008Oa-EW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:43 -0400
Received: by mail-ot1-x32d.google.com with SMTP id d10so452056otp.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=G0fIRemkfFntSQ7/A0AdRDDSInJ+9Vrfm9muU0cuwSo=;
	b=zEDK/eawqpvc7oa8PRGJZ/ub9FyFcTfUGKW46nVBQUJJjYv7P21Ba4VzZlCSpb9O23
	f3KZoF8fT/oi3EhK0tN+/Xsm88D8kvZlr4kiZ19QqJjFebV8mlNCMIxFIMZP59CW78HC
	1B4ypEmezAapzCSDUjT8ovYi+7gw+vTPjmLHR2WhX6ZaZDMBwaud5QOgeuzqHDrTrD7e
	8wxAro+5FsB76cxbcxHeMJhrgegqv/n2zr7EoW5W220maowmzthgmF5zlBCn3KOi5MiR
	dOwKcUewAKTRjCsbKyL8ovr+snIZORujxOFdTtOF+9pyVolqzAjp+VsXOXiJqJW2ZR+k
	vpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=G0fIRemkfFntSQ7/A0AdRDDSInJ+9Vrfm9muU0cuwSo=;
	b=V8qc1J57bJZ52xyh1hRNkeY/i1FGh4mxK/n7vHDZtg9CiGsU3gvQKrl7zwkr2klK1W
	6hovjw8axy36ryIJKgdNBbSQTpRmZd0bMzSelA8/jC58rVGMQOEtQBzn2shij0ZAE1Ai
	DwutMlnhxeaPtINcvYdWtxO8jY7yFFnNLi3k52wPZqOinz8yzkooC/QDimWiCJ7WfP0w
	1QYgSBxPmqB7ZENhlNsJJ7mXPuBpFHX1cD12SivB3x+TGhi8uFpDrhkug5YOXMlJj0ug
	utGRgfGV1+RhayN2a2Cb4jRoadWoxjiVuE59NpMqrhk9ihc0rxOTP3y+l28OkPdGvVbJ
	DOWQ==
X-Gm-Message-State: APjAAAUKbYh7Fg0VFV7GLUdLBeN7pQlpxk2YFwe1tIC1A/Q2saX4+iSy
	nelVJbPffBjFCg2lanni3u2xkknq7qEUkmeuVl/PJw==
X-Google-Smtp-Source: APXvYqySTMgO52ukSox2oWL0i3Mcoc1YeRbqvl3v3PLR/+TAadufBMYYvWxZJPgvctZCDmDtwYK1AMboChoOYWZ1JMg=
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr6282493otp.151.1556895755562; 
	Fri, 03 May 2019 08:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190503004130.8285-1-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 16:02:24 +0100
Message-ID:
 <CAFEAcA81mqN6gDcyW1vzsnER-7CMzsdWreZ93X8Z6b2vCL_2pQ@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] [PULL 00/19] Python queue, 2019-05-02
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503150224.uy5NM8v2GC0u6v81gnV_dimIBlTtX7HZVyf2WCyuLxM@z>

On Fri, 3 May 2019 at 01:41, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to faf441429adfe5767be52c5dcdb8bc03161d064f:
>
>   configure: automatically pick python3 is available (2019-05-02 21:33:27=
 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2019-05-02
>
> * configure: automatically pick python3 is available
>   (Daniel P. Berrang=C3=A9)
>
> * tests/acceptance (Cleber Rosa, Philippe Mathieu-Daud=C3=A9):
>   * Multi-architecture test support
>   * Multiple arch-specific boot_linux_console test cases
>   * Increase verbosity of avocado by default
>   * docstring improvements
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

