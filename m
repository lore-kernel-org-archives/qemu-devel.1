Received: from eggs.gnu.org ([209.51.188.92]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFEDQ-0001hr-9b
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hFEDP-0007Dx-9N
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:40:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:47834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hFEDP-0007DO-0r
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:40:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hFEDN-0001gC-Mf
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 08:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A42AB2E804E
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 08:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Apr 2019 08:31:03 -0000
From: Joachim Durchholz <jo@durchholz.org>
Reply-To: Bug 1824616 <1824616@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155514426371.20376.231958396525560199.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824616] [NEW] Build succeeds despite flex/bison
 missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I just built qemu using a fresh install, and "make" would report success
despite messages of "flex: command not found" and "bison: command not
found".

I didn't notice any errors, but I don't know whether that's because
there's a workaround in case the tools aren't there, or because I didn't
exercize the code paths that would fail.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824616

Title:
  Build succeeds despite flex/bison missing

Status in QEMU:
  New

Bug description:
  I just built qemu using a fresh install, and "make" would report
  success despite messages of "flex: command not found" and "bison:
  command not found".

  I didn't notice any errors, but I don't know whether that's because
  there's a workaround in case the tools aren't there, or because I
  didn't exercize the code paths that would fail.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824616/+subscriptions
