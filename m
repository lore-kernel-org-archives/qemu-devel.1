Received: from eggs.gnu.org ([2001:4830:134:3::10]:40032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI5q7-0008DG-7d
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 00:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI5q6-0006se-5c
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 00:11:31 -0400
References: <20170605203845.24351-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6c7c070a-313c-2573-3cc5-d1f83c9f0c7f@redhat.com>
Date: Tue, 6 Jun 2017 00:11:20 -0400
MIME-Version: 1.0
In-Reply-To: <20170605203845.24351-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com



On 06/05/2017 04:38 PM, Eric Blake wrote:
> I found a crasher and some odd behavior while rebasing my
> bdrv_get_block_status series, so I figured I'd get these things
> fixed first.  This is based on top of Max's block branch.
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-status-v4
> 
> Since v3:
> - check all qemu-iotests (patch 1)
> 
> 001/4:[0012] [FC] 'qemu-io: Don't die on second open'
> 002/4:[----] [--] 'block: Guarantee that *file is set on bdrv_get_block_status()'
> 003/4:[----] [--] 'block: Simplify use of BDRV_BLOCK_RAW'
> 004/4:[----] [--] 'blkdebug: Support .bdrv_co_get_block_status'
> 
> Eric Blake (4):
>   qemu-io: Don't die on second open
>   block: Guarantee that *file is set on bdrv_get_block_status()
>   block: Simplify use of BDRV_BLOCK_RAW
>   blkdebug: Support .bdrv_co_get_block_status
> 
>  include/block/block.h      |  6 +++---
>  block/blkdebug.c           | 11 +++++++++++
>  block/commit.c             |  2 +-
>  block/io.c                 |  5 +++--
>  block/mirror.c             |  2 +-
>  block/raw-format.c         |  2 +-
>  block/vpc.c                |  2 +-
>  qemu-io.c                  |  7 ++++---
>  tests/qemu-iotests/060.out |  1 +
>  tests/qemu-iotests/114.out |  5 +++--
>  tests/qemu-iotests/153.out |  6 ++++++
>  tests/qemu-iotests/177     |  3 +++
>  tests/qemu-iotests/177.out |  5 +++++
>  13 files changed, 43 insertions(+), 14 deletions(-)
> 

3,4:

Reviewed-by: John Snow <jsnow@redhat.com>
