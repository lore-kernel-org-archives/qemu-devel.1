Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B4C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10262087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiXAsrtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10262087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1YU-00039V-Np
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iz1Wn-0001OO-Pp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iz1Wl-0004jU-MP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:58:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iz1Wl-0004fL-Hz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580835498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+axfceX9bi1nAXKWfz9IDxOFv9GNGHrIZ1H/QGbx70=;
 b=fiXAsrtI8m7b2isB9j8b6ovKyLIYq2LXx5bzo6BhvBir/DrK35/NNHGJW91gxbmRH4jtbq
 Ees3Re/dIeNixqIAqbAvi3gHPiBcq/ZyZJrgG71kEswVoF/nU3cwhYYIyMjahrDhmcaecu
 lhEyNkXcq7R0McHwUjz1xnUcBl/rUz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-BNiTv2JFPmGy8ArtGNTEIw-1; Tue, 04 Feb 2020 11:58:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4345801A2A;
 Tue,  4 Feb 2020 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 726F91001B08;
 Tue,  4 Feb 2020 16:58:00 +0000 (UTC)
Subject: Re: [PATCH 1/1] tests/acceptance: Count Raspberry Pi logos displayed
 on framebuffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200131232436.23548-1-f4bug@amsat.org>
 <20200131232436.23548-2-f4bug@amsat.org>
 <ad5d50ff-acc8-247f-74d9-7854605baaca@redhat.com>
 <3ba16ccb-108b-8721-2e04-b00630bcb7d5@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <da60e227-390f-9d40-3be2-3c0d55b89e64@redhat.com>
Date: Tue, 4 Feb 2020 14:57:57 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3ba16ccb-108b-8721-2e04-b00630bcb7d5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BNiTv2JFPmGy8ArtGNTEIw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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


On 2/3/20 2:08 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/3/20 3:21 PM, Wainer dos Santos Moschetta wrote:
>> On 1/31/20 9:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Add a test that verifies that each core properly displays the
>>> Raspberry Pi logo on the framebuffer device.
>>>
>>> We simply follow the OpenCV "Template Matching with Multiple Objects"
>>> tutorial, replacing Lionel Messi by a raspberrry:
>>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>>>
>>> When OpenCV and NumPy are installed, this test can be run using:
>>>
>>> =C2=A0=C2=A0 $ avocado --show=3Dapp,framebuffer run -t device:bcm2835-f=
b=20
>>> tests/acceptance/
>>> =C2=A0=C2=A0 JOB ID=C2=A0=C2=A0=C2=A0=C2=A0 : 9bbbc54c0a6fa180348d0b530=
5507f76852b4da2
>>> =C2=A0=C2=A0 JOB LOG=C2=A0=C2=A0=C2=A0 :=20
>>> avocado/job-results/job-2020-01-31T23.48-9bbbc54/job.log
>>> =C2=A0=C2=A0=C2=A0 (1/1)=20
>>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2=
_framebuffer_logo:=20
>>>
>>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (0, 0)
>>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (71, 0=
)
>>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (142, =
0)
>>> =C2=A0=C2=A0 framebuffer: found raspberry at position (x, y) =3D (213, =
0)
>>> =C2=A0=C2=A0 PASS (11.06 s)
>>> =C2=A0=C2=A0 RESULTS=C2=A0=C2=A0=C2=A0 : PASS 1 | ERROR 0 | FAIL 0 | SK=
IP 0 | WARN 0 |=20
>>> INTERRUPT 0 | CANCEL 0
>>> =C2=A0=C2=A0 JOB TIME=C2=A0=C2=A0 : 11.39 s
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> The resulting match can be visualised at=20
>>> https://pasteboard.co/ISzNHtx.png
>>> ---
>>> =C2=A0 tests/acceptance/boot_linux_console.py | 62=20
>>> ++++++++++++++++++++++++++
>>> =C2=A0 1 file changed, 62 insertions(+)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>> b/tests/acceptance/boot_linux_console.py
>>> index e40b84651b..4e69a83a12 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -12,6 +12,7 @@ import os
>>> =C2=A0 import lzma
>>> =C2=A0 import gzip
>>> =C2=A0 import shutil
>>> +import logging
>>> =C2=A0 from avocado import skipUnless
>>> =C2=A0 from avocado_qemu import Test
>>> @@ -21,6 +22,19 @@ from avocado.utils import process
>>> =C2=A0 from avocado.utils import archive
>>> +NUMPY_AVAILABLE =3D True
>>> +try:
>>> +=C2=A0=C2=A0=C2=A0 import numpy as np
>>> +except ImportError:
>>> +=C2=A0=C2=A0=C2=A0 NUMPY_AVAILABLE =3D False
>>> +
>>> +CV2_AVAILABLE =3D True
>>> +try:
>>> +=C2=A0=C2=A0=C2=A0 import cv2
>>> +except ImportError:
>>> +=C2=A0=C2=A0=C2=A0 CV2_AVAILABLE =3D False
>>> +
>>> +
>>
>>
>> Those Python packages are only needed by this new test case, and the=20
>> test is likely to be moved to a separate file soon. So I suggest to=20
>> put those availability checks inside the test method, so easing the=20
>> future removal. And use self.cancel() to cancel the test (if the case).
>
> Yes I'll move (actually the series is ready, I'll add this on top).
>
>>
>>
>>> =C2=A0 class BootLinuxConsole(Test):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Boots a Linux kernel and checks that the=
 console is=20
>>> operational and the
>>> @@ -360,6 +374,54 @@ class BootLinuxConsole(Test):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_arm=
_raspi2(0)
>>> +=C2=A0=C2=A0=C2=A0 @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not inst=
alled')
>>> +=C2=A0=C2=A0=C2=A0 @skipUnless(CV2_AVAILABLE, 'Python OpenCV not insta=
lled')
>>> +=C2=A0=C2=A0=C2=A0 def test_arm_raspi2_framebuffer_logo(self):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:arm
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:ra=
spi2
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Ddevice:bcm=
2835-fb
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 screendump_path =3D os.path=
.join(self.workdir, 'screendump.pbm')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_url =3D ('https://g=
ithub.com/raspberrypi/linux/raw/'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'raspberryp=
i-kernel_1.20190517-1/'
>>> + 'drivers/video/logo/logo_linux_clut224.ppm')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_hash =3D 'fff3cc20c=
6030acce0953147f9baac43f44ed6b0'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_path =3D self.fetch=
_asset(rpilogo_url,=20
>>> asset_hash=3Drpilogo_hash)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_url =3D ('http://archiv=
e.raspberrypi.org/debian/'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'pool/main/r/raspberrypi-firmware/'
>>> + 'raspberrypi-kernel_1.20190215-1_armhf.deb')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_hash =3D 'cd284220b3212=
8c5084037553db3c482426f3972'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_path =3D self.fetch_ass=
et(deb_url, asset_hash=3Ddeb_hash)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.extrac=
t_from_deb(deb_path,=20
>>> '/boot/kernel7.img')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtb_path =3D self.extract_f=
rom_deb(deb_path,=20
>>> '/boot/bcm2709-rpi-2-b.dtb')
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_console()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_command_line =3D (se=
lf.KERNEL_COMMON_COMMAND_LINE +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'earlycon=3Dpl011,0x3f201000=20
>>> console=3DttyAMA0')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-kernel',=
 kernel_path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-dtb', dtb_path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-append', kernel_command_line)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 framebuffer_ready =3D 'Cons=
ole: switching to colour frame=20
>>> buffer device'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern(se=
lf, framebuffer_ready)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.command('human-moni=
tor-command', command_line=3D'stop')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.command('human-moni=
tor-command',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comma=
nd_line=3D'screendump %s' %=20
>>> screendump_path)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger =3D logging.getLogge=
r('framebuffer')
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_cores_count =3D 4
>>
>>
>> Won't this fail if host cpu cores are less than 4?
>
> This count the TCG vCPU guest emulated by QEMU, and are not related to=20
> the host cores.
>
> I.E. you can run this test on a single-core powerpc host cpu, QEMU=20
> will instantiate 4 virtual cores for the raspberry pi.
>
> Also, the Raspberry Pi 2/3 machines are forced to 4 cores, because=20
> they only run a certain type of system-on-chip which has 4 cores=20
> built-in.


ah, ok, I learned something new today. Thanks!

- Wainer

>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match_threshold =3D 0.95
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 screendump_bgr =3D cv2.imre=
ad(screendump_path, cv2.IMREAD_COLOR)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_bgr =3D cv2.imread(=
rpilogo_path, cv2.IMREAD_COLOR)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D cv2.matchTemplat=
e(screendump_bgr, rpilogo_bgr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cv2.TM_CCOEFF_=
NORMED)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loc =3D np.where(result >=
=3D match_threshold)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rpilogo_count =3D 0
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for rpilogo_count, pt in en=
umerate(zip(*loc[::-1]), start=3D1):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log=
ger.debug('found raspberry at position (x, y) =3D %s',=20
>>> pt)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertGreaterEqual(rpi=
logo_count, cpu_cores_count)
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def test_arm_exynos4210_initrd(self):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=
=3Darch:arm
>>
>>
>


