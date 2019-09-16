Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E02C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1032067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 10:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1032067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nsU-0008RG-LT
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 06:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9noh-0005vw-46
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9nob-00053H-HY
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:01:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i9nob-00052f-3H
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 06:01:01 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A2FB7BDAB
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 10:00:59 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so5599848wmo.5
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 03:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I7VZ6JfG7/3lyUsnV0VJIHLAAMksNs+AcWiSfx8o9Xo=;
 b=JTzPI8JEjQyt1E+qfVJte+zn7aAZqBU9gzHDCKWDdnL2irvQi6REvnOrtFm14sXm6s
 5MO4B5PcTg4skYwlzNfubdACqcNwEgJQoGRuYEaYzlFY3CdOsXhDGKtVM4vayUvVL+Tj
 7sLTVMdU0kLozJ3Ahm5a3Mvssv32m76d+RNOAg7zyoS4wTPWJRxeI7q0eiB2LWMMCE6E
 TlZe4eNG02Yq2YUkCdp9bmTw24pRKe6NcpjCEMUhkHYVL6kYOjpfa91KJbvEeZe+eAj/
 Rj0GorYYCxswEI1V+ueQb76D5/6lCzBPxw/KzxDt4KVLnUxiEAAqC4RkpbpDSKgrtJkw
 uNCA==
X-Gm-Message-State: APjAAAWJygKJmFmAC4enrOHlpA5300I+AEyBAZttds/Fw/XxgzIykhOA
 UugvswTKe0x9ytmx4v1w2aMJnCgjJBC4yKOXKnxhajFwsKrMZzHTDqDuNunHX76Xleo1KsXLIIP
 D8RXovDgMNUnsmTA=
X-Received: by 2002:adf:ee05:: with SMTP id y5mr13543213wrn.291.1568628056259; 
 Mon, 16 Sep 2019 03:00:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxG6Um2afGW9X2atJFXzdTltC8TNnXCCSU8OKOx46qrKn7aXD1XeTtO8Mf3W6aVw+qf20q7nA==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr13543186wrn.291.1568628056037; 
 Mon, 16 Sep 2019 03:00:56 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b7sm16402204wrj.28.2019.09.16.03.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 03:00:55 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-7-f4bug@amsat.org> <87o8zk1vi2.fsf@linaro.org>
 <77f96bda-d007-637a-7cc0-8b65790a6828@redhat.com> <87muf41sku.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <18e2ba80-1f16-87bc-48b0-5d08ef30f3ac@redhat.com>
Date: Mon, 16 Sep 2019 12:00:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87muf41sku.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 6/6] .travis.yml: Split enterprise vs.
 hobbyist acceptance test job
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 11:46 AM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 9/16/19 10:43 AM, Alex Benn=C3=A9e wrote:
>>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>  .travis.yml | 18 ++++++++++++++++--
>>>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index 69a37f7387..753276eb33 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -265,9 +265,23 @@ matrix:
>>>>          - "3.6"
>>>>
>>>>
>>>> -    # Acceptance (Functional) tests
>>>> +    # Acceptance (Functional) tests [enterprise]
>>>>      - env:
>>>> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86=
_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s39=
0x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu"
>>>> +        - CONFIG=3D"--python=3D/usr/bin/python3
>>>> --target-list=3Dx86_64-softmmu,mips64el-softmmu,aarch64-softmmu,s390=
x-softmmu,ppc64-softmmu"
>>>
>>> You could use:
>>>
>>>   --target-list=3D${MAIN_SOFTMMU_TARGETS}
>>>
>>> and
>>>
>>>   --disable-user --target-list-exclude=3D${MAIN_SOFTMMU_TARGETS}
>>
>> I like the idea, but this variable is slighly different:
>>
>> MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu,mips-=
softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64=
-softmmu"
>>
>> Are you suggesting we use MAIN_SOFTMMU_TARGETS for 'Enterprise'
>> targets?
>=20
> Broadly - I'm note sure how we want to make the distinction in QEMU. We
> have targets which are actively maintained and represent current
> architectures that people still ship software to run on. The other
> targets are machines that are either esoteric designs that exist in
> particular niches or of academic interest and the old architecture kept
> alive out of a sense of nostalgia.
>=20
>>
>> As long as mips64-softmmu is present, I think we can remove mips-softm=
mu
>> from MAIN_TARGETS. Maybe i386-softmmu can be removed too.
>=20
> Well the MIPS targets are actively maintained although for 32 bit you
> don't see many distros for them these days. There might be an argument
> for demoting i386-softmmu as I'm guessing there isn't much 32 bit kvm i=
n
> the enterprise right now (although It would be unsurprising to be told
> otherwise).
>=20
>>
>> That would give the following hobbyist list:
>>
>> i386-softmmu,mips-softmmu,alpha-softmmu,ppc-softmmu,m68k-softmmu
>=20
> I'm not sure about the hobbyist moniker as pretty much any of these TCG
> targets is more actively maintained than the x86 which is mostly all
> about the HW virtualisation these days. Trouble is I can't think of
> another name that doesn't sound condescending:
>=20
>   HISTORICAL_SOFTMMU_TARGETS
>   LEGACY_SOFTMMU_TARGETS
>   FASTERTHANNATIVE_SOFTMMU_TARGETS
>   ARCHIVISTS_SOFTMMU_TARGETS
>=20
> ? As ever naming things is hard....

:) I'm not trying to classify tests, I simply want users/maintainers to
not be reluctant/scared to add tests because "CI takes too long".

Also, I find it practical to have small jobs, what I do when testing a
series when I know it only affects a set of jobs, I push and directly
click "cancel all jobs" on the Travis web, then I just click on "restart
this job" on the set I'm interested in.
This way I can quickly figure out the series is OK or rework it.

>> (I plan to add hppa-softmmu there too).
>>
>>>> +        - TEST_CMD=3D"make check-acceptance"
>>>> +      after_failure:
>>>> +        - cat tests/results/latest/job.log
>>>> +      addons:
>>>> +        apt:
>>>> +          packages:
>>>> +            - python3-pil
>>>> +            - python3-pip
>>>> +            - python3.5-venv
>>>> +
>>>> +
>>>> +    # Acceptance (Functional) tests [hobbyist]
>>>> +    - env:
>>>> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dmip=
s-softmmu,arm-softmmu,alpha-softmmu,ppc-softmmu,m68k-softmmu"
>>>>          - TEST_CMD=3D"make check-acceptance"
>>>>        after_failure:
>>>>          - cat tests/results/latest/job.log
>>>
>>>
>>> --
>>> Alex Benn=C3=A9e
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

