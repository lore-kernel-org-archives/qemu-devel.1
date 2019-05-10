Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AEAC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0089217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0089217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48248 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAGQ-0000lV-0S
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 14:28:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hPAFY-0000Th-HA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hPAFW-0000Mo-Ts
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:28:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:47586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hPAFW-0000IB-N8
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:28:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hPAFT-0004qA-44
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 18:27:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AFC422E884B
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 18:21:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 May 2019 18:07:35 -0000
From: Bug Watch Updater <1718719@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: product=xserver; status=Unknown; importance=Medium;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
	status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=xorg-server; component=main;
	status=Triaged; importance=Undecided; assignee=tjaalton@ubuntu.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cyphermox fourdan gitlab-migration jadahl janitor
	paelzer powersj seb128 tjaalton
X-Launchpad-Bug-Reporter: Mathieu Trudel-Lapierre (cyphermox)
X-Launchpad-Bug-Modifier: Bug Watch Updater (bug-watch-updater)
References: <150601012428.28823.10384460665730601462.malonedeb@gac.canonical.com>
Message-Id: <155751165750.11270.13117501324011965425.launchpad@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: f2b852ee82b22171156dc8e1aae7f307a2377b77
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1718719] Re: qemu can't capture keys properly
 under wayland
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1718719 <1718719@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Launchpad has imported 9 comments from the remote bug at
https://bugs.freedesktop.org/show_bug.cgi?id=3D102475.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2017-08-30T11:42:57+00:00 Sebastien Bacher wrote:

The Ubuntu maintainer backported the recent change to add keyboard
grabbing to xwayland, with that change the keyboard arrow keys stop
working in kvm

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/0

------------------------------------------------------------------------
On 2017-08-30T12:40:12+00:00 Olivier Fourdan wrote:

Can you please elaborate of what exactly has been backported and the
resulting patches?

Which Wayland compositor do you use?

It's worth noting that the xwayland patches in themselves won't make a
difference *unless* the Wayland compositor implements the corresponding
protocol, and I am aware of none for now (the patch for mutter is still
pending).

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/1

------------------------------------------------------------------------
On 2017-08-30T13:36:16+00:00 Sebastien Bacher wrote:

The Ubuntu diff is
http://launchpadlibrarian.net/334552966/xorg-server_2%3A1.19.3-1ubuntu3_2%3=
A1.19.3-1ubuntu4.diff.gz

it looks like the backported commits are

xwayland-pointer-confine.diff
+d5e2f271ad93e50 xwayland: Remove two unused proc pointers.
+ca17f3e9fd3b59f xwayland: Lock the pointer if it is confined and has no cu=
rsor
+513e3bd3870fdb8 xwayland: Update root window size when desktop size changes
+fafdb0cc9697eb5 xwayland: "Accept" confineTo on InputOnly windows
+c217fcb4c4640ff xwayland: Allow pointer warp on root/None window

xwayland-add-grab-protocol-support.diff
https://cgit.freedesktop.org/xorg/xserver/commit/?id=3D0a448d133

Ubuntu doesn't have any compositor change, it's standard GNOME 3.24 so
there is must be something wrong and it does make a difference without
implementing the protocole.

Note that reverting 0a448d133 does fix the issue

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/2

------------------------------------------------------------------------
On 2017-08-30T14:57:34+00:00 Olivier Fourdan wrote:

Tried reproducing the issue with the arrow keys using the current
Xwayland from master with mutter/gnome-shell from master, using qemu-kvm
with SDL backend (-display sdl) but failedto reproduce, all keys
(including the arrow keys) work fine in the guest.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/3

------------------------------------------------------------------------
On 2017-08-31T16:26:13+00:00 Olivier Fourdan wrote:

Created attachment 133910
Test patch

Can you try the attached patch (this is for testing purpose *only*) and
report back if that makes any difference?

With this patch, if the compositor has no support for Xwayland keyboard
grab protocol as you said you haven't in Ubuntu, Xwayland won't set up
its grab handler at all.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/4

------------------------------------------------------------------------
On 2017-08-31T23:04:19+00:00 Sebastien Bacher wrote:

the patch doesn't seem to make a difference

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/5

------------------------------------------------------------------------
On 2017-09-01T07:15:06+00:00 Olivier Fourdan wrote:

Well, what this patch does is disabling any specific grab handler if the
Xwayland grab protocol is not available, by postponing the setup of
those handler until Xwayland can bind to the relevant interface as
advertised by the compositor.

If the compositor doesn't support the Xwayland grab protocol, then all
those routines are not "enabled" in Xwayland, I don't see how they could
break anything if not used...

Unfortunately, we cannot tell whether or not the compositor supports the
Xwayland grab protocol using something like weston-info because, for
security reasons, the compositor will (should) only advertiset he given
protocl to Xwayland alone and hide it to any other client.

So, if that patch makes no difference, it means that:

 - The Wayland compositor claim to support Xwayland grab protocol but is
buggy and doesn't send all key events as expected

 - Or the problem is completely unrelated to this patch.

So next step for you is to:

 - Check the actual patches applied to mutter in Ubuntu
 - Check what happens at the protocol level

To do so, yo can use the envvar WAYLAND_DEBUG prior to start gnome-shell
(which will spawn Xwayland) so that we can tell what globals are listed
in the wl_registry and see if "zwp_xwayland_keyboard_grab_manager_v1" is
one of them.

e.g., from a console:

  $ WAYLAND_DEBUG=3D1 dbus-run-session -- gnome-shell --display-server
--wayland |& tee ~/wayland-debug.log

The wl_registry globals will be listed at the beginning of the log so
that should be enough to tell if the compositor claims to be supporting
"zwp_xwayland_keyboard_grab_manager_v1".

Then, you can start qemu-kvm as usual and try to press the keys that do
not work, those will be captured in the log as well, so we can tell if
the compositor sends those key events to the client (Xwayland, in which
case the problem lies in Xwayland) or not (in which case the problem
lies in the compositor).

Please attach the "wayland-debug.log" to this bugzilla once you've
performed those tests (but make sure you don't type any sensitive data
in any application while the log is being captured as any key event will
be logged).

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/6

------------------------------------------------------------------------
On 2017-09-01T16:43:07+00:00 Sebastien Bacher wrote:

the issue isn't there when using your debug command but it begins in
that session if gsd-media-keys is started... I'm calling it a week now
but I'm going to poke to it a bit more on monday

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/7

------------------------------------------------------------------------
On 2019-05-10T15:53:05+00:00 Gitlab-migration wrote:

-- GitLab Migration Automatic Message --

This bug has been migrated to freedesktop.org's GitLab instance and has
been closed from further activity.

You can subscribe and participate further through the new bug through
this link to our GitLab instance:
https://gitlab.freedesktop.org/xorg/xserver/issues/706.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1718719/comments/18


** Changed in: xserver
       Status: Incomplete =3D> Unknown

** Bug watch added: gitlab.freedesktop.org/xorg/xserver/issues #706
   https://gitlab.freedesktop.org/xorg/xserver/issues/706

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1718719

Title:
  qemu can't capture keys properly under wayland

Status in QEMU:
  New
Status in XServer:
  Unknown
Status in qemu package in Ubuntu:
  Confirmed
Status in xorg-server package in Ubuntu:
  Triaged

Bug description:
  This appears to be different than the previous similar bugs; patches
  do look to be applied to use libinput in the wayland case. Still:

  unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org

  I am using qemu-system-x86                       1:2.10+dfsg-0ubuntu1
  on artful.

  Many key inputs work correctly, but at boot the system will not
  properly catch the arrow keys, the above error shows up immediately
  after hitting Esc (for instance) to get to the boot menu. Booting from
  CD onto a daily Ubuntu desktop image, I can't navigate the splash
  menu.

  The same works correctly through virt-manager (which uses spice
  AFAICT, but wayland tends to crash when running virt-manager), and
  things work if I switch my session to Xorg rather than wayland.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1718719/+subscriptions

