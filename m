Received: from eggs.gnu.org ([2001:4830:134:3::10]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eid1B-0003GW-Dy
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eid1A-0004Ob-GI
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:24:53 -0500
Date: Mon, 5 Feb 2018 10:24:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180205092443.GB30338@localhost.localdomain>
References: <20180126160411.4033-1-eblake@redhat.com>
	<20180126160411.4033-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180126160411.4033-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PULL 6/8] iotest 205: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Am 26.01.2018 um 17:04 hat Eric Blake geschrieben:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20180119135719.24745-6-vsementsov@virtuozzo.com>
> [eblake: adjust to next available test number]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/205     | 156 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/205.out |   5 ++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 162 insertions(+)
>  create mode 100644 tests/qemu-iotests/205
>  create mode 100644 tests/qemu-iotests/205.out

This test case fails for luks. Maybe it's easy enough to enable luks, or
maybe we have to disable it. Not sure how other Python test cases handle
this. Can you have a look, please?

Kevin
