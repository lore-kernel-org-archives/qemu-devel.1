Received: from eggs.gnu.org ([209.51.188.92]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1go7hS-0007O8-OG
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1go7hQ-00079m-T4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1go7hP-00074u-AM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1go7hG-0000VT-HO
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7D8C22E8037
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Jan 2019 14:07:23 -0000
From: Chen Zhang <1813406@bugs.launchpad.net>
Reply-To: Bug 1813406 <1813406@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154851751023.19548.18254052025186745164.malonedeb@gac.canonical.com>
Message-Id: <154868444340.25279.4992968151914152107.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813406] Re: qemu-img convert malfunction on macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Preliminary debugging seems to hint that wrong image convert status for
some sectors during iteration in convert_do_copy() accumulated a much
smaller allocated_sectors than it should.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813406

Title:
  qemu-img convert malfunction on macOS

Status in QEMU:
  New

Bug description:
  On macOS 10.13.6, `qemu-img convert` failed to convert a qcow2 into a
  new qcow2 (for the purpose of shrinking the image).

  A 50GB (3.7GB allocated) qcow2 image was used as source. The qemu-img
  convert output was a 3.4MB file.

  qemu-img from HomeBrew were tested. Both 2.11.1 and 3.1.0_1 failed to
  convert a qcow2 image.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813406/+subscriptions
