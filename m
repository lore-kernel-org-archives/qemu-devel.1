Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36764C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF53321670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzooFvU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF53321670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60455 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqhO-0001fY-AL
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:59:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqgL-000187-JO
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqgH-0007yE-RF
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:58:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLqgH-0007xM-LX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:57:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so24868678wre.7
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=IT6k9a77CVn82aYB7ji/cgfCAqxIlP01Bzug1LGws0Y=;
	b=RzooFvU+dTe93Faxg4dd65iwOrpXYoXRKfr1ZQmNVkWqRNOmm2bJ7U0IZItY09EMVS
	1F8qCq0YcMb95eo9Qt1tRgZtwFahoS3HkKHyGhAN9D6XnXAXgPrNqhQ0u5eSRzZRqcOr
	iZQ7wNaLOj48NOKwgKsxyTiot2QaVz4/oYBgIkPr40G2AOIc65oIzSdQ9LNAVY+2IURG
	s9BdCUr/7VZ2Ph8ApURqzlLExWxm2CFoleuliqq6qYx59y5JM1+tvId87NW7RoO/MK8C
	XJGarsIZQDyQocbQKlAt0TER8VRiuLWsj5b9Hu2RqFERPbRhHbKDShzRbkSJ8rxn1rLv
	rujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=IT6k9a77CVn82aYB7ji/cgfCAqxIlP01Bzug1LGws0Y=;
	b=NCY6P0lMq4anFsH+evrwnooZqmSrNQASAcESDIf9zYAHWTMtlYr31XYKFqLss/R4P/
	pCFVF5AXwKh3iWLG540quQueDJtpAXW5xgcyjezPAxXnZviGUQo/vAd5NPEP30ENG8mI
	7i6yG0q5oQLf4iPUd73JCVx7K48Zq7OZEfG9An6E3eQbsBOcW48ZLJ3SmbVcN8FGCJYz
	jEVTN393FlCywqR9sAeT5aSBvgXaqvL7nSrHEuTSm7Qh1gtkyz4lvEGwSi+Gp8/XGKH/
	Q2w5mtLIBNcqRCMP0kSiNliQvA4/q6CITQJMJ7flFSfvfXqz6wZZC5/MDCNm7dKAr5zF
	8rsQ==
X-Gm-Message-State: APjAAAW6NMzXXQ1kWpoqUsM1zsLdTzZniMYksex6YW/NhqMV9MB5nu+u
	2m4ejun3Gb0lTAPJ3r8bs2+LNw==
X-Google-Smtp-Source: APXvYqxJ3pTos6HLslyrM84cOMsVRqumQT8mgKdc2Retgv+ETpvVhJCQVEEk6QnMS1ymMgfDVHRKuA==
X-Received: by 2002:adf:e88b:: with SMTP id d11mr29042938wrm.327.1556722675432;
	Wed, 01 May 2019 07:57:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id y6sm3798986wra.24.2019.05.01.07.57.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 07:57:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 048651FF87;
	Wed,  1 May 2019 15:57:54 +0100 (BST)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-4-alex.bennee@linaro.org>
	<83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
Date: Wed, 01 May 2019 15:57:53 +0100
Message-ID: <871s1i6x3i.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v5 03/15] tests/tcg/aarch64: add system
 boot.S
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
	cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501145753.bdathY2DgbKbr0sk-YHqOPO-1-FYHWelyewXLowY_rU@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/19 9:52 AM, Alex Benn=C3=A9e wrote:
>> +.error:
>> +	.string "Terminated by exception.\n"
>
> Put it in .rodata just because we can?

Sure.

>
>> +        /* Page table setup (identity mapping).  */
>> +	adrp	x0, ttb
>> +	add	x0, x0, :lo12:ttb
>
> You are in control of the layout of the executable,
> and adr has a 1MB range.  Why use adrp+add?

Ok.

>
>> +        /* Create some (big) pages */
>> +	adr	x1, .				/* phys address */
>> +	bic	x1, x1, #(1 << 30) - 1		/* 1GB block alignment */
>
> Do you really want 1GB pages?  You'll pretty much only be able to test va=
lid
> memory operations with that.  Which is also true until there's something =
other
> than an exit for the exception vector... but ya know what I mean.

Yeah we can do better here. I mainly went with what libgloss had setup
because I was finding it hard to get find a nice summary of the various
page table formats. I want big enough that I don't have to futz around
create multiple page entries and ideally have some fault-able regions as
well.


>
>> +        /* Setup some stack space and enter the test code.
>> +         * Assume everthing except the return value is garbage when we
>> +	 * return, we won't need it.
>> +         */
>> +	adrp	x0, stack
>> +	add	x0, x0, :lo12:stack
>> +        mov      sp, x0
>
> You need a pointer to the end of the stack, not the beginning.
> Again, I think this could be just
>
> 	adr	sp, stack_end

lol, I guess the page table was being crapped over....

>
> Also, there's tab/space confusion all through this file.
> IMO, this is assembly, so it *should* be tabs.

That will probably be my editor getting confused because .S implies cpp

>
>> @@ -0,0 +1,22 @@
>> +ENTRY(__start)
>> +
>> +SECTIONS
>> +{
>> +    /* virt machine, RAM starts at 1gb */
>> +    . =3D (1 << 30);
>> +    .text : {
>> +        *(.text)
>> +    }
>> +    .data : {
>> +        *(.data)
>> +    }
>> +    .rodata : {
>> +        *(.rodata)
>> +    }
>
> If you ever wanted to make this read-only, swap .rodata before .data, so =
that
> it's next to .text.

OK

>
>
> r~


--
Alex Benn=C3=A9e

