Received: from eggs.gnu.org ([2001:4830:134:3::10]:40124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fn9iv-0008W2-Dn
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 17:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fn9iq-0007q7-E7
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 17:41:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:51980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fn9iq-0007oi-7a
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 17:40:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fn9io-0000L1-3y
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 21:40:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F0DF42E80D9
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 21:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Aug 2018 21:28:32 -0000
From: "Enrico Weigelt, metux IT consult" <1785902@bugs.launchpad.net>
Reply-To: Bug 1785902 <1785902@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153367731299.17920.17499928996818370996.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785902] [NEW] local/9pfs: Too many levels of
 symbolic links
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

Version: 2.9.1

The primary symptom is resolving symlink fails w/ error "too many levels
of symbolic links".

My analysis showed that local_readlink() uses local_open_nofollow() to
open the file and then tries to read it. local_open_nofollow() then
tries to open the file w/ O_NOFOLLOW, which obviously fails if the
requested file is a symlink.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785902

Title:
  local/9pfs: Too many levels of symbolic links

Status in QEMU:
  New

Bug description:
  Version: 2.9.1

  The primary symptom is resolving symlink fails w/ error "too many
  levels of symbolic links".

  My analysis showed that local_readlink() uses local_open_nofollow() to
  open the file and then tries to read it. local_open_nofollow() then
  tries to open the file w/ O_NOFOLLOW, which obviously fails if the
  requested file is a symlink.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785902/+subscriptions
