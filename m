Received: from eggs.gnu.org ([2001:4830:134:3::10]:40092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctJDh-0006N0-Uc
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctJDd-0000bE-19
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:25:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:56345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctJDc-0000ax-SR
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:25:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctJDa-0001QI-R1
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:25:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BFEAF2E80C8
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:25:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Mar 2017 19:13:42 -0000
From: John Snow <1390520@bugs.launchpad.net>
Reply-To: Bug 1390520 <1390520@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141107160655.5759.49372.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170329191343.26064.36547.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1390520] Re: virtual machine fails to start with
 connected audio cd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is currently no expectation that Audio CDs will work on an
emulated CD drive; as long as audio CDs aren't causing QEMU to crash or
anything of the sort, this is wishlist and not a bug.

Still, I'll try to take a look later and see if there's an easy win here
or not. I imagine we don't support many of the Audio CD commands that
ATAPI drives need in order to service audio requests, but there may be
some difficulty in the pass-through as well.

** Changed in: qemu
     Assignee: (unassigned) =3D> John Snow (jnsnow)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1390520

Title:
  virtual machine fails to start with connected audio cd

Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Confirmed
Status in libvirt source package in Trusty:
  Confirmed

Bug description:
  when connecting a data cd with a virtual machine (IDE CDROM 1), the virtu=
al machine starts up and the data cd is accessable (for example to install =
software package or drivers),
  but connecting an audio cd the following error appears:

  -------------------------------------------------------------------------=
------------------------------------------------------
  cannot read header '/dev/sr0': Input/output error

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/details.py", line 2530, in _c=
hange_config_helper
      func(*args)
    File "/usr/share/virt-manager/virtManager/domain.py", line 850, in hotp=
lug_storage_media
      self.attach_device(devobj)
    File "/usr/share/virt-manager/virtManager/domain.py", line 798, in atta=
ch_device
      self._backend.attachDevice(devxml)
    File "/usr/lib/python2.7/dist-packages/libvirt.py", line 493, in attach=
Device
      if ret =3D=3D -1: raise libvirtError ('virDomainAttachDevice() failed=
', dom=3Dself)
  libvirtError: cannot read header '/dev/sr0': Input/output error
  -------------------------------------------------------------------------=
---------------------------------------------------

  Description:    Ubuntu 14.04.1 LTS
  Release:        14.04

  qemu:
    Installiert:           2.0.0+dfsg-2ubuntu1.6
    Installationskandidat: 2.0.0+dfsg-2ubuntu1.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1390520/+subscriptions
