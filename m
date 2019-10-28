Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B7CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144B520830
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuQqH2QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144B520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPBxl-0007IJ-3R
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 16:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPBvV-0004Su-Cr
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPBvS-0003If-Hk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:47:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPBvS-0003IP-Dz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572295661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AsJxILrDeD6+4CAfvbNa2DO8amy+t8Dh73G8/+RSh0=;
 b=JuQqH2QDtq99yR8vhk9RHj5eHzT4tuxflDP9qySKlaIyB4hU+dPiGb99ibVyLI3JSZGeER
 70ntwIQ6D5pUfmpNSCZ3ACWoaDKdEPLjnsenAZDjLf5xdhVBMf7q5GiaGXYjpNzkOIkfGn
 5LOtKig6MiHSgBx9nEEw//5xSJzw20I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-vCEDlXiyOzitlvYtHs5e7Q-1; Mon, 28 Oct 2019 16:47:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09E71005509;
 Mon, 28 Oct 2019 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0CD46085E;
 Mon, 28 Oct 2019 20:47:27 +0000 (UTC)
Date: Mon, 28 Oct 2019 16:47:25 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 22/26] tests/boot_linux_console: Boot Linux and run few
 commands on raspi3
Message-ID: <20191028204725.GC18794@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-23-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-23-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vCEDlXiyOzitlvYtHs5e7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:37AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Add a test which boots Linux and run basic commands using the serial
> port console.
>=20
> The kernel image is built by the Debian project:
> https://wiki.debian.org/RaspberryPi
>=20
> The DeviceTree blob comes from the official Raspberry Pi project:
> https://www.raspberrypi.org/
>=20
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>=20
> This test can be run using:
>=20
>   $ avocado run --show=3Dconsole,app run -t machine:raspi3 tests/acceptan=
ce
>   console: [    0.000000] Linux version 4.14.0-3-arm64 (debian-kernel@lis=
ts.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18)) #1 SMP Debian 4.14.12-=
2 (2018-01-06)
>   console: [    0.000000] Boot CPU: AArch64 Processor [410fd034]
>   console: [    0.000000] Machine model: Raspberry Pi 3 Model B
>   console: [    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (opti=
ons '')
>   console: [    0.000000] bootconsole [pl11] enabled
>   [...]
>   console: Starting network: OK
>   console: Found console ttyAMA0
>   console: Boot successful.
>   console: / # cat /proc/cpuinfo
>   console: processor      : 0
>   console: BogoMIPS       : 125.00
>   console: r      : 0x41
>   console: CPU architecture: 8
>   console: CPU variant
>   console: : 0x0
>   console: CPU part       : 0xd03
>   console: CPU revision   : 4
>   console: / # uname -a
>   console: Linux buildroot 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-0=
1-06) aarch64 GNU/Linux
>   console: reboot
>   console: / # reboot
>   console: / # Found console ttyAMA0
>   console: Stopping network: OK
>   console: Saving random seed... done.
>   console: Stopping logging: OK
>   console: umount: devtmpfs busy - remounted read-only
>   console: umount: can't unmount /: Invalid argument
>   console: The system is going down NOW!
>   console: Sent SIGTERM to all processes
>   console: Sent SIGKILL to all processes
>   console: Requesting system reboot
>   console: kvm: exiting hardware virtualization
>   console: reboot: Restarting system
>   PASS (11.08 s)
>=20
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2: Use archive.gzip_uncompress (Cleber)
>=20
> some chars are scrambled on the console?
> Cleber ran this 100 times and doesn't have issue.
> ---

Now, I'm not getting good vibes from this test.  It spawns QEMU and
then gets stuck on every single execution.

VM launch command: 'aarch64-softmmu/qemu-system-aarch64 -chardev socket,id=
=3Dmon,path=3D/var/tmp/tmpgpee0g1h/qemu-23397-monitor.sock -mon chardev=3Dm=
on,mode=3Dcontrol -display none -vga none -machine raspi3 -chardev socket,i=
d=3Dconsole,path=3D/var/tmp/tmpgpee0g1h/qemu-23397-console.sock,server,nowa=
it -serial chardev:console -kernel /var/tmp/avocado_7ks9sppd/avocado_job_ws=
p2727i/1-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_r=
aspi3_initrd_uart0/boot/vmlinuz-4.14.0-3-arm64 -dtb /home/cleber/avocado/da=
ta/cache/by_location/cd5c65e442f2375a87c174b91963be739bcdae77/bcm2710-rpi-3=
-b.dtb -initrd /var/tmp/avocado_7ks9sppd/avocado_job_wsp2727i/1-tests_accep=
tance_boot_linux_console.py_BootLinuxConsole.test_arm_raspi3_initrd_uart0ro=
otfs.cpio -append printk.time=3D0 earlycon=3Dpl011,0x3f201000 console=3Dtty=
AMA0 panic=3D-1 noreboot -no-reboot'
>>> {'execute': 'qmp_capabilities'}
<<< {'return': {}}

Given that I've tested this before, and I see some changes to raspi3
since then, I'll try to bisect the possible culprit.  If you have any
clues, they would be much appreciated.

- Cleber.


