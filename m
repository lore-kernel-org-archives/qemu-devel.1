Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DDC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704FC248EB
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzXmKPgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704FC248EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzOk-00053w-Lm
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmzNZ-0004cv-Pw
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:47:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmzNX-0002mo-QT
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:47:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id p19so2576946wmg.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hpS+CixpisG0EzjJUYe1K/aAzyd8vL4dkIEG7p8Znro=;
 b=jzXmKPgLX9AsdnOqduwdv4zaeg7jKLIyLfigYsObCA0a0oVj7oDCLPLzVR03wa7zHa
 DocadxVujZpd0styGj7J0ZLwLhwpCBLfusT8KDtgMZb//1X6WH1dsnlLhKOJ0FDRagQL
 v14PWW34Oh/KkFhTKwaA6yvlSEMRSfpdaVqbVbmaPjP5DfgIVLHOpO75mWCPR/r8iCn6
 BPaAhtYLXP7GDOWihr8g7SNc0n4YHbka6hZ7pzu3erqw9hVp6BVs+5nSTefAzjRkD6Gw
 NZEPkYtyei5CWYp6PW9OalY18Xw9hL2BZU5lzq7g9xcR4zxBuEdW1gzs3yPLjpTceiRo
 qUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hpS+CixpisG0EzjJUYe1K/aAzyd8vL4dkIEG7p8Znro=;
 b=X/gcp3BsCh9bXlJAAbSGuBRiZU4zFLlidnWDS0IhJylwOlBG/Z5hDZLoBQ48Al7ZSi
 DURXcYML8TSlszROorJtlYcBvauq8v6XnUldI8PeZepFbA8h1EUsC0oRGRTOTBiaCv3I
 PSmD+6r8uLRCdrDOMXcYCyTlYmXmBdCRtUBBGjypQDet4XfYGkFlZFvhnfjSjqtRQ9IS
 9eK+cb2eJvuCW0TqSlUTs1ClYQYpOvNsYYURixuyErd3E9lXb6cfLmMvCpaFx9DoazYN
 1zuo074QD+cZWoVAwPollZfugFmwvOmcjMQjR2OcObbYSc4XUtaiGBwqQsW/DZtq08uI
 girQ==
X-Gm-Message-State: AOAM531TCHWVBjHKFWRFewXjplcFmeuoo+DPI67SPU282IK/XpdgCSb7
 OKRV80xAB8Q17ncx/wQdAeOnoQ==
X-Google-Smtp-Source: ABdhPJzi1MlMdyv3JjpW2MlW0yLHUdQ0e4Kv03EoN46pGBMh22pW7oEeYrNFHdLYJmQbgwa0Kf9YkA==
X-Received: by 2002:a05:600c:281:: with SMTP id
 1mr5444813wmk.143.1592743636136; 
 Sun, 21 Jun 2020 05:47:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v11sm1993941wmb.3.2020.06.21.05.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:47:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 406071FF7E;
 Sun, 21 Jun 2020 13:47:14 +0100 (BST)
References: <20200620232947.17895-1-f4bug@amsat.org>
 <6ec17c5e-a7a2-ec47-cc30-807405cd39c0@amsat.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] .travis.yml: Build acceptance tests with -O2 compiler
 optimization
In-reply-to: <6ec17c5e-a7a2-ec47-cc30-807405cd39c0@amsat.org>
Date: Sun, 21 Jun 2020 13:47:14 +0100
Message-ID: <874kr4bn71.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 6/21/20 1:29 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> As we just want the tests to succeed, build them with compiler
>> optimizations enabled to run the tests faster.
>
> Maybe it is a good opportunity to test -O3 instead...
> Since this configuration is not covered.

Don't know if -O3 is worth it - even Gentoo developers warn against
cranking it up too much.

In fact I'm surprised we don't build -O2 by default.

>
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  .travis.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/.travis.yml b/.travis.yml
>> index 74158f741b..61b247db9f 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -293,7 +293,7 @@ jobs:
>>      - name: "GCC check-acceptance"
>>        dist: bionic
>>        env:
>> -        - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alph=
a-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el=
-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu=
,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>> +        - CONFIG=3D"--extra-cflags=3D-O2 --enable-tools --target-list=
=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmm=
u,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc6=
4-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-sof=
tmmu"
>>          - TEST_CMD=3D"make check-acceptance"
>>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>>        after_script:
>>=20


--=20
Alex Benn=C3=A9e

