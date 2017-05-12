Received: from eggs.gnu.org ([2001:4830:134:3::10]:59472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d8zuE-0003xd-OM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d8zuB-0007Bl-Mb
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:02:10 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d8zuB-000793-3O
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:02:07 -0400
References: <20170511163228.6666-1-quintela@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <59151783.9030508@huawei.com>
Date: Fri, 12 May 2017 10:01:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170511163228.6666-1-quintela@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Remove old MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 2017/5/12 0:32, Juan Quintela wrote:
> Hi
>
> Changes from v1:
>
> - make migrate_block_set_* take a boolean
> - disable block migration in colo to maintain semantics.
>
> Please review, Juan.
>
> [v1]
> Upon a time there were MigrationParms (only used for block migration)
> and then MigrationParams used for everything else.  This series:
>
> - create migration capabilities for block parameters
> - make the migrate command line parameters to use capabilities
> - remove MigrationParams completely
>
> Please, review.
>

Looks good to me, this makes codes more grace.

Reviewed-by:zhanghailiang <zhang.zhanghailiang@huawei.com>


> *** BLURB HERE ***
>
> Juan Quintela (3):
>    migration: Create block capabilities for shared and enable
>    migration: Remove use of old MigrationParams
>    migration: Remove old MigrationParams
>
>   include/migration/block.h     |  3 +++
>   include/migration/migration.h | 14 +++++-------
>   include/migration/vmstate.h   |  1 -
>   include/qemu/typedefs.h       |  1 -
>   include/sysemu/sysemu.h       |  3 +--
>   migration/block.c             | 17 ++------------
>   migration/colo.c              |  7 +++---
>   migration/migration.c         | 52 ++++++++++++++++++++++++++++++++++++-------
>   migration/savevm.c            | 18 +++------------
>   qapi-schema.json              |  7 +++++-
>   10 files changed, 68 insertions(+), 55 deletions(-)
>
