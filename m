Received: from eggs.gnu.org ([209.51.188.92]:35061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h1C52-0001gG-3A
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h1C4y-0006U2-Ri
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:34:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h1C4y-0006Fh-IG
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:34:04 -0500
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Tue, 5 Mar 2019 15:33:56 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780606B7F4@shsmsx102.ccr.corp.intel.com>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190305152249.GG9811@work-vm>
In-Reply-To: <20190305152249.GG9811@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V3 0/7] Migration/colo: Fix upstream bugs
 when occur failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>


-----Original Message-----
From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]=20
Sent: Tuesday, March 5, 2019 11:23 PM
To: Zhang, Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen <zhangckid@gmail.com>=
; Juan Quintela <quintela@redhat.com>; zhanghailiang <zhang.zhanghailiang@h=
uawei.com>; Markus Armbruster <armbru@redhat.com>; Eric Blake <eblake@redha=
t.com>; qemu-dev <qemu-devel@nongnu.org>
Subject: Re: [PATCH V3 0/7] Migration/colo: Fix upstream bugs when occur fa=
ilover

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> This series focus on COLO failover bug fix and optimization.
>=20
> V3:
>  - Fix grammer issues in patch 4/7.
>  - Add more information in commit log of patch 5/7.

I've queued 1,3,5 but not the others yet, I need to look to do the reviews =
on them.

Sure~ Thank you for your help~

Thanks
Zhang Chen

Dave

> V2:
>  - Add patch 4/7 to handle failover state.
>  - Add new patches to optimize failover status.
>=20
> V1:
>  - Init patch.
>=20
>=20
> Zhang Chen (7):
>   Migration/colo.c: Fix double close bug when occur COLO failover
>   Migration/colo.c: Fix COLO failover status error
>   Migration/colo.c: Make COLO node running after failover
>   Migration/colo.c: Add new COLOExitReason to handle all failover state
>   qapi/migration.json: Remove a variable that doesn't exist in example
>   Migration/colo.c: Add the necessary checks for colo_do_failover
>   Migration/colo.c: Make user obtain the COLO mode info after failover
>=20
>  migration/colo.c      | 69 ++++++++++++++++++++++++++++++-------------
>  migration/migration.c |  3 ++
>  qapi/migration.json   | 17 ++++++-----
>  3 files changed, 61 insertions(+), 28 deletions(-)
>=20
> --
> 2.17.GIT
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
