Received: from eggs.gnu.org ([2001:4830:134:3::10]:56261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e87n5-0005Db-C8
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e87n1-0004UC-9R
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:47:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:52086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e87n0-0004Nx-Vz
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:47:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e87my-0001QZ-FW
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:47:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3B7C82E80CD
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:47:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 16:28:39 -0000
From: Bug Watch Updater <697197@bugs.launchpad.net>
Reply-To: Bug 697197 <697197@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110104122142.23014.63077.malonedeb@gandwana.canonical.com>
Message-Id: <150912171998.4405.2100049521656894163.launchpad@loganberry.canonical.com>
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

Launchpad has imported 5 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D668589.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2011-01-10T20:45:01+00:00 Petr wrote:

Description of problem:
The semantics of the ',password' option to -vnc are that it enables the VNC=
 auth scheme. If the VNC server password is unset or empty string, all atte=
mpts to authenticate with the server will be explicitly blocked.

This allows applications to enable and selectively allow access for a
period of time, before clearing the password again to prevent further
access.

Upstream changes have introduced a flaw by disabling all authentication
when the password was cleared with upstream commit [1].

[1]
http://www.qemu.com/qemu.git/commit/?id=3D52c18be9e99dabe295321153fda7fce9f=
76647ac

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/9

------------------------------------------------------------------------
On 2011-01-28T18:02:42+00:00 Neil wrote:

Created attachment 475841
Fix to vnc password semantics

This patch corrects the flaw in qemu-kvm

Please see http://launchpad.net/bugs/697197 for testing performed.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/15

------------------------------------------------------------------------
On 2011-02-28T11:09:05+00:00 Petr wrote:

Created qemu tracking bugs for this issue

Affects: fedora-all [bug 680886]

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/31

------------------------------------------------------------------------
On 2011-03-10T20:11:32+00:00 errata-xmlrpc wrote:

This issue has been addressed in following products:

  Red Hat Enterprise Linux 6

Via RHSA-2011:0345 https://rhn.redhat.com/errata/RHSA-2011-0345.html

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/32

------------------------------------------------------------------------
On 2012-03-30T17:33:58+00:00 Petr wrote:

Statement:

This issue does not affect versions of kvm package as shipped with Red
Hat Enterprise Linux 5.

Reply at:
https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/697197/comments/33

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
