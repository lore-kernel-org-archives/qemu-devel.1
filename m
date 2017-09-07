Received: from eggs.gnu.org ([2001:4830:134:3::10]:52521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpvOQ-0000fC-Jz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpvOM-0001N9-0l
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:54:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpvOL-0001M2-Ri
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D464785550
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 11:54:40 +0000 (UTC)
Date: Thu, 7 Sep 2017 12:54:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907115433.GL2098@work-vm>
References: <20170907084230.26493-1-famz@redhat.com>
	<20170907093731.GF2098@work-vm> <20170907113742.GC25123@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907113742.GC25123@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] buildsys: Move rdma libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>

* Fam Zheng (famz@redhat.com) wrote:
> On Thu, 09/07 10:37, Dr. David Alan Gilbert wrote:
> > * Fam Zheng (famz@redhat.com) wrote:
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > OK, I've not actually got a preference as to whether it's
> > per-object or not - I don't really see any advantage.
> 
> Thanks for the review.  You're right this probably doesn't make a difference
> except for a bit more consistency, until we want to make rdma a module (as in
> --enable-modules) like the ones in block layer. The -libs and -cflags variables
> were initially added just for that.
> 
> While we are talking about it, is there any reason why that will not be a good
> idea?  There are other libraries used by QEMU outside block layer that are
> overdue to be converted to modules, like ui (gtk, sdl, etc.), rdma seems to be a
> candidate too.

I don't think we've ever tried to make the migration code modular;
it probably wouldn't be impossible to split it out - it's wired
into a few places but it should be doable.

Dave

> Fam
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
