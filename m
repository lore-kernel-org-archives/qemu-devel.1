Received: from eggs.gnu.org ([2001:4830:134:3::10]:42324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTTO0-0003wg-E8
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTTNv-0003yp-Gb
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:01:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:56562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTTNv-0003yZ-BV
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:01:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTTNu-0002Ih-0j
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 13:01:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 02F9A2E80AE
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 13:01:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 12:48:14 -0000
From: Eduardo Habkost <ehabkost@redhat.com>
Reply-To: Bug 1657010 <1657010@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170117063435.21322.40478.malonedeb@gac.canonical.com>
Message-Id: <20170117124814.21415.63567.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1657010] Re: RFE: Please implement -cpu best or a
 CPU fallback option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of having a new CPU model called "best", we can simply make
"-cpu host" available on TCG. I have submitted a patch for this
yesterday:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg422959.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1657010

Title:
  RFE: Please implement -cpu best or a CPU fallback option

Status in QEMU:
  New

Bug description:
  QEMU should implement a -cpu best option or some other way to make
  this work:

  qemu -M pc,accel=3Dkvm:tcg -cpu best

  qemu -M pc,accel=3Dkvm:tcg -cpu host:qemu64

  See also:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1277744#c6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1657010/+subscriptions
