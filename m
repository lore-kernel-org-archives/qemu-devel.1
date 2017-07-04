Received: from eggs.gnu.org ([2001:4830:134:3::10]:53298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSILn-0002E9-JX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSILm-00068Y-Ui
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:34:23 -0400
Date: Tue, 4 Jul 2017 15:34:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704073410.GE10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/15] block: Make
 bdrv_round_to_clusters() signature more useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Mon, 07/03 17:14, Eric Blake wrote:
> In the process of converting sector-based interfaces to bytes,
> I'm finding it easier to represent a byte count as a 64-bit
> integer at the block layer (even if we are internally capped
> by SIZE_MAX or even INT_MAX for individual transactions, it's
> still nicer to not have to worry about truncation/overflow
> issues on as many variables).  Update the signature of
> bdrv_round_to_clusters() to uniformly use int64_t, matching
> the signature already chosen for bdrv_is_allocated and the
> fact that off_t is also a signed type, then adjust clients
> according to the required fallout.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
