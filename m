Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531BFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2038D218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kig303A/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2038D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfZc-0004Ao-VX
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 15:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihfYB-0003Ng-7O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihfY9-0005Gj-Dw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:04:02 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihfY9-0005By-3W
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:04:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so3656840wrh.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 12:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rb87RzSReAft+27ajusbq28mdyVma0jgt4/sq+bpy/o=;
 b=kig303A/HLDq2lB7ZvBPtt4JUl6tX/odtWuX8bKWAu0djKFpDxP5hFbmvx7y94fubu
 qWRq4h3ehPLQbYBgtOlqVLLDOjlyC/nWhzkgpp+4cjJRVvCrV0SIPTdEgPAEI/eKPqqe
 lCUoGC2LLBj0UXWiTWRoU3ctwMHT1/wrcKqEN2cTRMvBHX1Caf87Gn9c7OPfHCXvl+QF
 1cmKhVFD8iTo6AWWzxa8/955c1d9JGJyAU0V1ddCBKkF9TdCDEOPzkD5+Rz5Wko5RWp7
 /XJo1+dh7S+yINp3INJvOP/5zluoREnkeedS4+l15Ir7lWLw3O+dRBgcNLRtc42fAkIN
 APDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rb87RzSReAft+27ajusbq28mdyVma0jgt4/sq+bpy/o=;
 b=ai4l9Kr5AiwzU9xYFo7ah8haWv8us3NFzBYFv6LqQsjv44eBXPorwJdROmhqAtCT0X
 ptOXhypJXQ/lFre17tiQuagixNAUXr3oKPpP1AVx3tI9igGp02EinX/Zo5fQCiqr/TUP
 WoAaU8Zy4y3yzF9TzWQZNvTouphnZchMM0oOdGuAeVFo4LP825F5JJJRtk3lpt/MirOa
 5IoqSkRucHI+KMJhUABH6mUR7BKMAy/uEgYjLAJ421ViOJVDHM9fWemnZ48t9Gm+geb8
 23rTLfzu1/mGKO6da1yXqb59Oyo4W8lTruhcrYnN+YEuUHWiyXOUTfMs1CSH6oXEzbUh
 MO+g==
X-Gm-Message-State: APjAAAWu/yXCwN9tEycZZ53VcxkUWyyXOVb2MRdQwzpTFYfUdv07Rpwf
 M/yPwdHhbcvMsAoOdjH2c+VSCw==
X-Google-Smtp-Source: APXvYqxLN0afR6r1QSjuJtnnIqsaKMtzJ5LcLG3kAxSXuer330wc3nTMZrnP3R8BKi4RIxhzu98PpA==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr4861228wrr.116.1576699439756; 
 Wed, 18 Dec 2019 12:03:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm3942980wre.68.2019.12.18.12.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 12:03:58 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C99471FF87;
 Wed, 18 Dec 2019 20:03:57 +0000 (GMT)
References: <20191205122518.10010-1-alex.bennee@linaro.org>
 <20191205122518.10010-6-alex.bennee@linaro.org>
 <0dbd7631-2258-83e8-fc96-3265cbd8d8d1@vivier.eu>
 <87mubswkdv.fsf@linaro.org>
 <65cc0703-2ddd-0233-25dc-b87a9611d297@vivier.eu>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 5/6] linux-user: convert target_munmap debug to a
 tracepoint
In-reply-to: <65cc0703-2ddd-0233-25dc-b87a9611d297@vivier.eu>
Date: Wed, 18 Dec 2019 20:03:57 +0000
Message-ID: <87y2v9e6z6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 16/12/2019 =C3=A0 13:00, Alex Benn=C3=A9e a =C3=A9crit :
>>=20
>> Laurent Vivier <laurent@vivier.eu> writes:
>>=20
>>> Le 05/12/2019 =C3=A0 13:25, Alex Benn=C3=A9e a =C3=A9crit :
>>>> Convert the final bit of DEBUG_MMAP to a tracepoint and remove the
>>>> last remanents of the #ifdef hackery.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>  linux-user/mmap.c       | 9 ++-------
>>>>  linux-user/trace-events | 1 +
>>>>  2 files changed, 3 insertions(+), 7 deletions(-)
>>>>
>>>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>=20
>> Are you going to take this series via your tree or would you like me to
>> put the PR together?
>>=20
>
> As you prefer.

Very well queued to pullreq/testing-logging-misc, thanks.

>
> Thanks,
> Laurent


--=20
Alex Benn=C3=A9e

