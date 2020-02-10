Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81494C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DF02080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DF02080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1AAg-0000Io-FG
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 09:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1A9y-0008K0-30
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1A9w-0000ax-22
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:35:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:55966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1A9v-0000aV-Ry
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 09:35:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1A9u-0005Qg-14
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 14:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 05D512E80C0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 14:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2020 14:26:05 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1859656@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=maas; status=New; importance=Undecided;
 assignee=lee.trager@canonical.com; 
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=ubuntu-z-systems; status=Triaged; importance=High;
 assignee=maas; 
X-Launchpad-Bug-Tags: s390x
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fheimes ltrager paelzer sfeole
X-Launchpad-Bug-Reporter: Sean Feole (sfeole)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <157902669328.14768.4315907500950527119.malonedeb@wampee.canonical.com>
Message-Id: <158134476520.18744.313046835334838352.malone@gac.canonical.com>
Subject: [Bug 1859656] Re: [2.6] Unable to reboot s390x KVM machine after
 initial deploy
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 65789dfc3dfb9fb8cc07d9f4f969c304dd285767
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1859656 <1859656@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are the interesting bits from the log:

   1 LOADPARM=3D[........]^M                                               =
             =

   2 Network boot device detected^M                                        =
           =

   3 ^M                                                                    =
           =

   4 Network boot starting...^M                                            =
           =

   5   Using MAC address: 52:54:00:02:a3:f9^M                              =
           =

   6   Requesting information via DHCP:     ^H^H^H010^H^H^H^Hdone^M        =
           =

   7   Using IPv4 address: 192.168.122.102^M                               =
           =

   8   Using TFTP server: 192.168.122.1^M                                  =
           =

   9   Bootfile name: 'boots390x.bin'^M                                    =
           =

  10   Receiving data:  0 KBytes^M                                         =
           =

  11   TFTP error: file not found: boots390x.bin^M                         =
           =

  12 Trying pxelinux.cfg files...^M^M                                      =
           =

...
  14 TFTP: Received s390x/01-52-54-00-02-a3-f9 (581 bytes)^M               =
       =

  15 Loading pxelinux.cfg entry 'execute'^M                                =
           =

...
  17   TFTP: Received ubuntu/s390x/ga-19.04/disco/daily/boot-kernel (4318 K=
Bytes)^M   =

...
  19   TFTP: Received ubuntu/s390x/ga-19.04/disco/daily/boot-initrd (19360 =
KBytes)^M  =

  20 Network loading done, starting kernel...^M                            =
           =

  21 ^M                                                                    =
           =

  22 [    0.439873] Linux version 5.0.0-38-generic (buildd@bos02-s390x-020)=
 (gcc version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) #41-Ubuntu SMP Tue Dec 3 00:26=
:40 UTC 2019 (Ubuntu 5.0.0-38.41-generic      5.0.21)

...

38 ^M[    0.451953] Kernel command line: nomodeset ro
root=3Dsquash:http://192.168.122.1:5248/images/ubuntu/s390x/ga-19.04/disco/=
daily/squashfs
ip=3D::::vm1:BOOTIF ip6=3Doff overlayroot=3Dtmpfs ov
erlayroot_cfgdisk=3Ddisabled cc:{'datasource_list': ['MAAS']}end_cc cloud-
config-url=3Dhttp://192-168-122-0--24.maas-
internal:5248/MAAS/metadata/latest/by-id/wpr3yp/?op=3Dget_preseed apparmor
=3D0 log_host=3D192.168.122.1 log_port=3D5247 --- console=3Dtty1 console=3D=
ttyS0
BOOTIF=3D01-52-54-00-02-a3-f9

...

 155 Begin: Mounting root file system ... Begin: Running /scripts/local-top=
 ... IP-Config: enc1 hardware address 52:54:00:02:a3:f9 mtu 1500 DHCP RARP^M
 156 hostname vm1 IP-Config: no response after 2 secs - giving up^M        =
           =

 157 IP-Config: enc1 hardware address 52:54:00:02:a3:f9 mtu 1500 DHCP RARP^=
M          =

 158 hostname vm1 hostname vm1 IP-Config: enc1 complete (dhcp from 192.168.=
122.1):^M  =

 159  address: 192.168.122.102  broadcast: 192.168.122.255  netmask: 255.25=
5.255.0   ^M
 160  gateway: 192.168.122.254  dns0     : 192.168.122.1    dns1   : 10.245=
.236.13   ^M
 161  domain : maas                                                        =
    ^M     =

 162  rootserver: 192.168.122.1 rootpath: ^M                               =
           =

 163  filename  : lpxelinux.0^M                                            =
           =

 164 :: root=3Dsquash:http://192.168.122.1:5248/images/ubuntu/s390x/ga-19.0=
4/disco/daily/squashfs^M
 165 :: mount_squash downloading http://192.168.122.1:5248/images/ubuntu/s3=
90x/ga-19.04/disco/daily/squashfs to /root.tmp.img^M
 166 Connecting to 192.168.122.1:5248 (192.168.122.1:5248)^M               =
           =

 167 ^Mroot.tmp.img          21% |******                         | 66726k  =
0:00:03 ETA^Mroot.tmp.img          98% |****************************** |   =
296M  0:00:00 ETA^Mroot.tmp.img              100% |************************=
*******|   301M  0:00:00 ETA^M
 168 :: mount -t squashfs -o loop  '/root.tmp.img' '/root.tmp'^M           =
           =

 169 done.


^^ all of this seems to be the initial deployment ^^
We see curtin doing its things as instructed by maas.


Later on we see the reboot after install then

1362 -----END SSH HOST KEY KEYS-----^M                                     =
           =

1363 [  202.776296] cloud-init[1567]: Cloud-init v. 19.3-41-gc4735dd3-0ubun=
tu1~19.04.1 running 'modules:final' at Mon, 10 Feb 2020 10:42:08 +0000. Up =
114.97 seconds.^M
1364 [  202.776472] cloud-init[1567]: Cloud-init v. 19.3-41-gc4735dd3-0ubun=
tu1~19.04.1 finished at Mon, 10 Feb 2020 10:43:36 +0000. Datasource DataSou=
rceMAAS [http://192-168-122-0--24.maas-i     nternal:5248/MAAS/metadata/cur=
tin].  Up 202.74 seconds^M
1365 [^[[0;32m  OK  ^[[0m] Started ^[[0;1;39mExecute cloud user/final scrip=
ts^[[0m.^M =

1366 [^[[0;32m  OK  ^[[0m] Reached target ^[[0;1;39mCloud-init target^[[0m.=
^M         =

1367 [^[[0;32m  OK  ^[[0m] Stopped target ^[[0;1;39mGraphical Interface^[[0=
m.^M       =

1368 [^[[0;32m  OK  ^[[0m] Stopped target ^[[0;1;39mCloud-init target^[[0m.

...

1487 [^[[0;32m  OK  ^[[0m] Reached target ^[[0;1;39mReboot^[[0m.^M         =
           =

1488 LOADPARM=3D[        ]^M                                               =
             =

1489 Using virtio-blk.^M                                                   =
           =

1490 Using SCSI scheme.^M                                                  =
           =

1491 .....^M                                                               =
           =

1492 [    0.412847] Linux version 5.0.0-38-generic (buildd@bos02-s390x-020)=
 (gcc version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) #41-Ubuntu SMP Tue Dec 3 00:26=
:40 UTC 2019 (Ubuntu 5.0.0-38.41-generic      5.0.21)


...

the rest is the startup until a login:

1967 vm1 login:


But this does NOT use "fallback from failed network boot".
It used a valid netboot (into the deployment) and then reboot

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859656

Title:
  [2.6] Unable to reboot s390x KVM machine after initial deploy

Status in MAAS:
  New
Status in QEMU:
  Incomplete
Status in Ubuntu on IBM z Systems:
  Triaged

Bug description:
  MAAS version: 2.6.1 (7832-g17912cdc9-0ubuntu1~18.04.1)
  Arch: S390x

  Appears that MAAS can not find the s390x bootloader to boot from the
  disk, not sure how maas determines this.  However this was working in
  the past. I had originally thought that if the maas machine was
  deployed then it defaulted to boot from disk.

  If I force the VM to book from disk, the VM starts up as expected.

  Reproduce:

  - Deploy Disco on S390x KVM instance
  - Reboot it

  on the KVM console...

  Connected to domain s2lp6g001
  Escape character is ^]
  done
  =C2=A0=C2=A0Using IPv4 address: 10.246.75.160
  =C2=A0=C2=A0Using TFTP server: 10.246.72.3
  =C2=A0=C2=A0Bootfile name: 'boots390x.bin'
  =C2=A0=C2=A0Receiving data:  0 KBytes
  =C2=A0=C2=A0TFTP error: file not found: boots390x.bin
  Trying pxelinux.cfg files...
  =C2=A0=C2=A0Receiving data:  0 KBytes
  =C2=A0=C2=A0Receiving data:  0 KBytes
  Failed to load OS from network

  =3D=3D> /var/log/maas/rackd.log <=3D=3D
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] boots39=
0x.bin requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/6=
5a9ca43-9541-49be-b315-e2ca85936ea2 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
1-52-54-00-e5-d7-bb requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64BA0 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64BA requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64B requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF64 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF6 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
AF requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
A requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/0=
 requested by 10.246.75.160
  2020-01-14 18:21:24 provisioningserver.rackdservices.tftp: [info] s390x/d=
efault requested by 10.246.75.160

To manage notifications about this bug go to:
https://bugs.launchpad.net/maas/+bug/1859656/+subscriptions

