Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE5C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC3121479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FW+SN7+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC3121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1g6-0005v6-Om
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:18:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP1eA-0003q7-A3
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP1e7-0000Ja-I1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:16:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP1e5-0000HO-Rk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:16:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id w6so4947765otl.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=JT1gDJekzHKbnMdRbVfyHbxZONCIOc1jr/u/6nkz3aA=;
	b=FW+SN7+AJFTfkDxZYpLeN1X7PropI3RsSA4UzqRznvHi1Cf/+5950uw2SJIxEjIIwX
	FzAjHhpSnDrb7WAABGV1aHrLh9lIwwYqwVHDxlNcHpQnBaE43ieF/PQLgX+ogyMbVNzl
	zFrnZjY80TM4xwj7WxTygX3F0aAAC9oEcTW8gnDr62uYhqi5SzladU1YJjqvgaJfCSSa
	ARLdX98r6S7q2rIUPznLySOmWMrHIbGYzOOjLCI4MsjbFZlUsjilGT8MdBpx+hy7JdNk
	rPT3tGUIaKgP6w4yR0y1lEdYzoPCFtqhsqKfoAo6NpovbUal3NG66XuoYgCGY0sZnHaK
	WKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=JT1gDJekzHKbnMdRbVfyHbxZONCIOc1jr/u/6nkz3aA=;
	b=nykHdUH8mDeKclyBfjZwyjIn6gT1FGflrLLqk0pvjnJlrvUufx6mgacPZy59nOZ839
	HKQZ6hT5ZMjHEWaz0qVPE5yNyKWk4KuOrc4Ho/pv3mjh/ZaHiEJ1SYA2t/26jnXRHNqV
	9CVrsxNTLR1Z/x/3MuT3CgYHc7A0GVobYH6tYOgmm9x1GeR8m/R2akwKJ3VFAHZvyX+T
	Et5TZETdFDmUeleQHaHR06tQ33hXIeduigGknSCLI+VBrfcYhMPD93WKT1u+HprMclL1
	3afEPRVnpcUfSNpGdfoLqlud275jNKaNAwCFFZQKvU7QRo2GV/YFkG8p5NaP/OjCQZmC
	VFiw==
X-Gm-Message-State: APjAAAVYjx+7ZCA4ObGjTGjQDJes7fmYhMTllefmlmuv80T+pYW0RyaS
	FaZeO7Iwt6T/0q7danz5cgg8us0uWA2nZRmzKXjYLg==
X-Google-Smtp-Source: APXvYqwcbk/g4RqLKiqNVBYfLnBmqH4OEVvugsNoC5fB/tCK1DuUg4mR2qstLat1OnEFsdxuRi5gW1P50cU0A1tpqGw=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr5022687oto.151.1557479807630; 
	Fri, 10 May 2019 02:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190510071557.30126-1-laurent@vivier.eu>
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 10:16:36 +0100
Message-ID: <CAFEAcA8BAoqwdP-3cECUL2sLXQr_PxbdYBzMmZVEan3HcE8YVw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/7] Linux user for 4.1 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 08:18, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 68a7b9724fe80bedb85060bde605213ce3f9ba=
ec:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-05-09 13:36:10 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to 6b333239ab1a4fa98f07f907f6268484a8514d1e:
>
>   linux-user: fix GPROF build failure (2019-05-09 19:08:13 +0200)
>
> ----------------------------------------------------------------
> GPROF fixes, GCC9 fixes, SIOCGIFNAME fix, new IPV6 sockopts, elf fix
>
> ----------------------------------------------------------------
>
> Alex Benn=C3=A9e (2):
>   linux-user: avoid treading on gprof's SIGPROF signals
>   linux-user: fix GPROF build failure
>
> Alistair Francis (1):
>   linux-user/elfload: Fix GCC 9 build warnings
>
> Daniel P. Berrang=C3=A9 (1):
>   linux-user: avoid string truncation warnings in uname field copying
>
> Erik Kline via Qemu-devel (1):
>   The ioctl(SIOCGIFNAME) call requires a struct ifreq.

Hi Laurent -- it looks like you forgot to fix up the
author email in this patch, so my pullreq-application
script complains:

[staging 181447e27a] Merge remote-tracking branch
'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging
 Date: Fri May 10 10:06:35 2019 +0100
Erik Kline via Qemu-devel (1):
      The ioctl(SIOCGIFNAME) call requires a struct ifreq.
ERROR: pull request includes commits attributed to list

Could you fix it up and resubmit the pull, please?

thanks
-- PMM

