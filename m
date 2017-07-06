Received: from eggs.gnu.org ([2001:4830:134:3::10]:47981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTFoD-0007KM-Qw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTFoD-0005Ku-4Z
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:03:41 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-3-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1362c967-0b9a-d37c-0b32-b01dc6984382@redhat.com>
Date: Thu, 6 Jul 2017 19:03:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/17] hbitmap: Rename
 serialization_granularity to serialization_align
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
> The only client of hbitmap_serialization_granularity() is dirty-bitmap's
> bdrv_dirty_bitmap_serialization_align().  Keeping the two names consistent
> is worthwhile, and the shorter name is more representative of what the
> function returns (the required alignment to be used for start/count of
> other serialization functions, where violating the alignment causes
> assertion failures).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

One of the two hard problems in computer science.

Reviewed-by: John Snow <jsnow@redhat.com>
