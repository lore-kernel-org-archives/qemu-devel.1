Received: from eggs.gnu.org ([2001:4830:134:3::10]:52882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cl1Ya-0005OO-RR
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cl1YX-0005Ld-Ln
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:56:44 -0500
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <0ebee96b-163e-16f1-d442-071020037005@openvz.org>
Date: Mon, 6 Mar 2017 17:23:20 +0300
MIME-Version: 1.0
In-Reply-To: <20170225193155.447462-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] some migration bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, jsnow@redhat.com, lirans@il.ibm.com

On 02/25/2017 10:31 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>
> Here are some migration related bugs, two about INACTIVE bdses and one
> use-after-free.
>
> I'm absolutely not sure, that these bugs should be fixed like I'm fixing,
> but problem definitely exists.
>
> Reset in stopped state is strange case, may be such usage should be
> restricted.
> About INACTIVE - looks like it should be a separate run-state, not only
> bdrv-flag.
> Situation with migration state, which is global, but is set/reset/changed
> in not controlled manner is not very good too..
>
> Vladimir Sementsov-Ogievskiy (4):
>   iotests: add migration corner cases test
>   qmp-cont: invalidate on RUN_STATE_PRELAUNCH
>   savevm: fix savevm after migration
>   migration: fix use-after-free of to_dst_file
>
>  block/snapshot.c           |  3 +-
>  migration/savevm.c         | 16 +++++++++++
>  qmp.c                      |  3 +-
>  tests/qemu-iotests/175     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/175.out |  5 ++++
>  tests/qemu-iotests/group   |  1 +
>  6 files changed, 97 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qemu-iotests/175
>  create mode 100644 tests/qemu-iotests/175.out
>
guys, what about patches 1-3?

Den
