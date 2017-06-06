Received: from eggs.gnu.org ([2001:4830:134:3::10]:60040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIDZZ-00017o-JF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIDZV-0000m1-MC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:26:54 -0400
Date: Tue, 6 Jun 2017 14:26:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170606122645.GC5448@noname.redhat.com>
References: <20170605203845.24351-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605203845.24351-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 05.06.2017 um 22:38 hat Eric Blake geschrieben:
> I found a crasher and some odd behavior while rebasing my
> bdrv_get_block_status series, so I figured I'd get these things
> fixed first.  This is based on top of Max's block branch.
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-status-v4
> 
> Since v3:
> - check all qemu-iotests (patch 1)

Whoops, somehow I ended up applying and reviewing v4 while looking at
the v3 thread... Looks like there really aren't any missing test case
updates any more.

Thanks, applied to the block branch.

Kevin
