Received: from eggs.gnu.org ([2001:4830:134:3::10]:49953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz58n-0000pb-ED
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz58m-0000BA-J6
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 14:08:29 -0400
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930195345.23338-3-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <524d5033-8954-ffbd-827e-30acc29b0725@redhat.com>
Date: Mon, 2 Oct 2017 14:08:10 -0400
MIME-Version: 1.0
In-Reply-To: <20170930195345.23338-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] block: Add blkdebug hook for
 copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>



On 09/30/2017 03:53 PM, Eric Blake wrote:
> Make it possible to inject errors on writes performed during a
> read operation due to copy-on-read semantics.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

I suppose our docs DO say "ehh, see block-core.json" so I suppose no
update is necessary :)

Reviewed-by: John Snow <jsnow@redhat.com>
