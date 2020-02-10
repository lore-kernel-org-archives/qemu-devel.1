Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3833CC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D83C20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D83C20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j16pq-0003p6-6u
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j16p0-0003A2-GK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j16ou-0007dE-6d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:01:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:41236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j16ot-0007Lz-W8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:01:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j16oe-0004jf-BV
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 11:01:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 53E882E80C0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 11:01:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Feb 2020 10:52:07 -0000
From: Frank Heimes <1859656@bugs.launchpad.net>
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
X-Launchpad-Bug-Modifier: Frank Heimes (fheimes)
References: <157902669328.14768.4315907500950527119.malonedeb@wampee.canonical.com>
Message-Id: <158133192734.8965.10747491506558255647.malone@chaenomeles.canonical.com>
Subject: [Bug 1859656] Re: [2.6] Unable to reboot s390x KVM machine after
 initial deploy
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bf2277c564c7ca8268ec53b930956578ac342106
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

In between I found the time to setup an env. build upon older releases:

$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.1 LTS
Release:	18.04
Codename:	bionic

$ dpkg -l | grep -i qemu
ii  qemu-block-extra:s390x                1:2.11+dfsg-1ubuntu7             =
      s390x        extra block backend modules for qemu-system and qemu-uti=
ls
ii  qemu-kvm                              1:2.11+dfsg-1ubuntu7             =
      s390x        QEMU Full virtualization on x86 hardware
ii  qemu-system-common                    1:2.11+dfsg-1ubuntu7             =
      s390x        QEMU full system emulation binaries (common files)
ii  qemu-system-s390x                     1:2.11+dfsg-1ubuntu7             =
      s390x        QEMU full system emulation binaries (s390x)
ii  qemu-utils                            1:2.11+dfsg-1ubuntu7             =
      s390x        QEMU utilities

$ apt-cache policy maas
maas:
  Installed: 2.6.0-7803-g6fc5f26eb-0ubuntu1~18.04.1
  Candidate: 2.6.0-7803-g6fc5f26eb-0ubuntu1~18.04.1
  Version table:
 *** 2.6.0-7803-g6fc5f26eb-0ubuntu1~18.04.1 500
        500 http://ppa.launchpad.net/maas-maintainers/testing/ubuntu bionic=
/main s390x Packages
        100 /var/lib/dpkg/status
     2.4.2-7034-g2f5deb8b8-0ubuntu1 500
        500 http://us.ports.ubuntu.com/ubuntu-ports bionic-updates/main s39=
0x Packages
        500 http://ports.ubuntu.com/ubuntu-ports bionic-updates/main s390x =
Packages
        500 http://aus.ports.ubuntu.com/ubuntu-ports bionic-updates/main s3=
90x Packages
     2.4.0~beta2-6865-gec43e47e6-0ubuntu1 500
        500 http://us.ports.ubuntu.com/ubuntu-ports bionic/main s390x Packa=
ges
        500 http://ports.ubuntu.com/ubuntu-ports bionic/main s390x Packages

In this environment MAAS is not able to Commission ("Failed commissioning").
Trying to start the vm manually with virsh ends up with:

$ virsh start vm1 --console
Domain vm1 started
Connected to domain vm1
Escape character is ^]
done
  Using IPv4 address: 192.168.122.102
  Requesting file "boots390x.bin" via TFTP from 192.168.122.1
  Receiving data:  0 KBytesfile not found: boots390x.bin
Failed to load OS from network

So that is expecting, since the qemu packages version 1:2.11+dfsg-
1ubuntu7 were initially used - the GA version, that's not known to work
- the needed patch came later.

The first qemu packages that should be good are the ones with version 1:2.1=
1+dfsg-1ubuntu7.7.
But (after discussing with cpaelzer) the qemu packages didn't really change=
d since 1:2.11+dfsg-1ubuntu7.7, I thought that I now upgrade to the latest =
ones (1:2.11+dfsg-1ubuntu7.22):

$ sudo apt install qemu-block-extra qemu-kvm qemu-system-common qemu-system=
-s390x qemu-utils =

Reading package lists... Done
Building dependency tree       =

Reading state information... Done
Suggested packages:
  debootstrap
Recommended packages:
  sharutils
The following packages will be upgraded:
  qemu-block-extra qemu-kvm qemu-system-common qemu-system-s390x qemu-utils
5 upgraded, 0 newly installed, 0 to remove and 167 not upgraded.
Need to get 3,249 kB of archives.
After this operation, 32.8 kB of additional disk space will be used.
Get:1 http://us.ports.ubuntu.com/ubuntu-ports bionic-proposed/main s390x qe=
mu-utils s390x 1:2.11+dfsg-1ubuntu7.22 [811 kB]
Get:2 http://us.ports.ubuntu.com/ubuntu-ports bionic-proposed/main s390x qe=
mu-system-common s390x 1:2.11+dfsg-1ubuntu7.22 [671 kB]
Get:3 http://us.ports.ubuntu.com/ubuntu-ports bionic-proposed/main s390x qe=
mu-block-extra s390x 1:2.11+dfsg-1ubuntu7.22 [37.3 kB]
Get:4 http://us.ports.ubuntu.com/ubuntu-ports bionic-proposed/main s390x qe=
mu-kvm s390x 1:2.11+dfsg-1ubuntu7.22 [12.5 kB]
Get:5 http://us.ports.ubuntu.com/ubuntu-ports bionic-proposed/main s390x qe=
mu-system-s390x s390x 1:2.11+dfsg-1ubuntu7.22 [1,717 kB]
Fetched 3,249 kB in 0s (8,360 kB/s)        =

(Reading database ... 67530 files and directories currently installed.)
Preparing to unpack .../qemu-utils_1%3a2.11+dfsg-1ubuntu7.22_s390x.deb ...
Unpacking qemu-utils (1:2.11+dfsg-1ubuntu7.22) over (1:2.11+dfsg-1ubuntu7) =
...
Preparing to unpack .../qemu-system-common_1%3a2.11+dfsg-1ubuntu7.22_s390x.=
deb .
..
Unpacking qemu-system-common (1:2.11+dfsg-1ubuntu7.22) over (1:2.11+dfsg-1u=
buntu
7) ...
Preparing to unpack .../qemu-block-extra_1%3a2.11+dfsg-1ubuntu7.22_s390x.de=
b ...
Unpacking qemu-block-extra:s390x (1:2.11+dfsg-1ubuntu7.22) over (1:2.11+dfs=
g-1ub
untu7) ...
Preparing to unpack .../qemu-kvm_1%3a2.11+dfsg-1ubuntu7.22_s390x.deb ...
Unpacking qemu-kvm (1:2.11+dfsg-1ubuntu7.22) over (1:2.11+dfsg-1ubuntu7) ...
Preparing to unpack .../qemu-system-s390x_1%3a2.11+dfsg-1ubuntu7.22_s390x.d=
eb ..
.
Unpacking qemu-system-s390x (1:2.11+dfsg-1ubuntu7.22) over (1:2.11+dfsg-1ub=
untu7
) ...
Setting up qemu-block-extra:s390x (1:2.11+dfsg-1ubuntu7.22) ...
Setting up qemu-utils (1:2.11+dfsg-1ubuntu7.22) ...
Processing triggers for man-db (2.8.3-2) ...
Setting up qemu-system-common (1:2.11+dfsg-1ubuntu7.22) ...
Setting up qemu-system-s390x (1:2.11+dfsg-1ubuntu7.22) ...
Setting up qemu-kvm (1:2.11+dfsg-1ubuntu7.22) ...

And with that the Commissioning worked and ended correctly,
and I was also able to complete a Deployment afterwards.

I deployed 19.04 (disco, since I think that Sean faced the issue while
he tried to deploy disco, too) and it worked. The system (vm1) came up
and I was able to login:

$ ssh ubuntu@192.168.122.201 =

The authenticity of host '192.168.122.201 (192.168.122.201)' can't be estab=
lished.
ECDSA key fingerprint is SHA256:WMeXfn4hIAc38WUnXqPuhASMLjiig+uzdhqfkjzR7mI.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.122.201' (ECDSA) to the list of known h=
osts.
Welcome to Ubuntu 19.04 (GNU/Linux 5.0.0-38-generic s390x)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Feb 10 10:44:33 UTC 2020

  System load:  0.19              Processes:           95
  Usage of /:   42.4% of 7.27GB   Users logged in:     0
  Memory usage: 15%               IP address for enc1: 192.168.122.201
  Swap usage:   0%

4 updates can be installed immediately.
4 of these updates are security updates.


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@vm1:~$

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

