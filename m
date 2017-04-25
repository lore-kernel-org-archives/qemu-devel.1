Received: from eggs.gnu.org ([2001:4830:134:3::10]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d329e-0007kD-UU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d329e-0003lQ-6H
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:13:26 -0400
Date: Tue, 25 Apr 2017 23:13:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170425151317.GF13555@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] qemu-io aborts at quit after reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Hi Kevin,

This happens both on master and on your block-next tree:

    $ qemu-io -f raw null-co:// -c 'reopen -r'
    Unexpected error in bdrv_check_perm() at /stor/work/qemu/block.c:1437:
    Block node is read-only
    Aborted

It seems bs->read_only and perms go out of sync when bdrv_reopen() toggles the
former.

Something is missing here?

Fam
