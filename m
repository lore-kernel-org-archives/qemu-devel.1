Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB8CC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF2820678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF2820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nEz-0000aq-JG
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9nEB-0008OP-33
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9nE8-0006md-ME
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:23:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i9nE8-0006ks-FT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:23:20 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93D7281DEC
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 09:23:18 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j2so7495869wre.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tw/LnvRXA/ZsgOOZs9MJes4ZicBEx/+DTOp5f8FYdwM=;
 b=QnU9bCIW/8TJ9IrulytAnXEwJWGsgzjDIERwCUIYintH/NsvV7oITPKaoVRqnhq7Qs
 6n+rFavwz8i/VCo8LkhwgCjAHCDODotg2tMmfeLmUdtMQTphAKHxvJmFhvvM1Z4Kgexf
 HvmAy5+n27RyefUEy8zPZ2X8geRVU+QWofu8LbBCNKlXWK6q0TJcHkT4DTcgAln6NS1I
 On2vJ9fjz8E46XLYa/QBVB5JsR3Bp0wjw4Zhbhu2XVfvP2ZssS5ZfkyxHAj74UvGwMhK
 zWHZYUWHsK6oSlVBfCl2AaWhCBa89id1z04lYqySeakWntRmORdNuhmF3nY1/vcZHrez
 zImw==
X-Gm-Message-State: APjAAAUgX6x8M84VuQV87a9gY8z7BW9/2x0rQtZZzM/lxb+dFSpotJA5
 1cJSN/qK0G3hy/57QJc/nxkRMVawA5SfMRchEPwTQGPJQKZtp6iNhaP0aQFCHkDyYw8TjQ3URQO
 czjM60kfDa9l1AnA=
X-Received: by 2002:a7b:c764:: with SMTP id x4mr12129422wmk.134.1568625795865; 
 Mon, 16 Sep 2019 02:23:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCt0B0OoBE46bnF4meLUIWeynu2ibKWZQ5HQLtWF8rOFRdIHp9xdH1qrNqu1l+tHjJYtlsmA==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr12129396wmk.134.1568625795557; 
 Mon, 16 Sep 2019 02:23:15 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g11sm1158848wmh.45.2019.09.16.02.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 02:23:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-7-f4bug@amsat.org> <87o8zk1vi2.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <77f96bda-d007-637a-7cc0-8b65790a6828@redhat.com>
Date: Mon, 16 Sep 2019 11:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87o8zk1vi2.fsf@linaro.org>
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
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 10:43 AM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  .travis.yml | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 69a37f7387..753276eb33 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -265,9 +265,23 @@ matrix:
>>          - "3.6"
>>
>>
>> -    # Acceptance (Functional) tests
>> +    # Acceptance (Functional) tests [enterprise]
>>      - env:
>> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x=
-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu"
>> +        - CONFIG=3D"--python=3D/usr/bin/python3
>> --target-list=3Dx86_64-softmmu,mips64el-softmmu,aarch64-softmmu,s390x-=
softmmu,ppc64-softmmu"
>=20
> You could use:
>=20
>   --target-list=3D${MAIN_SOFTMMU_TARGETS}
>=20
> and
>=20
>   --disable-user --target-list-exclude=3D${MAIN_SOFTMMU_TARGETS}

I like the idea, but this variable is slighly different:

MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu,mips-sof=
tmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-so=
ftmmu"

Are you suggesting we use MAIN_SOFTMMU_TARGETS for 'Enterprise' targets?

As long as mips64-softmmu is present, I think we can remove mips-softmmu
from MAIN_TARGETS. Maybe i386-softmmu can be removed too.

That would give the following hobbyist list:

i386-softmmu,mips-softmmu,alpha-softmmu,ppc-softmmu,m68k-softmmu

(I plan to add hppa-softmmu there too).

>> +        - TEST_CMD=3D"make check-acceptance"
>> +      after_failure:
>> +        - cat tests/results/latest/job.log
>> +      addons:
>> +        apt:
>> +          packages:
>> +            - python3-pil
>> +            - python3-pip
>> +            - python3.5-venv
>> +
>> +
>> +    # Acceptance (Functional) tests [hobbyist]
>> +    - env:
>> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dmips-=
softmmu,arm-softmmu,alpha-softmmu,ppc-softmmu,m68k-softmmu"
>>          - TEST_CMD=3D"make check-acceptance"
>>        after_failure:
>>          - cat tests/results/latest/job.log
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

