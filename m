Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3F1C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 18:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584FD20815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 18:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKTz50lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584FD20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQyK0-0005pt-5m
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 14:08:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQyIo-00058U-5j
	for qemu-devel@nongnu.org; Wed, 15 May 2019 14:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQyCm-0007v3-T4
	for qemu-devel@nongnu.org; Wed, 15 May 2019 14:00:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQyCm-0007uY-Ll
	for qemu-devel@nongnu.org; Wed, 15 May 2019 14:00:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so437575wrr.13
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=NBfPtcj2+HMzh0Ht+rrKfnIOQfjquRHAord/+1Xd2Fc=;
	b=VKTz50lWSdCNmRDhb5vyu0JhoplshYuyZFp2fpwSyQtElCHP6WqgKOZ53UgMRYH3Pu
	3e5ihSFbtgre7qzy5DdTX+VbYjCxk8om2MGaLv5xSsJ6Q2VwzCoSDAXAsgrQPDXIUpbi
	JJ1SxyLiShieufa6ORY+TkC80uq8pwnJGRzWJyKZZhMWve2sXqpC42RbbZk+NuLcqrBt
	t/a5AGPB8AbuXNNZMg3Z3ZQdaG+c9SCm8vskEnTxNQHBbEEe+q9K7+N6v0eJBPj/Z7KH
	o6tNw6JFF6QzXjjZBm1aljX/NSa4qbvzRAjLMsn/aqTFdsTSFhy3lcjmdhW0CY6LVHLQ
	1I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=NBfPtcj2+HMzh0Ht+rrKfnIOQfjquRHAord/+1Xd2Fc=;
	b=fAaAXu2OKZMx1siuGpLK7rKnmEXNx60uSOxfmUnXeInz8pm7BlRhOasm8QXHTxhQS7
	6+EtvqtoHxtUEMdrecjtkvej7XeVO4Fstd4EB9ZEKN0tGjne/CtwJuiHlQRxTSwlmMuI
	MwEPfRxWvFAuWDczeUnY1GkzGfau3CpYWVBUcZmcd23HU34n5k3gsNzI9JDbAySeScp6
	nTomz6fNbfPfoZ3mcbG6iX+CFXOEzBVylx/9s83ff+fdAOn0U3wansmD7PAk5h8APnCK
	6xGtbDI8g1XcrO8Dp70uH262Avzv0BzCzF02MMRVPPbnyHwINIoKcAy2xvdLob0vDXpj
	xihA==
X-Gm-Message-State: APjAAAVK1XVhKZ30jdE2PKOkdlq2Ixocxm+0jtuFPyA9uNDVaOsptEoF
	id+6RvYzicroEKVIEVBF+HkWUQ==
X-Google-Smtp-Source: APXvYqwjZzYd7yq3yv8g6G2+JdSZEn/xSwtusFDgu6Hc+BkjgWxM/DFxvFu9oPgVMmgkTMXf8dZ5bw==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr811921wru.35.1557943237136;
	Wed, 15 May 2019 11:00:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id m17sm3374089wmc.6.2019.05.15.11.00.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 11:00:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C1BAD1FF87;
	Wed, 15 May 2019 19:00:35 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-1-arilou@gmail.com>
Date: Wed, 15 May 2019 19:00:35 +0100
Message-ID: <877earmwcc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v9 00/27] gdbstub: Refactor command packets
 handler
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


Jon Doron <arilou@gmail.com> writes:

> This patch series refactors the old gdbstub command packets handler
> with a new infrastructure which should ease extending and adding new
> and missing gdb command packets.

Jon,

I've finished my review and things are looking pretty good. The code is
a good clean-up and makes adding new features a lot easier. Thanks for
the examples of extensions - they were worth it to see how this might be
used although we shouldn't include them in the first merge. As they
extend the gdbserver ABI we'll want to think carefully about exactly
what we want to expose before we include it in master.

Going forwards aside from the various comments on each patch it would be
worth making sure the branch has gone through at least one CI run to
make sure the non-x86 builds (and disable-tcg and other exotica) haven't
been broken.

It would be nice if we could extend the testing of the gdbserver. Have
you been testing this with the gdb test suite or just manually? Now we
have system test and linux-user binaries being built we could probably
do better than the manually run tests/guest-debug/test-gdbstub.py.

Finally it would be nice if we could modernise the membuf and strbuf
handling with a more robust glib based approach. I understand if you
don't want to do that now and I'll happily accept the patches without it
but I did notice you can send the gdbserver a bit loopy if you send it
some very long maint packets so it would be nice to have that a bit
safer.

--
Alex Benn=C3=A9e

