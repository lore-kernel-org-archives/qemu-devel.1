Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C5C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DA120866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKJ5Vcac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DA120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45495 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYSn-0004r6-O3
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:08:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYYRa-0004B7-6O
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYYRY-0002Jx-Kt
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:07:18 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYYRY-0001HA-AF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:07:16 -0400
Received: by mail-oi1-x243.google.com with SMTP id m202so7443418oig.6
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lsmwWSsz6/MI7PqsBhK2NXtLBVJJvW0Xg5zFZsjHZbo=;
	b=EKJ5Vcac9KV73pDiQYTdSA0iSnYF9/GzYyAJ622EA8TvhmbMPqHwpZ5ZTGixzd1b5H
	DM5PpidV5/2jUgVcKX6mbyldVzubyR4O4n68aG0Qf0b5zbxo/i/uTJgpzQm8Xc9qcieM
	9PBERI2I2JivGuh43v3hKliHuNNV6gpmbAE83HEX+0fLAX9jaEM0lISP8abvu9wwAKSf
	MrrejtKV2jbfIDmmyP4iVDZYA7P6k/QxTJ2lm2QnHrXuniy0Edj4R1jJcqQg37T/i79b
	HSSdeJ9OKli3mAiUTp126pK1c2MtcCqtjpE0Bf6C53tN0dliF8twhZJDueZPpLBrgObz
	+J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lsmwWSsz6/MI7PqsBhK2NXtLBVJJvW0Xg5zFZsjHZbo=;
	b=fX84DHx4mvP2VexNLAgncpvu2zz5MqLK9R9RcTS4k7Sh2ft1oxhws5dUKEPt2wk61j
	W8Szx/CM70Y2I+gr1CYZCjn9PYs2uFlyEEUSAOHaER12f6Xx/TECAhhw9zX+8gAYQClI
	jIQwL/5TS1L0M+gEVse1oIbQwZZrohJc/VbN2ULbePrygfqQPOxBFkx7gMD7Qqx/c9Wj
	C/kwj84JL0V8/1loQ/mJA1tUKfxWunOBMEuDszKU5Qw5BaOa9pHuryKdkIHkRVXz66Jb
	IfrwVaSwt3vK/+j1wBXgnBsIGQaxF452RcMZ2JsZwOtV80VXa2Vt93IC09uzCoth7uPz
	CMew==
X-Gm-Message-State: APjAAAV6EG/KwSYPffINIvnZFDXpWhdwp1KjtucG0VdpFjBCd9Sy8L8C
	aQM5hthPx673aGFHoH9fKmLT8g==
X-Google-Smtp-Source: APXvYqzxnQxbLsqIZIjWBRnt45ZtyYkN6CUYS7q3yxayRRrfeQWNpeyUO+N1wKEgOJ+GEPmFMWglzQ==
X-Received: by 2002:aca:3485:: with SMTP id b127mr6794100oia.86.1559750816293; 
	Wed, 05 Jun 2019 09:06:56 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id n2sm6763267otl.7.2019.06.05.09.06.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 09:06:55 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
	<9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
	<CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
	<3bc0d426-bd59-055d-a010-b136cba555bf@linaro.org>
	<CAK4993j5JXgV9CYDckt99kwgQaG6w-GN-Tka7r2nahoh33rheQ@mail.gmail.com>
	<CAK4993jWViasj8PKUCHcbMh-9SPJmELqua9eSbFvwL7gpm2e5A@mail.gmail.com>
	<7b0c5e07-5b99-3344-7f80-847880f85b5b@linaro.org>
	<CAK4993jPs_j9qvv8v2sfZ=npGkbkMAv3HaWSYRiSqFthkvfmdA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fd701964-3e5e-fde2-1103-d38881a39129@linaro.org>
Date: Wed, 5 Jun 2019 11:06:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993jPs_j9qvv8v2sfZ=npGkbkMAv3HaWSYRiSqFthkvfmdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/19 10:19 AM, Michael Rolnik wrote:
> Richard.
> 
> We use break instruction for testing.
> (Here https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests).
> Each test is a big list of small tests with a break between them. We run the
> tests on HW and on QEMU then compare register after each break. If we don't
> implement break the way Sarah suggested we have no way of testing.
> What do you suggest?

Hmm.

Ordinarily I would say to use some sort of syscall/exception/interrupt
instruction, but I see that avr doesn't have any of those.

You could use "call breakpoint" instead of using raw BREAK instructions with
the implementation just being

breakpoint:
	ret

and have gdb issue "break breakpoint" before beginning.

But perhaps I'm being over-pedantic about this, and someone else should weigh
in.  Alex, I nominate you since you most recently touched gdbserver.  ;-)


r~

