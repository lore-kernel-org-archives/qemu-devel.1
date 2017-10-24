Received: from eggs.gnu.org ([2001:4830:134:3::10]:44937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e6uJP-00044b-FK
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e6uJL-0005h9-DU
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:11:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:60860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e6uJL-0005gx-4c
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 04:11:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e6uJI-000368-Rc
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 08:11:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9589C2E80D1
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 08:11:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Oct 2017 07:59:11 -0000
From: Farid Zarazvand <1719282@bugs.launchpad.net>
Reply-To: Bug 1719282 <1719282@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150633291490.21822.10650098875082014124.malonedeb@chaenomeles.canonical.com>
Message-Id: <150883195131.17616.2025906369076991146.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719282] Re: Unable to boot after drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is no source or destination machine. I used drive-mirror to
transfer VM Image to different physical disk on same machine ("mode":
"absolute-paths"). After block-job-complete and shutting down vm, I
start vm again with same command with different drive path pointing to
mirrored image. "-drive 'file=3DMIRRORED_IMAGE_PATH..".

* Command line used to launch VM:
```
/usr/bin/kvm -id 48016 -chardev 'socket,id=3Dqmp,path=3D/var/run/qemu-serve=
r/48016.qmp,server,nowait' -mon 'chardev=3Dqmp,mode=3Dcontrol' -pidfile /va=
r/run/qemu-server/48016.pid -daemonize -smbios 'type=3D1,uuid=3D7a4b5ebc-a2=
30-4e57-8ebc-4979a7b5a378' -name srv34197 -smp '4,sockets=3D1,cores=3D4,max=
cpus=3D4' -nodefaults -boot 'menu=3Don,strict=3Don,reboot-timeout=3D1000,sp=
lash=3D/usr/share/qemu-server/bootsplash.jpg' -vga cirrus -vnc unix:/var/ru=
n/qemu-server/48016.vnc,x509,password -cpu kvm64,+lahf_lm,+sep,+kvm_pv_unha=
lt,+kvm_pv_eoi,enforce -m 8192 -k en-us -device 'pci-bridge,id=3Dpci.1,chas=
sis_nr=3D1,bus=3Dpci.0,addr=3D0x1e' -device 'pci-bridge,id=3Dpci.2,chassis_=
nr=3D2,bus=3Dpci.0,addr=3D0x1f' -device 'piix3-usb-uhci,id=3Duhci,bus=3Dpci=
.0,addr=3D0x1.0x2' -device 'usb-tablet,id=3Dtablet,bus=3Duhci.0,port=3D1' -=
chardev 'socket,path=3D/var/run/qemu-server/48016.qga,server,nowait,id=3Dqg=
a0' -device 'virtio-serial,id=3Dqga0,bus=3Dpci.0,addr=3D0x8' -device 'virts=
erialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0' -device 'virtio-bal=
loon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3' -iscsi 'initiator-name=3Diqn=
.1993-08.org.debian:01:6f368eef312d' -drive 'file=3D/var/lib/vz/images/4801=
6/vm-48016-disk-1.raw,if=3Dnone,id=3Ddrive-ide0,format=3Draw,cache=3Dnone,a=
io=3Dnative,detect-zeroes=3Don' -device 'ide-hd,bus=3Dide.0,unit=3D0,drive=
=3Ddrive-ide0,id=3Dide0,bootindex=3D100' -drive 'file=3D/var/lib/vz/templat=
e/iso/sysresccd-v03.iso,if=3Dnone,id=3Ddrive-ide2,media=3Dcdrom,aio=3Dthrea=
ds' -device 'ide-cd,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide2,id=3Dide2,booti=
ndex=3D200' -netdev 'type=3Dtap,id=3Dnet0,ifname=3Dtap48016i0,script=3D/var=
/lib/qemu-server/pve-bridge,downscript=3D/var/lib/qemu-server/pve-bridgedow=
n' -device 'rtl8139,mac=3DD6:89:56:3F:38:1F,netdev=3Dnet0,bus=3Dpci.0,addr=
=3D0x12,id=3Dnet0' -netdev 'type=3Dtap,id=3Dnet1,ifname=3Dtap48016i1,script=
=3D/var/lib/qemu-server/pve-bridge,downscript=3D/var/lib/qemu-server/pve-br=
idgedown' -device 'rtl8139,mac=3D66:92:13:4A:6B:7E,netdev=3Dnet1,bus=3Dpci.=
0,addr=3D0x13,id=3Dnet1'
```

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719282

Title:
  Unable to boot after drive-mirror

Status in QEMU:
  New

Bug description:
  Hi,
  I am using "drive-mirror" qmp block-job command to transfer VM disk image=
 to other path (different physical disk on host).
  Unfortunately after shutting down and starting from new image, VM is unab=
le to boot and qrub enters rescue mode displaying following error:
  ```
  error: file '/grub/i386-pc/normal.mod' not found.
  Entering rescue mode...
  grub rescue>
  ```

  To investigate the problem, I compared both RAW images using linux
  "cmp -l" command and found out that they differ in 569028 bytes
  starting from address 185598977 to 252708864 which are located on
  /boot partition.

  So I mounted /boot partition of mirrored RAW image on host OS and it
  seems that file-system is broken and grub folder is not recognized.
  But /boot on original RAW image has no problem.

  Mirrored Image:
  ls -l /mnt/vm-boot/
  ls: cannot access /mnt/vm-boot/grub: Structure needs cleaning
  total 38168
  -rw-r--r-- 1 root root   157721 Oct 19  2016 config-3.16.0-4-amd64
  -rw-r--r-- 1 root root   129281 Sep 20  2015 config-3.2.0-4-amd64
  d????????? ? ?    ?           ?            ? grub
  -rw-r--r-- 1 root root 15739360 Nov  2  2016 initrd.img-3.16.0-4-amd64
  -rw-r--r-- 1 root root 12115412 Oct 10  2015 initrd.img-3.2.0-4-amd64
  drwxr-xr-x 2 root root    12288 Oct  7  2013 lost+found
  -rw-r--r-- 1 root root  2679264 Oct 19  2016 System.map-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2114662 Sep 20  2015 System.map-3.2.0-4-amd64
  -rw-r--r-- 1 root root  3126448 Oct 19  2016 vmlinuz-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2842592 Sep 20  2015 vmlinuz-3.2.0-4-amd64

  Original Image:
  ls /mnt/vm-boot/ -l
  total 38173
  -rw-r--r-- 1 root root   157721 Oct 19  2016 config-3.16.0-4-amd64
  -rw-r--r-- 1 root root   129281 Sep 20  2015 config-3.2.0-4-amd64
  drwxr-xr-x 5 root root     5120 Nov  2  2016 grub
  -rw-r--r-- 1 root root 15739360 Nov  2  2016 initrd.img-3.16.0-4-amd64
  -rw-r--r-- 1 root root 12115412 Oct 10  2015 initrd.img-3.2.0-4-amd64
  drwxr-xr-x 2 root root    12288 Oct  7  2013 lost+found
  -rw-r--r-- 1 root root  2679264 Oct 19  2016 System.map-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2114662 Sep 20  2015 System.map-3.2.0-4-amd64
  -rw-r--r-- 1 root root  3126448 Oct 19  2016 vmlinuz-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2842592 Sep 20  2015 vmlinuz-3.2.0-4-amd64

  ls /mnt/vm-boot/grub/ -l
  total 2376
  -rw-r--r-- 1 root root      48 Oct  7  2013 device.map
  drwxr-xr-x 2 root root    1024 Oct 10  2015 fonts
  -r--r--r-- 1 root root    9432 Nov  2  2016 grub.cfg
  -rw-r--r-- 1 root root    1024 Oct  7  2013 grubenv
  drwxr-xr-x 2 root root    6144 Aug  6  2016 i386-pc
  drwxr-xr-x 2 root root    1024 Aug  6  2016 locale
  -rw-r--r-- 1 root root 2400500 Aug  6  2016 unicode.pf2

  qemu Version: 2.7.0-10

  Host OS: Debian 8x64
  Guest OS: Debian 8x64

  QMP Commands log:
  socat UNIX-CONNECT:/var/run/qemu-server/48016.qmp STDIO
  {"QMP": {"version": {"qemu": {"micro": 0, "minor": 7, "major": 2}, "packa=
ge": "pve-qemu-kvm_2.7.0-10"}, "capabilities": []}}
  { "execute": "qmp_capabilities" }
  {"return": {}}
  { "execute": "drive-mirror",
    "arguments": {
      "device": "drive-ide0",
      "target": "/diskc/48016/vm-48016-disk-2.raw",
      "sync": "full",
      "mode": "absolute-paths",
      "speed": 0
    }
  }
  {"return": {}}
  {"timestamp": {"seconds": 1506331591, "microseconds": 623095}, "event": "=
BLOCK_JOB_READY", "data": {"device": "drive-ide0", "len": 269445758976, "of=
fset": 269445758976, "speed": 0, "type": "mirror"}}
  {"timestamp": {"seconds": 1506332641, "microseconds": 245272}, "event": "=
SHUTDOWN"}
  {"timestamp": {"seconds": 1506332641, "microseconds": 377751}, "event": "=
BLOCK_JOB_COMPLETED", "data": {"device": "drive-ide0", "len": 271707340800,=
 "offset": 271707340800, "speed": 0, "type": "mirror"}}

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719282/+subscriptions
