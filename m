Received: from eggs.gnu.org ([2001:4830:134:3::10]:33086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9BLp-0008Oy-8M
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9BLo-0006y4-BT
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:19:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180411185425.2461-7-mreitz@redhat.com>
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-7-mreitz@redhat.com>
Date: Thu, 19 Apr 2018 17:19:46 +0200
Message-ID: <w51fu3rcjfx.fsf@maestria.local.igalia.com>
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
> Currently, bdrv_replace_node() refuses to create loops from one BDS to
> itself if the BDS to be replaced is the backing node of the BDS to
> replace it: Say there is a node A and a node B.  Replacing B by A means
> making all references to B point to A.  If B is a child of A (i.e. A has
> a reference to B), that would mean we would have to make this reference
> point to A itself -- so we'd create a loop.
>
> bdrv_replace_node() (through should_update_child()) refuses to do so if
> B is the backing node of A.  There is no reason why we should create
> loops if B is not the backing node of A, though.  The BDS graph should
> never contain loops, so we should always refuse to create them.
>
> If B is a child of A and B is to be replaced by A, we should simply
> leave B in place there because it is the most sensible choice.
>
> A more specific argument would be: Putting filter drivers into the BDS
> graph is basically the same as appending an overlay to a backing chain.
> But the main child BDS of a filter driver is not "backing" but "file",
> so restricting the no-loop rule to backing nodes would fail here.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
