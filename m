Received: from eggs.gnu.org ([2001:4830:134:3::10]:36668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eizyP-0004tp-8K
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eizyK-0006Xo-9n
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:55:33 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39782)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eizyK-0006XA-19
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:55:28 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 06 Feb 2018 12:55:26 +0300
Message-ID: <20180206095526.26436.86301.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ PATCH  ] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru, laurent@vivier.eu, pavel.dovgaluk@ispras.ru

This set of patches includex fixes from Alex Benn=C3=A9e for fixing
BQL and replay locks after inventing the MTTCG. It also includes some
additional replay patches that makes this set of fixes working.
It is also fixes some vmstate creation (and loading) issues
in record/replay modes:
 - VM start/stop fixes in replay mode
 - overlay creation for blkreplay filter
 - fixes for vmstate save/load in record/replay mode
 - fixes for host clock vmstate

There is also a set of helper scripts written by Alex Benn=C3=A9e
for debugging the record/replay code.

v5 changes:
 - removed patch for narrowing BQL-protected code
 - disabled bdrv_(drain/flush)_all for record/replay mode

v4 changes:
 - removed upstreamed patches
 - added patch for saving async queue state in replay
 - minor fixes

v3 changes:
 - removed upstreamed patches
 - fixed bug with recursive checkpoints
 - fixed bug with icount warp checkpoint

v2 changes:
 - updated lock/unlock logic (as suggested by Paolo Bonzini)
 - updated cpu execution loop to avoid races in setting/resetting exit re=
quest (as suggested by Paolo Bonzini)
 - minor changes

---

Pavel Dovgalyuk (1):
      m68k: implement movep instruction


 target/m68k/translate.c |   53 +++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 53 insertions(+)

--=20
Pavel Dovgalyuk
