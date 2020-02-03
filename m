Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FECC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FB02082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7gmOndF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FB02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycd3-0008P6-03
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyccB-0007qd-5O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iycc9-0004fy-0X
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:22:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iycc8-0004fm-Sy
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580739732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8WOFrDlZIxe+YQ59pDQE+y1UgwqDQiC+KRZ1xvkUYUY=;
 b=i7gmOndFk/5X3DxrGQtAKBugyv1pvF6pZN1TtlIYy5cvqQyUSosmc9Z0zBDEw2pq3u8I0C
 jbo7EjCNXqolWGpKvSlhITR0pGoG0VE0lqdCzy3v6wureqEfRdXpWm+zV2V/0L8ECq3i9b
 vqIjwhpq95Mim8n7lsU9Gy1RbF7MUfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-SQulLM6PNiacNDhtsKEA8w-1; Mon, 03 Feb 2020 09:22:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87D4D108C253;
 Mon,  3 Feb 2020 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-90.gru2.redhat.com
 [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B0BF2101;
 Mon,  3 Feb 2020 14:21:54 +0000 (UTC)
Subject: Re: [PATCH 1/1] tests/acceptance: Count Raspberry Pi logos displayed
 on framebuffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200131232436.23548-1-f4bug@amsat.org>
 <20200131232436.23548-2-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <ad5d50ff-acc8-247f-74d9-7854605baaca@redhat.com>
Date: Mon, 3 Feb 2020 12:21:53 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200131232436.23548-2-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SQulLM6PNiacNDhtsKEA8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/31/20 9:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a test that verifies that each core properly displays the
> Raspberry Pi logo on the framebuffer device.
>
> We simply follow the OpenCV "Template Matching with Multiple Objects"
> tutorial, replacing Lionel Messi by a raspberrry:
> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>
> When OpenCV and NumPy are installed, this test can be run using:
>
>    $ avocado --show=3Dapp,framebuffer run -t device:bcm2835-fb tests/acce=
ptance/
>    JOB ID     : 9bbbc54c0a6fa180348d0b5305507f76852b4da2
>    JOB LOG    : avocado/job-results/job-2020-01-31T23.48-9bbbc54/job.log
>     (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ar=
m_raspi2_framebuffer_logo:
>    framebuffer: found raspberry at position (x, y) =3D (0, 0)
>    framebuffer: found raspberry at position (x, y) =3D (71, 0)
>    framebuffer: found raspberry at position (x, y) =3D (142, 0)
>    framebuffer: found raspberry at position (x, y) =3D (213, 0)
>    PASS (11.06 s)
>    RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>    JOB TIME   : 11.39 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> The resulting match can be visualised at https://pasteboard.co/ISzNHtx.pn=
g
> ---
>   tests/acceptance/boot_linux_console.py | 62 ++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index e40b84651b..4e69a83a12 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -12,6 +12,7 @@ import os
>   import lzma
>   import gzip
>   import shutil
> +import logging
>  =20
>   from avocado import skipUnless
>   from avocado_qemu import Test
> @@ -21,6 +22,19 @@ from avocado.utils import process
>   from avocado.utils import archive
>  =20
>  =20
> +NUMPY_AVAILABLE =3D True
> +try:
> +    import numpy as np
> +except ImportError:
> +    NUMPY_AVAILABLE =3D False
> +
> +CV2_AVAILABLE =3D True
> +try:
> +    import cv2
> +except ImportError:
> +    CV2_AVAILABLE =3D False
> +
> +


Those Python packages are only needed by this new test case, and the=20
test is likely to be moved to a separate file soon. So I suggest to put=20
those availability checks inside the test method, so easing the future=20
removal. And use self.cancel() to cancel the test (if the case).


>   class BootLinuxConsole(Test):
>       """
>       Boots a Linux kernel and checks that the console is operational and=
 the
> @@ -360,6 +374,54 @@ class BootLinuxConsole(Test):
>           """
>           self.do_test_arm_raspi2(0)
>  =20
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> +    def test_arm_raspi2_framebuffer_logo(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Ddevice:bcm2835-fb
> +        """
> +        screendump_path =3D os.path.join(self.workdir, 'screendump.pbm')
> +        rpilogo_url =3D ('https://github.com/raspberrypi/linux/raw/'
> +                       'raspberrypi-kernel_1.20190517-1/'
> +                       'drivers/video/logo/logo_linux_clut224.ppm')
> +        rpilogo_hash =3D 'fff3cc20c6030acce0953147f9baac43f44ed6b0'
> +        rpilogo_path =3D self.fetch_asset(rpilogo_url, asset_hash=3Drpil=
ogo_hash)
> +        deb_url =3D ('http://archive.raspberrypi.org/debian/'
> +                   'pool/main/r/raspberrypi-firmware/'
> +                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
> +        deb_hash =3D 'cd284220b32128c5084037553db3c482426f3972'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path, '/boot/kernel7.i=
mg')
> +        dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-=
2-b.dtb')
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'earlycon=3Dpl011,0x3f201000 console=3Dtt=
yAMA0')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        framebuffer_ready =3D 'Console: switching to colour frame buffer=
 device'
> +        wait_for_console_pattern(self, framebuffer_ready)
> +        self.vm.command('human-monitor-command', command_line=3D'stop')
> +        self.vm.command('human-monitor-command',
> +                        command_line=3D'screendump %s' % screendump_path=
)
> +        logger =3D logging.getLogger('framebuffer')
> +
> +        cpu_cores_count =3D 4


Won't this fail if host cpu cores are less than 4?


Thanks!

- Wainer

> +        match_threshold =3D 0.95
> +        screendump_bgr =3D cv2.imread(screendump_path, cv2.IMREAD_COLOR)
> +        rpilogo_bgr =3D cv2.imread(rpilogo_path, cv2.IMREAD_COLOR)
> +        result =3D cv2.matchTemplate(screendump_bgr, rpilogo_bgr,
> +                                   cv2.TM_CCOEFF_NORMED)
> +        loc =3D np.where(result >=3D match_threshold)
> +        rpilogo_count =3D 0
> +        for rpilogo_count, pt in enumerate(zip(*loc[::-1]), start=3D1):
> +            logger.debug('found raspberry at position (x, y) =3D %s', pt=
)
> +        self.assertGreaterEqual(rpilogo_count, cpu_cores_count)
> +
>       def test_arm_exynos4210_initrd(self):
>           """
>           :avocado: tags=3Darch:arm


