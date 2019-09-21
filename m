Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F2C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED4D208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED4D208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBbTs-0002aX-9P
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 05:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBbT5-0001xn-8T
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBbT3-0000jt-Lt
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBbT3-0000hz-EB
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:14:13 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16F2CB62C
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 09:14:12 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l3so2800137wmf.8
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 02:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FA+JzAgDMVZOdsDHL63KG1xPWkgSmQb1cJFkkfcNCLQ=;
 b=IDDbQnGkfef/GpIBUDuLU2rD44XnBkNc+J/Or590dADNHCon0567qzLyEv+3ZWDGfm
 m30Jz6Yklx/PsEGUExnWaUQ5/+muYIcIfPLnBXWIDno8syzIa3d0lGB4WxRLeGAEuuND
 jHY8WIAdp/cs0eqL3eHDNnqMDvyT9TUzEMhr2RlzEZN/YsL4IkRzuBzqnm4J5+JqyEFJ
 LrIVFcaNSVhrjVSOIRgBqcpZR9I70OPGjZ9qKz+mZwwtpYHp6R88vEybbs3fje7+NrIg
 +flzgknETISCwzgxIOoks70yFnSGbp7gxp+Nqhv1+RGw7McO2pBXmxhija3vxQVujmR8
 2/aQ==
X-Gm-Message-State: APjAAAUxYxfqcRdHU8It5XPmjw3bgNKEdWeES4DyAibbzl2QRmjHM7/M
 6UeIfbsXMOOwjfUQSuEO0gAkm9ZHlJnrqsRdfiIsE2ZGxLi/nkHljXUq4zab1MA32nlVq/t09E3
 EEaNZl5FPaDwhTXo=
X-Received: by 2002:a1c:4846:: with SMTP id v67mr6508570wma.120.1569057250831; 
 Sat, 21 Sep 2019 02:14:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRnfBjWJXTC8ev3fUOGKKKcVQ+dT7peHSQsuaihl1qRWDxj+qjR3mmP9H/9GlM3AZAPt99ew==
X-Received: by 2002:a1c:4846:: with SMTP id v67mr6508557wma.120.1569057250620; 
 Sat, 21 Sep 2019 02:14:10 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v7sm5318893wru.87.2019.09.21.02.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 02:14:09 -0700 (PDT)
Subject: Re: [PATCH 5/5] .travis.yml: Build and install EDK2 roms
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>
References: <20190311003052.13778-1-philmd@redhat.com>
 <20190311003052.13778-6-philmd@redhat.com>
 <ecd8aaf1-f75e-abd0-48b1-e80a227f01c3@redhat.com>
 <19958c32-2df9-cccf-3f05-c2fa0fe3dec2@redhat.com>
 <b8aad7bf-1dec-5c1d-1b76-d15b639e4953@redhat.com>
 <87tvcsc8h2.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9408b4f3-081b-fe92-0368-7c79bb9abe24@redhat.com>
Date: Sat, 21 Sep 2019 11:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87tvcsc8h2.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 8:44 PM, Alex Benn=C3=A9e wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
>> On 06/13/19 18:59, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Laszlo,
>>>
>>> On 3/12/19 5:29 PM, Laszlo Ersek wrote:
>>>> On 03/11/19 01:30, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> Add a job to build and install the EDK2 platform firmware binaries.
>>>>>
>>>>> This job is only triggered if the last commit matches the EDK2
>>>>> name (case insensitive), or when tag are created (such releases
>>>>> or release candidates).
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> ---
>>>>>  .travis.yml | 21 +++++++++++++++++++++
>>>>>  1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>> index e942175dd3..628cc52c99 100644
>>>>> --- a/.travis.yml
>>>>> +++ b/.travis.yml
>>>>> @@ -258,3 +258,24 @@ matrix:
>>>>>      - env:
>>>>>          - CONFIG=3D"--disable-system"
>>>>>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>>>> +
>>>>> +
>>>>> +    # EDK2 roms builds
>>>>> +    - if: tag IS present OR commit_message =3D~ /(edk2|EDK2)/
>>>>> +      env:
>>>>> +        - CONFIG=3D"--disable-system --disable-user --prefix=3D$PW=
D/dist"
>>>>> +        - EDK2_BUILD_OPTIONS=3D"--quiet --silent"
>>>>> +      script:
>>>>> +        - git submodule update --init roms/edk2
>>>>> +        - make -j3
>>>>> +        - make -C roms efi -j2
>>>>> +        - make install
>>>>> +      addons:
>>>>> +        apt:
>>>>> +          packages:
>>>>> +            - dos2unix
>>>>> +            - gcc-aarch64-linux-gnu
>>>>> +            - gcc-arm-linux-gnueabihf
>>>>> +            - iasl
>>>>> +            - nasm
>>>>> +            - uuid-dev
>>>>>
>>>>
>>>> Regardless of what problem we're trying to address with "--quiet
>>>> --silent", those options are wrong. You certainly want detailed buil=
d
>>>> logs for the case a CI job fails (at build time or at runtime).
>>>
>>> On Travis we get:
>>>
>>> The job exceeded the maximum log length, and has been terminated.
>>> (https://travis-ci.org/philmd/qemu/jobs/545329905)
>>>
>>> So I moved to GitLab, but we still get:
>>>
>>> "Job's log exceeded limit of 4194304 bytes."
>>> (https://gitlab.com/philmd/qemu/-/jobs/230772314)
>>>
>>> Regarding the options to pass to edk2-build.sh,
>>>
>>> $ build --help
>>>   -j LOGFILE, --log=3DLOGFILE
>>>                    Put log in specified file as well as on console.
>>>   -s, --silent     Make use of silent mode of (n)make.
>>>   -q, --quiet      Disable all messages except FATAL ERRORS.
>>>   -v, --verbose    Turn on verbose output with informational messages
>>>                    printed, including library instances selected, fin=
al
>>>                    dependency expression, and warning messages, etc.
>>>
>>> '--log' duplicate the output, and I don't want to reduce the log
>>> details, so I understand I should use:
>>>
>>>   ./edk2-build.sh [...] --log=3Dbuild.log >/dev/null || cat build.log
>>>
>>> Is that correct? But then I'd need to modify Makefile.edk2 to redirec=
t
>>> stdout.
>>
>> Would it be possible to invoke the outermost make like this?
>>
>>   make -C roms -j2 efi >make.roms.efi.log 2>&1 \
>>   || ( tail -c 2M make.roms.efi.log; false )

The build gets killed:

  No output has been received in the last 10m0s, this potentially
  indicates a stalled build or something wrong with the build itself.
  Check the details on how to adjust your build configuration on:

https://docs.travis-ci.com/user/common-build-problems/#build-times-out-be=
cause-no-output-was-received

  The build has been terminated

> Or something like:
>=20
>      after_failure:
>        - tail -c 2M make.roms.efi.log
>=20
> as Cleber suggested for his acceptance tests. Generally we want to try
> and make the builds less noisy and only echo relevant details when it
> fails. However we've tended to turn up the noise so we can debug stuff
> and that is just painful to browser on the Travis website.

I'll try that.

>>>> The reason why I only include DEBUG firmware builds in the edk2 bund=
ling
>>>> series is similar -- RELEASE builds lack DEBUG messages and ASSERT()=
s,
>>>> and as such they are 100% unsupportable in my book. Bugs in software=
 are
>>>> the norm, not the exception, so we should allow (even force) the use=
r
>>>> (and remote systems) to provide as much information as they can.
>>>
>>> Sure, we have the same book here ;)
>>>
>>> Regards,
>>>
>>> Phil.
>>>
> --
> Alex Benn=C3=A9e
>=20

