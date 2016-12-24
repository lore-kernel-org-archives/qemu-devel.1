Received: from eggs.gnu.org ([2001:4830:134:3::10]:60610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKs6T-000254-9K
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 14:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKs6O-0002KG-B8
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 14:35:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:40384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cKs6O-0002KC-2P
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 14:35:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cKs6M-0000W7-9y
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 19:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 40D2F2E80C6
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 19:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Dec 2016 19:25:28 -0000
From: =?utf-8?b?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?=
	<1652459@bugs.launchpad.net>
Reply-To: Bug 1652459 <1652459@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161224192528.14563.19329.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1652459] [NEW] kvm rbd driver (and maybe others,
 i.e. qcow2, qed and so on)  does not report DISCARD-ZERO flag
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

# lsblk -D
NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
sda           0        4K       1G         0
=E2=94=9C=E2=94=80sda1        0        4K       1G         0
=E2=94=9C=E2=94=80sda2     1024        4K       1G         0
=E2=94=94=E2=94=80sda5        0        4K       1G         0

Last column should be `1` at least for "RBD+discard=3Dunmap" since reading
from discarded regions in RBD MUST return zeroes. The same with QCOW2,
QED and sparse raw images. KVM should copy value of this flag when real
raw device (i.e. real SSD) with discard capability is used as virtual
disk.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

+ ```
  # lsblk -D
  NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
  sda           0        4K       1G         0
  =E2=94=9C=E2=94=80sda1        0        4K       1G         0
  =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
  =E2=94=94=E2=94=80sda5        0        4K       1G         0
+ ```
  =

- =

- Last column should be `1` at least for "RBD+discard=3Dunmap" since readin=
g from discarded regions in RBD MUST return zeroes. The same with QCOW2, QE=
D and sparse raw images. KVM should copy value of this flag when real raw d=
evice (i.e. real SSD) with discard capability is used as virtual disk.
+ Last column should be `1` at least for "RBD+discard=3Dunmap" since reading
+ from discarded regions in RBD MUST return zeroes. The same with QCOW2,
+ QED and sparse raw images. KVM should copy value of this flag when real
+ raw device (i.e. real SSD) with discard capability is used as virtual
+ disk.

** Description changed:

- ```
- # lsblk -D
- NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
- sda           0        4K       1G         0
- =E2=94=9C=E2=94=80sda1        0        4K       1G         0
- =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
- =E2=94=94=E2=94=80sda5        0        4K       1G         0
- ```
+    # lsblk -D
+    NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
+    sda           0        4K       1G         0
+    =E2=94=9C=E2=94=80sda1        0        4K       1G         0
+    =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
+    =E2=94=94=E2=94=80sda5        0        4K       1G         0
  =

- Last column should be `1` at least for "RBD+discard=3Dunmap" since reading
- from discarded regions in RBD MUST return zeroes. The same with QCOW2,
- QED and sparse raw images. KVM should copy value of this flag when real
- raw device (i.e. real SSD) with discard capability is used as virtual
- disk.
+ =

+ Last column should be `1` at least for "RBD+discard=3Dunmap" since readin=
g from discarded regions in RBD MUST return zeroes. The same with QCOW2, QE=
D and sparse raw images. KVM should copy value of this flag when real raw d=
evice (i.e. real SSD) with discard capability is used as virtual disk.

** Description changed:

-    # lsblk -D
-    NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
-    sda           0        4K       1G         0
-    =E2=94=9C=E2=94=80sda1        0        4K       1G         0
-    =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
-    =E2=94=94=E2=94=80sda5        0        4K       1G         0
+ <code>
+ # lsblk -D
+ NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
+ sda           0        4K       1G         0
+ =E2=94=9C=E2=94=80sda1        0        4K       1G         0
+ =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
+ =E2=94=94=E2=94=80sda5        0        4K       1G         0
+ <code>
  =

- =

- Last column should be `1` at least for "RBD+discard=3Dunmap" since readin=
g from discarded regions in RBD MUST return zeroes. The same with QCOW2, QE=
D and sparse raw images. KVM should copy value of this flag when real raw d=
evice (i.e. real SSD) with discard capability is used as virtual disk.
+ Last column should be `1` at least for "RBD+discard=3Dunmap" since reading
+ from discarded regions in RBD MUST return zeroes. The same with QCOW2,
+ QED and sparse raw images. KVM should copy value of this flag when real
+ raw device (i.e. real SSD) with discard capability is used as virtual
+ disk.

** Description changed:

- <code>
+ <pre>
  # lsblk -D
  NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
  sda           0        4K       1G         0
  =E2=94=9C=E2=94=80sda1        0        4K       1G         0
  =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
  =E2=94=94=E2=94=80sda5        0        4K       1G         0
- <code>
+ </pre>
  =

  Last column should be `1` at least for "RBD+discard=3Dunmap" since reading
  from discarded regions in RBD MUST return zeroes. The same with QCOW2,
  QED and sparse raw images. KVM should copy value of this flag when real
  raw device (i.e. real SSD) with discard capability is used as virtual
  disk.

** Description changed:

- <pre>
  # lsblk -D
  NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
  sda           0        4K       1G         0
  =E2=94=9C=E2=94=80sda1        0        4K       1G         0
  =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
  =E2=94=94=E2=94=80sda5        0        4K       1G         0
- </pre>
  =

  Last column should be `1` at least for "RBD+discard=3Dunmap" since reading
  from discarded regions in RBD MUST return zeroes. The same with QCOW2,
  QED and sparse raw images. KVM should copy value of this flag when real
  raw device (i.e. real SSD) with discard capability is used as virtual
  disk.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1652459

Title:
  kvm rbd driver (and maybe others, i.e. qcow2, qed and so on)  does not
  report DISCARD-ZERO flag

Status in QEMU:
  New

Bug description:
  # lsblk -D
  NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
  sda           0        4K       1G         0
  =E2=94=9C=E2=94=80sda1        0        4K       1G         0
  =E2=94=9C=E2=94=80sda2     1024        4K       1G         0
  =E2=94=94=E2=94=80sda5        0        4K       1G         0

  Last column should be `1` at least for "RBD+discard=3Dunmap" since
  reading from discarded regions in RBD MUST return zeroes. The same
  with QCOW2, QED and sparse raw images. KVM should copy value of this
  flag when real raw device (i.e. real SSD) with discard capability is
  used as virtual disk.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1652459/+subscriptions
