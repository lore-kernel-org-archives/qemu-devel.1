Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E5C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A9F20879
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjqSfbLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A9F20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6GU-000240-4n
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:13:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU6FM-0001a7-L1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU6FK-00020u-Kk
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:12:16 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:43290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU6FI-000203-Tb
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:12:14 -0400
Received: by mail-ot1-x32b.google.com with SMTP id i8so8042411oth.10
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=60JCe7l2JWP4sehBKJJERLet5QCiY9u4tAkFYAVZTUg=;
	b=LjqSfbLqBc1mWmciy6aXo6MNuw//Wvh8DNia61VPsGdu6XMID+GhdNQBXFtAknCo+V
	+T5C0C435O4ZXpho7SFF7GVLAAD2G48FrNW33WL70T5qkwRvh/qcJ8oCVeR8rrqi6/ez
	thfa2EHR2Fb0scZ4hj00Qddi7RlcDMKecm94STfpiAz834oM5QN7nZU+0VZS5aKr145c
	VCeuej1GmbU89JUjprKpYTndDVpOibvjiL8Y6r2GSFL0CTlquzLXxTGQAOiApmBA3SOv
	PLLc2VgGuutDA+0IST2ud/JI26k+iSgpx7XTxKj+kb1dyDJ3C/9/dqpWh0WGwO6+BGDD
	D/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=60JCe7l2JWP4sehBKJJERLet5QCiY9u4tAkFYAVZTUg=;
	b=R70hCPAztHcBNHWcoGBAszKSq6qQHQdCZTtFqw23ndI0/U3oW5iQ+EYdGMYjg4B1cL
	b1NxplgAPkJQKYGY8uVaCXP+Ryrajs/ga79leZwRp6j0Y208hz5tS54jERpyZu5xQkIR
	kvMoN8fbwaPt9o41ez7H5DIezCvQPyCyE4elTlwkYRRTquWGU3PhVW5lIqC67odBOi1C
	ekLbY/APpnT9IbPWLz/7wWArauwQj6gO+rzC40YkKMdZqAHwxY0vXDYL90+66qznWupW
	b1TmHYr6eeim1rHGNoaberSaFB+L+1M7VWNa65nNiN919qr9qqnkxVtY0VMStiwEHqcz
	WOYA==
X-Gm-Message-State: APjAAAUwM55B0CIdHJf+ck+pEt63to+f6Pph2QVynWz6rWPuFq7vATFL
	4ZohNetFx48Ywjxza6yG4LQQJhJt6+9aOm2faQMx1aBVbhg=
X-Google-Smtp-Source: APXvYqz1iTiodKQ+piwyrPeNyibIR2qIFi0UJ+0KfOXCq6L5f3z+T8dkjTUzY3tbfJjpCuDZe9BZ/qTxjgHBCX3/8rA=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr24597287otp.91.1558689132227; 
	Fri, 24 May 2019 02:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190523140059.18548-1-richard.henderson@linaro.org>
In-Reply-To: <20190523140059.18548-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 10:12:01 +0100
Message-ID: <CAFEAcA92zfN8N+ym7i8Ao=GpwUXhxMeRZk3nj608=7upqGup=w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 00/13] Add RX architecture
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 15:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Thanks to Sato-san for persevering through 14 iterations.
>
>
> r~
>
>
> The following changes since commit d418238dca7b4e0b124135827ead3076233052b1:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-rng-20190522' into staging (2019-05-23 12:57:17 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-rx-20190523
>
> for you to fetch changes up to fe7ddbc2dade3daf767c9ac07b8569791b5376a8:
>
>   MAINTAINERS: Add RX (2019-05-23 09:38:27 -0400)
>
> ----------------------------------------------------------------
> Initial commit for the RX cpu.
>

Hi -- I'm afraid this fails to pass "make check":

[...]
PASS 29 qmp-cmd-test /rx/qmp/query-name
PASS 30 qmp-cmd-test /rx/qmp/query-kvm
PASS 31 qmp-cmd-test /rx/qmp/query-uuid
PASS 32 qmp-cmd-test /rx/qmp/query-events
PASS 33 qmp-cmd-test /rx/qmp/query-cpus
Unexpected error in qapi_enum_parse() at
/home/petmay01/linaro/qemu-for-merges/qapi/qapi-util.c:39:
invalid parameter value: rx
Broken pipe
/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:143:
kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
Aborted (core dumped)
ERROR - too few tests run (expected 51, got 33)
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:884:
recipe for target 'check-qtest-rx' failed

thanks
- PMM

