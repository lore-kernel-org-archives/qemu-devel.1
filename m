Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904A8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7452076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESRomGei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7452076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZkV-0004sG-Gr
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZZee-0003Xa-An
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:41:32 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZZed-0000G3-BI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:41:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id v12so3326480wrp.12
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IQ0eFlSkR7zpXpj+3Jtq2ybHouefTyQIC/gafnIl3xo=;
 b=ESRomGeiqJRaAs6n9qnTW03sDrXgnT1QfCu4Jere/9OBt1ixa4K8zTBDX4giBD96Qs
 LIY9sUdo6lNE4CJ76fOxwQu5WRDF3pymlcYHLOTkJ+uzYR8sE+JYCSLOnteaQXw0BHIa
 JFAC5Ugkz5//SOQ4vW/JcYTWm66KjaW+h0HWozfiZk8HMPdFYS2pEmyUJYF5lcf/uMtv
 CdHOsOqkEREnCB6rgi8og2hFxsVBEyGt/EDaqtoC1LTaj4qMOLSmP7jPmb2HsRaUoTW5
 tFhcnU2+6TO6CTZhwSOF5vQUE4Pt2fXZxNmxOBb8PH52at/vW4pmgKHDY9tr40+yTolf
 RrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IQ0eFlSkR7zpXpj+3Jtq2ybHouefTyQIC/gafnIl3xo=;
 b=BhzZDgxkyYg0Us2UrUiDB4tScWOc5UvOQh2Cn4cK/Q23HGQE6eq8kD/5eO2mf7phoi
 s0Djs+BDMTCS/7BiffP350+x+PObKRCZv83ya9xm1PfEfqkZe1xRLxQQzvms8tnv+D6g
 FqHqms3U1gXtYN2lewew1PBGsEFSWs2uuJROHmh2SGyjUWbioN3MpBnBMDPfQ5ItIqMV
 SGio/sW48eZSznzHatbkxFfgezT60Z1m6RKJKuTAqX1rOPKFU8bB/3wMSEcbjAjuA2rh
 UIwkVtZp0P/qsfv8Bkz/ifIMt92V+ILMFkxvKxJPN+BysX1Kr23upCTNGtRrqqqQeiJE
 pBVA==
X-Gm-Message-State: AOAM533b3Rmx/aJY0DnmUM/3crWm+d6lXtSwtSrfErkpWC7BW83HskYM
 VNLxUhidk2w/NYZXRJWvucw=
X-Google-Smtp-Source: ABdhPJyguttZLTiyLrdgZbyoee/ObyT1w6IFSSUzHQnpO74GfsYedfTpCQAN+hYiaKF/JBMB5e8zLQ==
X-Received: by 2002:adf:8169:: with SMTP id 96mr4057902wrm.283.1589546489381; 
 Fri, 15 May 2020 05:41:29 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t6sm3473858wma.4.2020.05.15.05.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 05:41:28 -0700 (PDT)
Subject: Re: [PATCH] tests/docker: Kludge <linux/swab.h> breakage by pinning
 linux-libc-dev
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200513120147.21443-1-f4bug@amsat.org>
 <87a72beuhn.fsf@linaro.org> <2839ba1a-f4c4-3a4d-cabe-d6e0e1b6accc@amsat.org>
 <87blmpcshm.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <832577c9-7a7d-43d9-796b-e22e71b8baed@amsat.org>
Date: Fri, 15 May 2020 14:41:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87blmpcshm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

On 5/15/20 2:06 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 5/13/20 5:15 PM, Alex Bennée wrote:
>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>
>>>> Linux kernel commit d5767057c9a [1] aimed to fix an issue with the
>>>> swab() declaration, but doing so it introduced the BITS_PER_LONG
>>>> definition, without using the kernel __ prefix, leading to odd
>>>> failures in userland code using kernel uapi headers, such:
>>>>
>>>>         CC      block/file-posix.o
>>>>       In file included from include/qemu/timer.h:4,
>>>>                        from include/qemu/timed-average.h:29,
>>>>                        from include/block/accounting.h:28,
>>>>                        from include/block/block_int.h:27,
>>>>                        from block/file-posix.c:30:
>>>>       /usr/include/linux/swab.h: In function `__swab':
>>>>       include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
>>>>          20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>>>>             |                                  ^~~~~~
>>>>       include/qemu/bitops.h:20:41: error: missing binary operator before token "("
>>>>          20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
>>>>             |                                         ^
>>>>       cc1: all warnings being treated as errors
>>>>       make: *** [rules.mak:69: block/file-posix.o] Error 1
>>>>
>>>> The issue has been fixed in Linux kernel commit 467d12f5c78 [2].
>>>> Some distributions already backported the first commit, but still
>>>> lack the second one.
>>>>
>>>> This is the case for Debian Buster.
>>>> The linux-libc-dev package contains the Linux kernel headers.
>>>> Kernel commit d5767057c9a has been backported in package
>>>> commit 1fb0eb7956 "Update to 4.19.116" [3], see debian/changelog:
>>>>
>>>>     +linux (4.19.116-1) UNRELEASED; urgency=medium
>>>>     ...
>>>>     +    - uapi: rename ext2_swab() to swab() and share globally in swab.h
>>>>
>>>> The previous released update before it is debian/4.19.98-1,
>>>> released as debian/4.19.98-1+deb10u1.
>>>>
>>>> We can find this package in the Debian snapshot archives,
>>>> luckily archived on 2020-04-28 21:20:54 (see [4]).
>>>>
>>>> QEMU use Debian based Docker images for most of its cross-builds,
>>>> which are tested by our Shippable CI jobs. The current broken
>>>> package makes most of our CI red. We can kludge this by using the
>>>> latest package released before the breakage. Do so by pinning
>>>> the package version (apt hold), and using the snapshot archives,
>>>> similar to commit b4048a7cd1.
>>>> We'll revert once the fix is backported on Debian.
>>> May as well mention:
>>>     https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=960271
>>
>> Sure (I remembered you talked about it on IRC, but was lazy to dig).
>>
>>>
>>>>
>>>> Reference to commits:
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5767057c9a
>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=467d12f5c78
>>>> [3] https://salsa.debian.org/kernel-team/linux/-/commit/1fb0eb7956
>>>> [4] http://snapshot.debian.org/package/linux/4.19.98-1%2Bdeb10u1/#linux-libc-dev_4.19.98-1:2b:deb10u1
>>>>
>>>> Cc: Salvatore Bonaccorso <carnil@debian.org>
>>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>> Shippable green again:
>>>> https://app.shippable.com/github/philmd/qemu/runs/759/summary/console
>>>> ---
>>>>    tests/docker/dockerfiles/debian10.docker | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
>>>> index 0769700a41..d7084ac283 100644
>>>> --- a/tests/docker/dockerfiles/debian10.docker
>>>> +++ b/tests/docker/dockerfiles/debian10.docker
>>>> @@ -9,6 +9,15 @@
>>>>    #
>>>>    FROM debian:buster-slim
>>>>    + # Use a snapshot known to work (see
>>>> http://snapshot.debian.org/#Usage)
>>>> +ENV DEBIAN_SNAPSHOT_DATE "20200428T212054Z"
>>>> +RUN sed -i \
>>>> +    "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" \
>>>> +    /etc/apt/sources.list
>>>> +RUN sed -i \
>>>> +    "s%^deb \(https\?://\)security.debian.org/debian-security/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian-security/${DEBIAN_SNAPSHOT_DATE} \2%" \
>>>> +    /etc/apt/sources.list
>>>> +
>>>>    # Duplicate deb line as deb-src
>>>>    RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
>>>>    @@ -35,4 +44,11 @@ RUN apt update && \
>>>>            texinfo \
>>>>            $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
>>>>    +# Install common build utilities
>>>> +RUN apt update && \
>>>> +    DEBIAN_FRONTEND=noninteractive eatmydata \
>>>> +    apt install -y --allow-downgrades \
>>>> +        linux-libc-dev=4.19.98-1+deb10u1 && \
>>>> +    apt-mark hold linux-libc-dev
>>>> +
>>> Do we need this bit? Surely if we have a snapshot URL we don't need
>>> to
>>> hold the package as it will never get updated?
>>
>> You are right, it is a remnant from the first approach (pin it without
>> using snapshot) which didn't work. I'll remove this line and the
>> comment in description.
> 
> Hmm it seems this is needed - without it I see other failures:
> 
>    https://app.shippable.com/github/stsquad/qemu/runs/1377/8/console
> 

Sorry I haven't updated this thread.

I did the requested change, but then the snapshot server went down, so I 
couldn't finish testing.
My impression is that when 2 different versions are available (which 
happens in this snapshot date) apt will install the more recent. I 
couldn't find other snapshot dates with at least 4.19.98-1+deb10u1 and 
at most 4.19.98-1+deb10u1. Only this date but with 2 versions, so 
pinning is unfortunately required.


