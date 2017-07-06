Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT80W-0004gw-VP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT80W-0001EC-9B
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:43:53 -0400
Date: Thu, 6 Jul 2017 16:43:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706144341.GK5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-19-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-19-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 18/21] backup: Switch backup_run() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Change the internal
> loop iteration of backups to track by bytes instead of sectors
> (although we are still guaranteed that we iterate by steps that
> are cluster-aligned).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
