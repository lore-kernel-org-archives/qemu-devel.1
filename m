Received: from eggs.gnu.org ([2001:4830:134:3::10]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3dQv-0000Au-5i
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3dQr-0000Uk-1B
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:06:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f3dQq-0000UI-T2
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:06:12 -0400
Date: Wed, 4 Apr 2018 16:06:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180404080600.GA10540@xz-mi>
References: <bb088a1ba2e344273db32402f7c9fae4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb088a1ba2e344273db32402f7c9fae4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com

On Wed, Apr 04, 2018 at 11:55:14AM +0530, Balamuruhan S wrote:

[...]

> > too. So still I'll put aside the "which one is better" question.
> > 
> > For your use case, you can have a look on either of below way to
> > have a converged migration:
> > 
> > - auto-converge: that's a migration capability that throttles CPU
> >   usage of guests
> 
> I used auto-converge option before hand and still it doesn't help
> for migration to complete

Have you digged about why?  AFAIK auto-convergence will at last absort
merely the whole vcpu resource (99% of them maximum).  Maybe you are
not with the best throttle values?  Or do you think that could be a
auto-convergence bug too?

> 
> > 
> > - postcopy: that'll let you start the destination VM even without
> >   transferring all the RAMs before hand
> 
> I am seeing issue in postcopy migration between POWER8(16M) -> POWER9(1G)
> where the hugepage size is different. I am trying to enable it but host
> start
> address have to be aligned with 1G page size in ram_block_discard_range(),
> which I am debugging further to fix it.

I thought the huge page size needs to be matched on both side
currently for postcopy but I'm not sure.  CC Dave (though I think
Dave's still on PTO).

-- 
Peter Xu
