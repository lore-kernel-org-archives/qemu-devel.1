Received: from eggs.gnu.org ([2001:4830:134:3::10]:49013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9OCW-0000sw-Iq
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 00:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9OCR-0004LT-Ml
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 00:30:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:37632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e9OCR-0004KM-Gm
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 00:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e9OCQ-0002xS-Bf
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 04:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 523EF2E80C7
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Oct 2017 04:17:33 -0000
From: Launchpad Bug Tracker <997631@bugs.launchpad.net>
Reply-To: Bug 997631 <997631@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120510132745.22119.25005.malonedeb@chaenomeles.canonical.com>
Message-Id: <150942345402.24661.1325538486807789995.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 997631] Re: Windows 2008R2 very slow cold boot
 when 4 CPUs
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
https://bugs.launchpad.net/bugs/997631

Title:
  Windows 2008R2 very slow cold boot when 4 CPUs

Status in QEMU:
  Expired

Bug description:
  Hi,

  well, I'm in a similar boat as the one in #992067. But regardless any mem=
ory-settings.
  It takes "ages" in a cold-boot Windows 2008R2 with qemu-1.0.1, qemu-1.0.5=
0 and latest-n-greatest from today ( 1.0.50 /qemu-1b3e76e ). It eats up 400=
% host-cpu-load until login-prompt is shown on the console.

  Meanwhile I tried couple of settings with "-cpu features (hv_spinlocks), =
hv_relaxed and hv_vapic. ".
  Due to some Clock-glitches I start qemu-system-x86_64 with "-no-hpet".

  With 2 processors the system is up after 2 minutes, with 4 procs
  almost 10 minutes... After a reset ( warmstart) the 4 proc-system is
  up after a couple of 20 secs.

  Hints welcome, though once started, the system seems to operate
  "normally".

  Thnx in@vance,

  Oliver.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/997631/+subscriptions
