Received: from eggs.gnu.org ([209.51.188.92]:49864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giOMu-0000Zu-EE
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giOMt-0001uq-9J
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:50:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:38996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1giOMt-0001eA-28
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:50:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1giOMc-0001UK-J1
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 18:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C74B2E80C9
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 18:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Jan 2019 18:43:14 -0000
From: =?utf-8?q?=C5=BDilvinas_=C5=BDaltiena?= <1811533@bugs.launchpad.net>
Reply-To: Bug 1811533 <1811533@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154731859474.20612.3794172498936114295.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811533] [NEW] Unstable Win10 guest with qemu 3.1
 + huge pages + hv_stimer
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

Host:
Gentoo linux x86_64, kernel 4.20.1
Qemu 3.1.0 =

CPU: Intel i7 6850K
Chipset: X99

Guest:
Windows 10 Pro 64bit (1809)
Machine type: pc-q35_3.1
Hyper-V enlightenments: hv_stimer,hv_reenlightenment,hv_frequencies,hv_vapi=
c,hv_reset,hv_synic,hv_runtime,hv_vpindex,hv_time,hv_relaxed,hv_spinlocks=
=3D0x1fff
Memory: 16GB backed by 2MB huge pages

Issue:
Once guest is started, log gets flooded with:

qemu-system-x86_64: vhost_region_add_section: Overlapping but not
coherent sections at 103000

or

qemu-system-x86_64: vhost_region_add_section:Section rounded to 0 prior
to previous 1f000

(line endings change)

and as time goes guest loses network access (virtio-net-pci) and general
performance diminishes to extent of freezing applications.

Observations:
1) problem disappears when hv_stimer is removed
2) problem disappears when memory backing with huge pages is disabled
3) problem disappears when machine type is downgraded to pc-q35_3.0

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811533

Title:
  Unstable Win10 guest with qemu 3.1 + huge pages + hv_stimer

Status in QEMU:
  New

Bug description:
  Host:
  Gentoo linux x86_64, kernel 4.20.1
  Qemu 3.1.0 =

  CPU: Intel i7 6850K
  Chipset: X99

  Guest:
  Windows 10 Pro 64bit (1809)
  Machine type: pc-q35_3.1
  Hyper-V enlightenments: hv_stimer,hv_reenlightenment,hv_frequencies,hv_va=
pic,hv_reset,hv_synic,hv_runtime,hv_vpindex,hv_time,hv_relaxed,hv_spinlocks=
=3D0x1fff
  Memory: 16GB backed by 2MB huge pages

  Issue:
  Once guest is started, log gets flooded with:

  qemu-system-x86_64: vhost_region_add_section: Overlapping but not
  coherent sections at 103000

  or

  qemu-system-x86_64: vhost_region_add_section:Section rounded to 0
  prior to previous 1f000

  (line endings change)

  and as time goes guest loses network access (virtio-net-pci) and
  general performance diminishes to extent of freezing applications.

  Observations:
  1) problem disappears when hv_stimer is removed
  2) problem disappears when memory backing with huge pages is disabled
  3) problem disappears when machine type is downgraded to pc-q35_3.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811533/+subscriptions
