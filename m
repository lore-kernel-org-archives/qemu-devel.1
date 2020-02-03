Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA992C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC432082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YATQE5ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC432082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeHL-0003wq-Su
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iyeGg-0003LM-GE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iyeGe-0002QF-DI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:08:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iyeGe-0002Oq-8p
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580746087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRiVg9JWxyuSYYX1hq/kXf+nP/mO4Z4DN9flepn/J7k=;
 b=YATQE5jaLLZcvk6oqpJ1s2zwPquzeE82OE7nzBOB8mju6H/Bmz9MmJxQ9K3q84YyFuilRH
 zh1vVKUsZUn6CxZsbzAgBu6ydcJN8tQ2VxTxBj6tJpnMcOdeiHGTvQlCTyLkON5/Ui1dxt
 0zSDUHKgkTvCy4ulzNgUgZj3yTjQqZk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-mrLx_hKHPfu9XYrJf7bYWg-1; Mon, 03 Feb 2020 11:08:05 -0500
Received: by mail-wr1-f71.google.com with SMTP id u8so7492252wrp.10
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EcdA3xLgoEZ6hYGiSKiEGv8kVnkfLQhBGi5qQkd4q0Q=;
 b=hssEalqcht2+ct/NBiB51OZsTmKIFmvkO9jLxH5vYVQpDqUtg5i93DtUrMGpZWWk80
 v6rL5pB+6ZYSOr3rtXKWieDyqpNVxGglBvORT/gjq8EJNxfLLRDKUiGu+KUZyJAR8+jD
 EW2vWHBmHSVYvHxshSCO3xeesubL5IO+PBQz2GVcXYfw7ccdOL/ziiTraBC4fVUQ+Cje
 Vp2zMvkekI/lW/01xilvAJGL8BoEYeqMZiSpkj4/COBDrvkT0UbosoCMTb8Qqul8Nz/m
 CAzdlBzVhLHv66FLsMSBwHQuxjLUvaU+IYcvRngu7BwATX2B20yyDEzkaOo3vF5vfIo9
 ZFgg==
X-Gm-Message-State: APjAAAUItas0W0S8jM8vaLNhXbyKRt/48dtrWMzIMLz78sEEJBfJKYV5
 dhGxaA5LRLPb+z5S+oRuZEbel8CPNWlxu/Krav64SSkxSZSrXuN/xJ+UPLT5VrLNbeRnit0xF4G
 7NOPUvoECPdUr8X0=
X-Received: by 2002:adf:cd11:: with SMTP id w17mr16054841wrm.66.1580746083220; 
 Mon, 03 Feb 2020 08:08:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4wFZC5XDidYwuyJtHUKb8wPOjpjdZsbV9r5UUgF1bhtv1RnD5+h4ay3NJaxu+64rCNLUQRg==
X-Received: by 2002:adf:cd11:: with SMTP id w17mr16054816wrm.66.1580746082954; 
 Mon, 03 Feb 2020 08:08:02 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id y7sm23990771wrr.56.2020.02.03.08.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 08:08:02 -0800 (PST)
Subject: Re: [PATCH 1/1] tests/acceptance: Count Raspberry Pi logos displayed
 on framebuffer
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200131232436.23548-1-f4bug@amsat.org>
 <20200131232436.23548-2-f4bug@amsat.org>
 <ad5d50ff-acc8-247f-74d9-7854605baaca@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ba16ccb-108b-8721-2e04-b00630bcb7d5@redhat.com>
Date: Mon, 3 Feb 2020 17:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ad5d50ff-acc8-247f-74d9-7854605baaca@redhat.com>
Content-Language: en-US
X-MC-Unique: mrLx_hKHPfu9XYrJf7bYWg-1
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 3:21 PM, Wainer dos Santos Moschetta wrote:
> On 1/31/20 9:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add a test that verifies that each core properly displays the
>> Raspberry Pi logo on the framebuffer device.
>>
>> We simply follow the OpenCV "Template Matching with Multiple Objects"
>> tutorial, replacing Lionel Messi by a raspberrry:
>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>>
>> When OpenCV and NumPy are installed, this test can be run using:
>>
>> =C2=A0=C2=A0 $ avocado --show=3Dapp,framebuffer run -t device:bcm2835-fb=
=20
>> tests/acceptance/
>> =C2=A0=C2=A0 JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : 9bbbc54c0a6fa180348d0b5305=
507f76852b4da2
>> =C2=A0=C2=A0 JOB LOG=C2=A0=C2=A0=C2=A0 : avocado/job-results/job-2020-01=
-31T23.48-9bbbc54/job.log
>> =C2=A0=C2=A0=C2=A0 (1/1)=20
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_=
framebuffer_logo:=20
>>
>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (0, 0)
>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (71, 0)
>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (142, 0=
)
>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (213, 0=
)
>> =C2=A0=C2=A0 PASS (11.06 s)
>> =C2=A0=C2=A0 RESULTS=C2=A0=C2=A0=C2=A0 : PASS 1 | ERROR 0 | FAIL 0 | SKI=
P 0 | WARN 0 |=20
>> INTERRUPT 0 | CANCEL 0
>> =C2=A0=C2=A0 JOB TIME=C2=A0=C2=A0 : 11.39 s
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> The resulting match can be visualised at=20
>> https://pasteboard.co/ISzNHtx.png
>> ---
>> =C2=A0 tests/acceptance/boot_linux_console.py | 62 +++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 62 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py=20
>> b/tests/acceptance/boot_linux_console.py
>> index e40b84651b..4e69a83a12 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -12,6 +12,7 @@ import os
>> =C2=A0 import lzma
>> =C2=A0 import gzip
>> =C2=A0 import shutil
>> +import logging
>> =C2=A0 from avocado import skipUnless
>> =C2=A0 from avocado_qemu import Test
>> @@ -21,6 +22,19 @@ from avocado.utils import process
>> =C2=A0 from avocado.utils import archive
>> +NUMPY_AVAILABLE =3D True
>> +try:
>> +=C2=A0=C2=A0=C2=A0 import numpy as np
>> +except ImportError:
>> +=C2=A0=C2=A0=C2=A0 NUMPY_AVAILABLE =3D False
>> +
>> +CV2_AVAILABLE =3D True
>> +try:
>> +=C2=A0=C2=A0=C2=A0 import cv2
>> +except ImportError:
>> +=C2=A0=C2=A0=C2=A0 CV2_AVAILABLE =3D False
>> +
>> +
>=20
>=20
> Those Python packages are only needed by this new test case, and the=20
> test is likely to be moved to a separate file soon. So I suggest to put=
=20
> those availability checks inside the test method, so easing the future=20
> removal. And use self.cancel() to cancel the test (if the case).

Yes I'll move (actually the series is ready, I'll add this on top).

>=20
>=20
>> =C2=A0 class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Boots a Linux kernel and checks that the =
console is operational=20
>> and the
>> @@ -360,6 +374,54 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_arm_=
raspi2(0)
>> +=C2=A0=C2=A0=C2=A0 @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not insta=
lled')
>> +=C2=A0=C2=A0=C2=A0 @skipUnless(CV2_AVAILABLE, 'Python OpenCV not instal=
led')
>> +=C2=A0=C2=A0=C2=A0 def test_arm_raspi2_framebuffer_logo(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:ras=
pi2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Ddevice:bcm2=
835-fb
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 screendump_path =3D os.path.=
join(self.workdir, 'screendump.pbm')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_url =3D ('https://gi=
thub.com/raspberrypi/linux/raw/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'raspberryp=
i-kernel_1.20190517-1/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'drivers/vi=
deo/logo/logo_linux_clut224.ppm')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_hash =3D 'fff3cc20c6=
030acce0953147f9baac43f44ed6b0'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_path =3D self.fetch_=
asset(rpilogo_url,=20
>> asset_hash=3Drpilogo_hash)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_url =3D ('http://archive=
.raspberrypi.org/debian/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'pool/main/r/raspberrypi-firmware/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'raspberrypi-kernel_1.20190215-1_ar=
mhf.deb')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_hash =3D 'cd284220b32128=
c5084037553db3c482426f3972'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_path =3D self.fetch_asse=
t(deb_url, asset_hash=3Ddeb_hash)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.extract=
_from_deb(deb_path,=20
>> '/boot/kernel7.img')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtb_path =3D self.extract_fr=
om_deb(deb_path,=20
>> '/boot/bcm2709-rpi-2-b.dtb')
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_console()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_command_line =3D (sel=
f.KERNEL_COMMON_COMMAND_LINE +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'earlycon=3Dpl011,0x3f201000=20
>> console=3DttyAMA0')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-kernel', =
kernel_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-dtb', dtb_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-append', kernel_command_line)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 framebuffer_ready =3D 'Conso=
le: switching to colour frame=20
>> buffer device'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern(sel=
f, framebuffer_ready)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.command('human-monit=
or-command', command_line=3D'stop')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.command('human-monit=
or-command',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comma=
nd_line=3D'screendump %s' % screendump_path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger =3D logging.getLogger=
('framebuffer')
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_cores_count =3D 4
>=20
>=20
> Won't this fail if host cpu cores are less than 4?

This count the TCG vCPU guest emulated by QEMU, and are not related to=20
the host cores.

I.E. you can run this test on a single-core powerpc host cpu, QEMU will=20
instantiate 4 virtual cores for the raspberry pi.

Also, the Raspberry Pi 2/3 machines are forced to 4 cores, because they=20
only run a certain type of system-on-chip which has 4 cores built-in.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match_threshold =3D 0.95
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 screendump_bgr =3D cv2.imrea=
d(screendump_path, cv2.IMREAD_COLOR)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_bgr =3D cv2.imread(r=
pilogo_path, cv2.IMREAD_COLOR)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D cv2.matchTemplate=
(screendump_bgr, rpilogo_bgr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cv2.TM_CCOEFF_=
NORMED)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loc =3D np.where(result >=3D=
 match_threshold)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_count =3D 0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for rpilogo_count, pt in enu=
merate(zip(*loc[::-1]), start=3D1):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logg=
er.debug('found raspberry at position (x, y) =3D %s', pt)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertGreaterEqual(rpil=
ogo_count, cpu_cores_count)
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def test_arm_exynos4210_initrd(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3D=
arch:arm
>=20
>=20


