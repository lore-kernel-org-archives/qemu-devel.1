Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8B4C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBC0216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFTLRZ1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBC0216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShc9-0000Mw-KW
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:42:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShar-0007ia-0o
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShaq-0001UK-6m
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:40:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hShap-0001U6-VP
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:40:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id c77so11658619wmd.1
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=4gUoSOtHM7EmjVYdXkTbZPZ2KJrZvuf0H5L1g00TcZs=;
	b=HFTLRZ1hv5qrRIolJRESw7lcLVKprKKTBCarW9iGENeyzcReQXWiO9vbyoWCrsBDv9
	3/h97uOZgJf8R2Yqut51bMKzdmzy4DED2Xkoe3c2bBJT9Qn4YuJ9VrZekZTjAbkANJOI
	piQgGadjv/7qg3oqknuI3amVvib7FPUsaL8+X44u+EqrEFWKrzP99IP1OVYwg2u3Q/GA
	VKAgmi82DdLlIAGJ3pKOEGHGOl1jbVNtp1+/qznaMuv/Fd0Y1BnTSLTYh+olMVv2JQh0
	xOOQKSWuZdN9y/rSQmnxVAW8HN9P5S7jy1LE+yTvXOsYxKEXeSO8ETNajQWTqhOaURUw
	hvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=4gUoSOtHM7EmjVYdXkTbZPZ2KJrZvuf0H5L1g00TcZs=;
	b=InjfH6TQlH86FIhxiPSitoIGdlsVIqlmoaykSw4Vufc4GUbNNwM5VR2xB7CZhq1YmU
	vw56gpI4x59MfFl3i0uwhS+yMokNybwXTBDigne7MPwhulIsJA37V5owToNgrI5myhAc
	2YJIEyW1ZIjPYBK43W4/udSIUmfMAgqWilPd4/Qda2F2S2GMhCTigfog1N2sihfvf+k6
	te3Bx5sZ2NzclSN1KWPUF8iZjUENJgh3X4tp3nxPC1t/2el+bYG3okhzZDxsTnsbwH+3
	dhKhZ7oBsSJBbGYEzQlGVkgDiFPRtPwM2VfsNoWoJjQXU1766zs3lfPhR2ZyxvAblHv7
	r66Q==
X-Gm-Message-State: APjAAAXi7Hu+CtB8jr6aYroRUoFcrFoijF9VYrx+YUZpFFxnzbeCUYgd
	QWZPZJiU98WPCB40TRDtwwMaCg==
X-Google-Smtp-Source: APXvYqzFtYsfuxGUSvvmFI5D/JoaUlc85rjwwoSKdNcxSdtTZbkQIcuFt9TcjY8z0SPwVLKBCO+fjw==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr31083552wme.1.1558356038597;
	Mon, 20 May 2019 05:40:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d17sm11011515wrw.18.2019.05.20.05.40.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:40:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7A5711FF87;
	Mon, 20 May 2019 13:40:37 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-25-arilou@gmail.com>
	<87a7fnmx2t.fsf@zen.linaroharston>
	<CAP7QCohe8gHEUhSed+yVi4gkYmJx+KoYzAikOs4uFNAWHxQgwg@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <CAP7QCohe8gHEUhSed+yVi4gkYmJx+KoYzAikOs4uFNAWHxQgwg@mail.gmail.com>
Date: Mon, 20 May 2019 13:40:37 +0100
Message-ID: <87tvdpguyi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v9 24/27] gdbstub: Add another handler for
 setting qemu.sstep
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> On Wed, May 15, 2019 at 8:44 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Jon Doron <arilou@gmail.com> writes:
>>
>> > Follow GDB general query/set packet conventions, qemu.sstep can now
>> > be set with the following command as well:
>> > gdb> maint packet Qqemu.sstep:Value
>>
>> I;m not sure about exposing internal values to a protocol like this.
>> Maybe text based flags would be better?
>>
>
> We kinda have to at this point as this was the original implementation
> or we might end up breaking up the "API"
> see commit: 60897d369f10b464720d8a6de4553c47943ea927

Ahh yes I see. TIL I guess ;-)

--
Alex Benn=C3=A9e

