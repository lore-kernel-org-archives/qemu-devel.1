Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4399AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1A0217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJzHKIXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1A0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXQ9-0005r9-2j
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itXNc-0003qn-9g
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itXNb-00054R-6N
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:46:12 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itXNa-00053u-UX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:46:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so29632564wrw.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5xKiMzSEGHS2fUZurP6rjaTJo1Wh8KwDH5AODe83M/M=;
 b=yJzHKIXhYc566cN/6OhpofH49l41rdDW6KxCtH+7C7X55vH0jIsOYkBgur/kXowVj/
 EX+bdlyFjAmcI76f34bT+ROBVL5LaFxGn+1jBBToRCYptGu3obpBvh54rAQz9qodPpAB
 uHFOwcsKbQok3b7DjG2mdYEO/KlCySf19qhy9gAj2Op1Le/QScYrznMslJXVqBLZyTmU
 kEXDVjF7kbSBVUHLOxNnwYbwtRwuiXW93X6PQnqFicrRwPzdW2JKzBMLQ8Fs4KymNI1T
 RurlS34PUrCwsdpdOIMefQsNz/SWZFiAe1ziOPh83FWUEC2daU3yIFNJgXmiRJ/c5o6Y
 mwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5xKiMzSEGHS2fUZurP6rjaTJo1Wh8KwDH5AODe83M/M=;
 b=nlLkcI0quuD/nB91Q3X3gmzYxYvchPlV/ZsFVwfttXpvKsHGDlgB8i/JIlpbvzl97G
 7t2/EKtMhv2NpZhie43OGC8b7M0B2zyEZpr6fFRtw1bDG+zFyPK59A6yQ5Mn3kkdWNY7
 9+ak3ThKNsfWq8W31j8s1GRe3m0M/b6zPY2Y/0GdfncAQCkMjgUwoS1Gx+oKHPVW91Y0
 Afn9AL0KP5h8iarF2RfzjvDpdAvxZ82C3UE6hMldnReoJiZgBc246goBOgEGjqukHayV
 Vf6otBEt3mQkBhuKNtrSKXjntao4kVOcwUOkSa7JRy3F/8CQHp0SxtmAOFWzvfFBMjB7
 ui5g==
X-Gm-Message-State: APjAAAVQx1rMJ9U2rhZYZmUW40gwraMhY3Ujo+s3dr7049v2xC6P3qj4
 rW4PG3GUuJFouhg5j5bgbafEgQ==
X-Google-Smtp-Source: APXvYqzLgdVYXOKHk+wgpJH0wn5yJLXI3BxEEKPXKUH4KnaanvDtPG5h7RdoPfPeyW7FH3N36CTxKg==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr17645046wrs.424.1579527969703; 
 Mon, 20 Jan 2020 05:46:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n8sm47582298wrx.42.2020.01.20.05.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 05:46:08 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C72D81FF87;
 Mon, 20 Jan 2020 13:46:07 +0000 (GMT)
References: <20200117230245.5040-1-richard.henderson@linaro.org>
 <CANCZdfpNWaLOureeFTc78+EoAW+t9tu+NzcO7d61=AwuTQWDDQ@mail.gmail.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH] linux-user: Reserve space for brk
In-reply-to: <CANCZdfpNWaLOureeFTc78+EoAW+t9tu+NzcO7d61=AwuTQWDDQ@mail.gmail.com>
Date: Mon, 20 Jan 2020 13:46:07 +0000
Message-ID: <875zh62qcg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Warner Losh <imp@bsdimp.com> writes:

> On Fri, Jan 17, 2020 at 4:03 PM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> With bad luck, we can wind up with no space at all for brk,
>> which will generally cause the guest malloc to fail.
>>
> ...
>
>> The choice of 16MB is somewhat arbitrary.  It's enough for libc
>> to get going, but without being so large that 32-bit guests or
>> 32-bit hosts are in danger of running out of virtual address space.
>> It is expected that libc will be able to fall back to mmap arenas
>> after the limited brk space is exhausted.
>>
>
> The biggest abuser of brk() is emacs, so according to one old wag
> this should be 80MB. Eighty Megabytes And Continuously Swapping.

Is this related to the dumper that it uses? I guess the new dumper
system isn't a problem as I was able to run emacs -nw -q on the buster
image without problem.

--=20
Alex Benn=C3=A9e

