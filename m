Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnHI5-0003pg-0m
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 01:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fnHI1-0001Zh-P4
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 01:45:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:48858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fnHI1-0001Yg-IW
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 01:45:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fnHHz-0002N7-F3
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 05:45:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4AA132E80CC
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 05:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Aug 2018 05:39:53 -0000
From: "Enrico Weigelt, metux IT consult" <1785902@bugs.launchpad.net>
Reply-To: Bug 1785902 <1785902@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153367731299.17920.17499928996818370996.malonedeb@soybean.canonical.com>
Message-Id: <153370679389.3404.12403179420873139317.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785902] Re: local/9pfs: Too many levels of
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

Turned out that security_model=3Dmapped can't cope with symlinks in the
host file system.

Instead, security_model=3Dpassthrough works as expected. OTOH, I'll have
to check, whether this mode already provides a safe chroot, or guest can
escape and damage the host system.

The wiki page needs some more documentation on that:
https://wiki.qemu.org/Documentation/9psetup

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
