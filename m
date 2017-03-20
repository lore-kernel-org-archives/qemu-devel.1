Received: from eggs.gnu.org ([2001:4830:134:3::10]:45622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cq6Ww-0007M1-S3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cq6Wt-000125-Jd
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:16:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:56836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cq6Wt-00011k-8j
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:15:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cq6Wr-0000zp-Jy
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 23:15:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA4CE2E80CD
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 23:15:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Mar 2017 23:00:07 -0000
From: Thomas Huth <888150@bugs.launchpad.net>
Reply-To: Bug 888150 <888150@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111109163052.7143.14547.malonedeb@gac.canonical.com>
Message-Id: <20170320230007.19872.87075.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 888150] Re: qemu and qemu.git -> Migration + disk
 stress introduces qcow2 corruptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The URL that you've mentioned in the description is not valid anymore
... can you still reproduce this problem with the latest version of
QEMU, or can we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/888150

Title:
  qemu and qemu.git -> Migration + disk stress introduces qcow2
  corruptions

Status in QEMU:
  Incomplete

Bug description:
  Hi guys, here I am, reporting yet another issue with qemu. This time,
  it's something that was first reported in January, and Juan proposed a
  patch for it:

  http://comments.gmane.org/gmane.comp.emulators.qemu/89009

  [PATCH 4/5] Reopen files after migration

  The symptom is, when running disk stress or any intense IO operation
  in guest while migrating it causes a qcow2 corruption. We've seen this
  consistently on the daily test jobs, both for qemu and qemu-kvm. The
  test that triggers it is autotest stress test running on a VM with
  ping-pong background migration.

  The fix proposed by Juan is on our RHEL branch and such a problem does
  not happen on the RHEL branch. So, what about re-considering Juan's
  patch, or maybe work out a solution that is satisfactory for the
  upstream maintainers?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/888150/+subscriptions
