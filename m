Received: from eggs.gnu.org ([2001:4830:134:3::10]:35249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fcj0a-0001BK-DD
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fcj0X-0000YV-85
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:08:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fcj0X-0000WB-1j
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:08:05 -0400
Date: Tue, 10 Jul 2018 11:07:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180710030754.GK23001@xz-mi>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180710015640.GA10680@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710015640.GA10680@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/9] migration: postcopy recovery
 unit test, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On Tue, Jul 10, 2018 at 07:26:40AM +0530, Balamuruhan S wrote:
> On Thu, Jul 05, 2018 at 11:17:46AM +0800, Peter Xu wrote:
> > Based-on: <20180627132246.5576-1-peterx@redhat.com>
> > 
> > Based on the series to unbreak postcopy:
> >   Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
> >   Message-Id: <20180627132246.5576-1-peterx@redhat.com>
> > 
> > This series introduce a new postcopy recovery test.  The new test
> > actually helped me to identify two bugs there so fix them as well
> > before 3.0 release.
> > 
> > Patch 1: a trivial cleanup for existing postcopy ram load, which I
> >          found a bit confusing during debugging the problem.
> > 
> > Patch 2-3: two bug fixes that address different issues.  Please see
> >            the commit log for more information.
> > 
> > Patch 4-9: add the postcopy recovery unit test.
> > 
> > Please review.  Thanks,
> 
> Hi Peter, Dave,
> 
> I am sorry, I have missed to include Peter's postcopy-recover fix patchset,
> 
> migration: delay postcopy paused state
> migration: move income process out of multifd
> migration: unbreak postcopy recovery
> migration: unify incoming processing
> 
> Postcopy migration with pause and recover is working fine.
> 
> # QTEST_QEMU_BINARY=./ppc64-softmmu/qemu-system-ppc64
> # ./tests/migration-test
> /ppc64/migration/deprecated: OK
> /ppc64/migration/bad_dest: OK
> /ppc64/migration/postcopy/unix: OK
> /ppc64/migration/postcopy/recovery: OK
> /ppc64/migration/precopy/unix: OK
> 
> But qtest patches in this patchset have to be rebased as commit
> 5fd4a9c97397bc0819a919de7a62ec972ec85260 (tests/migration: Skip tests
> for ppc tcg) have gone in.
> 
> # git am ../postcopy_pause/4.patch 
> Applying: tests: introduce migrate_postcopy_* helpers
> error: patch failed: tests/migration-test.c:351
> error: tests/migration-test.c: patch does not apply
> Patch failed at 0001 tests: introduce migrate_postcopy_* helpers
> The copy of the patch that failed is found in:
>    /home/bala/qemu/.git/rebase-apply/patch
> When you have resolved this problem, run "git am --resolved".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> 
> I have manually reverted it to apply and test your patchset.
> 
> This Patchset is working without any issues.
> 
> Tested-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

Thanks for the quick follow up!  I'll have a look today at the problem
that Dave reported.

Regards,

-- 
Peter Xu
