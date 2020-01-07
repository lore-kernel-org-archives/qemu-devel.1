Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E25C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0AE2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDKbYcWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0AE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioo9t-0002HS-Ex
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ion9R-0003p0-3S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ion9P-0004pB-KA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:35:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26125
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ion9P-0004oz-Gf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28aKNVBw2E1mDWMgUFsk521ZcZW2DlCzdUm/8BuZo4M=;
 b=SDKbYcWIjGaXoksTG87rXD5IS+H+Y2i2wTbgoD/yuVRA5qNgJVnC5vC7g+ug5AxWv5Uxws
 jBSuxLrvV/cC5nSX0oGQV9adHwNIvBdtNacVeAcZGj1QEdqERBvdmtkzssygss60Vx72t3
 SCZTnZPxYZ6CrxjTWTswuCBV9v/yTJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-dKW1ScfmOQyPgcPyP9pQWA-1; Tue, 07 Jan 2020 06:35:54 -0500
Received: by mail-wm1-f70.google.com with SMTP id g26so1861062wmk.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rDSGXVQiMR/yaabTXBCvRHk/Xsa6zDqBJNSlmTI44tQ=;
 b=iu0yDu2j2hqcQu/ybj4O0DRMnRX0ziHxmOZSYszZ0HhqnbksSU5BHj3rpFZMthXq6g
 To7orMoelHBFo58L67aP4xuianeE2w+6sWPQ+1UMRFnL9hjt+djrEMDYI4yBSu1PD1D0
 zTBGIa9dLQx1wWRsELYjonKwrjaioRWbRu5iA1oxAzWm+eBYZ0l4WyLE/kcYju5Ex6qz
 Q4leuGW9RJz0noEnvZOGYxtY4qr9f+dYWGBmFWKMuA0HocpaD8h7ea91HTeXHxuWwJPs
 KB5iO06PalMzcX7SC5gTgRQ8uX+8YbICqtGDqmaxqQi4PMLF7445z7pKrVxUMz+l6I/w
 SYUw==
X-Gm-Message-State: APjAAAXGU0gruz7DyvkQcMPbqa1DKXaxSNjdmR0BgSN66eS3WzvittRr
 r6LdxTaNAVKw95Kt4ZaJzvG6adiLlmJKaBAxIfTkYgYk2veuMpGK2P5SUD6TfxBo0paNsdOtP95
 s9YGuq80feofUOm4=
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr78197568wrs.222.1578396952190; 
 Tue, 07 Jan 2020 03:35:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwo4RgsWx1h6uof4BfK4TLnjZnsuRyZZzuXVkn0MIhn8Urspk50Vskylfj382PJ5jcHJXfsyQ==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr78197539wrs.222.1578396951907; 
 Tue, 07 Jan 2020 03:35:51 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n187sm26569317wme.28.2020.01.07.03.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 03:35:51 -0800 (PST)
Subject: Re: [PATCH 2/3] gitlab-ci.yml: Add a job to build EDK2 firmware
 binaries
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200106184601.25453-1-philmd@redhat.com>
 <20200106184601.25453-3-philmd@redhat.com>
 <74b5d03a-c3a3-38b8-68cb-192dd04f1802@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <505f9ed4-5b40-79d2-ac32-3ffb3d6c6976@redhat.com>
Date: Tue, 7 Jan 2020 12:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <74b5d03a-c3a3-38b8-68cb-192dd04f1802@redhat.com>
Content-Language: en-US
X-MC-Unique: dKW1ScfmOQyPgcPyP9pQWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 11:12 AM, Laszlo Ersek wrote:
> On 01/06/20 19:46, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add a GitLab job to build the EDK2 firmware binaries.
>> This job is only built when the roms/edk2/ submodule is updated,
>> when a git-ref starts with 'edk2' or when the last commit contains
>> 'EDK2'.
>=20
> keyword "or"; okay.
>=20
>>
>> GitLab CI generates an artifacts.zip file containing the firmware
>> binaries.
>>
>> With edk2-stable201905, the job took 40 minutes 26 seconds,
>> the artifacts.zip takes 10MiB.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   .gitlab-ci-edk2.yml | 37 +++++++++++++++++++++++++++++++++++++
>>   .gitlab-ci.yml      |  3 +++
>>   MAINTAINERS         |  3 ++-
>>   3 files changed, 42 insertions(+), 1 deletion(-)
>>   create mode 100644 .gitlab-ci-edk2.yml
>>
>> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
>> new file mode 100644
>> index 0000000000..abfaf52874
>> --- /dev/null
>> +++ b/.gitlab-ci-edk2.yml
>> @@ -0,0 +1,37 @@
>> +build-edk2:
>> + rules: # Only run this job when ...
>> + - changes: # ... roms/edk2/ is modified (submodule updated)
>> +   - roms/edk2/*
>> +   when: always
>> + - if: '$CI_COMMIT_REF_NAME =3D~ /^edk2/' # ... the branch/tag starts w=
ith 'edk2'
>=20
> (1) can you add "or" in the comment here?
>=20
>> +   when: always
>> + - if: '$CI_COMMIT_MESSAGE =3D~ /edk2/i' # last commit description cont=
ains 'EDK2'
>=20
> (2) ditto
>=20
>> +   when: always
>> + artifacts:
>> +   paths: # 'artifacts.zip' will contains the following files:
>> +   - pc-bios/edk2*bz2
>> +   - pc-bios/edk2-licenses.txt
>> +   - edk2-stdout.log
>> +   - edk2-stderr.log
>> + image: ubuntu:16.04 # Use Ubuntu Xenial
>> + before_script: # Install packages requiered to build EDK2
>> + - apt-get update --quiet --quiet
>> + - DEBIAN_FRONTEND=3Dnoninteractive
>> +   apt-get install --assume-yes --no-install-recommends --quiet --quiet
>> +     build-essential
>> +     ca-certificates
>> +     dos2unix
>> +     gcc-aarch64-linux-gnu
>> +     gcc-arm-linux-gnueabi
>> +     git
>> +     iasl
>> +     make
>> +     nasm
>> +     python
>> +     uuid-dev
>> + script: # Clone the required submodules and build EDK2
>> + - git submodule update --init roms/edk2
>=20
> yes, this is needed; qemu users are used to updating top-level
> submodules (which is why we didn't try to automate that away in the edk2
> build stuff)
>=20
>> + - git -C roms/edk2 submodule update --init
>=20
> (3) but this should not be necessary. See the "submodules" target in
> "roms/Makefile.edk2".

Hmm build fails without it:
https://gitlab.com/philmd/qemu/-/jobs/395644357#L436

The 'test -d edk2/.git' might be not enough?

>> + - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
>> + - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
>> + - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a edk2-stderr=
.log >&2)
>=20
> Process substitution is a nifty feature, but perhaps we can do without
> it, for simplicity. (I realize this is bash-only; I just like to
> minimize the use of non-portable features if there is a portable
> replacement that is also simple.)
>=20
> Redirections are processed in the order they appear on the command line
> [1], *after* stdout/stdin is redirected for pipelining [2]:
>=20
> [1]
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html=
#tag_18_07
>=20
> "If more than one redirection operator is specified with a command, the
> order of evaluation is from beginning to end."
>=20
> [2]
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html=
#tag_18_09_02
>=20
> "The standard input, standard output, or both of a command shall be
> considered to be assigned by the pipeline before any redirection
> specified by redirection operators that are part of the command"
>=20
>=20
> (4) Therefore, the following should work:
>=20
>    make -j${JOBS} -C roms efi 2>&1 1>edk2-stdout.log \
>    | tee -a edk2-stderr.log >&2
>=20
> Untested, of course :)

This works like charm :>

> Looks OK otherwise.

Thanks for the review!

>=20
> Thanks!
> Laszlo


