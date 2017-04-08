Received: from eggs.gnu.org ([2001:4830:134:3::10]:54878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwhDu-0000S8-F6
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 23:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwhDt-00038q-Hm
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 23:39:38 -0400
Date: Sat, 8 Apr 2017 11:39:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170408033925.GB6548@lemon>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-7-famz@redhat.com>
	<20170407132850.GG16146@stefanha-x1.localdomain>
	<6f0d8984-d781-9dc3-a175-5428da83c6f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0d8984-d781-9dc3-a175-5428da83c6f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] tests/block-job-txn: Don't start
 block job before adding to txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, 04/07 14:05, John Snow wrote:
> 
> 
> On 04/07/2017 09:28 AM, Stefan Hajnoczi wrote:
> > On Fri, Apr 07, 2017 at 02:54:14PM +0800, Fam Zheng wrote:
> >> Previously, before test_block_job_start returns, the job can already
> >> complete, as a result, the transactional state of other jobs added to
> >> the same txn later cannot be handled correctly.
> >>
> >> Move the block_job_start() calls to callers after
> >> block_job_txn_add_job() calls.
> >>
> >> Signed-off-by: Fam Zheng <famz@redhat.com>
> >> ---
> >>  tests/test-blockjob-txn.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > CCing John Snow because he looked at block jobs completing during txn
> > setup recently.
> > 
> > Stefan
> > 
> 
> This matches the changes we made to qmp_transaction, but I forgot to (or
> didn't take care to)  change the qtest as it didn't cause a regression
> at the time.
> 
> I wonder if I should make it a runtime error to add a job to a
> transaction which has already "started" to make sure that this interface
> is not misused, as this test highlights that there were still some
> remaining "bad" uses of the interface.
> 
> Regardless...
> 
> Thanks for the CC. ACK

So, shall we merge this for 2.9?

Fam
