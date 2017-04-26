Received: from eggs.gnu.org ([2001:4830:134:3::10]:44993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3OkW-0002Xa-5f
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3OkV-0007M4-HO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:21:00 -0400
Date: Wed, 26 Apr 2017 17:20:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170426152044.GN4538@noname.str.redhat.com>
References: <20170426020349.25257-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426020349.25257-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Remove NULL check in bdrv_co_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 26.04.2017 um 04:03 hat Fam Zheng geschrieben:
> Reported by Coverity. We already use bs in bdrv_inc_in_flight before
> checking for NULL. It is unnecessary as all callers pass non-NULL bs, so
> drop it.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to block-next.

Kevin
