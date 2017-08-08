Received: from eggs.gnu.org ([2001:4830:134:3::10]:60893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S4-00016t-H7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S0-0006dH-J8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df6S0-0006cp-Cq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3753885546
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 15:29:43 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-237.ams2.redhat.com
	[10.36.116.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9910770959
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 15:29:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  8 Aug 2017 17:29:32 +0200
Message-Id: <20170808152941.11247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Misc patches for 2017-08-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c233a35d3d91af666aa95a6a3ba8244d4ce728=
c6:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170803' into =
staging (2017-08-04 13:03:58 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f5048cb7517348a20ba202e435e1006a8f5001cf:

  maint: Include bug-reporting info in --help output (2017-08-08 17:28:53=
 +0200)

----------------------------------------------------------------
* --help/--version improvements (Eric)
* GCC 7 workaround (Greg)
* Small SCSI fix (Hannes)
* SSE 4.1 fix (Joseph)
* RCU deadlock fix (myself)

----------------------------------------------------------------
Eric Blake (4):
      qemu-img: Sort sub-command names in --help
      qemu-io: Give more --version information
      qga: Give more --version information
      maint: Include bug-reporting info in --help output

Greg Kurz (1):
      kvm: workaround build break on gcc-7.1.1 / fedora26

Hannes Reinecke (1):
      scsi: clarify sense codes for LUN0 emulation

Joseph Myers (1):
      target/i386: set rip_offset for some SSE4.1 instructions

Paolo Bonzini (2):
      rcu: completely disable pthread_atfork callbacks as soon as possibl=
e
      Revert "rcu: do not create thread in pthread_atfork callback"

 bsd-user/main.c         |  2 ++
 hw/scsi/scsi-bus.c      |  7 ++++++-
 include/qemu-common.h   |  5 +++++
 include/qemu/rcu.h      |  7 ++++++-
 include/sysemu/kvm.h    | 14 ++++----------
 linux-user/main.c       |  4 +++-
 linux-user/syscall.c    |  1 -
 os-posix.c              |  2 --
 qemu-img-cmds.hx        | 22 +++++++++++++---------
 qemu-img.c              |  2 +-
 qemu-io.c               |  9 ++++++---
 qemu-nbd.c              |  2 +-
 qga/main.c              |  8 +++++---
 target/i386/translate.c |  1 +
 util/rcu.c              | 30 +++++++++++++++++++++++++++---
 vl.c                    |  5 ++++-
 16 files changed, 84 insertions(+), 37 deletions(-)
--=20
2.13.3
