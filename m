Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7E7C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2ED21019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2ED21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7mLv-0001u9-74
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 16:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7mLF-0001VH-E7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7mLB-0003Gv-TQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:02:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7mLB-0003GY-Lv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:02:17 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DB8D859FE
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 20:02:15 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f10so291892wmh.8
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 13:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BviTQ3Qj/BsqP7pADTWVUBfn1nIItMLyxrE0GePPGLk=;
 b=NHE7yI1Day2LypXNJgKVf2KWZY3+Dx79AXmXISg90T6Ez4x62sao4fOxvoGqDtFCM4
 TgFSRFT2xu/6j5AHTNGJQWD3+6+Eh+CvRjT8qIspuDOembOT/KZQfDyAg77bVO5E6FOB
 knczeaK0PGCq0PeR8bZli3fZpvFZ/js0dIKdDFTgNsoLZTnrVSOiDwBsgR2YHovl/CCc
 JoB8tSW6C4Z/WncTr7F3zT42Ln0nrBGMmTDPI5jPK61l4t2kixDVcY7EWGHXr1DpTnUh
 P9zVgnnMMlC558C1Xj9Bx+d9bV8zQRobvzOjjViFkCadMKYhWzt5SIqKvWL8q6wt67Xj
 CuoQ==
X-Gm-Message-State: APjAAAXxmsJqluoHPvrzung+cWe11xUQn17U9fGWvM5u7qcNQGBuxaFY
 aGRrp+tCql2B7McaW6lZVeNqEkAiy+S5uZWDViTY1Z671jyRME/TYOJgTBo0JgDUz7Qoa9IDDMu
 PWiUP08IwjWaO9Mk=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr8894654wrs.315.1568145733495; 
 Tue, 10 Sep 2019 13:02:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQZadBnaVhV5LN+l//HnU3xv/Ay3fXwBe5THApkqDTlqTX7rCUndMLBC9lUdYF1Reuu17Oyg==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr8894639wrs.315.1568145733273; 
 Tue, 10 Sep 2019 13:02:13 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u22sm35907563wru.72.2019.09.10.13.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2019 13:02:12 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20190910163430.11326-1-f4bug@amsat.org>
 <20190910170745.GA26663@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f65c9b9f-97a7-8c6c-2a09-37a4de98d67c@redhat.com>
Date: Tue, 10 Sep 2019 22:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190910170745.GA26663@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] BootLinuxConsoleTest: Test the Quadra 800
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 7:07 PM, Cleber Rosa wrote:
> On Tue, Sep 10, 2019 at 06:34:30PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> This test boots a Linux kernel on a Quadra 800 board
>> and verify the serial is working.
>>
>> Example:
>>
>>   $ avocado --show=3Dapp,console run -t machine:q800 tests/acceptance/=
boot_linux_console.py
>>   console: ABCFGHIJK
>>   console: Linux version 5.2.0-2-m68k (debian-kernel@lists.debian.org)=
 (gcc version 8.3.0 (Debian 8.3.0-21)) #1 Debian 5.2.9-2 (2019-08-21)
>>   console: Detected Macintosh model: 35
>>   console: Apple Macintosh Quadra 800
>>   console: Built 1 zonelists, mobility grouping on.  Total pages: 3244=
8
>>   console: Kernel command line: printk.time=3D0 console=3DttyS0 vga=3D=
off
>>   [...]
>>   console: Calibrating delay loop... 1236.99 BogoMIPS (lpj=3D6184960)
>>   [...]
>>   console: NuBus: Scanning NuBus slots.
>>   console: Slot 9: Board resource not found!
>>   console: SCSI subsystem initialized
>>   console: clocksource: Switched to clocksource via1
>>   [...]
>>   console: macfb: framebuffer at 0xf9001000, mapped to 0x(ptrval), siz=
e 468k
>>   console: macfb: mode is 800x600x8, linelength=3D800
>>   console: Console: switching to colour frame buffer device 100x37
>>   console: fb0: DAFB frame buffer device
>>   console: pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashi=
ng.org>)
>>   console: scc.0: ttyS0 at MMIO 0x50f0c022 (irq =3D 4, base_baud =3D 2=
30400) is a Z85c30 ESCC - Serial port
>>   console: scc.1: ttyS1 at MMIO 0x50f0c020 (irq =3D 4, base_baud =3D 2=
30400) is a Z85c30 ESCC - Serial port
>>   console: Non-volatile memory driver v1.3
>>   console: adb: Mac II ADB Driver v1.0 for Unified ADB
>>   console: mousedev: PS/2 mouse device common for all mice
>>   console: random: fast init done
>>   console: Detected ADB keyboard, type <unknown>.
>>   console: input: ADB keyboard as /devices/virtual/input/input0
>>   console: input: ADB mouse as /devices/virtual/input/input1
>>   console: rtc-generic rtc-generic: registered as rtc0
>>   console: ledtrig-cpu: registered to indicate activity on CPUs
>>   [...]
>>   console: rtc-generic rtc-generic: setting system clock to 2019-09-10=
T16:20:25 UTC (1568132425)
>>   console: List of all partitions:
>>   console: No filesystem could mount root, tried:
>>   JOB TIME   : 2.91 s
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Based-on: <20190910113323.17324-1-laurent@vivier.eu>
>> "hw/m68k: add Apple Machintosh Quadra 800 machine"
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01775.html
>> ---
>>  tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py
>> index 2504ef0150..8e346bb0f4 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -373,3 +373,27 @@ class BootLinuxConsole(Test):
>>          self.vm.launch()
>>          console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
>>          self.wait_for_console_pattern(console_pattern)
>> +
>> +    def test_m68k_q800(self):
>> +        """
>> +        :avocado: tags=3Darch:m68k
>> +        :avocado: tags=3Dmachine:q800
>> +        """
>> +        deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m=
68k/main'
>> +                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68=
k.udeb')
>> +        deb_hash =3D '0797e05129595f22f3c0142db5e199769a723bf9'
>> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> +        kernel_path =3D self.extract_from_deb(deb_path,
>> +                                            '/boot/vmlinux-5.2.0-2-m6=
8k')
>> +
>> +        self.vm.set_machine('q800')
>> +        self.vm.set_console()
>> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>> +                               'console=3DttyS0 vga=3Doff')
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-append', kernel_command_line)
>> +        self.vm.launch()
>> +        console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
>> +        self.wait_for_console_pattern(console_pattern)
>> +        console_pattern =3D 'No filesystem could mount root'
>> +        self.wait_for_console_pattern(console_pattern)
>> --=20
>> 2.20.1
>>
>=20
> LGTM.
>=20
> Of course it needs to wait for the series adding the machine type.
> If there's a new version of the series, shouldn't this be included
> there?

At some point I'd like we enforce the rule "each new machine is added
with an integration test".
So far we are still trying to figure out what is the best use of Avocado
for QEMU, and what are good/cheap tests, how easy it is to add/use them,
and so on. We are improving :)
So, with this idea, indeed machine tests should go with the the series
that introduce it.
Meanwhile (there is no enforcement) I'm following new machines and
trying to catch them, ask the developer how to test them if there is no
guidelines, and add tests.

Laurent, do you agree to queue this patch to your series?

>  Either way:
>=20
> Tested-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>

Thanks!

Regards,

Phil.

