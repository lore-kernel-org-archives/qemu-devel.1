Received: from eggs.gnu.org ([2001:4830:134:3::10]:57658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBa8D-0000oF-O3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBa8A-0003LV-Dy
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:11:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:58610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBa8A-0003LK-74
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:11:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBa89-00082X-AV
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:11:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C5072E8031
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:11:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Apr 2018 05:54:14 -0000
From: Thomas Huth <676029@bugs.launchpad.net>
Reply-To: Bug 676029 <676029@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101116134732.17540.19683.malonedeb@wampee.canonical.com>
Message-Id: <152472205501.6639.13987323652576063526.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 676029] Re: Silently fail with wrong vde socket
 dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A fix for this problem has finally been contributed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7587855cd23755a7a6bd

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/676029

Title:
  Silently fail with wrong vde socket dir

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  Using qemu 0.12.5, kvm silently fail with exit code 1 when using -net
  vde and a wrong path for sock. Actually, the sock option is mean to be
  the socket dir of the vde_switch, not the socket itself.

  With -net vde,sock=3D/var/run/vde/vde0/ctl , strace ends with the
  following messages=C2=A0:

  connect(7, {sa_family=3DAF_FILE, path=3D"/var/run/vde/vde0/ctl/ctl"}, 110=
) =3D -1 ENOTDIR (Not a directory)
  close(7)                                =3D 0
  close(8)                                =3D 0
  exit_group(1)                           =3D ?
  root ~# =


  Please add a meaningful message.

  Regards,
  =C3=89tienne

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/676029/+subscriptions
