Received: from eggs.gnu.org ([2001:4830:134:3::10]:36421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccDNK-0005aj-Ot
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccDNK-0006Kx-14
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:44:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ccDNJ-0006KA-R7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:44:41 -0500
Date: Fri, 10 Feb 2017 15:44:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170210154435.GF13357@work-vm>
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] COLO: fix some bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> Hi,
> 
> This series fix three bugs of COLO. 
> patch 1 fix one usage case which users want to change checkpoint-delay
> with an extream big value set before, the new value may not take effect
> until finishing a long time of sleep.
> 
> Patch 2 and 3 are old patches that split from previous version
> long time ago, and has been reviewed by Dave.
> 
> I'd like to pick these three patches from the later COLO series,
> which will include some optimization and integrating with block
> replication and COLO net proxy.
> 
> Please review, thanks.

Queued.
I've added the '(Since 2.9)' that Eric asked for.

Dave

> 
> 
> zhanghailiang (3):
>   COLO: fix setting checkpoint-delay not working properly
>   COLO: Shutdown related socket fd while do failover
>   COLO: Don't process failover request while loading VM's state
> 
>  include/migration/colo.h      |   2 +
>  include/migration/migration.h |   8 ++++
>  migration/colo.c              | 102 +++++++++++++++++++++++++++++++++++++-----
>  migration/migration.c         |   3 ++
>  qapi-schema.json              |   4 +-
>  5 files changed, 108 insertions(+), 11 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
