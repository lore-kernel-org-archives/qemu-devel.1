Received: from eggs.gnu.org ([2001:4830:134:3::10]:59885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fJLV8-00088G-Cb
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fJLV7-00084L-9h
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:11:34 -0400
Date: Thu, 17 May 2018 19:11:08 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180517161108.GA29931@rkaganb.sw.ru>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/17] iotests: don't choke on
 disabled drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, Apr 26, 2018 at 07:19:41PM +0300, Roman Kagan wrote:
> Some iotests assume availability of certain block drivers, and fail if
> the driver is not supported by QEMU because it was disabled at configure
> time.
> 
> This series tries to address that, by making QEMU report the actual list
> of supported block drivers in response to "-drive format=?", and using
> this information to skip the parts of the io testsuite that can not be
> run in this configuration.
> 
> Roman Kagan (17):
>   block: iterate_format with account of whitelisting
>   iotests: iotests.py: prevent deadlock in subprocess
>   iotests: ask qemu for supported formats
>   iotest 030: skip quorum test setup/teardown too
>   iotest 030: require blkdebug
>   iotest 055: skip unsupported backup target formats
>   iotest 055: require blkdebug
>   iotest 056: skip testcases using blkdebug if disabled
>   iotest 071: notrun if blkdebug or blkverify is disabled
>   iotest 081: notrun if quorum is disabled
>   iotest 087: notrun if null-co is disabled
>   iotest 093: notrun if null-co or null-aio is disabled
>   iotest 099: notrun if blkdebug or blkverify is disabled
>   iotest 124: skip testcases using blkdebug if disabled
>   iotest 139: skip testcases using disabled drivers
>   iotest 147: notrun if nbd is disabled
>   iotest 184: notrun if null-co or throttle is disabled
> 
>  include/block/block.h         |  2 +-
>  block.c                       | 23 ++++++++++++++++++----
>  blockdev.c                    |  4 +++-
>  qemu-img.c                    |  2 +-
>  tests/qemu-iotests/030        |  7 +++++++
>  tests/qemu-iotests/055        | 13 ++++++++++++
>  tests/qemu-iotests/056        |  3 +++
>  tests/qemu-iotests/071        |  1 +
>  tests/qemu-iotests/081        |  1 +
>  tests/qemu-iotests/087        |  1 +
>  tests/qemu-iotests/093        |  1 +
>  tests/qemu-iotests/099        |  1 +
>  tests/qemu-iotests/124        |  5 +++++
>  tests/qemu-iotests/139        |  4 ++++
>  tests/qemu-iotests/147        |  1 +
>  tests/qemu-iotests/184        |  1 +
>  tests/qemu-iotests/common.rc  | 19 ++++++++++++++++++
>  tests/qemu-iotests/iotests.py | 46 ++++++++++++++++++++++++++++++++-----------
>  18 files changed, 117 insertions(+), 18 deletions(-)

Ping?
