Received: from eggs.gnu.org ([2001:4830:134:3::10]:57767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcrbd-0006Rx-2X
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcrbY-0002A3-0R
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:18:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcrbX-00029f-S1
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:18:51 -0400
Date: Tue, 10 Jul 2018 13:18:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180710121845.GA37263@work-vm>
References: <20180710091902.28780-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710091902.28780-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 00/10] migration: postcopy
 recovery unit test, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Balamuruhan S <bala24@linux.vnet.ibm.com>

* Peter Xu (peterx@redhat.com) wrote:
> Based-on: <20180627132246.5576-1-peterx@redhat.com>
> 
> Based on the series to unbreak postcopy:
>   Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
>   Message-Id: <20180627132246.5576-1-peterx@redhat.com>

Queued

(Took a bit of manual merging relative to my skip-tcg ppc patch)

> v2:
> - collect r-bs, and t-b for Balamuruhan
> - rename matching_target_page_size to matches_target_page_size [Dave]
> - fixup the race that Dave reported: the 1st patch was added as
>   a new patch (patch 4); the 2nd patch was squashed into the unit test
>   patch (patch 9)
> 
> Please review.  Thanks,
> 
> Peter Xu (10):
>   migration: simplify check to use qemu file buffer
>   migration: loosen recovery check when load vm
>   migration: fix incorrect bitmap size calculation
>   migration: show pause/recover state on dst host
>   tests: introduce migrate_postcopy_* helpers
>   tests: allow migrate() to take extra flags
>   tests: introduce migrate_query*() helpers
>   tests: introduce wait_for_migration_status()
>   tests: add postcopy recovery test
>   tests: hide stderr for postcopy recovery test
> 
>  migration/migration.c  |   2 +
>  migration/ram.c        |  21 +++--
>  migration/savevm.c     |  16 ++--
>  tests/migration-test.c | 205 ++++++++++++++++++++++++++++++++---------
>  4 files changed, 185 insertions(+), 59 deletions(-)
> 
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
