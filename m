Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B9C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AC7206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mc18kiPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AC7206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWdCg-0006C4-UU
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 04:47:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWdBb-0005tJ-Ew
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWdBa-0007cY-9C
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:46:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWdBZ-0007Yu-V8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:46:50 -0400
Received: by mail-oi1-x244.google.com with SMTP id r136so7132918oie.7
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=AwRUex3oIHEgUoEGXrADY2L4vksNM7iAbuQigSiYYZE=;
	b=Mc18kiPCsBg8SUP0D6uS5VPTgaueic8EzFqBemR5mSwoIq0bDmuQt5Ik9H1iXgqQnH
	rdbAXPrmpWdN/bXE0k/Vti7JwUeRy6jp1xIPkAIkKZzhrdnjzWI8OA+GO6OV4zOv7FPR
	oOJ++v/RyElCkBX3H59rVaaheodsar0UlSaNf+37FQ9PtJB8SZEb8WPXXL1enjjJaJ3l
	Ji169Zg7w+wZAmH6z45EO5PF2jWI0EeIjUORBLziWmmctDx87sJ+p5yw/RSEkyN17rS8
	4xDaq2FGkyotAYIx4zPVBTxdO0V05YIoUYKsty4FsBQjsmRZ82jgj6bzOQ/TXJJ77Yld
	Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=AwRUex3oIHEgUoEGXrADY2L4vksNM7iAbuQigSiYYZE=;
	b=WhsJ/NARRLT7NZgK16F0wBtjAPcAcViPQG1cNozUoMTYPfhcbBE1g/aR7icFtg5rrH
	LhV3HHZztd5irjMABbFiN3DqjlbSxzL2Ymfo5tAsmD4EIjSMHpUhO/PcbaC3Gy5KtCmf
	i7BLjDu4H1s8sJXQOpZHK46appH9Zq2fIC8JasoipWg6nSo8VSNBoo6lpEKzRAuek/1p
	m/1U6iZ5UJRUnB2b868B/5SO3hGtNiHtRdC2t5ANvmBKeH1hUmjipy8NHKMARPbbKLDi
	ARiiYnARzkFQs4YFV+Q9Gfzu16OK9CU9d2C4clZ666dWrPYgUb6i6ASi2C9Scs8zZw3M
	h+AQ==
X-Gm-Message-State: APjAAAXgcBk9W4Y+taiwWpbbVvAIgs/NV7B98zfURfINYRZaJWzezxnQ
	wsTAP4eZ/KYAXoKdFzVvMG+KuQ==
X-Google-Smtp-Source: APXvYqxZ6c8+I0VblfKALVRmPBcpV6PEQNGkMW46VQfp6u0qc/TGeU30Gw49TWE6MNl/dlXkOhI5gw==
X-Received: by 2002:aca:4b41:: with SMTP id y62mr5337774oia.131.1559292408686; 
	Fri, 31 May 2019 01:46:48 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id 38sm1951730otv.3.2019.05.31.01.46.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 01:46:47 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523204954.13122-1-richard.henderson@linaro.org>
	<155865586800.24.17673050455759130330@549697c9ad12>
	<87v9xr3ui8.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f42dfb1b-ad03-0bd6-efb3-100253b5201f@linaro.org>
Date: Fri, 31 May 2019 03:46:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87v9xr3ui8.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Update capstone module
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:20 AM, Alex Bennée wrote:
> 
> no-reply@patchew.org writes:
> 
>> Patchew URL: https://patchew.org/QEMU/20190523204954.13122-1-richard.henderson@linaro.org/
>>
>>
>>
>> Hi,
>>
>> This series failed build test on s390x host. Please find the details below.
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> # Testing script will be invoked under the git checkout with
>> # HEAD pointing to a commit that has the patches applied on top of "base"
>> # branch
>> set -e
>> CC=$HOME/bin/cc
>> INSTALL=$PWD/install
>> BUILD=$PWD/build
>> mkdir -p $BUILD $INSTALL
>> SRC=$PWD
>> cd $BUILD
>> $SRC/configure --cc=$CC --prefix=$INSTALL
>> make -j4
>> # XXX: we need reliable clean up
>> # make check -j4 V=1
>> make install
>>
>> echo
>> echo "=== ENV ==="
>> env
>>
>> echo
>> echo "=== PACKAGES ==="
>> rpm -qa
>> === TEST SCRIPT END ===
>>
>>   GEN     ui/input-keymap-qcode-to-atset1.c
>>   CC      cs.o
>>   CC      utils.o
>> cs.c:17:10: fatal error: capstone/capstone.h: No such file or directory
>>    17 | #include <capstone/capstone.h>
>>       |          ^~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>> ---
>>   CC      /var/tmp/patchew-tester-tmp-c6t41dq_/src/build/slirp/src/socket.o
>> In file included from utils.h:13,
>>                  from utils.c:12:
>> cs_priv.h:7:10: fatal error: capstone/capstone.h: No such file or directory
>>     7 | #include <capstone/capstone.h>
>>       |          ^~~~~~~~~~~~~~~~~~~~~
>> compilation terminated.
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20190523204954.13122-1-richard.henderson@linaro.org/testing.s390x/?type=message.
> 
> I saw this on my laptop (which doesn't have system capstone installed)
> as well. Did I imagine there was a patch floating around to deal with
> the captone/capstone inconsistency?

You did see one, but that was for users of capstone.
This is while building capstone itself.

This means that something changed in capstone's own build system that I failed
to replicate while pulling it into ours, and I failed to notice because the
build here found the system header instead.

Ho hum.


r~

