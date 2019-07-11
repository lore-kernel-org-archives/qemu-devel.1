Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BADBC74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567C020838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WerzwgHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567C020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlSrD-0000zJ-C6
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 02:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlSqI-0000XE-QA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlSqB-0004qu-JE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:46:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlSq9-0004jr-0S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:46:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id 31so4953155wrm.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+K//a5zAJLT6JyFs7cdEkxXODnV9izfAM+X65UAE1GY=;
 b=WerzwgHRUR6oxu1xRg6ED/o31Y77AJGqBqRf/dBQZzYFoUc+0qP9jqZj918jCaovoU
 miw2CDS7me8GC9qSMgh+YM3oYEEQ2x3RuDDts4FWfpwKK66q4V4Umk5QeI43u81VLGo5
 piKqnQ7dibd7aKq/q1Pn6DDTkechQU0pVFkG5O8M6k1hnKZB6A4PlFr9IAF12IrxV8sF
 kf8WGZbMkjjOTK3zQRD/Z/+VyG6vW/PT9qr4FT2B+WAEdbEr+5jefpi4xDXmh/at4Mov
 sLUt33LRwqpcfaaKGKf2yoFJ8VdDfwvbYv/ekYy0jrq2wHmHtjtVK4OZSOXJCdgS6Fje
 Ha/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+K//a5zAJLT6JyFs7cdEkxXODnV9izfAM+X65UAE1GY=;
 b=Tf1ZAJLpxM0ZyZzmeDmd2JAYOLnIDJ944bOdp7paOoHWdYsurUFFtJaDbUjLObV9EN
 bPf3jvAhE2/sc8xQvmjKZP0ggL9ew1xqHTbGg2m4W7Isky+N5scjCGATQ3k5m0k+rFwr
 WEDureXJ8GXuvABM+ndxRcKsgCtk9qXnZAfo5XqSOObPgiAqvpQyYT7utfCWBmVFzxI/
 xgfGAMwLMjNiiq9dpucUVHVdsCoDtgWYjp58vqfTZiA4YZNLV98je+BnMtXNyD741BQ9
 2tMK3pK781llxshnY4fxRYDWMxkooNQjFg6BD5y3z5caKR9dWtZtCzewzr1fHlgdwRu8
 xk6A==
X-Gm-Message-State: APjAAAWdNSZtxyj19xCo1/irNaNFAnICSZhXN8plw9Y6u2QBjgK8H/a0
 W00k/aIvgSlBjam4CXD4w2XHFg==
X-Google-Smtp-Source: APXvYqxudsDlcTs/KKEImRJTgBvJSQ7n+YZu6W8a0NSH/LnIM0mWnBarMEdQEv6p9+JUyfmtfmG/Lg==
X-Received: by 2002:adf:deca:: with SMTP id i10mr2638962wrn.313.1562827550512; 
 Wed, 10 Jul 2019 23:45:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w24sm4144949wmc.30.2019.07.10.23.45.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 23:45:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 242361FF87;
 Thu, 11 Jul 2019 07:45:49 +0100 (BST)
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <CAFEAcA9cqbD0HjLmTOzF_fGHGOXeBhnJ0uRoQe2kQqeNYgTdXA@mail.gmail.com>
 <27b955fb-5852-1165-c5fd-c8e047f1375a@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <27b955fb-5852-1165-c5fd-c8e047f1375a@gmail.com>
Date: Thu, 11 Jul 2019 07:45:49 +0100
Message-ID: <87h87tdq76.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> On 7/3/19 6:01 PM, Peter Maydell wrote:
>> On Mon, 1 Jul 2019 at 05:43, Jan Bobek <jan.bobek@gmail.com> wrote:
>>>
>>> Add an x86 configuration file with all MMX instructions.
>>>
>>> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
>>
>>> --- /dev/null
>>> +++ b/x86.risu
>>> @@ -0,0 +1,96 @@
>>> +######################################################################=
#########
>>> +# Copyright (c) 2019 Linaro Limited
>>
>> I'm guessing from your email address that this copyright line probably
>> isn't right :-)
>
> Haha indeed, I just copy-pasted it from the other files; the same goes for
> the rest of the source files.
>
> Any suggestions on what it should be? I'm not currently employed by
> anyone (as Google keeps reminding us).

It should be (c) 2019 Jan Bobek as you wrote it. The license text should
be the same (assuming you are happy to license it, which I assume you
are given you are contributing to RISU ;-)

>
> -Jan


--
Alex Benn=C3=A9e

