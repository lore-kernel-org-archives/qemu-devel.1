Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BB1C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B82205ED
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsqCK92a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B82205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZs8-0000gf-Ba
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:13:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZrG-0008Hf-2j
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZrF-0008HU-3f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:12:18 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:38457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMZrE-0008C5-QL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:12:17 -0400
Received: by mail-ot1-x331.google.com with SMTP id b1so5604700otp.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=lecofhz2CfZc6Fh5iPYhjVa72mCbZtogkkS//icHXOU=;
	b=XsqCK92a2pgb12Nu88f/XJ/+K/0PREHdGiPBoVOi4CsO9NfeZU3sH1sV+4jV0N2N7q
	oK5fgj945l2+t7wOe1luo2B6ZskAvuqtwnbvsmJ1qYIprBODa132F3qxdMOwk9KdJQra
	W0n3JJ/KRHUROCbQFkcUzT1bzsV+1ADfe4P1uBxjGb1a4rQYbVDbMwNh3hwxYsR8HLs7
	A0D1SYSIxAMRErMR64dSPhxxh1J8ClaZnKgbmZ6X0k14bcAkK0BPzlP0sR2uDoqr79T3
	zDTtQKZZrfVjCeI+OZ6wgkhwKZWUS8F35o/X22p2ZwQ/Cal4YEGl5Yqztf+omRlU4B/D
	7jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=lecofhz2CfZc6Fh5iPYhjVa72mCbZtogkkS//icHXOU=;
	b=rR6scjk4joybBXA0HkxhyY/fdlO6NdqpCYOquX6h8F41I8L0GovqFWqGZJyr9pLyo0
	RZPoy9RmUbGa/3hYhEN7Tc/shpJTg7abxiyetGU1HMt2ea71Gm8fYkPJ5QhojTeGNoym
	Ho9+CzLkeMUo/PCzkbvQJVwgbMxKNn0axtS3ntzrUmrrr8mNqqhlGSeSxsCU8oqmDL6U
	Ar/0QL5BulDj8ipK5hcTmth99oGDDqNnBl8t0LHvTlFGC4knzPTyxaQTssutmVzVrfBg
	OwmRWQBQtChDu2u1FI+9suY7/JlPBNZ5yvUFW7hp/zHFZQD0vRSQy442wsIHPpeXVhTz
	C/Sw==
X-Gm-Message-State: APjAAAVjq8O3Dc7HSG0rPAa1xGu5or835UU/UJkMUwHvucPfkjKKPG+/
	E02qVqGBN1qvBvx7KkmqQw0b1uUQEezB1fT6WHbs1w==
X-Google-Smtp-Source: APXvYqzzAyL6GoJWmB0aDZJ6CPp9Sp+6IccZxC22mpTx/XorQ1nAhq4UXpxWFrKmmoI7RFfE3051P7HcZio2sgE/zxA=
X-Received: by 2002:a9d:6d19:: with SMTP id o25mr6318358otp.151.1556896335741; 
	Fri, 03 May 2019 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA-eVOZhXj+OLB+VvxXZTniny_sMCFaeWsv+2uEErM-=zA@mail.gmail.com>
	<b70484a8-b408-7c2b-7fd7-27f1c1d98f4d@redhat.com>
In-Reply-To: <b70484a8-b408-7c2b-7fd7-27f1c1d98f4d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 16:12:04 +0100
Message-ID:
 <CAFEAcA9iHz6At=siOPyc76HvNm=PQpBmTLqyPPBTgeoPDKx7qw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503151204.f3gU2IUT4JYzjWKF_Mf79Y3nLJms-UNWGfUMiKe50jg@z>

On Fri, 3 May 2019 at 16:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> FYI I was running MinGW tests with "make docker-test-mingw@fedora
> SHOW_ENV=3D1 J=3D8 NETWORK=3D1" and ran "git pull" to refresh my local re=
po,
> and got:
>
> $ make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D8 NETWORK=3D1
> make[1]: Entering directory '/home/phil/source/qemu'
>   GEN
> /home/phil/source/qemu/docker-src.2019-05-03-16.55.51.7157/qemu.tar
> slirp: unmerged (59a1b1f165458c2acb7ff0525b543945f7416225)
> fatal: git-write-tree: error building trees
> Cannot save the current index state
> Cloning into
> '/home/phil/source/qemu/docker-src.2019-05-03-16.55.51.7157/qemu.tar.vroo=
t'...
> done.
> error: pathspec 'slirp:' did not match any file(s) known to git.
> error: pathspec 'needs' did not match any file(s) known to git.
> error: pathspec 'merge' did not match any file(s) known to git.
> failed to checkout slirp: needs merge revision
> tar: /var/tmp/qemu/qemu.tar: Cannot open: No such file or directory
> tar: Error is not recoverable: exiting now
> Failed to untar source
> tests/docker/Makefile.include:203: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 1

This weird set of errors is demonstrating a bug in
scripts/archive-source.sh where it is not checking
for errors from git. Specifically it does:

if git diff-index --quiet HEAD -- &>/dev/null
then
    HEAD=3DHEAD
else
    HEAD=3D$(git stash create)
fi

and git prints "slirp: needs merge revision", which we
blindly put into the HEAD variable, and then later do:

git checkout $HEAD

which is what's causing the weird pathspec errors, because
(a) we're trying to check out an error message and (b) our
shell quoting is nonexistent and so we don't even treat it
as a single argument...

thanks
-- PMM

