Received: from eggs.gnu.org ([2001:4830:134:3::10]:46345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eS2mL-0007fG-Gi
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eS2mK-00008f-J7
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:29:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
Date: Thu, 21 Dec 2017 16:28:49 +0100
In-Reply-To: <20171207155102.66622-1-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Thu, 7 Dec 2017 18:50:56 +0300")
Message-ID: <87shc4umku.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/6] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, dgilbert@redhat.com, Eric Blake <eblake@redhat.com>

Looks like you forgot to cc: Eric.  Fixing...

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Here:
>     1. separate export name from device name
>     1.1 several exports per device possible
>     2. add nbd-server-remove
>
> v2:
> 01: add r-bs by Max and Eric, add comment to code (hope you don't mind)
> 03: address export by its name, not by device name
>     make it possible to force-remove export, which is already
>     non-force-removed (thourh new "hidden" field)
> other patches are new
>
> v1:
> Add command to remove nbd export, pair to nbd-server-add.
> The whole thing and description are in patch 02.
>
>
> Vladimir Sementsov-Ogievskiy (6):
>   nbd/server: add additional assert to nbd_export_put
>   qapi: add name parameter to nbd-server-add
>   qapi: add nbd-server-remove
>   iotest 147: add cases to test new @name parameter of nbd-server-add
>   iotests: implement QemuIoInteractive class
>   iotest 201: new test for qmp nbd-server-remove
>
>  qapi/block.json               |  27 ++++++++-
>  include/block/nbd.h           |   3 +-
>  blockdev-nbd.c                |  41 +++++++++++--
>  hmp.c                         |   5 +-
>  nbd/server.c                  |  31 +++++++++-
>  tests/qemu-iotests/147        |  68 +++++++++++++++++-----
>  tests/qemu-iotests/147.out    |   4 +-
>  tests/qemu-iotests/201        | 130 ++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/201.out    |   5 ++
>  tests/qemu-iotests/group      |   1 +
>  tests/qemu-iotests/iotests.py |  38 ++++++++++++
>  11 files changed, 325 insertions(+), 28 deletions(-)
>  create mode 100644 tests/qemu-iotests/201
>  create mode 100644 tests/qemu-iotests/201.out
