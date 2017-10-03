Received: from eggs.gnu.org ([2001:4830:134:3::10]:48507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKn2-0001mI-1y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzKmy-0003Pj-07
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:51:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzKmx-0003O7-Py
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:50:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzKmw-0001vH-FH
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 10:50:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5F01A2E80CC
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 10:50:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 10:40:02 -0000
From: Thomas Huth <1318474@bugs.launchpad.net>
Reply-To: Bug 1318474 <1318474@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140512042017.23765.60559.malonedeb@wampee.canonical.com>
Message-Id: <150702720220.20964.2588406280062187709.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1318474] Re: QEMU update causes Windows
 reactivation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

How did you start QEMU with the new version here? You might need to
specify the correct machine type with the new version to avoid that the
guest sees different hardware (e.g. with the "-machine pc-i440fx-2.0"
option).

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1318474

Title:
  QEMU update causes Windows reactivation

Status in QEMU:
  Incomplete

Bug description:
  After updating QEMU the guest OS's detect new hardware. As a result
  any Windows OS sees it as a significant change in hardware and require
  a reactivation.

  Host OS: Ubuntu 14.04 64-bit

  Guest OS's:
  Windows Server 2003 R2 Enterprise
  Windows Server 2008 R2 Enterprise
  Windows Server 2008 R2 Web
  Windows Server 2008 R2 Data Center

  QEMU version: 2.0.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1318474/+subscriptions
