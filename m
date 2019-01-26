Received: from eggs.gnu.org ([209.51.188.92]:55821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnQEE-0003Fy-0W
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 10:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnQEA-0003Ib-GZ
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 10:50:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gnQE7-0003Gy-M8
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 10:50:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gnQE6-0000di-0W
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 15:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9D2E2E80C7
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 15:50:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Jan 2019 15:45:10 -0000
From: Chen Zhang <1813406@bugs.launchpad.net>
Reply-To: Bug 1813406 <1813406@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154851751023.19548.18254052025186745164.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813406] [NEW] qemu-img convert malfunction on
 macOS
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

On macOS 10.13.6, `qemu-img convert` failed to convert a qcow2 into a
new qcow2 (for the purpose of shrinking the image).

A 50GB (3.7GB allocated) qcow2 image was used as source. The qemu-img
convert output was a 3.4MB file.

qemu-img from HomeBrew were tested. Both 2.11.1 and 3.1.0_1 failed to
convert a qcow2 image.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: macos qemu-img

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813406

Title:
  qemu-img convert malfunction on macOS

Status in QEMU:
  New

Bug description:
  On macOS 10.13.6, `qemu-img convert` failed to convert a qcow2 into a
  new qcow2 (for the purpose of shrinking the image).

  A 50GB (3.7GB allocated) qcow2 image was used as source. The qemu-img
  convert output was a 3.4MB file.

  qemu-img from HomeBrew were tested. Both 2.11.1 and 3.1.0_1 failed to
  convert a qcow2 image.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813406/+subscriptions
