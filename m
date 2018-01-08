Received: from eggs.gnu.org ([2001:4830:134:3::10]:40542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSUA-00045W-OW
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSU9-00056L-SL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 03:08:46 -0500
Date: Mon, 8 Jan 2018 16:08:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180108080838.GD5443@lemon.usersys.redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
	<20180105225753.30509-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105225753.30509-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 06/20] iscsi: Switch
 iscsi_allocmap_update() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, jcody@redhat.com, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 01/05 16:57, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert all uses of
> the allocmap (no semantic change).  Callers that already had bytes
> available are simpler, and callers that now scale to bytes will be
> easier to switch to byte-based in the future.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
