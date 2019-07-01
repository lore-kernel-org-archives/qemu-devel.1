Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6D2C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BCC205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="Ylt9Rua2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BCC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4Um-0001rn-Gy
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:09:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hpoussin@reactos.org>) id 1hi3Kg-00073l-3r
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1hi3Ka-0004II-FL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:55:22 -0400
Received: from iserv.reactos.org ([138.201.90.89]:39932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1hi3KS-0003oJ-S7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Tnrt49U2OEOkcU6Vy0Hb51r4M1HDNQBgzwu6GqfiujY=; b=Ylt9Rua2wZJe4OohmEvWwgV3W4
 DjZWqmozw4qbYmaIKL5C5U/wnqub4z6908xwtVhFxzUl35h33OC+gMX9lkwtMHy3gvbTGXSq4DEvA
 7sf4KxU02vZ/B7r3uWDVr3uX98hMurCKhtEDEODkjf3+JMDGRXO/b+qAAa2U7Hsb3Wqk=;
Received: from [2a01:e35:2e3e:3c40:3d64:a34f:19ef:bcc5]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1hi3GU-0005Ua-VP; Mon, 01 Jul 2019 20:51:07 +0000
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190627110201.1999-1-f4bug@amsat.org>
 <20190627110201.1999-2-f4bug@amsat.org>
 <86219d39-81e4-9796-f0ca-d1389b1608b0@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <19976364-ba51-67f8-e5ea-498b4cdefa8a@reactos.org>
Date: Mon, 1 Jul 2019 22:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <86219d39-81e4-9796-f0ca-d1389b1608b0@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 138.201.90.89
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/acceptance: Add test that runs
 NetBSD installer on PRep/40p
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
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kamil Rytarowski <kamil@netbsd.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/06/2019 à 14:00, Philippe Mathieu-Daudé a écrit :
> typo "PRep" -> "PReP" in patch subject
> 
> On 6/27/19 1:01 PM, Philippe Mathieu-Daudé wrote:
>> User case from:
>> http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   tests/acceptance/ppc_prep_40p.py | 63 ++++++++++++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 tests/acceptance/ppc_prep_40p.py
> 
> Hervé, in v2 I plan to rename it machine_ppc_prep_40p.py and add an
> entry in MAINTAINERS:

With the change you want to do:
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

> 
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> @@ -1051,6 +1051,7 @@ F: hw/timer/m48t59-isa.c
>   F: include/hw/isa/pc87312.h
>   F: include/hw/timer/m48t59.h
>   F: pc-bios/ppc_rom.bin
> +F: tests/acceptance/machine_ppc_prep_40p.py
> 
> ---
> 
>>
>> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
>> new file mode 100644
>> index 0000000000..53f2d2ecf0
>> --- /dev/null
>> +++ b/tests/acceptance/ppc_prep_40p.py
>> @@ -0,0 +1,63 @@
>> +# Functional test that boots a PReP/40p machine and checks its serial console.
>> +#
>> +# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
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
>> +    timeout = 60
>> +
>> +    # TODO refactor to MachineTest
>> +    def wait_for_console_pattern(self, success_message, failure_message=None):
>> +        """
>> +        Waits for messages to appear on the console, while logging the content
>> +
>> +        :param success_message: if this message appears, test succeeds
>> +        :param failure_message: if this message appears, test fails
>> +        """
>> +        console = self.vm.console_socket.makefile()
>> +        console_logger = logging.getLogger('console')
>> +        while True:
>> +            msg = console.readline().strip()
>> +            if not msg:
>> +                continue
>> +            console_logger.debug(msg)
>> +            if success_message in msg:
>> +                break
>> +            if failure_message and failure_message in msg:
>> +                fail = 'Failure message found in console: %s' % failure_message
>> +                self.fail(fail)
>> +
>> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
>> +    def test_factory_firmware_and_netbsd(self):
>> +        """
>> +        :avocado: tags=arch:ppc
>> +        :avocado: tags=machine:40p
>> +        :avocado: tags=slowness:high
>> +        """
>> +        bios_url = ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
>> +                    '7020-40p/P12H0456.IMG')
>> +        bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>> +        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
>> +        drive_url = ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
>> +                     'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
>> +        drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
>> +        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
>> +
>> +        self.vm.set_machine('40p')
>> +        self.vm.set_console()
>> +        self.vm.add_args('-bios', bios_path,
>> +                         '-fda', drive_path)
>> +        self.vm.launch()
>> +        os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
>> +        self.wait_for_console_pattern(os_banner)
>> +        self.wait_for_console_pattern('Model: IBM PPS Model 6015')
>>
> 


