Received: from eggs.gnu.org ([2001:4830:134:3::10]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxrje-0004ZN-EZ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxrja-0000Fm-FY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:05:14 -0400
Date: Tue, 11 Apr 2017 11:04:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411090457.GF4516@noname.str.redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 03/10] tests/block-job-txn:
 Don't start block job before adding to txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.04.2017 um 17:05 hat Fam Zheng geschrieben:
> Previously, before test_block_job_start returns, the job can already
> complete, as a result, the transactional state of other jobs added to
> the same txn later cannot be handled correctly.
> 
> Move the block_job_start() calls to callers after
> block_job_txn_add_job() calls.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
