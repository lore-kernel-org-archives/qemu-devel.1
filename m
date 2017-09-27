Received: from eggs.gnu.org ([2001:4830:134:3::10]:53204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxH7x-0002eu-UY
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxH7x-0002n4-8o
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 14:32:09 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-12-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8cba5202-fa3f-bd94-d9a1-2a300bc6ddf5@redhat.com>
Date: Wed, 27 Sep 2017 14:31:56 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/23] block: Switch
 bdrv_co_get_block_status_above() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> type (no semantic change), and rename it to match the corresponding
> public function rename.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>


Reviewed-by: John Snow <jsnow@redhat.com>
