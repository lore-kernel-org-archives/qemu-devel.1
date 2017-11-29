Received: from eggs.gnu.org ([2001:4830:134:3::10]:58856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK1SZ-00038m-1b
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eK1SU-0000Cm-27
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:27:27 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171129102513.9153-2-pbonzini@redhat.com>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-2-pbonzini@redhat.com>
Date: Wed, 29 Nov 2017 13:27:19 +0100
Message-ID: <w51indtmfrs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/4] block: Expect graph
 changes in bdrv_parent_drained_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org

On Wed 29 Nov 2017 11:25:10 AM CET, Paolo Bonzini wrote:
> From: Kevin Wolf <kwolf@redhat.com>
>
> The .drained_begin/end callbacks can (directly or indirectly via
> aio_poll()) cause block nodes to be removed or the current BdrvChild to
> point to a different child node.
>
> Use QLIST_FOREACH_SAFE() to make sure we don't access invalid
> BlockDriverStates or accidentally continue iterating the parents of the
> new child node instead of the node we actually came from.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Jeff Cody <jcody@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
