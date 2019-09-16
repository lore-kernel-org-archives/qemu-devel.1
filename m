Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDCBC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA3D20678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA3D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9uF2-0002L5-PR
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9tj9-0003zQ-9d
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9tj7-0005oy-6f
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:19:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i9tj6-0005oU-UC
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:19:45 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 758F76412B
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 16:19:43 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j2so124795wre.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 09:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/nCeEFcwNYNmavubZMs4+O41Pm/FoNBLtnz4Kw++jmQ=;
 b=pxfFGDRaN2f1xoFV9dyP8VHfI/1jdT6WEsY5FSeIng5tsT+jZ3eSRCeLomnykisTxO
 SSh05w4AYkSH43e8Kc8cEwPaHyVkmJkRYAlCPpPPrtUapA/HBZqK5WuMucGjTfjL1D3Q
 UiineV+PXoU+gUbmuNQRduXQaLltYcj9aLrgXEUj60vCrdcFROWh7+PDXKZ+oiYDalfs
 PLj71K1jIUYsz+kByZWyfXIUGCsBgnhbvi+0vKSqBCN1kpBDaM3oD7suUvGKpdNdbQ13
 vC9Y2eg0MvmzUf0OvCMiEQKbPhseZkwMuxOWkMn4D6/pkGhKj6H2Zy6EJZuzZWSUJD4j
 LhTg==
X-Gm-Message-State: APjAAAWQp6dCWjuMOnoRod4BmD31aMZGYcZFa5kCnTOyTX+PIEfUwXG9
 mZIxI107jtOFIb9MNjXxkxdAF00aou8zAOocpnnU3YN9NOv/3T5V9YfoO+/WFoWOxpu619iOGOq
 rqw3hd1RzCRGgkOk=
X-Received: by 2002:adf:a415:: with SMTP id d21mr49553wra.94.1568650782182;
 Mon, 16 Sep 2019 09:19:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzZ7AjunQTFCvEBZewnQ8gHQdMk/6Jy+i6MK+EUB9Fzq+6aDMy1nbisqebbmI3grjZVN/BpmQ==
X-Received: by 2002:adf:a415:: with SMTP id d21mr49516wra.94.1568650781823;
 Mon, 16 Sep 2019 09:19:41 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v6sm40213wma.24.2019.09.16.09.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 09:19:41 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-2-f4bug@amsat.org>
 <20190916160839.GA2724@dhcp-17-173.bos.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <252b6e94-fe8f-f9a7-0d4b-4743b1809a06@redhat.com>
Date: Mon, 16 Sep 2019 18:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190916160839.GA2724@dhcp-17-173.bos.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/6] tests/acceptance: Add test that
 runs NetBSD 4.0 installer on PRep/40p
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
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 6:08 PM, Cleber Rosa wrote:
> On Sun, Sep 15, 2019 at 11:19:35PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> As of this commit, NetBSD 4.0 is very old. However it is enough to
>> test the PRep/40p machine.
>>
>> User case from:
>> http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html
>>
>> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Installers after 4.0 doesn't work anymore, not sure if this is a
>> problem from the QEMU model or from NetBSD.
>> ---
>>  MAINTAINERS                      |  1 +
>>  tests/acceptance/ppc_prep_40p.py | 63 +++++++++++++++++++++++++++++++=
+
>>  2 files changed, 64 insertions(+)
>>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 50eaf005f4..ce809c7dee 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1068,6 +1068,7 @@ F: hw/timer/m48t59-isa.c
>>  F: include/hw/isa/pc87312.h
>>  F: include/hw/timer/m48t59.h
>>  F: pc-bios/ppc_rom.bin
>> +F: tests/acceptance/machine_ppc_prep_40p.py
>> =20
>>  sPAPR
>>  M: David Gibson <david@gibson.dropbear.id.au>
>> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_p=
rep_40p.py
>> new file mode 100644
>> index 0000000000..53f2d2ecf0
>> --- /dev/null
>> +++ b/tests/acceptance/ppc_prep_40p.py
>> @@ -0,0 +1,63 @@
>> +# Functional test that boots a PReP/40p machine and checks its serial=
 console.
>> +#
>> +# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later. See the COPYING file in the top-level directory.
>> +
>> +import os
>> +import logging
>> +
>> +from avocado import skipIf
>> +from avocado_qemu import Test
>> +
>> +
>> +class IbmPrep40pMachine(Test):
>> +
>> +    timeout =3D 60
>> +
>> +    # TODO refactor to MachineTest
>=20
> Your TODO is a clear sign of awareness of the duplicated code that
> follows.  The mention of a MachineTest points into the direction that
> I can see as the best final solution (that is, test classes that target
> specific test scenarions).
>=20
> But, it may be a more effective refactor strategy, to simply turn the
> `wait_for_console_pattern` from a method into a utility function, and
> then the discussion of the common test classes (say MachineTest,
> GuestTest, MigrationTest) can follow later.

Yes, I'd like we clean this and make it robust, but for now, the more
tests we have, the better we can see how the common MachineTest should
be. Let's do this in another follow-up series.

>> +    def wait_for_console_pattern(self, success_message, failure_messa=
ge=3DNone):
>=20
> Following the previous suggestion, `self` would become something like `=
test`.
>=20
>> +        """
>> +        Waits for messages to appear on the console, while logging th=
e content
>> +
>=20
> Documented as something like:
>=20
>   :param test: an Avocado test containing a VM that will have its conso=
le
>                read and probed for a success or failure message
>   :type test: :class:`avocado_qemu.Test`
>=20
>> +        :param success_message: if this message appears, test succeed=
s
>> +        :param failure_message: if this message appears, test fails
>> +        """
>> +        console =3D self.vm.console_socket.makefile()
>> +        console_logger =3D logging.getLogger('console')
>> +        while True:
>> +            msg =3D console.readline().strip()
>> +            if not msg:
>> +                continue
>> +            console_logger.debug(msg)
>> +            if success_message in msg:
>> +                break
>> +            if failure_message and failure_message in msg:
>> +                fail =3D 'Failure message found in console: %s' % fai=
lure_message
>> +                self.fail(fail)
>> +
>> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-C=
I')
>> +    def test_factory_firmware_and_netbsd(self):
>> +        """
>> +        :avocado: tags=3Darch:ppc
>> +        :avocado: tags=3Dmachine:40p
>> +        :avocado: tags=3Dslowness:high
>=20
> This is certainly a discussion in itself, but I wonder what is your
> criteria for definising the slowness level of a test.  FOY, this one
> takes me ~17 seconds on my local machine.

Ah, I was running this in my --enable-debug --enable-tcg-debug
out-of-tree directory, it takes >2min here.

>> +        """
>> +        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
>> +                    '7020-40p/P12H0456.IMG')
>> +        bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>> +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_ha=
sh)
>> +        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-arch=
ive/'
>> +                     'NetBSD-4.0/prep/installation/floppy/generic_com=
0.fs')
>> +        drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
>> +        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive=
_hash)
>> +
>> +        self.vm.set_machine('40p')
>=20
> FIY, Avocado 72.0 (due Tomorrow) will have relaxed strictness for tags
> values.  That will allow us to represent all current machine type
> names in ":avocado: tags=3Dmachine:$VALUE" (such as "s390-ccw-virtio").
> Then we'll be able to reuse them here, avoiding a bit of boiler plate
> code.

Good news!

>> +        self.vm.set_console()
>> +        self.vm.add_args('-bios', bios_path,
>> +                         '-fda', drive_path)
>> +        self.vm.launch()
>> +        os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 P=
ST 2007'
>> +        self.wait_for_console_pattern(os_banner)
>> +        self.wait_for_console_pattern('Model: IBM PPS Model 6015')
>> --=20
>> 2.20.1
>>
>=20
> Overall it looks good and works for me.  Let me know what you think of
> the wait_for_console_pattern() refactor suggestions.

Thanks, I agree we can do it later :)

Regards,

Phil.

