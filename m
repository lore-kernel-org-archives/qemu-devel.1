Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31804C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F582070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F582070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGil6-0007qA-6n
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGijh-0006wf-PV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGijg-0004vE-DX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:32:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGijg-0004sP-4r
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:32:48 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M6DrU-1jA5y13jdA-006fkk; Tue, 24 Mar 2020 13:32:38 +0100
Subject: Re: [PULL v2 0/5] Linux user for 5.0 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200324111700.595531-1-laurent@vivier.eu>
 <CAFEAcA9-gYfwNCKLkbbbTx1+xSG6E2ErH0NZ=9JPQwNJvwmVzQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2c2cc8db-32ed-6a25-266b-9a3476f39805@vivier.eu>
Date: Tue, 24 Mar 2020 13:32:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9-gYfwNCKLkbbbTx1+xSG6E2ErH0NZ=9JPQwNJvwmVzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+m3I/NjmNAcMzgThGdOSHXOXZNjUF5BzVuBTkEJ+3zjuqHXtPCM
 i+U+wxlxLOlfT90ITpywNJBj2PeVvAoNjyEfuOHjIahIL9S5ZvLls/YdMymgDxyQeMqQHQW
 fYVSo9Tp83GP5NFAcM/ZKyE2tR0vVXR+secECsYOqhmAIlPtWK5hYhLvMRPGjoaOwhOtB9p
 5gijzEV8V4BlcFIuivGBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LAWXwgMl3qI=:mMu7xsmymALtBShaS05VWu
 zcZaK+MGga0voDkYCzsPPzbH0qSo25ZJvmkb9MLUug9zQ3i8TP5wXM1L7RKL0pULw1yI1FcYM
 uuGL0/3SlR+zNWV2Ti8uGwjz5zSCXqEzX5H6G7dPs8g+Vh6A/Ypd3+yZYBzXMj+ryXQYE9rUu
 LdPGYInrcBQEVKapHCWawIvbwSN6fREVv6spse12fLpe7M92SVpq5Ac249bncT6oECHBKCZBH
 bM+VbYH9SPXEEz9P2pUDPbAx2N+/RBpR/6gAheyVsrzvFLxdtVl+SA+0xWdu9o/YZXTh/ZbE7
 2RHsXv+TNpahkHYXvA41xKkPOMqLNt/J69dfGzSzaLDn1u6l7q3KMMdaeSHBsEDc+QElKftRB
 QCi81Ay+xuiDLJDYFKmYOpwY38XILGQrYbbWdkUvbv+qYQ1H3oWXqN3qAlPEhEZjqvoWb6c0u
 paLTl+trJjiPZ58/I20mb3VoaGeyN2C78PbC0DcSsV/H8rStYY0mODEEzsQNJa5XOJFD6eeLC
 9DcTpVf3/LIkLnnetggmzFQoBoeHAsaCYKDzzfOWfj2mcnLSiVNUV4qRL3EwL69WP0TKMG3yH
 SDSaxk10T32YCj9n7HviLMJeNei6EUH5+HF2SgUNAz3wMWLaLvcj/bz8m/LJ5vOqQB1Cf/NyM
 oRTxgELmjWTtAi+GKax2YoegNKfc4iFdBRqFx3GA2PovZk/eOhgwu/XyijOAz7wSDSdf3BV0J
 YxoQ0zl+lM+6N5bCFrHchgxjyYB+T+PpRpCgJWxANCgEM5kfFhUYbBXBqpEOwqpBEUHT/HNJr
 v/fSHitTBnerEyrAFeQ3Yzfcho5W8Vo/LM5jD9xn98gOmYwhlurdmuoJzABZqGFOHSevj7p
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/03/2020 à 13:20, Peter Maydell a écrit :
> On Tue, 24 Mar 2020 at 11:18, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 29e0855c5af62bbb0b0b6fed792e004dad92ba95:
>>
>>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-pull-request' into staging (2020-03-22 21:00:38 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>>
>> for you to fetch changes up to eec24827f7e67ead39349bb78597da566f854a4c:
>>
>>   linux-user: Flush out implementation of gettimeofday (2020-03-24 12:04:14 +0100)
>>
>> ----------------------------------------------------------------
>> Emulate x86_64 vsyscall
>>
>> v2: remove trailing space
>>
>> ----------------------------------------------------------------
>>
>> Richard Henderson (5):
>>   target/i386: Renumber EXCP_SYSCALL
>>   linux-user/i386: Split out gen_signal
>>   linux-user/i386: Emulate x86_64 vsyscalls
>>   linux-user: Add x86_64 vsyscall page to /proc/self/maps
>>   linux-user: Flush out implementation of gettimeofday
> 
> Fails as before:

OK, I think there is an existing problem in the build dependencies.

Do you use enable all targets ("configure" without parameters)?
Do you run make with "all" or "x86_64-linux-user/all"?

I will not resend this PR while I don't understand what really happens.

Thanks,
Laurent

