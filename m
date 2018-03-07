Received: from eggs.gnu.org ([2001:4830:134:3::10]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etW4u-00054a-8u
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etW4p-0006L4-AE
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:13:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etW4p-0006Kn-5N
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:13:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C95C776FB9
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 10:13:38 +0000 (UTC)
Date: Wed, 7 Mar 2018 18:13:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307101325.GP17720@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-21-dgilbert@redhat.com>
	<20180302075107.GM27381@xz-mi> <20180305195513.GW3131@work-vm>
	<20180306033736.GA3615@xz-mi> <20180306105418.GD3096@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306105418.GD3096@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 20/29] postcopy:
 postcopy_notify_shared_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Tue, Mar 06, 2018 at 10:54:18AM +0000, Dr. David Alan Gilbert wrote:

[...]

> > Basically above was what I thought - to record the faulted addresses
> > with specific PostcopyFD when page fault happened, then we may know
> > which page(s) will a PostcopyFD need.  But when with that, we'll
> > possibly need a lock to protect the information (or any other sync
> > method).
> 
> OK, but I think you're suggesting building a whole new data structure to
> know which ones need notifying;  that sounds like a lot of extra
> complexity for not much gain.

Yes we may need a new structure (or just a list of addresses?), and
indeed I have no idea on how that would help us.  I think it depends
on how many useless wakeup we will have, and how expensive is each of
such a wakeup notification.  Again, I think current solution is good
enough as long as we don't see explicit blocker on performance side,
and we can rethink that when really needed.  Thanks,

-- 
Peter Xu
