Received: from eggs.gnu.org ([2001:4830:134:3::10]:58414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8FAp-0007nW-J8
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 20:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8FAk-0007tV-Ce
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 20:40:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:59788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8FAk-0007t8-0S
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 20:40:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8FAh-0002RQ-TK
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 00:40:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D71682E80CD
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 00:40:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 00:22:57 -0000
From: Bug Watch Updater <524447@bugs.launchpad.net>
Reply-To: Bug 524447 <524447@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100219141749.18571.12250.malonedeb@wampee.canonical.com>
Message-Id: <150915017793.3122.15744235500775165385.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 524447] Re: virsh save is very slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 4 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D599091.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2010-06-02T16:38:36+00:00 Cole wrote:

See https://bugs.launchpad.net/ubuntu/+source/qemu-
kvm/+bug/524447/comments/5

Apparently increasing the dd block size greatly increases the speed of
the domain save operation.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/524447/comments/6

------------------------------------------------------------------------
On 2010-06-07T17:56:00+00:00 Laine wrote:

commit 20206a4bc9f1293c69eca79290a55a5fa19976d5 in libvirt git changes
the dd blocksize to 1M. This decreased the time required for a save of a
suspended 512MB guest from 3min47sec to 56sec.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/524447/comments/8

------------------------------------------------------------------------
On 2010-06-10T12:19:33+00:00 Eric wrote:

An additional patch avoids the overhead of seeking to a 1M alignment:
https://www.redhat.com/archives/libvir-list/2010-June/msg00239.html

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/524447/comments/9

------------------------------------------------------------------------
On 2010-07-21T16:48:55+00:00 Daniel wrote:

This is included in 0.8.2. In addition upstream QEMU has identified &
fixed a flaw that had significant speed impact

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/524447/comments/15


** Changed in: libvirt
       Status: Unknown =3D> Fix Released

** Changed in: libvirt
   Importance: Unknown =3D> Medium

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/524447

Title:
  virsh save is very slow

Status in libvirt:
  Fix Released
Status in QEMU:
  Fix Released
Status in libvirt package in Ubuntu:
  Invalid
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in libvirt source package in Lucid:
  Won't Fix
Status in qemu-kvm source package in Lucid:
  Fix Released
Status in libvirt source package in Maverick:
  Won't Fix
Status in qemu-kvm source package in Maverick:
  Won't Fix
Status in qemu-kvm package in Debian:
  Fix Released

Bug description:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  SRU Justification:
  1. impact: 'qemu save' is slow
  2. how addressed: a patch upstream fixes the case when a file does not an=
nounce when it is ready.
  3. patch: see the patch in linked bzr trees
  4. TEST CASE: see comment #4 for a specific recipe
  5. regression potential:  this patch only touches the vm save path.
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  As reported here: http://www.redhat.com/archives/libvir-
  list/2009-December/msg00203.html

  "virsh save" is very slow - it writes the image at around 1MB/sec on
  my test system.

  (I think I saw a bug report for this issue on Fedora's bugzilla, but I
  can't find it now...)

  Confirmed under Karmic.

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/524447/+subscriptions
