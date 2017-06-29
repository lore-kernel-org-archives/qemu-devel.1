Received: from eggs.gnu.org ([2001:4830:134:3::10]:51596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dQVUP-0007tI-J1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dQVUK-0001JF-Lv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:11:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:59281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dQVUK-0001J6-Fi
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:11:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dQVUH-0004Td-5s
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:11:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B12522E81ED
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:11:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2017 09:04:13 -0000
From: Thomas Huth <1700380@bugs.launchpad.net>
Reply-To: Bug 1700380 <1700380@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149840696740.3624.10086547691536237734.malonedeb@gac.canonical.com>
Message-Id: <149872705315.29588.6127703206346332791.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1700380] Re: commit snapshot image got Permission
 denied error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing, according to comment #2

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1700380

Title:
  commit snapshot image got Permission denied error

Status in QEMU:
  Invalid

Bug description:
  qemu 2.9.0, adm64, start image with -snapshot param, make some changes
  in the image, then:

  $telnet localhost 7000

  (qemu) commit virtio0
  'commit' error for 'virtio0': Permission denied

  Nerver met this problem before, commit is ok. I recently compiled
  v2.9.0, so is there some new param in qemu-qemu-system-x86_64 to avoid
  commit Permission denied?

  Regards.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1700380/+subscriptions
