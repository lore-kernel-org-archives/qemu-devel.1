Received: from eggs.gnu.org ([2001:4830:134:3::10]:49263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1rJN-0003ZS-N1
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1rJN-0000iJ-2K
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:58:53 -0400
Date: Tue, 10 Oct 2017 11:58:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010095836.GG4177@dhcp-200-186.str.redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-14-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-14-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/18] block/mirror: Keep write perm for
 pending writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Am 13.09.2017 um 20:19 hat Max Reitz geschrieben:
> The owner of the mirror BDS might retire its write permission; but there
> may still be pending mirror operations so the mirror BDS cannot
> necessarily retire its write permission for its child then.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

I'm confused. The child of mirror_top_bs is the source, but don't mirror
operations only write to the target?

Kevin
