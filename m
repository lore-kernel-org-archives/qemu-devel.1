Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C89D20989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C89D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41259 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3OZ-0001wv-67
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:08:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP347-0000jN-Kl
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP346-0004sW-M5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:47:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP346-0004rw-Dg
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:47:46 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MbC5g-1gsCDc1t2u-00bY8B; Fri, 10 May 2019 12:47:32 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190510071557.30126-1-laurent@vivier.eu>
	<CAFEAcA8BAoqwdP-3cECUL2sLXQr_PxbdYBzMmZVEan3HcE8YVw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ad4692d1-d21c-c1ed-d784-f790c4668bb6@vivier.eu>
Date: Fri, 10 May 2019 12:47:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8BAoqwdP-3cECUL2sLXQr_PxbdYBzMmZVEan3HcE8YVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:slCcKAeY0mRq+VIbRaLoSXkM5tNILp+4cneERU9aDVCQfUbfZ/i
	4/HV7503gQcFr6LQATj7HI7QR08HAdb1FvyBW+KzxzLRFZvYZ0FvrcMgEW8M4MkN+cI2Z45
	64ZvdfaF14GAhqqIaxrFkeifaUK1hhrDitHJU4cmLM7iETAxoVLPTKhQZP33I0tAs2uzRRP
	yi/5Vx1+yH74doai5846w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:28Lol8Hp6J4=:CC5y2gdpLxYGxSvasa4rsv
	rg5l8dlPex+sg3GNAW7wska6mL9GyYWP3kamtKADJTXX9yvP1L7P+ZkakV2g9bWKzseOLlmFq
	2lL4LFiNyRKB6o3LIRXZ3dbMsjpzB/nRfg6PaL9ujA7QLuattMLj/jJI1Qoug9bvr5ZuV/Pa7
	tPOpR3u8nXYO17vN1yaEktOqmibInRt+6CiEw28LAEA16JIF7hYpGVvryjMoFq0AKkYxV0Gtu
	nvafvbSIpIc4BnfK7XZqIdeTpsAVVu3TCxljOaAWeBaxECbwWSfKAqhW703HvCFHfWDCGcp+n
	XeK0+2i78LFZQ++K6Y+JnrtnQBWTinc9/8J6ZEHIVx44xCDXmqvNqkpU1aooEhSvd2UJXc1e7
	Uh+GaMB5mmgoeh28BEJNEELwqqUETXeqogvMRtWJVV7Z6NXF8HUFT/e2UOQSY0HGZi0HMhCdI
	9oPhm9EsN5OjG+DzkhW/sk3j/aFggPycD4QrcjC5c3J7t9JDRc/y7HiEoE6Kp8K15BcSfs5lg
	Plc7+Gij8goq2nHu64rWIFkFjRncyIU0zOJ1oswz7SSvdGok1U35QzzdkJX2RlJFid267k1CG
	EzOKOhZQxGsqmn7Nh4n8vWO7Umz2cZ+nrKqR6gW1rPZMFXr08llPFvh6OAtmtcDf8h+uCwU9g
	cGw+rVNBSfu1BL6+wNvMQVDczmUzwk9mXDWLI5tGtm9HAaQZ+rIhrsythmlRhWaB0imk8S5gQ
	WFCFCRP1adCcvadBKqDgde4sWSP7iX2gTwwk2ft3J+GpoIUNA+9jhjNoasw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PULL 0/7] Linux user for 4.1 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/05/2019 11:16, Peter Maydell wrote:
> On Fri, 10 May 2019 at 08:18, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 68a7b9724fe80bedb85060bde605213ce3f9baec:
>>
>>    Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-05-09 13:36:10 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>>
>> for you to fetch changes up to 6b333239ab1a4fa98f07f907f6268484a8514d1e:
>>
>>    linux-user: fix GPROF build failure (2019-05-09 19:08:13 +0200)
>>
>> ----------------------------------------------------------------
>> GPROF fixes, GCC9 fixes, SIOCGIFNAME fix, new IPV6 sockopts, elf fix
>>
>> ----------------------------------------------------------------
>>
>> Alex Bennée (2):
>>    linux-user: avoid treading on gprof's SIGPROF signals
>>    linux-user: fix GPROF build failure
>>
>> Alistair Francis (1):
>>    linux-user/elfload: Fix GCC 9 build warnings
>>
>> Daniel P. Berrangé (1):
>>    linux-user: avoid string truncation warnings in uname field copying
>>
>> Erik Kline via Qemu-devel (1):
>>    The ioctl(SIOCGIFNAME) call requires a struct ifreq.
> 
> Hi Laurent -- it looks like you forgot to fix up the
> author email in this patch, so my pullreq-application
> script complains:
> 
> [staging 181447e27a] Merge remote-tracking branch
> 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging
>   Date: Fri May 10 10:06:35 2019 +0100
> Erik Kline via Qemu-devel (1):
>        The ioctl(SIOCGIFNAME) call requires a struct ifreq.
> ERROR: pull request includes commits attributed to list
> 
> Could you fix it up and resubmit the pull, please?

Done.

And thank you to have checked that.

Laurent


