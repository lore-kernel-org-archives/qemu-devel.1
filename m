Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C0AC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028FE20870
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKaT4vVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028FE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1SU4-0005Bl-4D
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1STP-0004Xu-OX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1STN-0003Bc-VR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:08:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1STN-0003BO-RB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581415732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xK0zrMEkoSCleotxh27l/Mhp7k/XGqfNZX5CTg6/XPQ=;
 b=iKaT4vVq5bNs2j+tzKZo9AfkL93WEDLdKIy6CJ0PGV7tsqcIqYO83dFsxbvsmkcY6S/u7T
 44AN7U4047yt6UF/lp3u9UjI5hVoQQ4wd2QqXtWUsWYGSkj/yVghzZU1LT/13NT1M4x/O3
 gbVWG/YdLioLjDI0V/HszGtr0OYo9So=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-eWCSN9nYMLuKHr52K6EpSg-1; Tue, 11 Feb 2020 05:08:47 -0500
Received: by mail-wr1-f72.google.com with SMTP id w17so6644151wrr.9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 02:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s213ryhI7rtPbGqQei6G9oTTZJ6HNcM1cOEDhlbYEVI=;
 b=A4C2E3OAT5Ab69GJE8tmOjbMV2TT1UfY4U3dbsfT++X96DqHrD1MqghQtLJuOiDwQx
 NwbrA/HygZt+ouN8dt0B2WPHRBgy5Q1Cm7Zmm8klBx6zbfxpUqeBEsboXn6EtSkQzsgJ
 zyvGtWtqKgZEJX6Ol0+upM3qBL0repwXsCC0r1lznBXja6tMQy7sEQkRAFQtaVvJ5vnj
 fhcwWlm/Bfmrq3C2r4sXWnj+LWq8WvhpCKrdf0slCMbsKwMl1Nc/AJGTMB3Vfd116262
 68W6ABz6tFZnnvzvrIcWrqpoa0vbo+YBM35Y2cWjLaVo4ADmQ0Y+Sp7jjKjCwaVF/t3A
 KK9w==
X-Gm-Message-State: APjAAAUmfC/Add3ibwaBchICY0DOHGhqyuV2CcDuXKuYIswkYt1R8e59
 gQZsbZ6s70z4qDHnLFaULPfZlKxlfXcIsF4QzYhUckN0uLfTOVoH7wF/iX4TI5Teb3SrwsDDP1j
 Ajz6sWBOzqF0BVlI=
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr8038195wrp.2.1581415726459;
 Tue, 11 Feb 2020 02:08:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnvREcQuXjca4hmaonmq0B/buJ0iWVVO4ezB4IdBUyh49q+b0NRhQd+HKOLx7SjpCYrxNtyg==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr8038152wrp.2.1581415726103;
 Tue, 11 Feb 2020 02:08:46 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm4748939wrv.78.2020.02.11.02.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 02:08:45 -0800 (PST)
Subject: Re: [PATCH 1/2] tests/acceptance: Extract boot_integratorcp() from
 test_integratorcp()
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200131211102.29612-1-f4bug@amsat.org>
 <20200131211102.29612-2-f4bug@amsat.org>
 <c13e2bf5-2373-f33e-1aea-824c46b9f3cf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c058ed6e-1296-ef9e-4844-97bf12bef1bd@redhat.com>
Date: Tue, 11 Feb 2020 11:08:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c13e2bf5-2373-f33e-1aea-824c46b9f3cf@redhat.com>
Content-Language: en-US
X-MC-Unique: eWCSN9nYMLuKHr52K6EpSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/1/20 8:06 AM, Thomas Huth wrote:
> On 31/01/2020 22.11, Philippe Mathieu-Daud=C3=A9 wrote:
>> As we want to re-use this code, extract it as a new function.
>> Since we are using the PL011 serial console, add a Avocado tag
>> to ease filtering of tests.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   tests/acceptance/machine_arm_integratorcp.py | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/accept=
ance/machine_arm_integratorcp.py
>> index 4f9ab40f2f..748819916d 100644
>> --- a/tests/acceptance/machine_arm_integratorcp.py
>> +++ b/tests/acceptance/machine_arm_integratorcp.py
>> @@ -19,12 +19,7 @@ class IntegratorMachine(Test):
>>  =20
>>       timeout =3D 90
>>  =20
>> -    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted c=
ode')
>> -    def test_integratorcp(self):
>> -        """
>> -        :avocado: tags=3Darch:arm
>> -        :avocado: tags=3Dmachine:integratorcp
>> -        """
>> +    def boot_integratorcp(self):
>>           kernel_url =3D ('https://github.com/zayac/qemu-arm/raw/master/=
'
>>                         'arm-test/kernel/zImage.integrator')
>>           kernel_hash =3D '0d7adba893c503267c946a3cbdc63b4b54f25468'
>> @@ -40,4 +35,13 @@ class IntegratorMachine(Test):
>>                            '-initrd', initrd_path,
>>                            '-append', 'printk.time=3D0 console=3DttyAMA0=
')
>=20
> I wonder whether you might want to move the "console=3DttyAMA0" to the
> test_integratorcp(), too, to get the text in the framebuffer in the
> second test instead?

This is not a test, but a common method used by both tests, so both use it.

>=20
>>           self.vm.launch()
>> +
>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted c=
ode')
>> +    def test_integratorcp(self):
>> +        """
>> +        :avocado: tags=3Darch:arm
>> +        :avocado: tags=3Dmachine:integratorcp
>> +        :avocado: tags=3Ddevice:pl011
>> +        """
>> +        self.boot_integratorcp()
>>           wait_for_console_pattern(self, 'Log in as root')
>>
>=20
> Anyway, patch looks fine,
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!

Peter, Thomas previous patch and these series are reviewed. Can you=20
queue them in your target-arm.next tree?


