Received: from eggs.gnu.org ([2001:4830:134:3::10]:33721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDy-0004S0-6D
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDv-0004rw-GF
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:60552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDv-0004rU-Aa
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDu-0002Rz-2g
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5F09E2E80E8
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:17:52 -0000
From: Launchpad Bug Tracker <809912@bugs.launchpad.net>
Reply-To: Bug 809912 <809912@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110713143335.13610.27004.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170104041752.27545.39427.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 809912] Re: qemu-kvm -m bigger 4096 aborts with
 'Bad ram offset'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/809912

Title:
  qemu-kvm -m bigger 4096 aborts with 'Bad ram offset'

Status in QEMU:
  Expired

Bug description:
  When I try to start a virtual machine (x86_64 guest on a x86_64 host
  that has 32GB memory, using kvm_amd module, both host and guest
  running linux-2.6.39 kernels) with "qemu-system-x86_64 -cpu host -smp
  2 -m 4096 ...", shortly after the guest kernel starts, qemu aborts
  with a message "Bad ram offset 11811c000".

  With e.g. "-m 3500" (or lower), the virtual machine runs fine.

  I experience this both using qemu-kvm 0.14.1 and a recent version from git
  commit 525e3df73e40290e95743d4c8f8b64d8d9cbe021
  Merge: d589310 75ef849
  Author: Avi Kivity <avi@redhat.com>
  Date:   Mon Jul 4 13:36:06 2011 +0300

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/809912/+subscriptions
