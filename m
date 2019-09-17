Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E1BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD552067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD552067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAA3s-0004zz-Gu
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAA2b-00040w-1z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAA2Z-0002r7-RV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAA2Z-0002q4-Gg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:44:55 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEE0A4E83E
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:44:53 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id n11so1003444wmc.8
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N1XGBRcV+UH5hGLZ3sO9NUBt4cQi6jH/DfS4rarD3xU=;
 b=Mp7w1VOA5TDQTead75UT3fNNlgLZC9RAzKwJjAGD6Q16AMqNbxfkbRd3krjv3fwtwr
 L1f8sGxQV22jnv7whnHduwYUjM2MOtfhwF54T1l9NUN2mh2fI4PlDYgjyyOvUfF/fqpj
 YqYGxGi9ug3ne1PBdZqwJeJgd1urzFrJ7Dg4by7JMXF2TRypNIlRSIvop7eDoJD8BNuV
 /nxBEdU+F27aVzeLhZY8GLpPx/1bsYfK+Cv+47s7pbN81NrVYp27E3Gfv1O6KofoL+Dg
 heMeO7I1tEiU2bq7YfaLkp6FkikZaKEZNXXBI+0TeoSoiAb+EgIRGC5+MuLZ1zapiziO
 fWYQ==
X-Gm-Message-State: APjAAAXxxydjHXzNeh+khN8JcGVzQPnvHs6WrvLMfjbK4bfdzXqNcjA2
 diOOxK+znGyi8IEq+aOjUCwrRGIS8qJjDHImDWq8Mw2ewwOF6xJHwsWbWItilEB+4HNLXRmHydb
 R7SBPHhRYEG+HGCg=
X-Received: by 2002:a05:6000:b:: with SMTP id
 h11mr2273512wrx.270.1568713492694; 
 Tue, 17 Sep 2019 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxIw5bDY1pNnwQOijy8zgPw3ThbPk3M9c+jz+dY+Gn7Q7vmyNoDaUv7GRs9l8YW12L17JruQ==
X-Received: by 2002:a05:6000:b:: with SMTP id
 h11mr2273496wrx.270.1568713492507; 
 Tue, 17 Sep 2019 02:44:52 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id j22sm3812427wre.45.2019.09.17.02.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 02:44:51 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-4-f4bug@amsat.org>
 <20190916193245.GA15318@dhcp-17-173.bos.redhat.com>
 <87impr1d6e.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <94cb3570-e2aa-fb20-6027-7026525e6922@redhat.com>
Date: Tue, 17 Sep 2019 11:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87impr1d6e.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/6] tests/acceptance: Test OpenBIOS on
 the PReP/40p
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
 qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 11:31 AM, Alex Benn=C3=A9e wrote:
> Cleber Rosa <crosa@redhat.com> writes:
>> On Sun, Sep 15, 2019 at 11:19:37PM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> User case from:
>>> https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  tests/acceptance/ppc_prep_40p.py | 32 ++++++++++++++++++++++++++++++=
++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_=
prep_40p.py
>>> index a0eac40d9f..87b5311b89 100644
>>> --- a/tests/acceptance/ppc_prep_40p.py
>>> +++ b/tests/acceptance/ppc_prep_40p.py
>>> @@ -82,3 +82,35 @@ class IbmPrep40pMachine(Test):
>>>          self.wait_for_console_pattern(fw_banner)
>>>          prompt_msg =3D 'Type any key to interrupt automatic startup'
>>>          self.wait_for_console_pattern(prompt_msg)
>>> +
>>> +    def test_openbios_192m(self):
>>> +        """
>>> +        :avocado: tags=3Darch:ppc
>>> +        :avocado: tags=3Dmachine:40p
>>> +        """
>>> +        self.vm.set_machine('40p')
>>> +        self.vm.set_console()
>>> +        self.vm.add_args('-m', '192')
>>
>> Is 192 a magic number (some kind of limit)?  Or just a value to check
>> against later?
>=20
> Just the memory configured for the machine, checked bellow. Or are you
> wondering why 192m and not any other amount?

The machine default is 128MiB. The firmware asks the memory controller
how many SIMMs of 8MiB are inserted. We can run OpenBIOS with 128MiB,
but by specifying a different default in this test, we also test the
memory controller device :)

Since this is not obvious I'll add a comment.

>>> +
>>> +        self.vm.launch()
>>> +        self.wait_for_console_pattern('>> OpenBIOS')
>>> +        self.wait_for_console_pattern('>> Memory: 192M')
>>> +        self.wait_for_console_pattern('>> CPU type PowerPC,604')
>>> +
>>
>> On my testing, this is a very stable test, I'm only getting PASSes.
> <snip>
>=20
> --
> Alex Benn=C3=A9e
>=20

