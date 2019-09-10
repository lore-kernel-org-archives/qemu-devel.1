Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC8BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CA521019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCeSwCOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CA521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7eLD-0004qs-80
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7eJY-00044O-0d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7eJW-0000XP-Jf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:28:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7eJW-0000Wu-CT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:28:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id y19so19450125wrd.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=va2J7d90/68j2HG7sQVQ3Naqfze7q2xKSEznsg8fv8U=;
 b=PCeSwCOAOXvpf+ot2HWymsZs56AxCDieOfKciz/fyWnW0tUAGdl/x804Y6zNDgFZ8K
 j80BZJY9caiS18XqVK1tcyG5OkPdPzPh8TtOsdYGMvwJRuTTgwOphf0Wnlq77eyC8TfC
 TjrQUbxIjYqHuKrcItyL+Gqu10t6Zc9KTAoYXtqhvWBg2uHa9biwlyRfzyJnjLmLV8Mj
 SGmuPoUcL2H4PZlU4qAE6KFHGOlLVvuMFe+o/00New7y6+Cp5cdP9nvC56K+huX/U6Wj
 T0ZkWhfeX6CP1rjq69g3Bg074g3G5Pkk6/bMdCSBE06783eergoP0N7JuHBZDlr7aVbs
 NghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=va2J7d90/68j2HG7sQVQ3Naqfze7q2xKSEznsg8fv8U=;
 b=bPeGIkZtKWwn9/CaLsGqt81T7QgnTiM8j5GfdAilftv1Ezn0ADhocU1I02xwBOr1BB
 HDUmSwBum53xJhog+5bmK9Xi6szUCwl//XeS3z3VZgh2mGGdPcYuanrWiH/s2I5zakSL
 i8iEhAY/8ItMAtduQlQtw1+Db3fdm+wMx57PdCK1gtTVgpeKNLE0a/8820xNMyeAXnUz
 z/Md+m6rPXFL0xuZiLkNAUHyN92qLodHIOh+gjte3H7KodP5/sIYDap45XkwC7JTCizd
 drix7tMnnBRd/YrY72R+jad9m9vNQ8eH4x2TivZdZvZUt0r71p1Yz7dLB+sUmHPdnnN1
 QjWA==
X-Gm-Message-State: APjAAAWsQrjvoHnX5/leakzXGyvVHjCNV3cp0cSqBvJv7Ebc2Rrp4IPB
 /UPjY7qlwAigHI2DQsM724iQ4Q==
X-Google-Smtp-Source: APXvYqzrpqRMXo0qIC84KzuXGi40hL57KtOiMiHW6UnOu+1zpdQ85LdT4RWLWfe+aFlq2IJIZjsq7g==
X-Received: by 2002:adf:ed43:: with SMTP id u3mr18563396wro.37.1568114880816; 
 Tue, 10 Sep 2019 04:28:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y72sm3110242wmc.26.2019.09.10.04.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 04:28:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B3781FF87;
 Tue, 10 Sep 2019 12:27:59 +0100 (BST)
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <CAFEAcA_rB21=KXr_kJinkeDa0i3=LAhAYDg50YQC_7v07TKXjA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_rB21=KXr_kJinkeDa0i3=LAhAYDg50YQC_7v07TKXjA@mail.gmail.com>
Date: Tue, 10 Sep 2019 12:27:59 +0100
Message-ID: <87lfuw1jcw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PULL 00/45] testing updates (fixes, upgrades,
 caching)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 10 Sep 2019 at 09:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb0=
4b1:
>>
>>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-=
09-07' into staging (2019-09-09 09:48:34 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-next-100919-1
>>
>> for you to fetch changes up to 4cf22bac5b22a36adf23dc9ec4628c66bbc6f209:
>>
>>   travis.yml: Install libcap-dev for testing virito-9p (2019-09-10 09:39=
:09 +0100)
>>
>> ----------------------------------------------------------------
>> Testing fixes:
>>
>>   - podman cleanups
>>   - docker.py python3 fixes (encode)
>>   - DEF_TARGET_LIST applied to cross build images
>>   - move a bunch to Buster based images
>>   - enable Travis caching
>>   - more common objs for faster builds
>>   - stable URLs for acceptance tests
>>   - additional travis dependencies
>
> Hi; this seems to break 'check-tcg' (for a linux-user static config):
>
> [...]
>   CHECK   debian-ppc64-cross
>   BUILD   ppc64-linux-user guest-tests with docker qemu:debian-ppc64-cross
>   RUN     tests for ppc64
>   TEST    test-mmap (default) on ppc64
>   TEST    sha1 on ppc64
>   TEST    linux-test on ppc64
>   TEST    testthread on ppc64
>   BUILD   TCG tests for ppc64abi32-linux-user
>   BUILD   ppc64abi32-linux-user guest-tests with powerpc-linux-gnu-gcc
>   RUN     TCG tests for ppc64abi32-linux-user
>   BUILD   ppc64abi32-linux-user guest-tests with powerpc-linux-gnu-gcc
>   RUN     tests for ppc64abi32
>   TEST    test-mmap (default) on ppc64abi32
>   TEST    sha1 on ppc64abi32
>   TEST    linux-test on ppc64abi32
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> timeout: the monitored command dumped core
> Segmentation fault
> ../Makefile.target:116: recipe for target 'run-linux-test' failed

What host are you running on? Mine doesn't run because it has no way of
building those tests.

>
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

