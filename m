Received: from eggs.gnu.org ([2001:4830:134:3::10]:33446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgToA-0006x2-Pk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgTo5-0007co-Tx
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:06:02 -0500
Date: Wed, 22 Feb 2017 11:05:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222100543.GC4112@noname.str.redhat.com>
References: <20170131115728.5244.21690.stgit@PASHA-ISP>
	<20170131115734.5244.64846.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170131115734.5244.64846.stgit@PASHA-ISP>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: implement bdrv_snapshot_goto
 for blkreplay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Am 31.01.2017 um 12:57 hat Pavel Dovgalyuk geschrieben:
> This patch enables making snapshots with blkreplay used in
> block devices.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Specifically, I think it avoids the blkreplay_open/close sequence. Is
this what is needed to make it work?

We should probably mention in the commit message the exact reason why
implementing .bdrv_snapshot_goto, but not the other snapshot related
callbacks, fixes things. If you confirm my assumption, I can add that
while applying.

Kevin
