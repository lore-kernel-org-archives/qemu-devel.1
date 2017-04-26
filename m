Received: from eggs.gnu.org ([2001:4830:134:3::10]:49586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHa-0001UB-2O
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHW-0002Kp-70
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:02 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 26 Apr 2017 15:46:46 +0200
Message-Id: <20170426134649.9042-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qemu-img/convert: Some small fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This series fixes some small issues in qemu-img's convert subcommand.


v2:
- Not CC'd to qemu-stable: This is mostly a rebase onto block-next, and
  the patches that make a difference will not appear in qemu-stable.
  Therefore, if this is merged, v1 will be good for qemu-stable.
- Dropped the old patch 1, it became superfluous
- (New) patch 2: Rebased onto block-next
  - %s/bs_n/s.src_num/g
  - The block that's removed no longer sets ret to -1; but we still have
    to do this in the block that's added (and don't set it to -EINVAL
    there because all the places around it use -1 as well and -EINVAL
    would thus look weird).
- (New) patch 3: Added, as reported by Eric


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[----] [-C] 'qemu-img/convert: Use @opts for one thing only'
002/3:[0007] [FC] 'qemu-img/convert: Move bs_n > 1 && -B check down'
003/3:[down] 'qemu-img: Document backing options'


Max Reitz (3):
  qemu-img/convert: Use @opts for one thing only
  qemu-img/convert: Move bs_n > 1 && -B check down
  qemu-img: Document backing options

 qemu-img.c                 | 23 +++++++++++++----------
 qemu-img-cmds.hx           |  8 ++++----
 qemu-img.texi              |  4 ++--
 tests/qemu-iotests/122.out |  4 ++--
 4 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.12.2
