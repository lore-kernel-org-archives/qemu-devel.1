Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8032FC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7EE206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LO7kwe1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7EE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUxvR-0005md-RP
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 14:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUxtS-0005D1-Jx
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUxtR-0000L6-5a
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:01:30 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUxtQ-0000KN-UD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:01:29 -0500
Received: by mail-wm1-x342.google.com with SMTP id z19so3249746wmk.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=I//FPJErWDOjPbaU6mFUmpdYlwsYCikmD0aTnhYe3MM=;
 b=LO7kwe1X4ukq14Zu1n0niwgQKqUhyYgWDth2btrr4L19hLiPUoVmpNGJWdfQNVSo9F
 MlWJze9KGS3CsWiRGSOYXAMejuu/WDyAvoh+ZJJSgdEehP9s0HAxrePN6L7syDMvJeff
 H70fvnke+oR95UGVjM10JHxFGkxQE7scAiSXWE0E8ouqLdoZHCbO6Ad1HqviKZVw9sb3
 6RrHHFp2z60UosxqgXeL8wvBe/ztmmso9v/8jrYjsGjYE1Xx/wj2jMOUdbwANyF4nx46
 cqg5t6ggxvKUwsqO/vu44tQDyxdwr706FV4hssbY/onH3lrQHRCVv84z6CvhHM6hwzum
 IbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=I//FPJErWDOjPbaU6mFUmpdYlwsYCikmD0aTnhYe3MM=;
 b=TTJeDtHSMrUa2Jz84qc4mhZsnysQvGpbLCW+UbJSs4ahQ5djIas1TqLL2RYjHhsg81
 MNc/8XoBMG0VrV93HqK3X6O1ELWUtqo9E9nwK7oi56kkdyhKUFqG55fwVckROlVVzXUC
 r/T6/wfopz/cv32EzZc6ZyIetHkG3iDwTt/rCQg1GpoglgTVqVsdvAvr1HNuh3Bn31Tt
 vC6v6Wpzo1DUeYFLrK1Jf8ri/Qr+Di1oUfOsUJEzHRfz6O8ikh+2tT8Ol56iStLmJVCM
 tad73joPxB5YANSiN+feEvO7XN3fjTDY29pjS7av+MoTajEvnZk05LTf51dYjeYlb1kR
 TgCw==
X-Gm-Message-State: APjAAAVoXDSyt5EUcwBgbpw71ad3EiFKAmEwtR/I4oPcGOrfGJg2hZ0Z
 1kXg12Lky6IzFIqHvgdhfY274Q==
X-Google-Smtp-Source: APXvYqzUYvFVKxgVfA/fDDKI0LhIRXRdOxR6zlP1+l5t9KJmC+FYdvqiM7SqkNk2lQg4gipVqIeBNA==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr4076869wmi.16.1573671687477;
 Wed, 13 Nov 2019 11:01:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w19sm3371438wmk.36.2019.11.13.11.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 11:01:26 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6A9161FF87;
 Wed, 13 Nov 2019 19:01:25 +0000 (GMT)
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-6-alex.bennee@linaro.org>
 <d58692dc-b94f-cd6a-c3dd-e9c76e68bdee@redhat.com>
 <BN6PR2201MB125185CB7DABA8AEE6888D92C6760@BN6PR2201MB1251.namprd22.prod.outlook.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Subject: Re: [EXTERNAL]Re: [PATCH v1 5/5] .travis.yml: drop 32 bit systems
 from MAIN_SOFTMMU_TARGETS
In-reply-to: <BN6PR2201MB125185CB7DABA8AEE6888D92C6760@BN6PR2201MB1251.namprd22.prod.outlook.com>
Date: Wed, 13 Nov 2019 19:01:25 +0000
Message-ID: <87bltf7g8q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>, "cota@braap.org" <cota@braap.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <amarkovic@wavecomp.com> writes:

>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> > -    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmm=
u,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x=
86_64-softmmu"
>> > +    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-so=
ftmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>>
>> Aleksandar, since you mostly test 32-bit MIPS, are you OK we keep
>> mips-softmmu and drop mips64-softmmu here? Another job (acceptance-test)
>> builds the mips64el-softmmu.
>
> Philippe, thanks for bringing this to my attention. Yes, 32-bit mips
> targets are important to us, but, what can we do, time constraints are
> time constraints, so I agree with Alex change, please go ahead, Alex.
> We can test 32-bit mips targets via other acceptance tests (those that
> can run longer, so-called "slow" group), and perhaps we can extend
> them to test more 32-bit mips systems.

To be clear both gcc and clang have rules that test:

        - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTMMU_T=
ARGETS}"

So the main targets which are reducing their coverage are:

        - CONFIG=3D"--enable-debug --target-list=3D${MAIN_SOFTMMU_TARGETS}"

        - CONFIG=3D"--enable-modules --target-list=3D${MAIN_SOFTMMU_TARGETS=
}"

        - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS} "
        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-sanitize"
      compiler: clang
      before_script:
        - ./configure ${CONFIG} --extra-cflags=3D"-fsanitize=3Dundefined -W=
error" || { cat config.log && exit 1; }

        - CONFIG=3D"--enable-gprof --enable-gcov --disable-pie --target-lis=
t=3D${MAIN_SOFTMMU_TARGETS}"

and the MacOSX 9.4 build:
        # MacOSX builds
        - env:
            - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS}"
          os: osx
          osx_image: xcode9.4
          compiler: clang

The Xcode 10.3 build is already a reduced list:
        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softmmu,=
m68k-softmmu,x86_64-softmmu"


>
> Thanks to everybody,
> Aleksandar


--
Alex Benn=C3=A9e

