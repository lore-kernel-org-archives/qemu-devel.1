Received: from eggs.gnu.org ([2001:4830:134:3::10]:44785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0is-0004QP-OO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0io-0002Tg-HH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:59:50 -0400
Date: Wed, 30 Aug 2017 11:59:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830105941.GK24565@stefanha-x1.localdomain>
References: <20170829120836.16091-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829120836.16091-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] misc: Remove unused Error variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Aug 29, 2017 at 03:08:36PM +0300, Alberto Garcia wrote:
> There's a few cases which we're passing an Error pointer to a function
> only to discard it immediately afterwards without checking it. In
> these cases we can simply remove the variable and pass NULL instead.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow.c  | 12 +++---------
>  block/qcow2.c |  8 ++------
>  dump.c        |  4 +---
>  3 files changed, 6 insertions(+), 18 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan
