Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64353C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E767216FD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k4ZYHUqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E767216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDYp-0005Rs-Dn
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:23:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDXm-0004mX-SZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDXl-0004cr-Tv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:22:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDXl-0004XS-Md
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:22:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so3963489wrs.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=YTG+nUXAI89emsfbts5sIYYpbOEKGBHcFtd3k/9PtY0=;
	b=k4ZYHUqBaE65z+1APZw4nnVVVZcNpLCxmZLIRzJPZRJdC/dwSP+dSInHQ4brOZJB9f
	bPRi7IhpqZ2WA7LAt7AV9fo7DII5cUGlr4XVSmU6O2LIbJtSmq1rFNzuecAHFhfYDJmC
	F6rV55naWqe8bbtCNdlKalm9FsDSm7GRvGuxkKBX42wXufSjPRgXryr/dfvJymuE0E1O
	BleNwEimGuDQwxAaYBm4HMOTSXPKMMwwBuoYh9wfsJkrMGLB04kNVIbdPQb8AYfI+BCN
	/j8ixNRxx900zocHa6EghcE/fOdjkeNB+PcI9rEnAsMm59TD7ewhkKLc/GQa7REGp6gL
	lrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=YTG+nUXAI89emsfbts5sIYYpbOEKGBHcFtd3k/9PtY0=;
	b=a3bln3MusFGc9SVf8Q6qJBEUGQYNgXqPpo81+bhucTvtUMdZzjzm+V9+IOpJoOCqBi
	FoWhvpwRKioOyJfC0m9840kWmIRHO6LYDNkyTVRf6xk2b+Yo62ioaOY4ks49ftLFN5Qb
	3X8vmzcf72pmfWEw/eHzYuWCcZIclmdTfJ/CnAaQfAoMAzel9xr3s8K8EEbYj/njUEDk
	S4hSAnWzhtdKq1XzW4lt7OK/ocolj9DQXcSfqRQvAKyAeZgwMzCwOAqxNJvGEAk2ZzCW
	4CUolo387frRFVP1dGPHQGVKdcSeSyqQ8iTFgV5NXsx9ecq4vI1UAHagFH/A0mm1pujS
	dI9w==
X-Gm-Message-State: APjAAAVCnNpXPTedHcicZJ4IV4RMy+eRWf66m+cNa3ueAb7rkyoxxiWo
	pCkXARHZ9krO8CDSnI4D7HKGsw==
X-Google-Smtp-Source: APXvYqwlpR9WU/GkYMCt6vpE37DUfBKo9GSCY8WeCA6rkQD2S8IQp/d2gmwi7XMOblQ3LSgFjPI9tg==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr3261588wrm.44.1556810558941;
	Thu, 02 May 2019 08:22:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id h9sm7486462wmb.5.2019.05.02.08.22.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 08:22:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id F00DD1FF87;
	Thu,  2 May 2019 16:22:37 +0100 (BST)
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190502040459.GE13618@umbus.fritz.box>
	<5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
	<87h8ad5e0h.fsf@zen.linaroharston>
	<e7318909-cae9-eef5-7f59-c9a2992fffeb@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <e7318909-cae9-eef5-7f59-c9a2992fffeb@linaro.org>
Date: Thu, 02 May 2019 16:22:37 +0100
Message-ID: <875zqs6fuq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
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
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502152237.MDX-PH28llAvZ9Yg3mtr9sWyxhY1E3FuLNCkdqFJuVo@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/2/19 3:47 AM, Alex Benn=C3=A9e wrote:
>>> This needs a different set of cleanups.  ;-)
>>
>> I guess this is another use case for softmmu support in linux-user where
>> HOST_PAGE !=3D TARGET_PAGE?
>
> Well, yes, but I was thinking more short-term, wherein we do not test thi=
ngs
> that we know will not work.  E.g. testing 4k pages on a 64k page host.

I guess we could add something to configure to emit the host page size
so we can conditionalise the tests. Or just fix mmap to take advantage
of the fact that getpagesize() reports the host page size and nope out
when that is greater than test-mmap -p....

>
>
> r~


--
Alex Benn=C3=A9e

