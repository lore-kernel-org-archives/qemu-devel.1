Received: from eggs.gnu.org ([2001:4830:134:3::10]:34642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnVZY-0008N0-MD
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 15:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnVZT-0007iF-S8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 15:56:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:57363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dnVZT-0007gG-MC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 15:56:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dnVZS-0004vB-Fp
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 19:56:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 683282E80C3
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 19:56:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Aug 2017 19:36:18 -0000
From: Thomas Huth <997631@bugs.launchpad.net>
Reply-To: Bug 997631 <997631@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120510132745.22119.25005.malonedeb@chaenomeles.canonical.com>
Message-Id: <150420817900.11507.32963704517015668.malone@wampee.canonical.com>
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

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/997631

Title:
  Windows 2008R2 very slow cold boot when 4 CPUs

Status in QEMU:
  Incomplete

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
