Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF0C282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 13:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C387627923
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 13:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJCKfUzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C387627923
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXQaQ-0001F7-V6
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 09:31:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXQZM-0000nC-8s
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXQZK-0002bH-CT
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:30:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hXQZH-0002RG-9I
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:30:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id t5so8660602wmh.3
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=1vfGlVePs2SLOw7Zlsncc7gFJutYMgJudZW+FUFL2UU=;
	b=LJCKfUzZrW0qmsSiyuJFpcepnlePpv1nwmF8BGqFV9fKQ+ioqFN40ce0CTsDLaqgts
	o00XJjW3YTwIx0MN1Yms59ioMLSafcYeu0HpuJerxkjP5xGq9LIxXn27KjwrSpVlSvaH
	1z1Ku0AFqDzpo6sHJk5Cjb2v9NiC5D4KokvNeG9gByOt8adr07Gd4ATOKYvFcqzazJGt
	bwSh3tHhprL85+tnN1ANlZkYov/7LhT2okrvTjEsauAQvZdFQiNONGZwVXwwnzklgRuU
	4ySj24AMRIq6gxymHUBrjSeNNTPN6YzNkNMAj4dl1jbtU7NW15xGZKfV6B8igZZpjK6n
	tffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=1vfGlVePs2SLOw7Zlsncc7gFJutYMgJudZW+FUFL2UU=;
	b=cxkvQ5q0swYxs6cm7A6MuV4L1+iUUCMNMEt6LyAHjQErs4+h8yG9/R2dxzjBNIN6hT
	i7a4RBLljPii3zcVplDGSzFjwwESjC51w/pM/4ToR+KBzeIFdJLq+NUBpF0auarwhIr9
	8piCuZOggJkZK2xzyQZjrsmvGTTzsBwFzO7v6StzNgEDOME6yppwLSqtayIfUvUmHa+q
	GJ2P+3WSGv4/CuE1h3afMS4r8KBvzwQwLAVB8cc6wpnmn6qi0/HDZfoQOdMKIEvb8DwV
	38IkyyvQkKUIlJH+GQRq9IoeADYBHGtqL+ImowP2MfOxnhFdRuFMuhbYDgE6sqcyYXf+
	kdgw==
X-Gm-Message-State: APjAAAWPlS2VxXBW9w4Sj28yG7+sZWQKtiuupHOp8sY5KKbPd0UoL286
	smgaIbINl5lH11V7Unogisk9KA==
X-Google-Smtp-Source: APXvYqzT2YVMLY2CJzrChTmFBHmvDeJjhY47P/ru23ZKjrp6jWvCeG7y1h8CDHJ+uytVyX7LoPlv0g==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr2508415wmg.177.1559482231047;
	Sun, 02 Jun 2019 06:30:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z193sm18105424wmc.20.2019.06.02.06.30.29
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 02 Jun 2019 06:30:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5249B1FF87;
	Sun,  2 Jun 2019 14:30:29 +0100 (BST)
References: <155912118291.12579.8926874795813611531.malonedeb@soybean.canonical.com>
	<155947076950.12691.8450256339566609756.malone@soybean.canonical.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1830872 <1830872@bugs.launchpad.net>
In-reply-to: <155947076950.12691.8450256339566609756.malone@soybean.canonical.com>
Date: Sun, 02 Jun 2019 14:30:29 +0100
Message-ID: <875zpodsi2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [Bug 1830872] Re: AARCH64 to ARMv7 mistranslation
 in TCG
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laszlo Ersek (Red Hat) <lersek@redhat.com> writes:

> Possibly related:
> [Qemu-devel] "accel/tcg: demacro cputlb" break qemu-system-x86_64
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07362.html
>
> (qemu-system-x86_64 fails to boot 64-bit kernel under TCG accel when
> QEMU is built for i686)
>
> Note to self: try to reprodouce the present issue with QEMU built at
> eed5664238ea^ -- this LP has originally been filed about the tree at
> a4f667b67149, and that commit contains eed5664238ea. So checking at
> eed5664238ea^ might reveal a difference.

Oops. Looks like tests/tcg/multiarch/system/memory.c didn't cover enough
cases.

--
Alex Benn=C3=A9e

