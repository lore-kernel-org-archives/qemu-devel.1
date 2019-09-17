Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB1C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8D520862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8D520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAA8j-0007XY-Jz
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAA74-0006iD-Ql
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAA73-0005Pq-2B
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:49:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAA72-0005P6-MR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:49:32 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 867D48553B
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:49:31 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id d10so647693wmb.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 02:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xmHNvmco0gIgXLnCjuy+4KYPGPpXHHI7NESsjXL//y8=;
 b=U6MAYiChUAjMcs5CQYqnQsrfZzvzG2azxBXP0Qt7xS+g4V5fNtG/5ON7JcNZOZKdv9
 kw9K8zxUJxkWGuoLCvyzxemKpLAeT64wTEv1m7vLWUHqW46wmAdz2BrLV/mThHI2V+zI
 3c1AkrleAl6woXKTAVxEARCMkZxLqsAHA3nohk9i/c/4Zm8TXgWw8pstplS7qZlksp8/
 kb+f7lgMCSKoyC6rMJlPWumtAjqpIx7jpWLQU357KJaFXSNR5qjbIsOSTSN8O1dy7gcz
 yUnuWKS2dOx4Is02chVLj0NC5ZlJ9oV7mxqKcU3c4VENtGEhfdMU9G/gAAZpVo2cFoUx
 O6pQ==
X-Gm-Message-State: APjAAAW4GgIdtfte/gy3LrOSrYPA9g2KahKWHMi8ev9bLijWCO6Chnhi
 EUl6AKDQh4aIgYRATlIn6QU9qJTtqroVH9MaKVwAW6LNpPU8HuVAVu8+Ke1YGa3I1z998OLLMW4
 +GrI5aqUVI04y9jc=
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr2407557wrq.214.1568713770250; 
 Tue, 17 Sep 2019 02:49:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy15ibIXwsMWkLm5lRh1fo7t8v/fTccC6EluEHxhnAJPxKex3GDReCyyDwsCnvnuHGJArP0ug==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr2407531wrq.214.1568713770002; 
 Tue, 17 Sep 2019 02:49:30 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u68sm2261420wmu.12.2019.09.17.02.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 02:49:29 -0700 (PDT)
To: Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-3-f4bug@amsat.org>
 <20190916175914.GA7550@dhcp-17-173.bos.redhat.com>
 <20190916185513.GA13659@dhcp-17-173.bos.redhat.com>
 <87h85b1d48.fsf@linaro.org>
 <CACXAS8BgxaeXt3dDxw6=JxSRWVvi90Kr8+BZyhgCdYxcONbQaQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fe76a6d5-0fff-0b6a-ee5d-73cf529812aa@redhat.com>
Date: Tue, 17 Sep 2019 11:49:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACXAS8BgxaeXt3dDxw6=JxSRWVvi90Kr8+BZyhgCdYxcONbQaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/6] tests/acceptance: Test Open
 Firmware on the PReP/40p
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
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, "open list:PReP" <qemu-ppc@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 11:42 AM, Artyom Tarasenko wrote:
> On Tue, Sep 17, 2019 at 11:33 AM Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
>> Cleber Rosa <crosa@redhat.com> writes:
>>> On Mon, Sep 16, 2019 at 01:59:22PM -0400, Cleber Rosa wrote:
>>>> On Sun, Sep 15, 2019 at 11:19:36PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>> User case from:
>>>>> https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> ---
>>>>>  tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
>>>>>  1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/pp=
c_prep_40p.py
>>>>> index 53f2d2ecf0..a0eac40d9f 100644
>>>>> --- a/tests/acceptance/ppc_prep_40p.py
>>>>> +++ b/tests/acceptance/ppc_prep_40p.py
>>>>> @@ -61,3 +61,24 @@ class IbmPrep40pMachine(Test):
>>>>>          os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:4=
0 PST 2007'
>>>>>          self.wait_for_console_pattern(os_banner)
>>>>>          self.wait_for_console_pattern('Model: IBM PPS Model 6015')
>>>>> +
>>>>> +    def test_openfirmware(self):
>>>>> +        """
>>>>> +        :avocado: tags=3Darch:ppc
>>>>> +        :avocado: tags=3Dmachine:40p
>>>>> +        """
>>>>> +        bios_url =3D ('https://github.com/artyom-tarasenko/openfir=
mware/'
>>>>> +                    'releases/download/40p-20190413/q40pofw-serial=
.rom')
>>>>> +        bios_hash =3D '880c80172ea5b2247c0ac2a8bf36bbe385192c72'
>>>>> +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios=
_hash)
>>>>> +
>>>>> +        self.vm.set_machine('40p')
>>>>> +        self.vm.set_console()
>>>>> +        self.vm.add_args('-bios', bios_path)
>>>>> +
>>>>> +        self.vm.launch()
>>>>> +        self.wait_for_console_pattern('QEMU PReP/40p')
>>>>> +        fw_banner =3D 'Open Firmware, built  April 13, 2019 09:29:=
23'
>>>>> +        self.wait_for_console_pattern(fw_banner)
>>>>> +        prompt_msg =3D 'Type any key to interrupt automatic startu=
p'
>>>>> +        self.wait_for_console_pattern(prompt_msg)
>>>>> --
>>>>> 2.20.1
>>>>>
>>>>
>>>> Tested-by: Cleber Rosa <crosa@redhat.com>
>>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>
>>> Actually, I'm seeing random but consistent failures.  I've tracked
>>> it down to the 'Open Firmware, built  April 13, 2019 09:29:23'.  Out
>>> of 100 executions I got 27 failures, with that line logged as:
>>>
>>>   2019-09-16 14:44:54,540 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:00,762 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:06,575 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:12,859 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:18,707 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:21,876 ppc_prep_40p     L0033 DEBUG| en Firmware, =
built  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:28,054 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:31,163 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:34,291 ppc_prep_40p     L0033 DEBUG| en Firmware, =
built  April 13, 2019 09:29:23
>>>   2019-09-16 14:45:57,719 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:03,610 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:06,795 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:17,087 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:21,534 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:24,694 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:38,076 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:49,863 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:46:54,435 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:00,672 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:03,834 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:06,852 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:14,276 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:17,380 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:34,749 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:39,217 ppc_prep_40p     L0033 DEBUG| n Firmware, b=
uilt  April 13, 2019 09:29:23
>>>   2019-09-16 14:47:43,750 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>   2019-09-16 14:48:04,003 ppc_prep_40p     L0033 DEBUG| Firmware, bui=
lt  April 13, 2019 09:29:23
>>>
>>> Given that we're not seeing this behavior in other target/marchine
>>> tests, my first impression is that this is what's being produced
>>> by QEMU, and not what's being badly captured by the Avocado and/or
>>> the test code.
>>
>> Is the DEBUG line meant to show everything that avocado saw? I guess w=
e
>> could have a bug in the serial port emulation causing characters to be
>> dropped?
>=20
> FWIW back in April I launched QEMU really a lot and never saw a broken =
banner.
> Either it's Avocado, or a regression. Is it possible to see the
> complete serial log?

I never saw this either.

Around that time (April) we had some problem with VM/Avocado using
chardev devices with Python, Cleber/Alex do you know if this is now fixed=
?

Meanwhile I'll investigate Cleber's failure (what are your ./configure
options and Avocado version used?)

Thanks,

Phil.

