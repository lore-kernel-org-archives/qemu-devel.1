Received: from eggs.gnu.org ([2001:4830:134:3::10]:43005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAxGW-0002oK-NK
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAxGV-0001H8-W7
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:37:16 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170516204724.1617-9-eblake@redhat.com> (Eric Blake's message
	of "Tue, 16 May 2017 15:47:20 -0500")
References: <20170516204724.1617-1-eblake@redhat.com>
	<20170516204724.1617-9-eblake@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 13:37:02 +0200
Message-ID: <8760gzd89t.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 08/12] dirty-bitmap: Change
 bdrv_get_dirty() to take bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> Half the callers were already scaling bytes to sectors; the other
> half can eventually be simplified to use byte iteration.  Both
> callers were already using the result as a bool, so make that
> explicit.  Making the change also makes it easier for a future
> dirty-bitmap patch to offload scaling over to the internal hbitmap.
>
> Remember, asking whether a byte is dirty is effectively asking
> whether the entire granularity containing the byte is dirty, since
> we only track dirtiness by granularity.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
