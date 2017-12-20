Received: from eggs.gnu.org ([2001:4830:134:3::10]:44700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRbob-0001dC-BU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRboW-0003kf-SN
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:41:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:47092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRboW-0003iV-N7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:41:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRboS-000317-JP
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 10:41:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C67DE2E80E8
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 10:41:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Dec 2017 10:31:55 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1739304 <1739304@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151372207410.18061.3050483309114042068.malonedeb@chaenomeles.canonical.com>
Message-Id: <151376591662.17755.1284403896485862270.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1739304] Re: Passing a directory to (eg.) -cdrom
 results in misleading error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yep, can repeat it here, it seems pretty random which error it gives:

[dgilbert@dgilbert-t530 try]$ ./x86_64-softmmu/qemu-system-x86_64 -cdrom /t=
mp
qemu-system-x86_64: -cdrom /tmp: Could not refresh total sector count: Inva=
lid argument
[dgilbert@dgilbert-t530 try]$ ./x86_64-softmmu/qemu-system-x86_64 -cdrom /v=
ar
qemu-system-x86_64: -cdrom /var: Could not read image for determining its f=
ormat: File too large


** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1739304

Title:
  Passing a directory to (eg.) -cdrom results in misleading error
  message

Status in QEMU:
  Confirmed

Bug description:
  For example:

      qemu-system-x86_64 -cdrom /path/to/directory

  Results in:

      Could not read image for determining its format: File too large

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1739304/+subscriptions
