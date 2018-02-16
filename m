Received: from eggs.gnu.org ([2001:4830:134:3::10]:49508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emin5-0003VE-A5
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emimz-0000Dx-So
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:23:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emimz-0000DR-72
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:23:09 -0500
Date: Fri, 16 Feb 2018 16:23:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180216162304.GA2309@work-vm>
References: <20180213125143.23488-1-dgilbert@redhat.com>
	<20180216155651.GA17727@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216155651.GA17727@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] monitor.c: Fix infinite loop in monitor's
 auto-complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, t.pagef.lt@gmail.com, qemu-devel@nongnu.org

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Tue, Feb 13, 2018 at 12:51:43PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> 
> Please include the details of how to trigger this bug.  This helps
> justify the patch as well as aiding anyone investigating/backporting the
> same issue in the future.

OK, I'll include Dimitris's:
   The QEMU monitor enters an infinite loop when trying to auto-complete commands
   that accept only optional parameters. The commands currently affected by this
   issue are 'info registers' and 'info mtree'.

> Aside from that:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks!

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
