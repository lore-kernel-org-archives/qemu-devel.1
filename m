Received: from eggs.gnu.org ([2001:4830:134:3::10]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzJ4w-0001Dj-Sl
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzJ4j-0002cD-2F
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:01:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:59326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzJ4i-0002Zo-TL
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:01:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzJ4h-0001Iq-CR
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 09:01:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5AF182E8053
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 09:01:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 08:48:52 -0000
From: Thomas Huth <1720971@bugs.launchpad.net>
Reply-To: Bug 1720971 <1720971@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150701947111.21373.726890493033526338.malonedeb@soybean.canonical.com>
Message-Id: <150702053267.28375.16586410113667065151.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1720971] Re: qemu/hw/block/onenand.c:522: strange
 if statement ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

*** This bug is a duplicate of bug 1715007 ***
    https://bugs.launchpad.net/bugs/1715007

** This bug has been marked a duplicate of bug 1715007
   hw/block/onenand.c:520: dead code ?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1720971

Title:
  qemu/hw/block/onenand.c:522: strange if statement ?

Status in QEMU:
  New

Bug description:
  [qemu/hw/block/onenand.c:523]: (warning) Opposite inner 'if' condition
  leads to a dead code block.

  Source code is

         for (b =3D 0; b < s->blocks; b ++) {
              if (b >=3D s->blocks) {
                  s->status |=3D ONEN_ERR_CMD;
                  break;
              }

  Inner if condition will never be true.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1720971/+subscriptions
