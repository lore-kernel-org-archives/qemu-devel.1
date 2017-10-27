Received: from eggs.gnu.org ([2001:4830:134:3::10]:42442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e82mF-0007IZ-4T
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 07:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e82mB-0002xc-Ua
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 07:26:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:60976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e82mB-0002x9-Oo
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 07:26:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e82m9-0007fX-Dp
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:26:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 55CE02E80CF
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:26:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 11:15:14 -0000
From: Bug Watch Updater <568445@bugs.launchpad.net>
Reply-To: Bug 568445 <568445@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100422141538.26448.76102.malonedeb@wampee.canonical.com>
Message-Id: <150910291496.11053.4342646559380897973.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 568445] Re: LVM backed drives should default to
 cache='none'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 5 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D623188.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2010-08-11T14:43:39+00:00 Jamin wrote:

Description of problem:
Defaults to using cache with an LVM backed storage.  The use of caching wit=
h raw partitions (LVM) results in significantly lower performance than no c=
ache at all.

How reproducible:
Always

Steps to Reproduce:
1. Create a new VM using LVM backed storage
  =

Actual results:
Cache is enabled for the VM's disks residing within LVM.

Expected results:
Cache should be disabled for disks residing within LVM.

Additional info:
http://www.linux-kvm.org/page/Tuning_KVM

Specifically:

QEMU also supports a wide variety of caching modes. Writeback is useful
for testing but does not offer storage guarantees. Writethrough (the
default) is safer, and relies on the host cache. If you're using raw
volumes or partitions, it is best to avoid the cache completely, which
reduces data copies and bus traffic:

 qemu -drive file=3D/dev/mapper/ImagesVolumeGroup-
Guest1,cache=3Dnone,if=3Dvirtio

This has also been reported with Ubuntu at:
https://bugs.launchpad.net/ubuntu/+source/virt-manager/+bug/568445

Reply at: https://bugs.launchpad.net/ubuntu/+source/virt-
manager/+bug/568445/comments/12

------------------------------------------------------------------------
On 2010-08-11T16:12:46+00:00 Daniel wrote:

Choice of caching mode is a policy decision. These belong in virt-
manager or other apps using libvirt.

Reply at: https://bugs.launchpad.net/ubuntu/+source/virt-
manager/+bug/568445/comments/13

------------------------------------------------------------------------
On 2010-08-11T17:01:21+00:00 Jamin wrote:

AFAIK, this is the place to post feature requests for virt-manager, at
least this is where their website directed me.  Intentionally selecting
a default mode that results in very poor performance (about 1/5 less)
when the upstream for the virtualization engine (qemu/kvm) clearly
indicates that another mode is preferable is (IMHO) a bad choice.
Furthermore, from what I can tell, virt-manager doesn't appear to
provide any means of changing or overriding the default.  A user must
instead manually edit the server's XML definition of the VM in question.

Reply at: https://bugs.launchpad.net/ubuntu/+source/virt-
manager/+bug/568445/comments/14

------------------------------------------------------------------------
On 2010-08-16T15:38:49+00:00 Jamin wrote:

Reopening against virt-manager as recommended on mailing list.

Reply at: https://bugs.launchpad.net/ubuntu/+source/virt-
manager/+bug/568445/comments/18

------------------------------------------------------------------------
On 2013-10-02T20:12:51+00:00 Cole wrote:

Fixed upstream now

Reply at: https://bugs.launchpad.net/ubuntu/+source/virt-
manager/+bug/568445/comments/20


** Changed in: virt-manager
       Status: Unknown =3D> Won't Fix

** Changed in: virt-manager
   Importance: Unknown =3D> Medium

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/568445

Title:
  LVM backed drives should default to cache=3D'none'

Status in QEMU:
  Invalid
Status in virt-manager:
  Won't Fix
Status in virt-manager package in Ubuntu:
  Triaged

Bug description:
  Binary package hint: virt-manager

  KVM guests using LVM backed drives appear to experience fairly high
  iowait times on the host system if the guest has even a moderate
  amount of disk I/O.  This translates to poor performance for the host
  and all guests running on the host, and appears to be due to caching
  as KVM defaults to using writethrough caching when nothing is
  specified.  Explicitly disabling KVM's caching appears to result in
  significantly better host and guest performance.

  This is recommended in at least a few places:
  http://www.mail-archive.com/libvir-list@redhat.com/msg17492.html
  http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/48471
  http://www.mail-archive.com/kvm@vger.kernel.org/msg30425.html
  http://virt.kernelnewbies.org/XenVsKVM

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/568445/+subscriptions
