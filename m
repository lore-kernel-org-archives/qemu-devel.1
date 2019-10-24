Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06405CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C625321872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fu0yeYqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C625321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhI7-0007RN-TL
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNgZF-0001aw-Jn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNgZE-0007dt-4h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNgZD-0007dn-UK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id 6so2435289wmf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aK5jMgNLWU7Qsn0qwEkDmmLl00urLpM/NU6gCfZo9fw=;
 b=Fu0yeYqQteA0T7l9U58T0K7u2CqPyDLVjbX6SmQq1v5yYswCoxIOhtx296iTZm01QX
 G7Lom3sU6cg3xK1OmDtGkDJyeT2xE+eMGdxc0IM/r5bD5sJ5f/TRXoXoscpuuj4rsrta
 W/F1UDa2QToIVmeswOPyHPSjC/OtlCxfTENc/SUmIBBjv4Ppf1HWHoWZdlWrG8jwaIAf
 Dapc61+NyCHJPMb/6J5G9jhKjvbE0+/L77wwbsFjS6J/HvKGkzaJ7q6ScrLBo7J1289+
 qKn7424U8V5o9RmlrE6D2r3fWENvt8K/klBm/lC+cqOelVzvpXtdWUc773MxbxkY5ttz
 TkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aK5jMgNLWU7Qsn0qwEkDmmLl00urLpM/NU6gCfZo9fw=;
 b=de3oNOCiBOZGI62nvceXtWPsTvwsWBO5a70yaxMo56CP6oP6dilMpqyxjXCCjH+BWl
 DJvYglDj030dKMv4xZ+qPXCh3U2G/lnUp/r4VFIJGfTiQSsgy7YZdymo9Y3kgBV5GSJM
 SFk2+GQp8Fp06t3HchrDc0TC8tMeovuV2I0n44Nrgv9EdLi7fpv/Lhbj5Oyl9LpvMo+/
 8rPbFU6OGGSEdeI7tfc5L316mxxtauC1227i0ikG/KdR2hr54SQttiifqFYp46thUslB
 RZlL/S/TITFZpYFjG2vSzGnMFvjVd1TSXmYtY2Zk02NBlYIT8FuBhs6XXQWpcT4RzY+M
 6Qgg==
X-Gm-Message-State: APjAAAW07bfm1ZGgQn46j6SLYvSVPUV5ZNs8V23T/mp8G3T4MA/jIa4z
 5TmKOHVsMq3tJJDwBhVK7Ojocw==
X-Google-Smtp-Source: APXvYqyZ3l0V4CeSBOfnnuzb/f93YPUJxkuOEnNI6U4hWFtLU3OnNoY0sychz2aNuScESKCIc7lJEA==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr3724924wmc.134.1571936790456; 
 Thu, 24 Oct 2019 10:06:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u187sm2232391wme.15.2019.10.24.10.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 10:06:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E2DAF1FF87;
 Thu, 24 Oct 2019 18:06:28 +0100 (BST)
References: <20191024160619.14179-1-alex.bennee@linaro.org>
 <4f36130d-f2cc-2432-7098-b73f82c1501e@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] travis.yml: enable linux-gcc-debug-tcg cache
In-reply-to: <4f36130d-f2cc-2432-7098-b73f82c1501e@redhat.com>
Date: Thu, 24 Oct 2019 18:06:28 +0100
Message-ID: <877e4um5t7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/24/19 6:06 PM, Alex Benn=C3=A9e wrote:
>> Create a new cache for the --enable-debug-tcg builds which is separate
>> from the normal debug builds which generate different code. We also
>> enable debug-tcg for the new plugins based builds as we want to ensure
>> any breakage to TCG is picked up by the sanity checks.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .travis.yml | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>> diff --git a/.travis.yml b/.travis.yml
>> index e3f10a93683..34bc8134f5b 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -135,7 +135,7 @@ matrix:
>>       # TCG debug can be run just on its own and is mostly agnostic to u=
ser/softmmu distinctions
>>       - env:
>>           - CONFIG=3D"--enable-debug-tcg --disable-system"
>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>
> This one runs default TEST_CMD=3D"make check -j3 V=3D1"

That does exercise the TCG a little because the various qemu-system-FOO
builds have some bootcode. However given we exercise the TCG more
further down we could just drop this matrix entry.

>
>>
>>       - env:
>> @@ -336,29 +336,29 @@ matrix:
>>       - env:
>>           - CONFIG=3D"--disable-system --enable-debug-tcg"
>>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>
> And this one "check-tcg", OK.
> (Maybe we can reorder the $CONFIG arguments so both jobs are more similar=
).
>
> Too bad Travis 'stages' are an enterprise feature:
>
> https://docs.travis-ci.com/user/conditional-builds-stages-jobs/#condition=
al-stages
>
> Because here we are building 2x the same, and cache isn't used.

Why isn't the cache used?

>
> Not this patch problem.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>
>>       # Run check-tcg against linux-user (with plugins)
>>       # we skip sparc64-linux-user until it has been fixed somewhat
>>       - env:
>> -        - CONFIG=3D"--disable-system --enable-plugins --target-list-exc=
lude=3Dsparc64-linux-user"
>> +        - CONFIG=3D"--disable-system --enable-plugins --enable-debug-tc=
g --target-list-exclude=3Dsparc64-linux-user"
>>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>
>>       # Run check-tcg against softmmu targets
>>       - env:
>>           - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu,=
arm-softmmu,aarch64-softmmu,alpha-softmmu"
>>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>
>>       # Run check-tcg against softmmu targets (with plugins)
>>       - env:
>> -        - CONFIG=3D"--enable-plugins --target-list=3Dxtensa-softmmu,arm=
-softmmu,aarch64-softmmu,alpha-softmmu"
>> +        - CONFIG=3D"--enable-plugins --enable-debug-tcg --target-list=
=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
>>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>
>>       # Release builds
>>


--
Alex Benn=C3=A9e

