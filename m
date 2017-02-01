Received: from eggs.gnu.org ([2001:4830:134:3::10]:43236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrKV-0008Jd-1Y
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYrKR-0003W9-5N
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:49427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYrKQ-0003Uw-Vt
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 04:35:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYrKP-0005V3-6m
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 09:35:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 26EF42E80CB
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 09:35:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Feb 2017 09:22:43 -0000
From: Thomas Huth <1221797@bugs.launchpad.net>
Reply-To: Bug 1221797 <1221797@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130906152853.18609.27662.malonedeb@wampee.canonical.com>
Message-Id: <20170201092243.8713.40831.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1221797] Re: virt-install gets stuck during
 downloading install.img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is not a QEMU bug ... for virt-install related problems, please see
https://virt-manager.org/bugs/ instead.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1221797

Title:
  virt-install gets stuck during downloading install.img

Status in QEMU:
  Invalid

Bug description:
  I have tried to install CentOS 6.4 using the latest version of all kvm
  related tools. My problem is that I get stuck at arround 20% during
  the download of the file install.img. Everything before that works
  just fine.

  My Server is based on CentOS 6.4

  I am using the following commands to install to server:
  virt-install \
  =C2=A0-n test \
  =C2=A0-r 1024 \
  =C2=A0--disk path=3D/var/kvm/images/test.img,size=3D25 \
  =C2=A0--vcpus=3D1 \
  =C2=A0--os-type linux \
  =C2=A0--os-variant=3Drhel6 \
  =C2=A0--network bridge=3Dbr2 \
  =C2=A0--nographics \
  =C2=A0--location=3D'http://mirror.netcologne.de/centos/6.4/os/x86_64' \
  =C2=A0--extra-args=3D'console=3Dtty0 console=3DttyS0,115200n8 serial' \

  I have checked that my server is ready for virtualization.

  If you need any further information I am happy to provide them

  Patrick Gramsl

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1221797/+subscriptions
