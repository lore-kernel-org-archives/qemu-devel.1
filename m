Received: from eggs.gnu.org ([2001:4830:134:3::10]:37709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeLHH-0007mh-ID
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eeLHE-0002GF-Aa
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:39:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:33228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eeLHD-0002Et-UH
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:39:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eeLHC-0007Jk-A8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 13:39:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3EB842E854F
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 13:39:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2018 13:25:24 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1269606 <1269606@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140115213002.25492.78294.malonedeb@wampee.canonical.com>
Message-Id: <151680032437.19781.4815642139618743275.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1269606] Re: curl driver (https) always says "No
 such file or directory"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I restored the original description.  Please report a new bug.

** Description changed:

+ =

  I have a remote server, on which an http disk image definitely exists.
- However the qemu curl block driver cannot open it.  It always gives the
+ However the qemu curl block driver cannot open it. It always gives the
  bogus error:
  =

  CURL: Error opening file: Connection time-out
  qemu-system-x86_64: -drive file=3Dhttp://onuma/scratch/cirros-0.3.1-x86_6=
4-disk.img,snapshot=3Don,cache=3Dwriteback,id=3Dhd0,if=3Dnone: could not op=
en disk image http://onuma/scratch/cirros-0.3.1-x86_64-disk.img: Could not =
open backing file: Could not open 'http://onuma/scratch/cirros-0.3.1-x86_64=
-disk.img': No such file or directory
  =

  On the server, I can see from the logs that qemu/curl is opening it:
  =

  192.168.0.175 - - [15/Jan/2014:21:25:37 +0000] "HEAD /scratch/cirros-0.3.=
1-x86_64-disk.img HTTP/1.1" 200 - "-" "-"
  192.168.0.175 - - [15/Jan/2014:21:25:37 +0000] "GET /scratch/cirros-0.3.1=
-x86_64-disk.img HTTP/1.1" 206 264192 "-" "-"
  =

  I am using qemu & curl from git today.
  =

  curl: curl-7_34_0-177-gc7a76bb
  qemu: for-anthony-839-g1cf892c
  =

  Here is the full command I am using:
  =

- 0622001a98105b80ecfad39dbf0b84c0ed71e12bb603a81a2b9b52e19ca7ae80E
+ http_proxy=3D \
+ LD_LIBRARY_PATH=3D/home/rjones/d/curl/lib/.libs \
+ LIBGUESTFS_BACKEND=3Ddirect \
+ LIBGUESTFS_HV=3D/home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
+ guestfish -v --ro -a http://onuma/scratch/cirros-0.3.1-x86_64-disk.img run
+ =

+ The full output (includes qemu command itself) is:
+ =

+ libguestfs: launch: program=3Dguestfish
+ libguestfs: launch: version=3D1.25.20fedora=3D21,release=3D1.fc21,libvirt
+ libguestfs: launch: backend registered: unix
+ libguestfs: launch: backend registered: uml
+ libguestfs: launch: backend registered: libvirt
+ libguestfs: launch: backend registered: direct
+ libguestfs: launch: backend=3Ddirect
+ libguestfs: launch: tmpdir=3D/tmp/libguestfsoQctgE
+ libguestfs: launch: umask=3D0002
+ libguestfs: launch: euid=3D1000
+ libguestfs: command: run: /usr/bin/supermin-helper
+ libguestfs: command: run: \ --verbose
+ libguestfs: command: run: \ -f checksum
+ libguestfs: command: run: \ --host-cpu x86_64
+ libguestfs: command: run: \ /usr/lib64/guestfs/supermin.d
+ supermin helper [00000ms] whitelist =3D (not specified)
+ supermin helper [00000ms] host_cpu =3D x86_64
+ supermin helper [00000ms] dtb_wildcard =3D (not specified)
+ supermin helper [00000ms] inputs:
+ supermin helper [00000ms] inputs[0] =3D /usr/lib64/guestfs/supermin.d
+ supermin helper [00000ms] outputs:
+ supermin helper [00000ms] kernel =3D (none)
+ supermin helper [00000ms] dtb =3D (none)
+ supermin helper [00000ms] initrd =3D (none)
+ supermin helper [00000ms] appliance =3D (none)
+ checking modpath /lib/modules/3.12.5-302.fc20.x86_64 is a directory
+ checking modpath /lib/modules/3.11.9-200.fc19.x86_64 is a directory
+ checking modpath /lib/modules/3.11.10-200.fc19.x86_64 is a directory
+ checking modpath /lib/modules/3.11.4-201.fc19.x86_64 is a directory
+ picked kernel vmlinuz-3.12.5-302.fc20.x86_64
+ supermin helper [00000ms] finished creating kernel
+ supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d
+ supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d/base.img=
.gz
+ supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d/daemon.i=
mg.gz
+ supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d/hostfiles
+ supermin helper [00041ms] visiting /usr/lib64/guestfs/supermin.d/init.img
+ supermin helper [00041ms] visiting /usr/lib64/guestfs/supermin.d/udev-rul=
es.img
+ supermin helper [00041ms] adding kernel modules
+ supermin helper [00064ms] finished creating appliance
+ libguestfs: checksum of existing appliance: 2017df18eaeee7c45b87139c9bd80=
be2216d655a1513322c47f58a7a3668cd1f
+ libguestfs: [00066ms] begin testing qemu features
+ libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-=
x86_64
+ libguestfs: command: run: \ -display none
+ libguestfs: command: run: \ -help
+ libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-=
x86_64
+ libguestfs: command: run: \ -display none
+ libguestfs: command: run: \ -version
+ libguestfs: qemu version 1.7
+ libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-=
x86_64
+ libguestfs: command: run: \ -display none
+ libguestfs: command: run: \ -machine accel=3Dkvm:tcg
+ libguestfs: command: run: \ -device ?
+ libguestfs: [00127ms] finished testing qemu features
+ [00128ms] /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
+     -global virtio-blk-pci.scsi=3Doff \
+     -nodefconfig \
+     -enable-fips \
+     -nodefaults \
+     -display none \
+     -machine accel=3Dkvm:tcg \
+     -cpu host,+kvmclock \
+     -m 500 \
+     -no-reboot \
+     -no-hpet \
+     -kernel /var/tmp/.guestfs-1000/kernel.19645 \
+     -initrd /var/tmp/.guestfs-1000/initrd.19645 \
+     -device virtio-scsi-pci,id=3Dscsi \
+     -drive file=3Dhttp://onuma/scratch/cirros-0.3.1-x86_64-disk.img,snaps=
hot=3Don,cache=3Dwriteback,id=3Dhd0,if=3Dnone \
+     -device scsi-hd,drive=3Dhd0 \
+     -drive file=3D/var/tmp/.guestfs-1000/root.19645,snapshot=3Don,id=3Dap=
pliance,cache=3Dunsafe,if=3Dnone \
+     -device scsi-hd,drive=3Dappliance \
+     -device virtio-serial-pci \
+     -serial stdio \
+     -device sga \
+     -chardev socket,path=3D/tmp/libguestfsoQctgE/guestfsd.sock,id=3Dchann=
el0 \
+     -device virtserialport,chardev=3Dchannel0,name=3Dorg.libguestfs.chann=
el.0 \
+     -append 'panic=3D1 console=3DttyS0 udevtimeout=3D600 no_timer_check a=
cpi=3Doff printk.time=3D1 cgroup_disable=3Dmemory root=3D/dev/sdb selinux=
=3D0 guestfs_verbose=3D1 TERM=3Dxterm-256color'
+ CURL: Error opening file: Connection time-out
+ qemu-system-x86_64: -drive file=3Dhttp://onuma/scratch/cirros-0.3.1-x86_6=
4-disk.img,snapshot=3Don,cache=3Dwriteback,id=3Dhd0,if=3Dnone: could not op=
en disk image http://onuma/scratch/cirros-0.3.1-x86_64-disk.img: Could not =
open image: Invalid argument
+ libguestfs: error: appliance closed the connection unexpectedly, see earl=
ier error messages
+ libguestfs: child_cleanup: 0x7f07bf6599b0: child process died
+ libguestfs: sending SIGTERM to process 19654
+ libguestfs: error: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 =
exited with error status 1, see debug messages above
+ libguestfs: error: guestfs_launch failed, see earlier error messages
+ libguestfs: closing guestfs handle 0x7f07bf6599b0 (state 0)
+ libguestfs: command: run: rm
+ libguestfs: command: run: \ -rf /tmp/libguestfsoQctgE

** Summary changed:

- curl driver (https) always says "No such file or directory"
+ curl driver (http) always says "No such file or directory"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1269606

Title:
  curl driver (http) always says "No such file or directory"

Status in QEMU:
  New

Bug description:

  I have a remote server, on which an http disk image definitely exists.
  However the qemu curl block driver cannot open it. It always gives the
  bogus error:

  CURL: Error opening file: Connection time-out
  qemu-system-x86_64: -drive file=3Dhttp://onuma/scratch/cirros-0.3.1-x86_6=
4-disk.img,snapshot=3Don,cache=3Dwriteback,id=3Dhd0,if=3Dnone: could not op=
en disk image http://onuma/scratch/cirros-0.3.1-x86_64-disk.img: Could not =
open backing file: Could not open 'http://onuma/scratch/cirros-0.3.1-x86_64=
-disk.img': No such file or directory

  On the server, I can see from the logs that qemu/curl is opening it:

  192.168.0.175 - - [15/Jan/2014:21:25:37 +0000] "HEAD /scratch/cirros-0.3.=
1-x86_64-disk.img HTTP/1.1" 200 - "-" "-"
  192.168.0.175 - - [15/Jan/2014:21:25:37 +0000] "GET /scratch/cirros-0.3.1=
-x86_64-disk.img HTTP/1.1" 206 264192 "-" "-"

  I am using qemu & curl from git today.

  curl: curl-7_34_0-177-gc7a76bb
  qemu: for-anthony-839-g1cf892c

  Here is the full command I am using:

  http_proxy=3D \
  LD_LIBRARY_PATH=3D/home/rjones/d/curl/lib/.libs \
  LIBGUESTFS_BACKEND=3Ddirect \
  LIBGUESTFS_HV=3D/home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
  guestfish -v --ro -a http://onuma/scratch/cirros-0.3.1-x86_64-disk.img run

  The full output (includes qemu command itself) is:

  libguestfs: launch: program=3Dguestfish
  libguestfs: launch: version=3D1.25.20fedora=3D21,release=3D1.fc21,libvirt
  libguestfs: launch: backend registered: unix
  libguestfs: launch: backend registered: uml
  libguestfs: launch: backend registered: libvirt
  libguestfs: launch: backend registered: direct
  libguestfs: launch: backend=3Ddirect
  libguestfs: launch: tmpdir=3D/tmp/libguestfsoQctgE
  libguestfs: launch: umask=3D0002
  libguestfs: launch: euid=3D1000
  libguestfs: command: run: /usr/bin/supermin-helper
  libguestfs: command: run: \ --verbose
  libguestfs: command: run: \ -f checksum
  libguestfs: command: run: \ --host-cpu x86_64
  libguestfs: command: run: \ /usr/lib64/guestfs/supermin.d
  supermin helper [00000ms] whitelist =3D (not specified)
  supermin helper [00000ms] host_cpu =3D x86_64
  supermin helper [00000ms] dtb_wildcard =3D (not specified)
  supermin helper [00000ms] inputs:
  supermin helper [00000ms] inputs[0] =3D /usr/lib64/guestfs/supermin.d
  supermin helper [00000ms] outputs:
  supermin helper [00000ms] kernel =3D (none)
  supermin helper [00000ms] dtb =3D (none)
  supermin helper [00000ms] initrd =3D (none)
  supermin helper [00000ms] appliance =3D (none)
  checking modpath /lib/modules/3.12.5-302.fc20.x86_64 is a directory
  checking modpath /lib/modules/3.11.9-200.fc19.x86_64 is a directory
  checking modpath /lib/modules/3.11.10-200.fc19.x86_64 is a directory
  checking modpath /lib/modules/3.11.4-201.fc19.x86_64 is a directory
  picked kernel vmlinuz-3.12.5-302.fc20.x86_64
  supermin helper [00000ms] finished creating kernel
  supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d
  supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d/base.img=
.gz
  supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d/daemon.i=
mg.gz
  supermin helper [00000ms] visiting /usr/lib64/guestfs/supermin.d/hostfiles
  supermin helper [00041ms] visiting /usr/lib64/guestfs/supermin.d/init.img
  supermin helper [00041ms] visiting /usr/lib64/guestfs/supermin.d/udev-rul=
es.img
  supermin helper [00041ms] adding kernel modules
  supermin helper [00064ms] finished creating appliance
  libguestfs: checksum of existing appliance: 2017df18eaeee7c45b87139c9bd80=
be2216d655a1513322c47f58a7a3668cd1f
  libguestfs: [00066ms] begin testing qemu features
  libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-=
x86_64
  libguestfs: command: run: \ -display none
  libguestfs: command: run: \ -help
  libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-=
x86_64
  libguestfs: command: run: \ -display none
  libguestfs: command: run: \ -version
  libguestfs: qemu version 1.7
  libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-=
x86_64
  libguestfs: command: run: \ -display none
  libguestfs: command: run: \ -machine accel=3Dkvm:tcg
  libguestfs: command: run: \ -device ?
  libguestfs: [00127ms] finished testing qemu features
  [00128ms] /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
      -global virtio-blk-pci.scsi=3Doff \
      -nodefconfig \
      -enable-fips \
      -nodefaults \
      -display none \
      -machine accel=3Dkvm:tcg \
      -cpu host,+kvmclock \
      -m 500 \
      -no-reboot \
      -no-hpet \
      -kernel /var/tmp/.guestfs-1000/kernel.19645 \
      -initrd /var/tmp/.guestfs-1000/initrd.19645 \
      -device virtio-scsi-pci,id=3Dscsi \
      -drive file=3Dhttp://onuma/scratch/cirros-0.3.1-x86_64-disk.img,snaps=
hot=3Don,cache=3Dwriteback,id=3Dhd0,if=3Dnone \
      -device scsi-hd,drive=3Dhd0 \
      -drive file=3D/var/tmp/.guestfs-1000/root.19645,snapshot=3Don,id=3Dap=
pliance,cache=3Dunsafe,if=3Dnone \
      -device scsi-hd,drive=3Dappliance \
      -device virtio-serial-pci \
      -serial stdio \
      -device sga \
      -chardev socket,path=3D/tmp/libguestfsoQctgE/guestfsd.sock,id=3Dchann=
el0 \
      -device virtserialport,chardev=3Dchannel0,name=3Dorg.libguestfs.chann=
el.0 \
      -append 'panic=3D1 console=3DttyS0 udevtimeout=3D600 no_timer_check a=
cpi=3Doff printk.time=3D1 cgroup_disable=3Dmemory root=3D/dev/sdb selinux=
=3D0 guestfs_verbose=3D1 TERM=3Dxterm-256color'
  CURL: Error opening file: Connection time-out
  qemu-system-x86_64: -drive file=3Dhttp://onuma/scratch/cirros-0.3.1-x86_6=
4-disk.img,snapshot=3Don,cache=3Dwriteback,id=3Dhd0,if=3Dnone: could not op=
en disk image http://onuma/scratch/cirros-0.3.1-x86_64-disk.img: Could not =
open image: Invalid argument
  libguestfs: error: appliance closed the connection unexpectedly, see earl=
ier error messages
  libguestfs: child_cleanup: 0x7f07bf6599b0: child process died
  libguestfs: sending SIGTERM to process 19654
  libguestfs: error: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 =
exited with error status 1, see debug messages above
  libguestfs: error: guestfs_launch failed, see earlier error messages
  libguestfs: closing guestfs handle 0x7f07bf6599b0 (state 0)
  libguestfs: command: run: rm
  libguestfs: command: run: \ -rf /tmp/libguestfsoQctgE

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1269606/+subscriptions
