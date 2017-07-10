Received: from eggs.gnu.org ([2001:4830:134:3::10]:49381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUgVv-000777-Np
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUgVu-0003B1-Vg
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:46:43 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-7-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ae073841-dda4-e15e-cc2b-cb88a221f83a@redhat.com>
Date: Mon, 10 Jul 2017 17:46:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/17] dirty-bitmap: Change
 bdrv_dirty_bitmap_*serialize*() to take bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> Right now, the dirty-bitmap code exposes the fact that we use
> a scale of sector granularity in the underlying hbitmap to anything
> that wants to serialize a dirty bitmap.  It's nicer to uniformly
> expose bytes as our dirty-bitmap interface, matching the previous
> change to bitmap size.  The only caller to serialization is currently
> qcow2-cluster.c, which becomes a bit more verbose because it is still
> tracking sectors for other reasons, but a later patch will fix that
> to more uniformly use byte offsets everywhere.  Likewise, within
> dirty-bitmap, we have to add more assertions that we are not
> truncating incorrectly, which can go away once the internal hbitmap
> is byte-based rather than sector-based.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
