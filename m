Received: from eggs.gnu.org ([209.51.188.92]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1BuJ-0005XL-Rh
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:23:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1BuI-0001Dk-8A
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:23:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1BuH-00018g-TX
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:23:02 -0500
Date: Tue, 5 Mar 2019 15:22:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190305152249.GG9811@work-vm>
References: <20190303145021.2962-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303145021.2962-1-chen.zhang@intel.com>
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
To: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> This series focus on COLO failover bug fix and optimization.
> 
> V3:
>  - Fix grammer issues in patch 4/7.
>  - Add more information in commit log of patch 5/7.

I've queued 1,3,5 but not the others yet, I need to look 
to do the reviews on them.

Dave

> V2:
>  - Add patch 4/7 to handle failover state.
>  - Add new patches to optimize failover status.
> 
> V1:
>  - Init patch.
> 
> 
> Zhang Chen (7):
>   Migration/colo.c: Fix double close bug when occur COLO failover
>   Migration/colo.c: Fix COLO failover status error
>   Migration/colo.c: Make COLO node running after failover
>   Migration/colo.c: Add new COLOExitReason to handle all failover state
>   qapi/migration.json: Remove a variable that doesn't exist in example
>   Migration/colo.c: Add the necessary checks for colo_do_failover
>   Migration/colo.c: Make user obtain the COLO mode info after failover
> 
>  migration/colo.c      | 69 ++++++++++++++++++++++++++++++-------------
>  migration/migration.c |  3 ++
>  qapi/migration.json   | 17 ++++++-----
>  3 files changed, 61 insertions(+), 28 deletions(-)
> 
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
