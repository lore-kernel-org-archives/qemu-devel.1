Received: from eggs.gnu.org ([2001:4830:134:3::10]:54189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drkfX-0004QG-Md
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drkfW-0002B5-Vz
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:51:59 -0400
Date: Tue, 12 Sep 2017 14:51:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170912125147.GJ29136@localhost.localdomain>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-5-pbonzini@redhat.com>
	<20170912103148.GE29136@localhost.localdomain>
	<1cd3ab85-9f8c-35cf-6ac7-77474e6e6e4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd3ab85-9f8c-35cf-6ac7-77474e6e6e4e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/12] qemu-iotests: limit
 non-_PROG-suffixed variables to common.rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 12.09.2017 um 14:28 hat Paolo Bonzini geschrieben:
> On 12/09/2017 12:31, Kevin Wolf wrote:
> > Hm, does this mean that instead of ./check failing when a binary is
> > missing, we try each test case now and each one fails with the same
> > error message?
> > 
> > *tries it out*
> > 
> > Okay, it's already broken today because the strings are never empty but
> > contain the name of the wrapper functions, but it's still bad behaviour.
> > Instead of just telling me that the binary is missing like it used to
> > work, I get tons of test case diffs.
> 
> So the patch is still dead code, isn't it?

Yes. But instead of moving it to a place where this ugly failure mode
becomes intentional, we should just fix the check and keep doing it once
at the start of ./check.

Kevin
