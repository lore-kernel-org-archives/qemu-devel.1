Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA53C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E739206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgnR4vH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E739206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGUHV-0002Qy-Hw
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 17:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGUGl-00022C-RR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGUGk-0007I9-DF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:05:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGUGj-0007Gn-Sr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:05:58 -0400
Received: by mail-pg1-x542.google.com with SMTP id k191so6692770pgc.13
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DXQDJW/GZpgCFGfUj4CUzQ53Vsf+VnXm/0i+gV8sOE8=;
 b=HgnR4vH10zbeYAHoP3OOBzEcEl2AiIkT2f2+4oEuFOwr8/Q2XYgpwkl2AEd4+8OUA5
 oo0aTTP15pFdBEDMgti+jL9oLak9kG3H3AZwFtW4e9x8KbpipSeJoMmvl8sJKem2uLqH
 eXZ2txzLX/E6i5v06WlEOKOz3GVBiS0N+gXR04UXO7LulX4IuK/kxxZoZhu7UY4EYgu2
 adrj5sNnLWhMXE2Qk8ehqY1Sh99imazkIe0fE3uxtmyQ0t1wm7ET7I0N/bMqw3S3EXOj
 +4iwN5fu26qucRzzArzJDvcbVtG45RQGEI7RP+N3WQVB43l5BKTS5r4whNxPy80gtp26
 qqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DXQDJW/GZpgCFGfUj4CUzQ53Vsf+VnXm/0i+gV8sOE8=;
 b=KLs6gQpcwEZoe9oPqPveBMmJzp3tPme++Mvf+g0QaMzvvrRNZGXuRqh3CWCcvKsbb7
 zAge584Pax6HXhQZ59m94U3NFdbXZTnTBjqYIqDozRpX9OkE6HmlzUa84912Pj0T9axF
 +n+gMGXr4T+pw6+lwtee0S5piGDnLPh3BflOL/8dX9qdx9sIiS8gSs9efQ2dgdGGhlqr
 8oXaUYZmBR7danq98/0NFjSuxGrjk1I237t48MsKSNdtpLSk0ZSqZl1de6KZ+IE2Siyw
 PRZe7rlytXhv1Cti44GU5SqUphV2fSGnTHyhGnGymILocZs+EEWDNed8dt9FGFvjGJCn
 wV7A==
X-Gm-Message-State: ANhLgQ13oV793bJJC1Fo1aY9rmXjQBwuzpJgholUYmdo1ZseYOo3YVkr
 AF2Mh5Ja+zL0/rhLLGN8Z84+k7Cq8ko=
X-Google-Smtp-Source: ADFU+vv75ZfzTVnqMYMt26tOCwumibkdwK3Mn18iptTWkYk1ZOeHqrPkD5h5ZFKGu64x5VeIeDMm9A==
X-Received: by 2002:a63:7451:: with SMTP id e17mr13102159pgn.234.1584997556004; 
 Mon, 23 Mar 2020 14:05:56 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 a24sm13771698pfl.115.2020.03.23.14.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 14:05:55 -0700 (PDT)
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
 <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
 <de0bec3f-473a-35d7-5a26-3bf79eee6181@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da97cccd-9a28-7aca-3b50-6f8181c3f299@linaro.org>
Date: Mon, 23 Mar 2020 14:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <de0bec3f-473a-35d7-5a26-3bf79eee6181@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 1:33 PM, Laurent Vivier wrote:
> Le 18/03/2020 à 20:46, Richard Henderson a écrit :
>> On 3/18/20 6:57 AM, Peter Maydell wrote:
>>> My set of "run ls for various architectures" linux-user tests
>>> https://people.linaro.org/~peter.maydell/linux-user-test-pmm-20200114.tgz
>>> fails with this pullreq:
>>>
>>> e104462:bionic:linux-user-test-0.3$
>>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
>>> -L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
>>> qemu: 0x40008117e9: unhandled CPU exception 0x101 - aborting
>>
>>
>> I replicated this on aarch64 host, with an existing build tree and merging in
>> the pull request.  It does not occur when building the same merged tree from
>> scratch.
>>
>> I have no idea what the reason for this is.  Laurent suggested a file in the
>> build tree that is shadowed by one in the source tree, but to me that makes no
>> sense for this case:
>>
>> It's target/i386/cpu.h that defines EXCP_SYSCALL (renumbered in this series
>> from 0x100 to 0x101), which is not in the build tree.  It is
>> linux-user/i386/cpu_loop.c that consumes EXCP_SYSCALL, and it is also not in
>> the build tree.
>>
>> However, from the error message above, it's clear that cpu_loop.o has not been
>> rebuilt properly.
>>
> 
> I removed this series from the final pull request as the problem doesn't
> seem related to change I made in configure.
> 
> I didn't find from where the problem comes.
> 
> Could you check if you are always able to reproduce the problem with master?

I could not replicate it today with master at 787f82407c5.


r~

