Received: from eggs.gnu.org ([2001:4830:134:3::10]:37775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVNGI-0006Q6-Vr
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVNGI-0006Zw-5j
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:25:26 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-13-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <33a6149c-184d-74c6-3bb6-36cb28adc5bf@redhat.com>
Date: Wed, 12 Jul 2017 15:25:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 12/17] dirty-bitmap: Change
 bdrv_[re]set_dirty_bitmap() to use bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> Some of the callers were already scaling bytes to sectors; others
> can be easily converted to pass byte offsets, all in our shift
> towards a consistent byte interface everywhere.  Making the change
> will also make it easier to write the hold-out callers to use byte
> rather than sectors for their iterations; it also makes it easier
> for a future dirty-bitmap patch to offload scaling over to the
> internal hbitmap.  Although all callers happen to pass
> sector-aligned values, make the internal scaling robust to any
> sub-sector requests.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
