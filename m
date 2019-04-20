Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BF2C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 01:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0B62183F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 01:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZv47wji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0B62183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHez6-0005qj-Vq
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 21:40:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHeyE-0005WG-UR
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHeyD-0006Lo-H4
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:39:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHeyA-0006F0-Ta
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 21:39:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so3271069plr.7
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lG/yh66FA9yQ7vHc1mdl5yepKiF7EK1XzUZp4kT6vZU=;
	b=wZv47wjiL/7yOUJNJSqLp82OIlS7Z1RDr141I9M2TjD4d06xsf5l6r8M2Nrvqz5IB3
	B44I/wvxoF3F9umc/rbx/SXVWEZL3/a+y2T4HYfp3PGF+ejK07wQxlVCdUQHzbbnAf66
	3y/GDYbq9QSoDIZd5d4K/9nOxmsoxS5fy4fT1RopNlkKCagnpkDh97G59LlstdVxPUAL
	SoPRlmdCJvgMthnw+IwfL/mZqwLtk5MmorOFyKKzCRYNOQDZjuhyagjtTWQit2PwDfjd
	zEvigiRv2Ngws33mS2uWmI2lH0mpEbkAhHo8yOQlkSLmw/ORDEC7OuJE7TY3UgIE05i7
	KoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lG/yh66FA9yQ7vHc1mdl5yepKiF7EK1XzUZp4kT6vZU=;
	b=Kv4XyIZHlKaNBVzFYLD8tcnh9ioPGMn/FxUR88SvZVHEnJVb+yIoxXbnTXX4BfFEbs
	3L+7hmTmHrWwARajN8KWtOGkvMiKoZdmIHQftz+Ycpw5/Xpg3qxUd9iGgDTcgmAxRhRy
	w6K7kcSZyTmZ2fRIMZ19Ur9TETUbCzH5Uz5Is8otzajT/wkxA1skp2puGKm4KY8SrA8o
	C9abfgGxkdraZUsNDn/49LZxQa+F/BWAD83tBYWkop2nYhIktVsRUkxmZpR4yBEh3zdB
	D1Ds2npEZX43EGtZMb9MWlQgqzIgRW0mxvq2bHC8gbbVgyCNfM1YXr+I/sFfwhqT75+a
	8Ihw==
X-Gm-Message-State: APjAAAVR4T+z2EWZsoHVV4JN33u+feBHDi9x8efcZq4Pc+NtdByraPfh
	nl8585jq6Evp8m/fGwnq0P4+vQ==
X-Google-Smtp-Source: APXvYqw8ts588Gi9zgg2Enoe3BWzvaqcwhUrovCTE9nqH1MAQ9aCd0UgHF5tTDz/5Eaq/cO1XMh4lg==
X-Received: by 2002:a17:902:b713:: with SMTP id
	d19mr7224529pls.54.1555724343812; 
	Fri, 19 Apr 2019 18:39:03 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	o81sm9816068pfa.156.2019.04.19.18.39.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 19 Apr 2019 18:39:02 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190416083150.19649-1-richard.henderson@linaro.org>
	<87zholfvcb.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b0d8bc0a-cd4a-ed3a-a1ce-aeb8d5ce5ec0@linaro.org>
Date: Fri, 19 Apr 2019 15:38:59 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87zholfvcb.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: Fix launchpad 1824853
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420013859.0cYQBKJLDbx5OPVf80vZjpwMGKweUYlk4tiouiAhydw@z>

On 4/19/19 1:07 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> This is a case where we generate more than 64k code for a mere 231
>> guest instructions.
> 
> I would like to know more! Are these unrolled vector ops or something else?

Yes.  E.g.

  ld4  { v0.16b - v3.16b }, [x0]

will generate 64 guest byte loads.  Given the size of the code
generated for each guest memory operation, we should probably
change this to use 64-bit loads and dole out the bytes manually.

Even for linux-user, with direct host memory ops this converts
to 1k code.

r~

