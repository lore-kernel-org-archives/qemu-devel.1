Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807F6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC912070A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ae5X1N1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC912070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivPqI-0005bI-Hz
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ivPpZ-00059a-BP
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ivPpY-0005SQ-1I
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:06:49 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ivPpX-0005P9-Pz
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:06:47 -0500
Received: by mail-pf1-x443.google.com with SMTP id 62so2775337pfu.11
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 10:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q5g4omBeNcDIHxeacwbhBiUNww+gLEAuo56iL6JptDg=;
 b=Ae5X1N1p4jy9mkcf7eJikXm4oUcUBI/Pb930L1H9FD3oOWYaJ/IvoolJ2RJ4er3NVJ
 Wu+vVllRfzijYyKcWrfu/t07Rzqm7oiAhCjkHo15t0LDDDmoN7VC+/IGEH7dzqY8qll2
 eOxsl2ZKI4VI9bvmDAkztujWwkSYg2aGQ9tl9dfe0y/B+jsXm5iGtB+dHo2+a4PhvRpV
 uBrvw+hlvdu1gy23ABGcljL+rFRi6j57ZvjaQIJmNq7Z+62tdLNpirCR7yd/NI+zpCpQ
 ktw5NLI7NbwMTdIFC4nAI7RA3LC8BNa2SMynCZS4gAWBsDJDp/8NX7A9HxsMcf5cJiKR
 iNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q5g4omBeNcDIHxeacwbhBiUNww+gLEAuo56iL6JptDg=;
 b=MJIM/wDpNP+bmyfvKGCgpHgkEzxuGAwsiqxkzupYTZjgd6g8Eq8xwdyhwyfmyYGMAw
 ncf+MYSLIbVBacviUTEd2E1/qhWvP6klxhIY97IAWR6WhHPaSNhKD65mMWiPPCiU+sX/
 nXkCWyB2h3kJujALueAdU81fi3K69nsRA0U2uZ/4WyH4UeIF6Y6pKsTTuBa5lh7qvZUs
 5c5HxHh1Cm8W1bKZOZHWBrBiSElvbqWm9fyv2p+yViasRgRbnXmrmDNTATIyzzhikG1v
 LcK4T4EAk7wbVpmz2yH5j8MuJJBBS56/vcXvmVVYZTJw6AXqRWCywNWIDgPhmPpXQuwy
 cwCg==
X-Gm-Message-State: APjAAAVPe0VYshggNvwgZ9sV2NYceWmU3jfiwjyau6p8O0kKQxUVPDEx
 9sl+ctsbovmKPQIOby9gKUA/4Q==
X-Google-Smtp-Source: APXvYqxH+s6Jl6l1gBywhluv+kUq13OojiaNi8NwHIO7Rib6SfXu1BLFJmUcO2xNMoqZrA3YshQxjw==
X-Received: by 2002:a65:5809:: with SMTP id g9mr10828177pgr.146.1579975606096; 
 Sat, 25 Jan 2020 10:06:46 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id l66sm10819490pga.30.2020.01.25.10.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2020 10:06:45 -0800 (PST)
Subject: Re: [PATCH v4 6/7] disas: mips: Add micromips R6 disassembler -
 infrastructure and 16-bit instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
 <CAL1e-=hqgWesfm9f8fsSQ8JS54LybNMMGygbCNi0O+VyfSAJvg@mail.gmail.com>
 <c3c80f0a-e348-4c7c-e8c4-579b16ec22a4@linaro.org>
 <CAL1e-=g89vC8gw6xNiGcNAhDixX2xZgnDjKgvDsChkvHHpduQA@mail.gmail.com>
 <0d2d0fff-302b-b8e6-cbc6-5c2bb66f1f8e@linaro.org>
 <CAL1e-=gsX+_G28i3MbFn3qLW7YKyQapaAdEhpkCKtvwS6juHHQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c1b65e3f-ea37-ebca-e47e-1fb1a30df9f2@linaro.org>
Date: Sat, 25 Jan 2020 08:06:40 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gsX+_G28i3MbFn3qLW7YKyQapaAdEhpkCKtvwS6juHHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/25/20 12:22 AM, Aleksandar Markovic wrote:
> 
> 
> On Saturday, January 25, 2020, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 1/24/20 1:38 PM, Aleksandar Markovic wrote:
>     > On Friday, January 24, 2020, Richard Henderson
>     <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>
>     > <mailto:richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>> wrote:
>     >     The thing I'm concerned about here is any future maintenance of this
>     file.  One
>     >     would surely prefer to edit the original decodetree input than this
>     output.
>     >
>     >
>     > Here is the deal: This dissasembler is meant to reflect the
>      documentation of a
>     > particular ISA, and as the documentation largely stays constant (except
>     adding
>     > some insignificant errata), the disassembler will stay virtually constant, we
>     > wouldn't like even to touch it, and we like it this way.
> 
>     No, this is neither right nor proper.
> 
>     To review the code in this form is significantly harder than in its decodetree
>     form.  That is in fact the whole point of the decodetree form: otherwise we'd
>     still be writing these sorts of parsers by hand.
> 
>     While there's no license on this new file (another problem), if as assumed this
>     is GPL 2+, then you are in violation of the GPL.  From section 3:
> 
>       # The source code for a work means the preferred form of
>       # the work for making modifications to it.
> 
>     You cannot with a straight face claim that the generated c is the preferred
>     form for making modifications.
> 
>     Finally, suppose we improve decodetree.py, so that it produces code with which
>     the compiler produces better code, for some metric of better.  We would want
>     this disassembler to benefit as well.
> 
> 
> I think you got some things upside-down. A tool developent and usage should be
> driven by the needs of users of a tool, and not dictated by the author. Users
> should be free to use the tool in any way they seem suitable, including its
> modification.

That's exactly right, provided that by "tool" you mean QEMU and by "users" you
mean everyone downstream of us.

Let me state for the record that I object to this generated file being merged
in this form, for the reasons I stated above.


r~

