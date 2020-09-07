Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874692075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czMdsQfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874692075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDeG-0008Ks-J3
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFDdI-0007DR-79
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:40:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFDdE-0005Dp-EO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599471611;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QExlLy8jSofv2tI/cGtlZTEeshpSz8fa87HJM8H60YU=;
 b=czMdsQfC2IxRswvCCarRj3M/GJJI2WfE9a16qk3VkxoxhxpNor+NGMZMsGqrtR7AlwC2bP
 Y9qmMUj38qH7JvKBgskHj6rBnp0wEGG6S5ifILIpdeXU72OkKotbD8bU6ga3nyLAt1AOZ0
 z4Y/yNA/zoOeUGh5DqFC5MyuMWeFkLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-bD3C1VklMpSTxihxOG50ug-1; Mon, 07 Sep 2020 05:39:45 -0400
X-MC-Unique: bD3C1VklMpSTxihxOG50ug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F01E1DDEC;
 Mon,  7 Sep 2020 09:39:42 +0000 (UTC)
Received: from redhat.com (ovpn-114-70.ams2.redhat.com [10.36.114.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3A3610013C4;
 Mon,  7 Sep 2020 09:39:32 +0000 (UTC)
Date: Mon, 7 Sep 2020 10:39:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/4] Acceptance tests: use an available kernel image
 package for arm
Message-ID: <20200907093930.GD810755@redhat.com>
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-2-crosa@redhat.com>
 <001385a1-92eb-d311-88b5-8e1e7f6f1f48@redhat.com>
MIME-Version: 1.0
In-Reply-To: <001385a1-92eb-d311-88b5-8e1e7f6f1f48@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 07, 2020 at 10:06:13AM +0200, Philippe Mathieu-Daudé wrote:
> [Cc'ing Daniel who usually have good ideas for that
> kind if project-wide problem]
> 
> On 9/7/20 6:19 AM, Cleber Rosa wrote:
> > Which means a newer kernel version.  Expected output was changed
> > to match the new kernel too.
> 
> Nack.
> 
> Acceptance tests are not to test the latest Linux kernel,
> they aim to assert a specific kernel tested by some developer
> still works while QEMU evolves.
> QEMU doesn't have to adapt to the latest kernel;
> QEMU should keep boot an old kernel.
> 
> Testing new kernels is good, you are adding coverage. But
> this break the acceptance testing contract "keep testing
> the same thing over time".
> 
> The problem you are trying to fix is the "where to keep
> assets from public locations where they are being removed?"
> one. Two years ago [*] you suggested to use some storage on
> the avocado-project.org:
> 
>   For Avocado-VT, there are the JeOS images[1], which we
>   keep on a test "assets" directory.  We have a lot of
>   storage/bandwidth availability, so it can be used for
>   other assets proven to be necessary for tests.
> 
>   As long as distribution rights and licensing are not
>   issues, we can definitely use the same server for kernels,
>   u-boot images and what not.
> 
>   [1] - https://avocado-project.org/data/assets/

If I look at stuff under that directory I see a bunch of "Jeos" qcow2
images, and zero information about the corresponding source for the
images, nor any information about the licenses of software included.
IOW what is stored their right now does not appear to comply with the
GPL licensing requirements for providing full and corresponding source.

> It is time to have QEMU assets managed the same way.

I'd rather we didn't do anything relying on binary blobs with no
info about how they were built. Pointing to the 3rd party download
URLs was the easy way to ensure we don't have to worry about licensing
problems.

IIUC, the majority of our acceptance tests needs should be satisfied
with a combination of a Linux kernel and busybox tools. We already
use cross-compilers to build TCG test cases.

I'd like to see us provide a minimal "config" file for each Linux
kernel combo we need to test. We should be able to define a fairly
simple script that do the Linux build, busybox build and then puts
the combination of them into a disk image.  Something 100% automated
and reviewable.

Even a minimal linux build takes some time, so we would need to cache
the binary result in some suitable manner. At least this way we have
a clear record of what we're building & how and can thus satisfy the
license rules.

> 
> [*] https://www.mail-archive.com/avocado-devel@redhat.com/msg00860.html
> 
> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/acceptance/boot_linux_console.py | 44 +++++++++++++-------------
> >  tests/acceptance/replay_kernel.py      |  8 ++---
> >  2 files changed, 26 insertions(+), 26 deletions(-)
> > 
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> > index aaa781a581..751b47b8fd 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -490,12 +490,12 @@ class BootLinuxConsole(LinuxKernelTest):
> >          :avocado: tags=arch:arm
> >          :avocado: tags=machine:cubieboard
> >          """
> > -        deb_url = ('https://apt.armbian.com/pool/main/l/'
> > -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> > -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
> > +                   'linux-image-dev-sunxi_20.08_armhf.deb')
> > +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> >          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> >          kernel_path = self.extract_from_deb(deb_path,
> > -                                            '/boot/vmlinuz-4.20.7-sunxi')
> > +                                            '/boot/vmlinuz-5.8.0-sunxi')
> >          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
> >          dtb_path = self.extract_from_deb(deb_path, dtb_path)
> >          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> > @@ -522,7 +522,7 @@ class BootLinuxConsole(LinuxKernelTest):
> >          exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> >                                                  'Allwinner sun4i/sun5i')
> >          exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
> > -                                                'system-control@1c00000')
> > +                                                '1c00000.system-control')
> >          # cubieboard's reboot is not functioning; omit reboot test.
> >  
> >      def test_arm_cubieboard_sata(self):
> > @@ -530,12 +530,12 @@ class BootLinuxConsole(LinuxKernelTest):
> >          :avocado: tags=arch:arm
> >          :avocado: tags=machine:cubieboard
> >          """
> > -        deb_url = ('https://apt.armbian.com/pool/main/l/'
> > -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> > -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
> > +                   'linux-image-dev-sunxi_20.08_armhf.deb')
> > +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> >          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> >          kernel_path = self.extract_from_deb(deb_path,
> > -                                            '/boot/vmlinuz-4.20.7-sunxi')
> > +                                            '/boot/vmlinuz-5.8.0-sunxi')
> >          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
> >          dtb_path = self.extract_from_deb(deb_path, dtb_path)
> >          rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
> > @@ -573,12 +573,12 @@ class BootLinuxConsole(LinuxKernelTest):
> >          :avocado: tags=arch:arm
> >          :avocado: tags=machine:orangepi-pc
> >          """
> > -        deb_url = ('https://apt.armbian.com/pool/main/l/'
> > -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> > -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
> > +                   'linux-image-dev-sunxi_20.08_armhf.deb')
> > +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> >          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> >          kernel_path = self.extract_from_deb(deb_path,
> > -                                            '/boot/vmlinuz-4.20.7-sunxi')
> > +                                            '/boot/vmlinuz-5.8.0-sunxi')
> >          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> >          dtb_path = self.extract_from_deb(deb_path, dtb_path)
> >  
> > @@ -598,12 +598,12 @@ class BootLinuxConsole(LinuxKernelTest):
> >          :avocado: tags=arch:arm
> >          :avocado: tags=machine:orangepi-pc
> >          """
> > -        deb_url = ('https://apt.armbian.com/pool/main/l/'
> > -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> > -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
> > +                   'linux-image-dev-sunxi_20.08_armhf.deb')
> > +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> >          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> >          kernel_path = self.extract_from_deb(deb_path,
> > -                                            '/boot/vmlinuz-4.20.7-sunxi')
> > +                                            '/boot/vmlinuz-5.8.0-sunxi')
> >          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> >          dtb_path = self.extract_from_deb(deb_path, dtb_path)
> >          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> > @@ -629,7 +629,7 @@ class BootLinuxConsole(LinuxKernelTest):
> >          exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> >                                                  'Allwinner sun8i Family')
> >          exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
> > -                                                'system-control@1c00000')
> > +                                                '1c00000.system-control')
> >          exec_command_and_wait_for_pattern(self, 'reboot',
> >                                                  'reboot: Restarting system')
> >          # Wait for VM to shut down gracefully
> > @@ -641,12 +641,12 @@ class BootLinuxConsole(LinuxKernelTest):
> >          :avocado: tags=machine:orangepi-pc
> >          :avocado: tags=device:sd
> >          """
> > -        deb_url = ('https://apt.armbian.com/pool/main/l/'
> > -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> > -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
> > +                   'linux-image-dev-sunxi_20.08_armhf.deb')
> > +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> >          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> >          kernel_path = self.extract_from_deb(deb_path,
> > -                                            '/boot/vmlinuz-4.20.7-sunxi')
> > +                                            '/boot/vmlinuz-5.8.0-sunxi')
> >          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> >          dtb_path = self.extract_from_deb(deb_path, dtb_path)
> >          rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
> > diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> > index b79fc8daf8..80a460814f 100644
> > --- a/tests/acceptance/replay_kernel.py
> > +++ b/tests/acceptance/replay_kernel.py
> > @@ -132,12 +132,12 @@ class ReplayKernel(LinuxKernelTest):
> >          :avocado: tags=arch:arm
> >          :avocado: tags=machine:cubieboard
> >          """
> > -        deb_url = ('https://apt.armbian.com/pool/main/l/'
> > -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
> > -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
> > +                   'linux-image-dev-sunxi_20.08_armhf.deb')
> > +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> >          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> >          kernel_path = self.extract_from_deb(deb_path,
> > -                                            '/boot/vmlinuz-4.20.7-sunxi')
> > +                                            '/boot/vmlinuz-5.8.0-sunxi')
> >          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
> >          dtb_path = self.extract_from_deb(deb_path, dtb_path)
> >          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> > 
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


