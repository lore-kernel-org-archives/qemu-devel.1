Received: from eggs.gnu.org ([2001:4830:134:3::10]:41827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7tRK-0006ib-Iu
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7tRF-0005A8-P8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:28:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:60076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7tRF-00058f-ED
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:27:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7tRB-0007mD-4G
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 01:27:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4AC222E80E7
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 01:27:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 01:09:30 -0000
From: Bug Watch Updater <397212@bugs.launchpad.net>
Reply-To: Bug 397212 <397212@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20090708224816.29273.25948.malonedeb@gandwana.canonical.com>
Message-Id: <150906657323.8333.17125295274280302627.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 397212] Re: Scrolling artifacts on some guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 36 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D503156.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2009-05-29T10:30:34+00:00 Stefan wrote:

Description of problem:
after for example catting a large file inside an xterm there are text artif=
acts remaining inside the xterm window. Scrolling up and down the xterm mak=
es things even worse.

Not sure if it's related to window scaling, please reassign
appropriately if not a virt-manager bug.

Screenshot attached

Version-Release number of selected component (if applicable):
virt-manager-0.7.0-5.fc11.i586

How reproducible:
always

Steps to Reproduce:
1. start VM
2. open xterm inside VM
3. cat large file (/var/log/messages) and scroll to make things worse
  =

Actual results:
text appears garbled

Expected results:
text appears normal without artifacts

Additional info:

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/0

------------------------------------------------------------------------
On 2009-05-29T10:31:13+00:00 Stefan wrote:

Created attachment 345887
garbled-xterm.png

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/1

------------------------------------------------------------------------
On 2009-06-04T17:09:33+00:00 Mark wrote:

Yeah, I can reproduce this, even with vncviewer - doesn't seem
reproducible outside of KVM, though

Moving to qemu

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/2

------------------------------------------------------------------------
On 2009-06-09T16:46:18+00:00 Bug wrote:


This bug appears to have been reported against 'rawhide' during the Fedora =
11 development cycle.
Changing version to '11'.

More information and reason for this action is here:
http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/3

------------------------------------------------------------------------
On 2009-06-23T16:04:26+00:00 Mark wrote:

bug #507626 is probably a dup of this

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/4

------------------------------------------------------------------------
On 2009-07-10T14:51:51+00:00 Jonathan wrote:

Similar bug report for Ubuntu:

https://bugs.launchpad.net/qemu/+bug/397212

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/10

------------------------------------------------------------------------
On 2009-07-20T08:42:27+00:00 Mark wrote:

Glauber posted a patch here:

http://lists.gnu.org/archive/html/qemu-devel/2009-07/msg01498.html

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/11

------------------------------------------------------------------------
On 2009-07-20T08:43:13+00:00 Mark wrote:

*** Bug 507626 has been marked as a duplicate of this bug. ***

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/12

------------------------------------------------------------------------
On 2009-07-22T15:38:43+00:00 Jonathan wrote:

Glauber, do you plan to push updated builds with this patch for F-11? I
don't see this patch incorporated on any of the recent koji builds..?

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/14

------------------------------------------------------------------------
On 2009-07-22T18:24:28+00:00 Glauber wrote:

The patched was NACKed upstream by Gerd. He believes there is a better
way to solve it. As such, I indent to wait for the real fix, or write it
myself it Gerd takes too long

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/15

------------------------------------------------------------------------
On 2009-07-28T00:27:02+00:00 Jonathan wrote:

Gerd has posted an updated patch here:

http://lists.gnu.org/archive/html/qemu-devel/2009-07/msg02107.html

my test machine is down presently, so haven't had chance to test it yet.

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/16

------------------------------------------------------------------------
On 2009-07-28T11:27:58+00:00 Jonathan wrote:

Have been playing with this a bit, and unfortunately applying the patch
in comment #10 against 0.10.5 requires picking up a fair amount of the
recent vnc logic changes (vnc.c and vnc.h) - not sure how you'd
recommend proceeding here? One option would be to pull vnc.[c,h] from
the current HEAD and add the patch, I suppose.. not sure what else might
break.

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/17

------------------------------------------------------------------------
On 2009-08-07T14:47:18+00:00 Mark wrote:

So, the upstream commit is:

  http://git.savannah.gnu.org/cgit/qemu.git/commit/?id=3D3e28c9adf4

and it depends on the fix for bug #501131 which we also want back-ported

(Note the vnc copyrect patch isn't applied to the stable-0.11 branch for
F-12 yet, either)

What I'd really like to see is both of these fixes back-ported to the
stable-0.10 branch and sent upstream to qemu-devel

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/18

------------------------------------------------------------------------
On 2009-09-07T17:36:19+00:00 Mark wrote:

This should be in the 0.10.7 release shortly:

http://git.savannah.gnu.org/cgit/qemu.git/commit/?h=3Dstable-0.10&id=3D74cc=
fe8b7e

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/19

------------------------------------------------------------------------
On 2009-09-11T11:16:56+00:00 Mark wrote:

Will push this to updates-testing soon:

* Fri Sep 11 2009 Mark McLoughlin <markmc@redhat.com> - 2:0.10.6-5
- Fix vnc segfault on disconnect (#501131)
- Fix vnc screen corruption with e.g. xterm (#503156)
- Rebase vnc sasl patches on top of these two vnc fixes

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/20

------------------------------------------------------------------------
On 2009-09-14T07:27:28+00:00 Fedora wrote:

qemu-0.10.6-5.fc11 has been submitted as an update for Fedora 11.
http://admin.fedoraproject.org/updates/qemu-0.10.6-5.fc11

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/21

------------------------------------------------------------------------
On 2009-09-14T11:11:01+00:00 Jonathan wrote:

Created attachment 360920
Windows XP guest with grabled screen

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/22

------------------------------------------------------------------------
On 2009-09-14T11:11:47+00:00 Jonathan wrote:

As the image attached in Comment #16 shows, this update doesn't fix the
problem for me. This is using:

# rpm -qa | grep qemu
qemu-system-x86-0.10.6-5.fc11.x86_64
qemu-img-0.10.6-5.fc11.x86_64
qemu-common-0.10.6-5.fc11.x86_64

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/23

------------------------------------------------------------------------
On 2009-09-14T11:50:41+00:00 Mark wrote:

Thanks for testing Jonathan

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/24

------------------------------------------------------------------------
On 2009-09-15T17:38:43+00:00 Jonathan wrote:

No problem. Alas, if anything, the screen tearing has gotten worse with
this version, rather than better - previously resizing the window in the
guest triggered a redraw which would clean up the garbage (at least
until scrolled again), but now that trick no longer works.

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/25

------------------------------------------------------------------------
On 2009-09-24T07:50:45+00:00 Mogens wrote:

Why on earth was version 2:qemu-0.10.6-5.fc11.x86_64 released
with this "bugfix" that has made the graphics looks worse?

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/26

------------------------------------------------------------------------
On 2009-09-24T09:15:36+00:00 Jonathan wrote:

Good question in Comment #20. Surely that's a mistake Mark?

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/27

------------------------------------------------------------------------
On 2009-10-01T09:20:59+00:00 Mark wrote:

Sorry about that, guys

This 'fix' will be in 0.10.7, so I'm inclined to leave it in for the
moment and try and get it fixed

If we don't get progress, I'll revert it soon

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/28

------------------------------------------------------------------------
On 2009-10-01T11:04:15+00:00 Jonathan wrote:

Is it worth pushing a build of the 0.10.7 rc to updates-testing?

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/29

------------------------------------------------------------------------
On 2009-10-09T21:59:50+00:00 Patrick wrote:

Anything new on this bug?

It's been open for 5 months now.

It's realllllyyy annoying, it makes Windows even harder to use :-(

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/30

------------------------------------------------------------------------
On 2009-10-16T13:21:14+00:00 Mark wrote:

*** Bug 528939 has been marked as a duplicate of this bug. ***

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/31

------------------------------------------------------------------------
On 2009-10-21T16:23:55+00:00 Jonathan wrote:

What would the implications of pushing qemu 0.11 to FC11 be - would that
work with libvirt and friends? If so, any chance of doing such a push?

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/32

------------------------------------------------------------------------
On 2009-10-21T16:31:18+00:00 Mark wrote:

We don't have any immediate plans to update qemu in Fedora 11 to 0.11.
See:

  http://www.redhat.com/archives/fedora-virt/2009-April/msg00008.html

Honestly, it should be a lot easier to fix this bug than deal with the
fallout from the inevitable regressions that would be caused by a re-
base. It's just a question of someone finding the time to debug it.

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/33

------------------------------------------------------------------------
On 2009-10-21T16:50:46+00:00 Patrick wrote:

(In reply to comment #27)
> We don't have any immediate plans to update qemu in Fedora 11 to 0.11. Se=
e:
> =

>   http://www.redhat.com/archives/fedora-virt/2009-April/msg00008.html
> =

> Honestly, it should be a lot easier to fix this bug than deal with the fa=
llout
> from the inevitable regressions that would be caused by a re-base. It's j=
ust a
> question of someone finding the time to debug it.  =


Bah ...

Is there some way to workaround this bug?

Is there another way to connect to the output other than VNC?

I've been using virt-manager.

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/34

------------------------------------------------------------------------
On 2009-10-21T20:23:27+00:00 Jonathan wrote:

Patrick - you could presumably run a VNC server inside your guest and
connect to that, rather than the QEMU vnc client.

The problem with backporting a fix is that there's been a lot of code
churn with the vnc related stuff in qemu, so to actually fix it would
require some knowledge of the vnc stuff, rather than mechanical adding
and removing of commits (I know, as I tried that sometime ago). The
people with that knowledge are too busy pushing forward than looking
back at old releases (understandably - it's more interesting).

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/35

------------------------------------------------------------------------
On 2009-10-23T13:24:33+00:00 Fedora wrote:

qemu-0.10.6-9.fc11 has been submitted as an update for Fedora 11.
http://admin.fedoraproject.org/updates/qemu-0.10.6-9.fc11

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/36

------------------------------------------------------------------------
On 2009-10-23T13:28:11+00:00 Mark wrote:

Patrick and Jonathan: okay, let's try and hit this bad boy with our big
stick

I'm pretty sure it's a problem with qemu's implementation of the
CopyRect extension, so I've just disabled that extension in
qemu-0.10.6-9.fc11 - that should fix the problem

AFAIK, CopyRect works fine in qemu-0.11.0 in Fedora 12

Could you confirm that qemu-0.10.6-9.fc11 fixes the issue? (comment here
and bump the karma in bodhi if so)

Thanks!

* Fri Oct 23 2009 Mark McLoughlin <markmc@redhat.com> - 2:0.10.6-9
- Disable the vnc CopyRect encoding since it's still broken (#503156)

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/37

------------------------------------------------------------------------
On 2009-10-23T14:41:33+00:00 Jonathan wrote:

Mark: qemu-0.10.6-9.fc11 does indeed fix the issue for me. Thanks very
much for taking the time to look at this.

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/38

------------------------------------------------------------------------
On 2009-10-23T17:05:56+00:00 Patrick wrote:

(In reply to comment #32)
> Mark: qemu-0.10.6-9.fc11 does indeed fix the issue for me. Thanks very mu=
ch for
> taking the time to look at this.  =


Me too, thanks!

I commented on the web page (showed up as anonymous), but how do I bump
bodhi karma?

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/39

------------------------------------------------------------------------
On 2009-10-27T06:40:46+00:00 Fedora wrote:

qemu-0.10.6-9.fc11 has been pushed to the Fedora 11 testing repository.  If=
 problems still persist, please make note of it in this bug report.
 If you want to test the update, you can install it with =

 su -c 'yum --enablerepo=3Dupdates-testing update qemu'.  You can provide f=
eedback for this update here: http://admin.fedoraproject.org/updates/F11/FE=
DORA-2009-10754

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/40

------------------------------------------------------------------------
On 2009-11-04T12:11:38+00:00 Fedora wrote:

qemu-0.10.6-9.fc11 has been pushed to the Fedora 11 stable repository.
If problems still persist, please make note of it in this bug report.

Reply at: https://bugs.launchpad.net/qemu/+bug/397212/comments/41


** Changed in: fedora
   Importance: Unknown =3D> Medium

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/397212

Title:
  Scrolling artifacts on some guests

Status in QEMU:
  Fix Released
Status in Fedora:
  Fix Released

Bug description:
  Screen doesn't refresh properly when scrolling (see the attachment).

  The behavior is seen on RHEL 4.8 and SLES 11, but not on RHEL 5.3.
  However, on RHEL5.3, scrolling is very sluggish.  It seems to be a
  trade-off between quick movement and frequent / accurate refreshing.

  Command line:

  qemu-system-x86_64 -m 2048 -drive file=3D/scratch/images/SLES-11-GMC-
  x86_64.raw -net nic,vlan=3D0,macaddr=3DDE:AD:BE:EF:88:95,model=3Drtl8139
  -net tap -vnc :40 -boot cd -monitor stdio -smp 4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/397212/+subscriptions
