Received: from eggs.gnu.org ([2001:4830:134:3::10]:46244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9RXY-0006ok-L8
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9RXY-0005G1-15
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:37:08 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180411185425.2461-7-mreitz@redhat.com>
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-7-mreitz@redhat.com>
Date: Fri, 20 Apr 2018 10:36:26 +0200
Message-ID: <w5136zqxoj9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 06/13] block: Generalize
 should_update_child() rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 11 Apr 2018 08:54:18 PM CEST, Max Reitz wrote:
> index c4dd1d4bb8..8d63a1b0c1 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -616,6 +616,8 @@ struct BdrvChild {
>      QLIST_ENTRY(BdrvChild) next_parent;
>  };
>  
> +typedef QLIST_HEAD(BdrvChildList, BdrvChild) BdrvChildList;
> +

I forgot to mention this in a previous e-mail, but what's this used for?

Berto
