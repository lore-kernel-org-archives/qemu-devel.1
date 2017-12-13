Received: from eggs.gnu.org ([2001:4830:134:3::10]:38439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eP4Tv-0007s3-Hn
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eP4Tu-0004Gs-QP
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:41:43 -0500
Date: Wed, 13 Dec 2017 11:41:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171213104132.GB3950@localhost.localdomain>
References: <20171212144054.16955-1-edgar.kaziakhmedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212144054.16955-1-edgar.kaziakhmedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: get rid of qcow2_backing_read1
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, klim.kireev@virtuozzo.com

Am 12.12.2017 um 15:40 hat Edgar Kaziakhmedov geschrieben:
> Since bdrv_co_preadv does all neccessary checks including
> reading after the end of the backing file, avoid duplication
> of verification before bdrv_co_preadv call.
> 
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks, applied to block-next.

Kevin
