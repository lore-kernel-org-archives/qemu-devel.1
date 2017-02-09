Received: from eggs.gnu.org ([2001:4830:134:3::10]:41918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbu1k-0003ZC-LG
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cbu1g-0001gv-Mm
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:05:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:54050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cbu1g-0001gl-Ho
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:05:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cbu1e-0000Uc-Mj
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 19:05:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 92ED72E805E
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 19:05:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Feb 2017 18:51:52 -0000
From: Thomas Huth <897193@bugs.launchpad.net>
Reply-To: Bug 897193 <897193@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111128122433.14324.27427.malonedeb@gac.canonical.com>
Message-Id: <20170209185152.6191.15040.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 897193] Re: virtfs: kernel compile fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/897193

Title:
  virtfs: kernel compile fails

Status in QEMU:
  Incomplete

Bug description:
  I am trying to compile a kernel under virtfs, and am getting an error.
  The error does not occur when compiling outside of the virtfs mount.

  Both guest and host are running the 3.0.4 kernel.
  QEMU is latest from git: bc75c9e50d308b2ec6623a40179c5cdc84b63dae

  QEMU command line:
  /usr/local/bin/qemu-system-x86_64 -nographic -boot c -m 1024 -machine typ=
e=3Dpc,accel=3Dkvm -drive file=3D/root/hdd1.img,if=3Dvirtio -drive file=3D/=
root/test1.img,if=3Dvirtio -drive file=3D/root/test2.img,if=3Dvirtio -virtf=
s local,path=3D/mnt/virtfs,security_model=3Dnone,mount_tag=3Dvirtfs -net ni=
c,model=3Dvirtio,macaddr=3DDE:AD:BE:EF:AA:BB -net tap,ifname=3Dqtap0,script=
=3Dno

  virtfs line in /etc/fstab:
  virtfs                  /mnt/virtfs             9p      defaults,noauto,t=
rans=3Dvirtio    0 0

  Steps to reproduce and output:

  [root@guest linux-3.0.4]# make mrproper
    CLEAN   scripts/basic
    CLEAN   scripts/kconfig
    CLEAN   include/config include/generated
    CLEAN   .config .config.old
  [root@guest linux-3.0.4]# make defconfig
    HOSTCC  scripts/basic/fixdep
    HOSTCC  scripts/kconfig/conf.o
    SHIPPED scripts/kconfig/zconf.tab.c
    SHIPPED scripts/kconfig/lex.zconf.c
    SHIPPED scripts/kconfig/zconf.hash.c
    HOSTCC  scripts/kconfig/zconf.tab.o
    HOSTLD  scripts/kconfig/conf
  *** Default configuration is based on 'x86_64_defconfig'
  #
  # configuration written to .config
  #
  [root@guest linux-3.0.4]# make
  scripts/kconfig/conf --silentoldconfig Kconfig

  *** Error during update of the configuration.

  make[2]: *** [silentoldconfig] Error 1
  make[1]: *** [silentoldconfig] Error 2
  make: *** No rule to make target `include/config/auto.conf', needed by `i=
nclude/config/kernel.release'.  Stop.

  =

  Please let me know if you need any other information.  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/897193/+subscriptions
