Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D0DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED39920663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="weOOA4+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED39920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iedLL-00023M-1o
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iedKW-00013U-Nk
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iedKV-0004N6-2j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:05:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iedKU-0004Mq-R6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:05:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so19567072wrr.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dDyJ+Ygp8KayXc04yALlIYltiUaOOEpiFcA17xreC2Q=;
 b=weOOA4+6DRrVBGbR5XFjP99Ep5SOgF4J5yjhmizJ47kLuK90xNfHHSRyY9mUf+rcz4
 mEQ5I8mG4lUuosbPfkaPdgsJ0ozrvRxX/fojR5ijg8ITgrk88+sqcXghQGEJdpXHhIq9
 w5wZdT4TawtEzof2Bv0Rc9wV01BUKQUi99bVU+7JF9E9aHL9F2q8jn6a0J7dN6vpBL16
 3YBrdk3F7bUDfM7YvMCBIomh2byILxr1bI6hIj7z8D/ycMzY+co4HaoIB1Vcsbul2/FI
 Tof5br7AW/O6RfGFr65FP/wgmqI45WjEIMxax9ZsyhmnblrSsUMmf6UapOhzrxqsgcM1
 ZvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dDyJ+Ygp8KayXc04yALlIYltiUaOOEpiFcA17xreC2Q=;
 b=Athj9ppW/u5Rj68JINXjGZyuiELlcAOxASFvUphXUdOq/ng7fmvMK+afToojBLcCkL
 7Oiyf7d6p872QH2jlijAJZ3xNMTpD8FtWyPG2Cv8QkjMnSBCaIZ/rswMSUb/GkUbM/r2
 1lUAcMvLnZ3cC39m2E49kKXX8kdCcsmZaPonDyGwiNFmA6lwy5sIj/0Z3UVqcyUYl/wR
 lOCgri8DFQUpK67hRBTYD13kN9TMHAjmP6uyZrSGFUDzBL6c3ssaW2zEQxvMppiiE54/
 WTJDv5mHYs2qlRCvLOJwCUpdKdde0drRSIDtUTbf+Opw9mvDba9dx8LD3mWM6OOxMG1y
 NVUw==
X-Gm-Message-State: APjAAAV9rH6XOCc8nKrtrokAACxeRc5Ku0JHhWvWRVlPhM8Ib0tqDzM/
 SO+OrFT1fuZOYGHO0yruYXgjwA==
X-Google-Smtp-Source: APXvYqzfGylwQnJzv75c5+XMmNAkEKlmbR74nISxltBLNdPfGmomQ1FJeGW4nSGbPOcekB9TlF646Q==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr2476214wrn.386.1575975920732; 
 Tue, 10 Dec 2019 03:05:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm2730835wmz.12.2019.12.10.03.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 03:05:19 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54BDE1FF87;
 Tue, 10 Dec 2019 11:05:18 +0000 (GMT)
References: <20191206140012.15517-1-wainersm@redhat.com>
 <20191206164204.GB23522@dhcp-17-72.bos.redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 0/2] tests/acceptance: Add boot vmlinux test
In-reply-to: <20191206164204.GB23522@dhcp-17-72.bos.redhat.com>
Date: Tue, 10 Dec 2019 11:05:18 +0000
Message-ID: <87a78030gh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, wrampazz@redhat.com,
 philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> On Fri, Dec 06, 2019 at 09:00:10AM -0500, Wainer dos Santos Moschetta wro=
te:
>> This series add a new acceptance test: boot an uncompressed
>> Linux kernel built with CONFIG_PVH, so checking the PVH
>> capability introduced in QEMU 4.0 works.
>>=20
>> The test implementation depends on [1] which is likely released
>> on next Avocado. So that will need a version 2 of this
>> series to bump Avocado version.
>>
>
> Right, the Avocado bits have been merged, so unless a major reversal
> comes (not expected at all), it will be on Avocado 74.0.
>
>> Also I want to use this as an example of a scenario that test
>> assets could be better managed. As you see on patch 01 the
>> kernel is built at test time on localhost. While Avocado provides
>> an API to easily fetch and build it, the whole process takes
>> reasonable time - besides the fact that localhost must have
>> all build dependencies installed. How could it be done better?
>>
>
> This is clearly not a "kernel build" test, so we should avoid building
> the kernel as part of the "PVH boot" test.  The problem you expose
> here is a very real, and each possible solution has its own problems,
> unfortunately.
>
> The best solution IMO would be to find a "well known" distribution of
> such a kernel.  Maybe something maintained by the Xen project or one
> of its commercial products?
>
> The second best solution is to have a helper script (using the Avocado
> utils API is fine) that will build a kernel and create/populate the
> test's data directory (tests/acceptance/pvh.py.data/) with a vmlinux.
> The test can cancel itself if it doesn't find a kernel there.
>
> The third best solution IMO is for this test to require a parameter
> telling where the CONFIG_PVH enabled vmlinux kernel image is.
>
> Also notice that, with a custom built kernel image (a different one
> for each user), the result of the test as a general indicator to the
> QEMU codebase diminishes quite a bit.

I can see a use case for making it easier for developers to build test
cases otherwise everyone has their own particular variant of the kernel
and buildroot/busybox which they have in their own farm. However as
Cleber has noted they make poor standardised tests given the variation
in kernel builds you can get.

That said I think there are better targets. kvm-unit-tests can be built
against a range of architectures and are fashioned as individual unit
tests for specific functionality. It would be useful to make it easy for
a developer to regenerate the test assets to re-run a test someone else
has found to fail.

>> Nonetheless I argue in favor of merging this as is, and
>> gradually implement corrections to improve the tests assets
>> management. Also if eventually the test is proven to unacceptable
>> slow down the Travis CI then I can add a guard to skip it.
>>
>
> I'm pretty sure that building the kernel will cause a major slow down
> of the Travis CI results for the "acceptance" block (and thus for the
> overall results).  But, it may also time it out (there's a 50 minutes
> deadline).
>
> I hope this brings some ideas, and thanks for coming up with
> interesting problems! :)
>
> - Cleber.
>
>> [1] https://github.com/avocado-framework/avocado/pull/3389
>>=20
>> Wainer dos Santos Moschetta (2):
>>   tests/acceptance: Add PVH boot test
>>   .travis.yml: Add kernel build deps for acceptance tests
>>=20
>>  .travis.yml             |  2 ++
>>  tests/acceptance/pvh.py | 48 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>>  create mode 100644 tests/acceptance/pvh.py
>>=20
>> --=20
>> 2.21.0
>>=20


--=20
Alex Benn=C3=A9e

