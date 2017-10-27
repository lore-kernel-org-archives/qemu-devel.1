Received: from eggs.gnu.org ([2001:4830:134:3::10]:56100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e87mx-0005BO-A4
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e87mv-00043X-M1
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:47:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:51836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e87mv-0003xN-Ca
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:47:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e87mt-0001Je-8r
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:47:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 395F32E80CC
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:47:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 16:28:02 -0000
From: Bug Watch Updater <697197@bugs.launchpad.net>
Reply-To: Bug 697197 <697197@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110104122142.23014.63077.malonedeb@gandwana.canonical.com>
Message-Id: <150912168281.4405.10228554865923789666.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 697197] Re: Empty password allows access to VNC
 in libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 3 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D667097.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2011-01-04T12:30:55+00:00 Neil wrote:

Description of problem:

The help for 'vnc_password' in qemu.conf states "An empty string will
still enable passwords, but be rejected by QEMU effectively preventing
any use of VNC.".

Yet if you set vnc_password=3D"" then you can access the VNC console
without any password prompt at all - just as you can if the entry is
hashed out.

Version-Release number of selected component (if applicable):

libvirtd (libvirt) 0.8.3


How reproducible:

Every time by configuration

Steps to Reproduce:
1. Create a VNC console without a password.
2. Set vnc_password=3D"" in /etc/libvirt/qemu.conf
3. Start up a guest and access the VNC console with a client. =

  =

Actual results:

You get straight into the console with no prompts.


Expected results:

Should have come up with a prompt and rejected the access. Or the
instructions in the qemu.conf file need changing to take account of the
current behaviour.

Additional info:

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/2

------------------------------------------------------------------------
On 2011-01-04T12:48:32+00:00 Neil wrote:

Similarly if you set the passwd attribute to '' in the vnc graphics XML
stanza.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/3

------------------------------------------------------------------------
On 2011-01-07T14:45:34+00:00 Daniel wrote:

This is not a libvirt bug. This is caused by a flaw in particular QEMU
version you are using, which silently disables auth when the password is
set to "". This bug was introduced in QEMU in this bogus commit

commit 52c18be9e99dabe295321153fda7fce9f76647ac
Author: Zachary Amsden <zamsden@redhat.com>
Date:   Thu Jul 30 00:15:01 2009 -1000

    When using stdio monitor and VNC display, one can set or clear a VNC
password; this should set or turn off VNC authentication as well.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/5


** Changed in: libvirt
       Status: Unknown =3D> Invalid

** Changed in: libvirt
   Importance: Unknown =3D> Medium

** Changed in: qemu-kvm
       Status: Unknown =3D> Fix Released

** Changed in: qemu-kvm
   Importance: Unknown =3D> Medium

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/697197

Title:
  Empty password allows access to VNC in libvirt

Status in libvirt:
  Invalid
Status in QEMU:
  Fix Released
Status in qemu-kvm:
  Fix Released
Status in libvirt package in Ubuntu:
  Invalid
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in libvirt source package in Lucid:
  Invalid
Status in qemu-kvm source package in Lucid:
  Fix Released
Status in libvirt source package in Maverick:
  Invalid
Status in qemu-kvm source package in Maverick:
  Fix Released
Status in libvirt source package in Natty:
  Invalid
Status in qemu-kvm source package in Natty:
  Fix Released
Status in libvirt source package in Karmic:
  Invalid
Status in qemu-kvm source package in Karmic:
  Fix Released
Status in qemu-kvm package in Debian:
  Fix Released

Bug description:
  The help in the /etc/libvirt/qemu.conf states

  "To allow access without passwords, leave this commented out. An empty
  string will still enable passwords, but be rejected by QEMU
  effectively preventing any use of VNC."

  yet setting:

  vnc_password=3D""

  allows access to the vnc console without any password prompt just as
  if it is hashed out completely.

  ProblemType: Bug
  DistroRelease: Ubuntu 10.10
  Package: libvirt-bin 0.8.3-1ubuntu14
  ProcVersionSignature: Ubuntu 2.6.35-24.42-server 2.6.35.8
  Uname: Linux 2.6.35-24-server x86_64
  Architecture: amd64
  Date: Tue Jan  4 12:18:35 2011
  InstallationMedia: Ubuntu-Server 10.04.1 LTS "Lucid Lynx" - Release amd64=
 (20100816.2)
  ProcEnviron:
   LANG=3Den_GB.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: libvirt

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/697197/+subscriptions
