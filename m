Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E8CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 00:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3C9208DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 00:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3C9208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHyUQ-0001FJ-9j
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 20:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHyTo-0000pO-43
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 20:05:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:39152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHyTk-0005TP-Jb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 20:05:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kHyTi-0002E1-Gc
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 00:05:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7A46A2E80E7
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 00:05:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2020 23:57:04 -0000
From: Bug Watch Updater <1894869@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=debian; sourcepackage=None; component=None;
 status=In Progress; importance=Unknown; assignee=None; 
X-Launchpad-Bug-Tags: chelsio t4
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 1butteryadmin alex-l-williamson stefan-proxmox
X-Launchpad-Bug-Reporter: Nick Bauer (1butteryadmin)
X-Launchpad-Bug-Modifier: Bug Watch Updater (bug-watch-updater)
References: <159958042175.17914.10047848067927369523.malonedeb@soybean.canonical.com>
Message-Id: <160012782570.5109.7874787719760308582.launchpad@loganberry.canonical.com>
Subject: [Bug 1894869] Re: Chelsio T4 has old MSIX PBA offset bug
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 2fdbaa0303e8b29043b832341602be001a65bf02
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 16:10:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1894869 <1894869@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Launchpad has imported 14 comments from the remote bug at
https://bugzilla.proxmox.com/show_bug.cgi?id=3D2969.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2020-08-28T06:29:13+00:00 Nick Bauer wrote:

There exists a bug with Chelsio NICs that causes the following error:

kvm: -device vfio-
pci,host=3D0000:83:00.7,id=3Dhostpci1.7,bus=3Dpci.0,addr=3D0x11.7: vfio
0000:83:00.7: hardware reports invalid configuration, MSIX PBA outside
of specified BAR

This bug was fixed in later versions of Qemu, and is caused by vendor
misconfigurations of their MSIX PBA. I know a catchall fix was
implemented in recent versions of Qemu, as well as patches applied to
hotfix it in earlier versions. I encountered this bug using a Chelsio T4
device, and I believe the patches are for T5 and newer.

Here is an email chain that has a patch for this situation:
https://patchwork.ozlabs.org/project/qemu-devel/patch/1435777545-32152-1-gi=
t-send-email-glaupre@chelsio.com/

I'd appreciate it if anyone could tell me what the best course of action
to fix it on my system would be. I assume the solution is to either
build Qemu with this patch applied, or update the version of Qemu in my
Proxmox installation, but I do not know which is the better route to go.

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/0

------------------------------------------------------------------------
On 2020-08-31T08:33:54+00:00 Stefan wrote:

The patch you mention is already included in our QEMU builds, but as you
correctly said it's only implemented for T5 devices.

You'd have to go about patching your QEMU yourself if you want this to
work, or message the upstream QEMU maintainers to include a fix (or even
better: provide them with the fix :) ).

In any case, a full 'lspci -nnkvv' output for your device (and any
virtual functions thereof) would help.

I've attached a QEMU patch for you to try, it has "0xNNNN" instead of
the actual device ID of your T4, so change that before applying the
patch. No liability of this working at all, here be dragons and if it
breaks everything you're on your own, but I believe it's simple enough
to work, provided the hardware quirk is the same on T4 as on T5.

You can find our QEMU downstream at https://git.proxmox.com/?p=3Dpve-
qemu.git;a=3Dsummary, if you put it in debian/patches/pve and mention the
file in debian/patches/series you should be able to build a pve-qemu
against it. Check out our developer documentation
(https://pve.proxmox.com/wiki/Developer_Documentation) as well.

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/1

------------------------------------------------------------------------
On 2020-08-31T08:34:21+00:00 Stefan wrote:

Created attachment 614
experimental T4 patch, change 0xNNNN to device id

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/2

------------------------------------------------------------------------
On 2020-08-31T22:14:41+00:00 Nick Bauer wrote:

Created attachment 615
Full output of lspci -nnkvv

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/3

------------------------------------------------------------------------
On 2020-08-31T22:15:51+00:00 Nick Bauer wrote:

Created attachment 616
Output of lspci -nnkvv with Chelsio devices only

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/4

------------------------------------------------------------------------
On 2020-09-01T00:57:02+00:00 Nick Bauer wrote:

Thank you so much for your reply! I have attached the lspci you
requested. I think the most recent version of qemu actually has a fix
for all devices that give this error, as there were reports of some HBA
cards also causing it. I would like to try applying your patch, however
for several days now my builds of pve-qemu have been getting stopped by
a missing dependency called libproxmox-backup-qemu0-dev. I have seen
other people on the forums mention that it exists in the repository, but
every time I git clone pve-qemu.git and attempt to build I get the same
error. I thought it would be taken care of by mk-build-deps, but even
that gets stopped by the same missing dependency. Apt install isn't able
to find it either. Would you be able to tell me where I can find this
dependency?

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/5

------------------------------------------------------------------------
On 2020-09-01T07:55:48+00:00 Stefan wrote:

You need to configure our PBS repository to get the library:

# echo "deb http://download.proxmox.com/debian/pbs buster pbstest" >> /etc/=
apt/sources.list.d/pbs.list
# apt update
# apt install libproxmox-backup-qemu0-dev

> I think the most recent version of qemu actually has a fix for all
devices that give this error, as there were reports of some HBA cards
also causing it.

Hm, not sure about that, the patch I added is against our 5.1 build from
the repo. That said, 5.1 is newer than what's currently rolled out, so
you can also try just building the repo version without any patches and
see if that fixes it. That would be nice, since 5.1 will be rolled out
soon-ish anyway :)

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/6

------------------------------------------------------------------------
On 2020-09-02T21:09:43+00:00 Nick Bauer wrote:

I managed to get the package installed. Apparently my sources.list was set =
to jessie instead of buster. Fixing this allowed me to download that packag=
e, however make still fails, but with new errors. Progress! I'll attach the=
 errors, but I understand if helping me fix this is outside of what you're =
willing to help me with.
As a side note, the machine that I am configuring this on is not deployed, =
does not have a deadline for deployment, and has no data stored on it at al=
l. As such, I'm willing to make just about any changes to it that you think=
 might help, or that you may want to test.

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/7

------------------------------------------------------------------------
On 2020-09-02T21:10:29+00:00 Nick Bauer wrote:

Created attachment 618
New errors

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/8

------------------------------------------------------------------------
On 2020-09-03T07:39:49+00:00 Stefan wrote:

Hm, it appears your linker isn't finding the library. Try installing the
'libproxmox-backup-qemu0' package as well, that should have been a
dependency of the -dev package though... Make sure
/usr/lib/libproxmox_backup_qemu.so.0 exists. If you use "make deb" it
also might be necessary to run the build as root.

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/9

------------------------------------------------------------------------
On 2020-09-03T22:37:13+00:00 Nick Bauer wrote:

I ran into problems building it with the patch applied. I know how to
correct those errors, but I decided to check if I could build without
the patches and found that the build fails for other reasons, too. I
have attached the new errors. I have attached the new output.

Just so that I understand it correctly, does the value that
PCI_VENDOR_ID_CHELSIO stores equal 1425? Since I have two of the same
Chelsio NIC installed, would that mean that I have to insert both 8100
and 8300 as my device IDs for my two cards in the patch, and have it
evaluate whether they are equal to the value at vdev->device_id for the
if statement the same way you did? Or should I just be bale to do it
with a single device ID?

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/10

------------------------------------------------------------------------
On 2020-09-03T22:38:37+00:00 Nick Bauer wrote:

Created attachment 620
New errors given by make after installing libproxmox-backup-qemu0

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/11

------------------------------------------------------------------------
On 2020-09-07T09:38:59+00:00 Stefan wrote:

There's no relevant error in the output you posted? You should have two
files 'pve-qemu-kvm_5.1.0-1_amd64.deb' and 'pve-qemu-kvm-
dbg_5.1.0-1_amd64.deb' in the repository root now, which you can install
with 'apt install ./*.deb' or similar. If not, you might need a 'make
clean' before the 'make deb'.

> Just so that I understand it correctly, does the value that
> PCI_VENDOR_ID_CHELSIO stores equal 1425? Since I have two of the same
> Chelsio NIC installed, would that mean that I have to insert both 8100 and
> 8300 as my device IDs for my two cards in the patch, and have it evaluate
> whether they are equal to the value at vdev->device_id for the if stateme=
nt
> the same way you did? Or should I just be bale to do it with a single dev=
ice
> ID?

# rg "PCI_VENDOR_ID_CHELSIO"
  include/hw/pci/pci_ids.h
  219:#define PCI_VENDOR_ID_CHELSIO            0x1425

Yes.

And also yes, if you need two different device IDs you need to add more
clauses to the 'or', e.g.:

    ((vdev->device_id & 0xff00) =3D=3D 0x5800 ||
    (vdev->device_id & 0xff00) =3D=3D 0x8100) ||
    (vdev->device_id & 0xff00) =3D=3D 0x8300)) {

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/12

------------------------------------------------------------------------
On 2020-09-08T15:55:01+00:00 Nick Bauer wrote:

Yes, you were right, I thought the warnings being set to evaluate as
errors would stop the build, but I completely missed where it said it
built the .deb packages. I got it built and installed this time, but I
still get the same error when I attempt to boot a vm with the Chelsio
cards. I have started a bug report with the upstream qemu devs.

Reply at: https://bugs.launchpad.net/qemu/+bug/1894869/comments/15


** Changed in: debian
       Status: Unknown =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894869

Title:
  Chelsio T4 has old MSIX PBA offset bug

Status in QEMU:
  New
Status in Debian:
  In Progress

Bug description:
  There exists a bug with Chelsio NICs T4 that causes the following
  error:

  kvm: -device vfio-
  pci,host=3D0000:83:00.7,id=3Dhostpci1.7,bus=3Dpci.0,addr=3D0x11.7: vfio
  0000:83:00.7: hardware reports invalid configuration, MSIX PBA outside
  of specified BAR

  I discovered this bug on a Proxmox system, and I was working with a
  downstream Proxmox developer to try to fix this issue. They provided
  me with the following change to make from line 1484 of hw/vfio/pci.c:

  static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* is 0x1000, =
so we hard code that here.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vdev->vendor_id=
 =3D=3D PCI_VENDOR_ID_CHELSIO &&
  -            (vdev->device_id & 0xff00) =3D=3D 0x5800) {
  +            ((vdev->device_id & 0xff00) =3D=3D 0x5800 ||
  +             (vdev->device_id & 0xff00) =3D=3D 0x1425)) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0msix->pba_offset =3D 0x1000;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (vdev->ms=
ix_relo =3D=3D OFF_AUTOPCIBAR_OFF) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0error_setg(errp, "hardware reports invalid configuration, "

  However, I found that this did not fix the issue, so the bug appears
  to work differently than the one that was present on the T5 NICs which
  has already been patched. I have attached the output of my lspci
  -nnkvv

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894869/+subscriptions

