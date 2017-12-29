Received: from eggs.gnu.org ([2001:4830:134:3::10]:52761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUlE6-0005iI-Hd
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUlE5-0008Dd-LX
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:20:54 -0500
Date: Fri, 29 Dec 2017 11:20:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229032046.GQ13004@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/20] iscsi: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the iscsi driver accordingly.  In this case,
> it is handy to teach iscsi_co_block_status() to handle a NULL map
> and file parameter, even though the block layer passes non-NULL
> values, because we also call the function directly.  For now, there
> are no optimizations done based on the want_zero flag.
> 
> We can also make the simplification of asserting that the block
> layer passed in aligned values.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
