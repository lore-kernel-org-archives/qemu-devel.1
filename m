Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B127C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96832085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhU3X0y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96832085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaJP-0008NQ-5t
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:29:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQaHg-0007Df-RW
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQaHf-0006ki-Am
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:28:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQaHd-0006fj-1z
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:28:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id q15so3471877wmj.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=FOBIwleDOITLjJTRYiV7KAftp8+vkxSSQrHmlaJusGo=;
	b=mhU3X0y+uYTPTAzE73MRSqSApann6Vk7hQ60zpOq9/swjsXgKKABcyUljWgGmihriE
	iNJNce0JdZNpCe5tGJSVOvz19w9VDsiPO9DvVTD78p5XcjDlr71otOg9a60Jvn+fnpgl
	rt3SADik5Vp7PxUWFLDBHNqOAKvY4eC2qSlCY+OeI//U1CFmFZAqXlOhZjBaJDGAMt67
	OG9MPUXgpKqzRoJ5OwaBlFB75D0gPR8dDuCBmbPpJKfQ3N9UBrr/vcvAPBAc5zm5pdbj
	ZJ8Jy84iZGu5CY606lNDzl+0ks2/OCQyTslsPXfH/gUdv88KLxUB73YYeyl3jB8nYPYU
	DmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=FOBIwleDOITLjJTRYiV7KAftp8+vkxSSQrHmlaJusGo=;
	b=jp73yhTOjHE1Y4PMgPBZKH7v/pDCnbB/z5DasC34YNSgco9a21V8s/0ArKU/ooBen8
	BdJUbTmJC176vHziT3AbG5RiMOOtcLdU/2vKo1lwLhgxaCNfKOMTZsF/xuCvI+kBMOYO
	1On096ZeWqdELxu5Klg2f5OIL8E7aQ2iOlPl0R1gttzcLiHiFP7M98jVoavBIGBujbkN
	b4ah6yF2qbucXVPf4Uq+tF3S9J9RqP5nG5cGh9BuJ46zKG4m7OF4LLK3NSUuTX1t8d1P
	LvYeAtuD4vL4xVSPzJcRXdOWHKqixOayEL6zLM6SkIYpc4q1Bfl512ZkjYyg9nt0sHq5
	rxuQ==
X-Gm-Message-State: APjAAAWVDWSGZw0Lo3ysfifQuE/ivboywY7TSB2OJwzjiwgtvy3BUy+a
	IHUChldJKtLb4iUnAieZe12NPw==
X-Google-Smtp-Source: APXvYqwmq4DQX6wziXY2TM8VtNu3Fugld/+NNnGkilf45f3jZutcE4OYozyyPBI9tRMnox5hAqlkpw==
X-Received: by 2002:a1c:9e04:: with SMTP id h4mr21254964wme.135.1557851281789; 
	Tue, 14 May 2019 09:28:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o6sm41353506wrh.55.2019.05.14.09.28.00
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 09:28:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 8BE911FF87;
	Tue, 14 May 2019 17:28:00 +0100 (BST)
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<20190510185438.29533-4-richard.henderson@linaro.org>
	<CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
	<87bm05nijn.fsf@zen.linaroharston>
	<e7cc54ef-c40c-1ea4-792b-b3d44abe7739@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <e7cc54ef-c40c-1ea4-792b-b3d44abe7739@redhat.com>
Date: Tue, 14 May 2019 17:28:00 +0100
Message-ID: <87a7fpngq7.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PULL v2 12/27] target/mips: Convert to
 CPUClass::tlb_fill
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, peter.maydell@linaro.org,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/14/19 5:48 PM, Alex Benn=C3=A9e wrote:
>>
>> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>>
>>> On May 10, 2019 8:57 PM, "Richard Henderson" <richard.henderson@linaro.=
org>
>>> wrote:
>>>>
>>>
>>> Please change the title to 'target/mips: Switch to using
>>> mips_cpu_tlb_fill()', or something along that line.
>>
>> It does seem a little redundant as "target/mips:" already marks it as a
>> mips specific change and viewing the log you can see a series of
>> architectures being converted to a new API.
>>
>>> Also, the reason for changing the field access_type to mips_access type
>>> should be explained in the commit message.
>>
>> ok
>>
>>> This commit message is generally poor, as it explains relatively
>>> unimportant logging issue, while not explaining the core of the
>>> change.
>>
>> Surely the core of the change is explained in the main patches that
>> introduce the new API? I think it would be redundant to repeat that for
>> every individual architecture touched. It's a shame it's hard to
>> explicitly reference a patch in the same series as the commit hashes are
>> not yet permanent. At least when we fix things referring to the short
>> hash of the original commit is fairly easy.
>
> Except in the case the maintainer is sending a pull request (like here)
> where he can manually fix the commits. Still this is a PITA...

If there was tooling that can go from a patch series to a pull request
then maybe. But generally a PR is a series of patches that have now
passed some standard and can now be sent. I'm not sure I'd want to go
over all my commits and re-edit the messages at that point.

--
Alex Benn=C3=A9e

