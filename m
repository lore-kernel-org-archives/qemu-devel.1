Received: from eggs.gnu.org ([2001:4830:134:3::10]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3kf3-0001jS-J8
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3kf2-0004Wt-Rn
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:44:49 -0400
Date: Thu, 27 Apr 2017 16:44:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170427144436.GH4805@noname.str.redhat.com>
References: <1493196046-5607-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493196046-5607-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/1] block: fix alignment
 calculations in bdrv_co_do_zero_pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

Am 26.04.2017 um 10:40 hat Denis V. Lunev geschrieben:
> tail_padding_bytes is calculated wrong. F.e. for
>     offset = 0
>     bytes = 2048
>     align = 512
> we will have tail_padding_bytes = 512 which is definitely wrong. The patch
> fixes that arithmetics.
> 
> Fortunately this problem is harmless, we will have 1 extra allocation and
> free thus there is no need to put this into stable. The problem is here
> from the very beginning.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <famz@redhat.com>

Thanks, applied to block-next.

Kevin
