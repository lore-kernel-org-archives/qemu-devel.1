Received: from eggs.gnu.org ([2001:4830:134:3::10]:46473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxUbc-0005rr-Sp
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxUbZ-0002Pu-QG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:23:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3352
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxUbZ-0002NA-0H
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:23:21 -0400
References: <20170406131326.2418-1-quintela@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58EB40CD.60101@huawei.com>
Date: Mon, 10 Apr 2017 16:22:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170406131326.2418-1-quintela@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Disable hotplug during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 2017/4/6 21:13, Juan Quintela wrote:
> Hi
>
> This updates patches with all the comments received.
> I move qdev_unplug() to make linux-user compile.
>
> Please, review.
>
>
> [RFC - v1]
> This series disable hotplug/unplug during migration.  Thank to Markus
> for explaining where I had to put the checks.  Why?  Because during
> migration we will fail if there are changes.  For instance, in
> postcopy, if we add a memory region, we would failing.  Same for other
> devices if they are not setup exactly the same on destination.
>
> Iidea would be to disable it, andthen enable for the thing that we know that work.
>
> This series are on top of my previous RAMState v2 serie.
>
> Commets, please?

Make sense, this will benefit COLO too :)

After the types found by Eric be fixed in patch 5,
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

> Thanks, Juan.
>
>
> *** BLURB HERE ***
>
> Juan Quintela (5):
>    qdev: qdev_hotplug is really a bool
>    qdev: Export qdev_hot_removed
>    qdev: Move qdev_unplug() to qdev-monitor.c
>    migration: Disable hotplug/unplug during migration
>    ram: Remove migration_bitmap_extend()
>
>   exec.c                  |  1 -
>   hw/core/qdev.c          | 40 +++-------------------------------------
>   include/exec/ram_addr.h |  2 --
>   include/hw/qdev-core.h  |  3 ++-
>   migration/ram.c         | 34 ----------------------------------
>   qdev-monitor.c          | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 50 insertions(+), 75 deletions(-)
>
