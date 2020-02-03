Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A766C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566D92086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdulbbON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566D92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycNb-0000v2-IL
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iycMo-00082T-Pi
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iycMm-0003Q6-36
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:06:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iycMl-0003MO-TN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580738778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBWUqVjVBu0s5c3cxxDUBRgI2KUhjLKiEkVMNBMsQso=;
 b=FdulbbONaqgEgwIGAiQ4lKhBQya9Iv9Jwv8tMxx7XoF5067A5AmDx7TZ/y9+O/pC07SSfN
 tZbVncAHRLiIuANRVgYt0NTnDNPcOMqwuEmUvq7MqX+BMRIlljRoIC3TEHGLbmvp5wWvY7
 96RpDQUqMu0WR/vVhyKnxSTF11bnWP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-kpf0-1swMdSupsV909b-BA-1; Mon, 03 Feb 2020 09:06:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C7E7CF9BF;
 Mon,  3 Feb 2020 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-90.gru2.redhat.com
 [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 701EA84BCD;
 Mon,  3 Feb 2020 14:05:51 +0000 (UTC)
Subject: Re: [PATCH 2/2] tests/acceptance/integratorcp: Verify Tux is
 displayed on framebuffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200131211102.29612-1-f4bug@amsat.org>
 <20200131211102.29612-3-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <62387425-5fc2-8607-3b78-6878b7611651@redhat.com>
Date: Mon, 3 Feb 2020 12:05:49 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200131211102.29612-3-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kpf0-1swMdSupsV909b-BA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/31/20 7:11 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a test that verifies the Tux logo is displayed on the framebuffer.
>
> We simply follow the OpenCV "Template Matching with Multiple Objects"
> tutorial, replacing Lionel Messi by Tux:

So Tux > Messi??!! I knew that!

> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>
> When OpenCV and NumPy are installed, this test can be run using:
>
>    $ AVOCADO_ALLOW_UNTRUSTED_CODE=3Dhmmm \
>      avocado --show=3Dapp,framebuffer run -t device:framebuffer \
>        tests/acceptance/machine_arm_integratorcp.py
>    JOB ID     : 8c46b0f8269242e87d738247883ea2a470df949e
>    JOB LOG    : avocado/job-results/job-2020-01-31T21.38-8c46b0f/job.log
>     (1/1) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.=
test_framebuffer_tux_logo:
>    framebuffer: found Tux at position [x, y] =3D (0, 0)
>    PASS (3.96 s)
>    RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>    JOB TIME   : 4.23 s
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> The resulting match is https://pasteboard.co/ISz7kr8.png
>
> For matching SMP machines, these suggestion might work:
> https://stackoverflow.com/questions/50579050/template-matching-with-multi=
ple-objects-in-opencv-python
> ---
>   tests/acceptance/machine_arm_integratorcp.py | 51 ++++++++++++++++++++
>   1 file changed, 51 insertions(+)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/accepta=
nce/machine_arm_integratorcp.py
> index 748819916d..a706fe1b44 100644
> --- a/tests/acceptance/machine_arm_integratorcp.py
> +++ b/tests/acceptance/machine_arm_integratorcp.py
> @@ -9,11 +9,26 @@
>   # later.  See the COPYING file in the top-level directory.
>  =20
>   import os
> +import logging
>  =20
>   from avocado import skipUnless
>   from avocado_qemu import Test
>   from avocado_qemu import wait_for_console_pattern
>  =20
> +
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
>   class IntegratorMachine(Test):
>       """Boots the Linux kernel and checks that the console is operationa=
l"""
>  =20
> @@ -45,3 +60,39 @@ class IntegratorMachine(Test):
>           """
>           self.boot_integratorcp()
>           wait_for_console_pattern(self, 'Log in as root')
> +
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_framebuffer_tux_logo(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:integratorcp
> +        :avocado: tags=3Ddevice:pl110
> +        :avocado: tags=3Ddevice:framebuffer
> +        """
> +        screendump_path =3D os.path.join(self.workdir, "screendump.pbm")
> +        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.12/=
'
> +                       'drivers/video/logo/logo_linux_vga16.ppm')
> +        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> +        tuxlogo_path =3D self.fetch_asset(tuxlogo_url, asset_hash=3Dtuxl=
ogo_hash)
> +
> +        self.boot_integratorcp()
> +        framebuffer_ready =3D 'Console: switching to colour frame buffer=
 device'
> +        wait_for_console_pattern(self, framebuffer_ready)
> +        self.vm.command('human-monitor-command', command_line=3D'stop')
> +        self.vm.command('human-monitor-command',
> +                        command_line=3D'screendump %s' % screendump_path=
)
> +        logger =3D logging.getLogger('framebuffer')
> +
> +        cpu_count =3D 1
> +        match_threshold =3D 0.92
> +        screendump_bgr =3D cv2.imread(screendump_path)
> +        screendump_gray =3D cv2.cvtColor(screendump_bgr, cv2.COLOR_BGR2G=
RAY)
> +        result =3D cv2.matchTemplate(screendump_gray, cv2.imread(tuxlogo=
_path, 0),
> +                                   cv2.TM_CCOEFF_NORMED)
> +        loc =3D np.where(result >=3D match_threshold)
> +        tux_count =3D 0
> +        for tux_count, pt in enumerate(zip(*loc[::-1]), start=3D1):
> +            logger.debug('found Tux at position [x, y] =3D %s', pt)
> +        self.assertGreaterEqual(tux_count, cpu_count)


