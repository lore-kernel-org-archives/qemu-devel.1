Received: from eggs.gnu.org ([2001:4830:134:3::10]:56038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1deqz3-00076t-Tx
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 18:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1deqyz-0005T5-Ak
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 18:58:50 -0400
References: <20170807203007.19033-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4cf8da94-da35-cb20-4a86-978019db6047@redhat.com>
Date: Mon, 7 Aug 2017 18:58:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170807203007.19033-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 0/4] More
 blk_getlength() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org



On 08/07/2017 04:30 PM, Eric Blake wrote:
> Thanks again to Markus for catching these spots.
> 
> Eric Blake (4):
>   vpc: Check failure of bdrv_getlength()
>   qcow: Check failure of bdrv_getlength() and bdrv_truncate()
>   qcow2: Drop debugging dump_refcounts()
>   qcow2: Check failure of bdrv_getlength()
> 
>  block/qcow.c  | 64 +++++++++++++++++++++++++++++++++++++++++------------------
>  block/qcow2.c | 26 ++++--------------------
>  block/vpc.c   |  9 ++++++++-
>  3 files changed, 57 insertions(+), 42 deletions(-)
> 

Reviewed-by: John Snow <jsnow@redhat.com>
