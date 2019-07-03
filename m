Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F9DC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7DD2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7DD2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hih9i-00012w-RN
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hih6g-00066U-7u
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hih6d-0006P6-F2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:23:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:38655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hih6c-0005wW-U6; Wed, 03 Jul 2019 11:23:35 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M89bP-1hf8iT0n5P-005FNq; Wed, 03 Jul 2019 17:22:38 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190702123713.14396-1-laurent@vivier.eu>
 <CAFEAcA_Zu0X1zLfKtBkQdi25KCkjf_PNu8zKWE5Dx7uzzLEzBA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5d7fa8ef-c56c-1f90-d5d6-b230d1e3f363@vivier.eu>
Date: Wed, 3 Jul 2019 17:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Zu0X1zLfKtBkQdi25KCkjf_PNu8zKWE5Dx7uzzLEzBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pDkQ4CsWU5PML5YJMrHqwjNbt5HOFJeDdYbyvNEe6otD86D59Xs
 ZNbFoD5kJ7N8RAoytaBvFcT8B2ioX2OuZTAdQC0ZX5F7zYhh6KFD0pB+Rg2HzCnDDXAJHKd
 42CSg8KaSjVs/iFguaabIzcR3yzCoI9IpRlL4FtdTusMbQS9NGvlSM8CqkreiQUHwMiBdZg
 SywC4BZbmco6haSCMDNKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7M0DV8hM5qU=:Pj5eaSTPW3Nc2MjeWNHTkw
 7IgZL2eS2z5Ay092Y6fPmeSzC2k23ah6V+YpxYVJ7zsUIyPBBOLbYMDlXG48m38Ov8dnuBX0b
 hVIicBFi8aI/uoUArY+h1RFZpg7PndMrsab23c0+EEOw0jHMMNXxsodFMNFFAtNjQyEbeooE6
 Nd1d7MJmjqD31CvaxWafrC7MKaTNoHWmaYAdrw1F9XkzOpKmiEpyeodLYpEqWZ/EUay19pB1m
 fuU9iUu0tyfmJtfhDIyP4vz6DXvCwyJPp/7Atw7bKFvqpf99kluibe7OHiIMrz/5Fu98u3z2w
 4iLcPz36orl/l2Os4n24jKnBFqcoj4B8GSb3N3vf6sPvYH5uK+1nOeuk6bC9iKDjDvYvkzBKc
 i+nUO9VHiRccHjEDJQV+Af+/DfxZ0BjBnLJlVF5P/TNVbyrE+Uohli3P7fONL8f85u+oioH6/
 KzQ7mNjRDMNk+Propj5yUPg+hHMNqmfnKw9sDVPIVqpTZaL7tbjDxwV2Z5O1iRJDZO2ggG7n+
 SNzcW0qkoC/O10gJBNDU0B4XaycxFrObYz/jt9aM3V40eRpKT6iXJV+rdAPzWi6nonmr9R2cs
 BdaLBbY2YIfZewjXGbXsipObKYEpDGILDGRlrjWEsTY/Ot3HocH9KOfCKVzv2Rttt/gp40V4m
 9MhTC39SVYqnnKnVbHju3ggXAXXoTKMWOxDmgIRo1guWQ2Fcv5uPbKN7mthrPAHScqmFzMYU+
 YvKh1pQYKoXD4pLuI7LZgF5DAaHyAvAV9eLoyh6f2JWmRxmTciQ6pYmiC14=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Justin Hibbits <chmeeedalf@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/07/2019 à 16:45, Peter Maydell a écrit :
> On Tue, 2 Jul 2019 at 13:39, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>
>> for you to fetch changes up to 7c955080d40ccc7952a0479bc160f2b048c0af53:
>>
>>   docs/devel/testing: Fix typo in dockerfile path (2019-07-02 10:12:32 +0200)
>>
>> ----------------------------------------------------------------
>> Fix typo, fix sys_cache_info() on FreeBSD/powerpc,
>> change virtio-rng default to urandom
>>
>> ----------------------------------------------------------------
> 
> Hi; this makes 'make check' fail on OSX:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-char -m=quick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name="test-char"
> Assertion failed: ((isize & (isize - 1)) == 0), function
> init_cache_info, file
> /Users/pm215/src/qemu-for-merges/util/cacheinfo.c, line 179.
> 
> I guess this is the sys_cache_info change.

OK, I will try to reproduce the problem.

I think before this patch (regarding the kind of change we have
introduced) isize and dsize were always set to 0 and then changed to 16
in fallback_cache_info()... or perhaps MacOS X sysctlbyname() needs a long.

Is there a HOWTO explaining how to build QEMU on MacOS X?

I'm going to resend the PR without this patch.

Thank you,
Laurent

