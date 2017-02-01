Received: from eggs.gnu.org ([2001:4830:134:3::10]:58952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYqOD-0007lG-BT
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 03:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYqO9-0001UH-DZ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 03:35:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:52545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYqO9-0001Tu-5Q
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 03:35:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYqO6-0003Xs-PZ
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 08:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BC6162E80C2
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 08:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Feb 2017 08:23:15 -0000
From: Thomas Huth <1250360@bugs.launchpad.net>
Reply-To: Bug 1250360 <1250360@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131112091735.10165.76015.malonedeb@soybean.canonical.com>
Message-Id: <20170201082315.9076.51144.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1250360] Re: qcow2 image logical corruption after
 host crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ok, so let's close this now. Thanks for your reply!

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1250360

Title:
  qcow2 image logical corruption after host crash

Status in QEMU:
  Won't Fix

Bug description:
  Description of problem:
  In case of power failure disk images that were active and created in qcow=
2 format can become logically corrupt so that they actually appear as unuse=
d (full of zeroes).
  Data seems to be there, but at this moment i cannot find any reliable met=
hod to recover it. Should it be a raw image, a recovery path would be avail=
able, but a qcow2 image only presents zeroes once it gets corrupted. My und=
erstanding is that the blockmap of the image gets reset and the image is th=
en assumed to be unused.
  My detailed setup :

  Kernel 2.6.32-358.18.1.el6.x86_64
  qemu-kvm-0.12.1.2-2.355.0.1.el6.centos.7.x86_64
  Used via libvirt libvirt-0.10.2-18.el6_4.14.x86_64
  The image was used from a NFS share (the nfs server did NOT crash and rem=
ained permanently active).

  qemu-img check finds no corruption;
  qemu-img convert will fully convert the image to raw at a raw image full =
of zeroes. However, there is data in the file, and the storage backend was =
not restarted, inactivated during the incident.
  I encountered this issue on two different machines, in both cases i was n=
ot able to recover the data.
  Image was qcow2, thin provisioned, created like this :
   qemu-img create -f qcow2 -o cluster_size=3D2M imagename.img

  While addressing the root cause in order to not have this issue repeat
  would be the ideal scenario, a temporary workaround to run on the
  affected qcow2 image to "patch" it and recover the data (eventually
  after a full fsck/recovery inside the guest) would also be good.
  Otherwise we are basically losing data on a large scale when using
  qcow2.


  Version-Release number of selected component (if applicable):
  Kernel 2.6.32-358.18.1.el6.x86_64
  qemu-kvm-0.12.1.2-2.355.0.1.el6.centos.7.x86_64
  Used via libvirt libvirt-0.10.2-18.el6_4.14.x86_64

  How reproducible:
  I am not able (and don't have at the moment enough resources to try to ma=
nually reproduce it), but the probability of the issue seems quite high as =
this is the second case of such corruption in weeks.
  Additional info:
  I can privately provide an image displaying the corruption.

  The reported problem has actually two aspects : first is the cause that e=
ventually produces this issue.
  The second is the fact that once the logical corruption has occured, qemu=
-img check finds nothing wrong with the image - this is obviously wrong.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1250360/+subscriptions
