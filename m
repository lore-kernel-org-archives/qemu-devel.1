Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F014FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09159207EA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmbbNwy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09159207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtHj-0006Zy-Ur
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYtGx-0005QU-5c
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:26:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYtGw-0000s1-BJ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:26:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id s8so21414068wrt.9
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kjFALF1lvGdunBjoO44+Y/yLPmkWNT/LizyU92EAQ5M=;
 b=tmbbNwy980hfhfWBLLmuCkQN9hGjWFtzzRxG4p0+ngpTY3T4dDiWGTvJQIdr/8b/+B
 sv2wT2gDSNv0jAJU7pnIIc5A4yg4h0PuQNj5yDqfPiNlZujanDSw2z6M1nYBNKMUfKkR
 tJiT0HpEoxZVg6Xev5ZsO6g3oPYz+mZLBR+BEnU9qnkrYdT80P55Ka3RD1uIT0ftKVVC
 ikzsPqf/ppc/sZZ4MyAwo4JRV91JYm0ppzYeGe7nSXfUmSzF3WyS4bmkKd5XOzFvUbTD
 StESneNUeajkwlcbGXYp8MnEHsTjg+r38gkhLPGliw1NKstPIc/psxK3TlSf+ZKZj5uO
 ls5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kjFALF1lvGdunBjoO44+Y/yLPmkWNT/LizyU92EAQ5M=;
 b=inGcSBbwZMK38Za26NQgZJcogdoWBkGI/s5p9jzwim3536eZOD5AKjfRrnj8Ujf2ow
 C/fYb/7J0GC894XIXOs0Bfamy7b+iqXDMY/OZbGVtgzGQN1/wksNQHHSRjnAstj3qDF6
 EIJ571U1MHhpJSwTQgrk+gtwUStQKLmDTYifJbPALAYtvSB6JNi+diTnKT7aeQ9KqFWo
 RTQi1LXHXSuCCTP4V07L8BCghQjSR893rw8t7hgLNOyMBjqVpkB1BvRYrWba3wq3tPJh
 mwwah4Le6Td7QwjoL35Jo2iJgMBN8idbnTjj0n/WSACaz5bOv2ZcshUTuEDUupWI+8bp
 yJqg==
X-Gm-Message-State: AGi0PuYpWFlO9Qcv76HSwbvI8rTVhNN0vI1i1eB4uyds6Pblz5upkjEb
 yi4lQ82q5V/LNrFgvTJKJmA=
X-Google-Smtp-Source: APiQypL4nthdLkOA2oHiZ6toQjU5bCGwHWZhyWWGMvQVdH9vgOkr4PcoeAIOSVCRRafjdM+3kB5ymg==
X-Received: by 2002:adf:e64c:: with SMTP id b12mr30891550wrn.131.1589383572833; 
 Wed, 13 May 2020 08:26:12 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id j2sm28276220wrp.47.2020.05.13.08.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 08:26:11 -0700 (PDT)
Subject: Re: [PATCH] tests/docker: Kludge <linux/swab.h> breakage by pinning
 linux-libc-dev
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200513120147.21443-1-f4bug@amsat.org>
 <87a72beuhn.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2839ba1a-f4c4-3a4d-cabe-d6e0e1b6accc@amsat.org>
Date: Wed, 13 May 2020 17:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87a72beuhn.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Salvatore Bonaccorso <carnil@debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 5:15 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Linux kernel commit d5767057c9a [1] aimed to fix an issue with the
>> swab() declaration, but doing so it introduced the BITS_PER_LONG
>> definition, without using the kernel __ prefix, leading to odd
>> failures in userland code using kernel uapi headers, such:
>>
>>        CC      block/file-posix.o
>>      In file included from include/qemu/timer.h:4,
>>                       from include/qemu/timed-average.h:29,
>>                       from include/block/accounting.h:28,
>>                       from include/block/block_int.h:27,
>>                       from block/file-posix.c:30:
>>      /usr/include/linux/swab.h: In function `__swab':
>>      include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
>>         20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>>            |                                  ^~~~~~
>>      include/qemu/bitops.h:20:41: error: missing binary operator before token "("
>>         20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>>            |                                         ^
>>      cc1: all warnings being treated as errors
>>      make: *** [rules.mak:69: block/file-posix.o] Error 1
>>
>> The issue has been fixed in Linux kernel commit 467d12f5c78 [2].
>> Some distributions already backported the first commit, but still
>> lack the second one.
>>
>> This is the case for Debian Buster.
>> The linux-libc-dev package contains the Linux kernel headers.
>> Kernel commit d5767057c9a has been backported in package
>> commit 1fb0eb7956 "Update to 4.19.116" [3], see debian/changelog:
>>
>>    +linux (4.19.116-1) UNRELEASED; urgency=medium
>>    ...
>>    +    - uapi: rename ext2_swab() to swab() and share globally in swab.h
>>
>> The previous released update before it is debian/4.19.98-1,
>> released as debian/4.19.98-1+deb10u1.
>>
>> We can find this package in the Debian snapshot archives,
>> luckily archived on 2020-04-28 21:20:54 (see [4]).
>>
>> QEMU use Debian based Docker images for most of its cross-builds,
>> which are tested by our Shippable CI jobs. The current broken
>> package makes most of our CI red. We can kludge this by using the
>> latest package released before the breakage. Do so by pinning
>> the package version (apt hold), and using the snapshot archives,
>> similar to commit b4048a7cd1.
>> We'll revert once the fix is backported on Debian.
> 
> May as well mention:
> 
>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=960271

Sure (I remembered you talked about it on IRC, but was lazy to dig).

> 
>>
>> Reference to commits:
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5767057c9a
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=467d12f5c78
>> [3] https://salsa.debian.org/kernel-team/linux/-/commit/1fb0eb7956
>> [4] http://snapshot.debian.org/package/linux/4.19.98-1%2Bdeb10u1/#linux-libc-dev_4.19.98-1:2b:deb10u1
>>
>> Cc: Salvatore Bonaccorso <carnil@debian.org>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Shippable green again:
>> https://app.shippable.com/github/philmd/qemu/runs/759/summary/console
>> ---
>>   tests/docker/dockerfiles/debian10.docker | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
>> index 0769700a41..d7084ac283 100644
>> --- a/tests/docker/dockerfiles/debian10.docker
>> +++ b/tests/docker/dockerfiles/debian10.docker
>> @@ -9,6 +9,15 @@
>>   #
>>   FROM debian:buster-slim
>>   
>> + # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
>> +ENV DEBIAN_SNAPSHOT_DATE "20200428T212054Z"
>> +RUN sed -i \
>> +    "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" \
>> +    /etc/apt/sources.list
>> +RUN sed -i \
>> +    "s%^deb \(https\?://\)security.debian.org/debian-security/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian-security/${DEBIAN_SNAPSHOT_DATE} \2%" \
>> +    /etc/apt/sources.list
>> +
>>   # Duplicate deb line as deb-src
>>   RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
>>   
>> @@ -35,4 +44,11 @@ RUN apt update && \
>>           texinfo \
>>           $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
>>   
>> +# Install common build utilities
>> +RUN apt update && \
>> +    DEBIAN_FRONTEND=noninteractive eatmydata \
>> +    apt install -y --allow-downgrades \
>> +        linux-libc-dev=4.19.98-1+deb10u1 && \
>> +    apt-mark hold linux-libc-dev
>> +
> 
> Do we need this bit? Surely if we have a snapshot URL we don't need to
> hold the package as it will never get updated?

You are right, it is a remnant from the first approach (pin it without 
using snapshot) which didn't work. I'll remove this line and the comment 
in description.

> 
>>   ENV FEATURES docs
> 
> 

