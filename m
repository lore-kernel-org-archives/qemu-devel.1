Received: from eggs.gnu.org ([2001:4830:134:3::10]:43040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZA4Z-0002NZ-Ox
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZA4U-00026p-PO
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:45:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:55542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZA4U-000264-H1
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:45:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZA4S-0008Ev-BV
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:45:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3DFBE2E80D6
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:45:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Dec 2018 07:36:26 -0000
From: Ali Sag <1808928@bugs.launchpad.net>
Reply-To: Bug 1808928 <1808928@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154511858636.8591.3431958243733477284.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1808928] [NEW] Bitmap Extra data is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

i am using dirty bitmaps and drive-backup. It works as aspected.

Lately, i encounter a disastrous error. There is not any information
about that situation. I cannot reach/open/attach/info or anything with a
qcow2 file.

virsh version
Compiled against library: libvirt 4.10.0
Using library: libvirt 4.10.0
Using API: QEMU 4.10.0
Running hypervisor: QEMU 2.12.0

"qemu-img: Could not open '/var/lib/libvirt/images/test.qcow2': Bitmap
extra data is not supported"

what is that mean? what should i do?
i cannot remove bitmap. i cannot open image or query.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: bitmaps block dirt qcow2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1808928

Title:
  Bitmap Extra data is not supported

Status in QEMU:
  New

Bug description:
  i am using dirty bitmaps and drive-backup. It works as aspected.

  Lately, i encounter a disastrous error. There is not any information
  about that situation. I cannot reach/open/attach/info or anything with
  a qcow2 file.

  virsh version
  Compiled against library: libvirt 4.10.0
  Using library: libvirt 4.10.0
  Using API: QEMU 4.10.0
  Running hypervisor: QEMU 2.12.0

  "qemu-img: Could not open '/var/lib/libvirt/images/test.qcow2': Bitmap
  extra data is not supported"

  what is that mean? what should i do?
  i cannot remove bitmap. i cannot open image or query.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1808928/+subscriptions
