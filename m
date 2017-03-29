Received: from eggs.gnu.org ([2001:4830:134:3::10]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctEXW-000362-UA
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctEXS-0005KS-QD
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:25:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:41075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctEXS-0005Jy-L7
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:25:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctEXR-0004oG-7f
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 14:25:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 339322E80C4
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 14:25:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Mar 2017 14:14:19 -0000
From: ChristianEhrhardt <1390520@bugs.launchpad.net>
Reply-To: Bug 1390520 <1390520@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141107160655.5759.49372.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170329141419.557.14323.malone@gac.canonical.com>
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

I'm actually not so convinced this is "supposed" or expected to work, it
might be worth to subscribe upstream qemu to get an expertise on that.

** Also affects: qemu
   Importance: Undecided
       Status: New

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
