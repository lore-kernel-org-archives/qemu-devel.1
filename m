Received: from eggs.gnu.org ([2001:4830:134:3::10]:33678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1d4p-0001Vg-30
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 15:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1d4l-0007H8-Ug
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 15:19:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1d4l-0007FP-Qg
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 15:19:07 -0400
Date: Thu, 29 Mar 2018 20:18:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180329191855.GI2982@work-vm>
References: <CGME20180322181739eucas1p2b5f31dc21663881bc244deaedec22712@eucas1p2.samsung.com>
	<1521742647-25550-1-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521742647-25550-1-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] postcopy block time calculation +
 ppc32 build fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> V1-V2
>     accidentally appeared __nocheck after rebase
>     this patch set also rebased after latest pull request
> 
> This patch set includes patches which were reverted by commit
> ee86981bd, due to build problem on 32 powerpc/arm architecture.
> Also it includes patch to fix build
> ([PATCH v4] migration: change blocktime type to uint32_t), but that
> patch was merged into:
> migration: add postcopy blocktime ctx into MigrationIncomingState
> migration: calculate vCPU blocktime on dst side
> migration: add postcopy total blocktime into query-migrate

OK, lets get this in when 2.13 opens.

Thanks!

Dave

> 
> based on
> commit c6740fc88ecd8f5cf3cf3185ee112c3eea41caa2
> "hw/rdma: Implementation of PVRDMA device"
> 
> Alexey Perevalov (6):
>   migration: introduce postcopy-blocktime capability
>   migration: add postcopy blocktime ctx into MigrationIncomingState
>   migration: calculate vCPU blocktime on dst side
>   migration: postcopy_blocktime documentation
>   migration: add blocktime calculation into migration-test
>   migration: add postcopy total blocktime into query-migrate
> 
>  docs/devel/migration.rst |  14 +++
>  hmp.c                    |  15 +++
>  migration/migration.c    |  51 ++++++++-
>  migration/migration.h    |  13 +++
>  migration/postcopy-ram.c | 268 ++++++++++++++++++++++++++++++++++++++++++++++-
>  migration/trace-events   |   6 +-
>  qapi/migration.json      |  17 ++-
>  tests/migration-test.c   |  16 +++
>  8 files changed, 392 insertions(+), 8 deletions(-)
> 
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
