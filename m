Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565F7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207A020848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsGwA9Ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207A020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nSM-00079Q-8b
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9nRX-0006ON-OU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9nRV-0002Qu-7H
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:09:26 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9nRU-0002Qf-VA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:09:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id v2so6215914wrp.12
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=j77nLhOwoWG/siSHqClrE51PrP47M+Q7dbHrF2aVhSw=;
 b=XsGwA9NgMU6/DNQ3JL6uFssdB4eUNF5WqWNX08fsVYSaWq//F51LrgPvVQgj6D2QtF
 Kf5T34VA+kuVMddZBbKHkqF5r2S9+uPCZ+eDJ20MxCteoa54kMmJjvnCG/cyAosEtOJ2
 Ns77+tVP6Gmw9KwioFckkIPAxcz1uRevbAZ0mzkl+dg25QsUKPyhy3iRNgJj7+kx9GU5
 tmGQGVutrDVumVuG4YkMJeTLLHYqRnFuPi6DDSl2b8oVCWXwfbPtNKnRCUniCdV4lNtN
 OrMP4yv7QQ78qm1SU0yombmCcLEQjN2XzeU/08CHf3YUGOPjFoI83E91VIONmJbR2ID5
 tIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=j77nLhOwoWG/siSHqClrE51PrP47M+Q7dbHrF2aVhSw=;
 b=F6Q8fFYaEBV3oY8Lz78/haIGScSvfvc369hmHGckiv2i2dU9usyieWVxS4WPMzB2hI
 DsbN5IDXIG9czbRhlHCNJjpcUEaSttCAz4dqfj5gCOg1HvXCHEAPCNhTsVggoM5u1sfb
 MlsMRUEReXQ1Bj7vfQmE+E8Wl4pXequh/Bv1ft2zNNaB/ertDuwd0XSA6SMRU5JM2dFA
 LB9lmsbH1a6VsHB9elIP+RytHktGZ5xrVnlDdaw1jttEI52u2xRq7t2eRYlIR2GaPlH9
 v8nrA/HDtfDfdLvNWs+iA+RXfOZHiuyuQzrnMcM3cI33nNwLOsmiUIHl/3hCg+FPwgYN
 5U+Q==
X-Gm-Message-State: ANhLgQ3b53F+GBRM+KrSCaqmoJACApVwgifNncYZBwVm6Kg4rFnd/mOS
 EEgMA6lMJwOtJEunBKWRJP4YHTqAFuk=
X-Google-Smtp-Source: ADFU+vti0xdiS73ZZ4mdetOBwuA+gDhYqfEatIxldvBklpcZv/xQWC5lskNtKKSg36fg2/nxTIKFWw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr9464790wrr.352.1583402962867; 
 Thu, 05 Mar 2020 02:09:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p17sm41027959wre.89.2020.03.05.02.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 02:09:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAD831FF87;
 Thu,  5 Mar 2020 10:09:20 +0000 (GMT)
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-8-alex.bennee@linaro.org>
 <874kv68lg9.fsf@linaro.org> <87v9njf87n.fsf@secure.laptop>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: quintela@redhat.com
Subject: Re: [PATCH  v1 07/10] configure: fix check for libzstd
In-reply-to: <87v9njf87n.fsf@secure.laptop>
Date: Thu, 05 Mar 2020 10:09:20 +0000
Message-ID: <87o8tb5d0v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Juan Quintela <quintela@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Fixes: 3a67848134d0
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  configure | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 7b373bc0bb8..caa65f58831 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2464,7 +2464,7 @@ fi
>>>  # zstd check
>>>=20=20
>>>  if test "$zstd" !=3D "no" ; then
>>> -    if $pkg_config --exist libzstd ; then
>>> +    if $pkg_config --exists libzstd ; then
>
> Hi
>
> several things:
>
> a- I found why I didn't get the error.  Fedora pkg-config is really
> "smart":
>
> b- I have tried (with this patch), the following configurations:
>    * --enable-zstd
>    * --disable-zstd
>    with both libzstd-devel installed and not installed. Everything
>    worked as expected.
>    (BTW, I tested that before submmiting the patch in the first place, I
>    thought that I had done all testing needed for such a check).
>
> Can you told me what architecture/distro/os are you using.

It broke on the CI setup - it could be another issue with the ageing
Travis images (Ubuntu 16.04).

>> Dropping this patch as it breaks the build even more!
>>
>>   CC      migration/block.o
>>
>> /home/travis/build/stsquad/qemu/migration/multifd-zstd.c:24:5: error: un=
known type name =E2=80=98ZSTD_CStream=E2=80=99
>>
>>      ZSTD_CStream *zcs;
>>
>>      ^
>
> This is really weird.  if you arrive here, that means:
> - you have zstd devel installed (whatever is that called for your
>   os/distro/whatever).

Well it detected it:

  zstd support      yes

>
> - pkg-config has found zstd devel packages and configured them (that
>   file depends on CONFiG_ZSTD beoing defined)
>
> - gcc has found <zstd.h> (i.e. it don't give one error about that
>   include file not found).
>
> And zstd don't have ZSTD_CStream defined?  What is going on here?
> Can you post/show what is on your zstd.h file?
> What zstd library version do you have?
>
> I thought that zstd was a new library, and that we didn't need to check
> for versions.  It appears that I was wrong.  And no, the include file
> don't show what features are new/old.

Obviously not that new but has changed since it first got introduced.

--=20
Alex Benn=C3=A9e

