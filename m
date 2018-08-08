Received: from eggs.gnu.org ([2001:4830:134:3::10]:60788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnHWn-0007bS-8A
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnHWk-0007ss-LP
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:53690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fnHWk-0007sU-FE
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fnHWj-00056A-8o
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 06:00:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1762B2E8030
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 06:00:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Aug 2018 05:43:03 -0000
From: "Enrico Weigelt, metux IT consult" <1500265@bugs.launchpad.net>
Reply-To: Bug 1500265 <1500265@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150927211256.29032.14479.malonedeb@chaenomeles.canonical.com>
Message-Id: <153370698392.32176.3691935412139348339.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1500265] Re: nested 9p filesystem with
 security_model=mapped-xattr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Interesting approach. But maybe it should be configurable (eg. specify
the mapping prefix).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1500265

Title:
  nested 9p filesystem with security_model=3Dmapped-xattr

Status in QEMU:
  New

Bug description:
  I do not know whether this is a bug or a feature request, but on a 9p
  virtfs with security_model=3Dmapped-xattr, access to extended attributes
  starting with "user.virtfs" coming from the guest seem to be silently
  ignored. Would it not be more correct to use some sort of "escaping",
  say map to "user.virtfs.x" on guest to "user.virtfs.virtfs.x" on host
  or something like that, so that the guest can use arbitrary
  attributes.

  In particular, this would allow nested virtual machines to use nested
  9p virtfs with security_model=3Dmapped-xattr.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1500265/+subscriptions
