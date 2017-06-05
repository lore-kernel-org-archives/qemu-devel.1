Received: from eggs.gnu.org ([2001:4830:134:3::10]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0QV-00012s-7m
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI0QU-0007yP-Fk
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:24:43 -0400
References: <20170511022036.32225-1-eblake@redhat.com>
	<20170511022036.32225-11-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5f3817ff-f30b-3de6-6cb7-8f726167d4ab@redhat.com>
Date: Mon, 5 Jun 2017 18:24:32 -0400
MIME-Version: 1.0
In-Reply-To: <20170511022036.32225-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/20] mirror: Switch mirror_cow_align()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 05/10/2017 10:20 PM, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> function (no semantic change), and add mirror_clip_bytes() as a
> counterpart to mirror_clip_sectors().  Some of the conversion is
> a bit tricky, requiring temporaries to convert between units; it
> will be cleared up in a following patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> 
> ---
> v2: tweak mirror_clip_bytes() signature to match previous patch
> ---
