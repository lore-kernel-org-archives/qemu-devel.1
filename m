Received: from eggs.gnu.org ([2001:4830:134:3::10]:44029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gNirj-00079z-Os
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gNirg-0007V6-Ll
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:29:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gNirg-0007UY-G2
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 13:29:12 -0500
Date: Fri, 16 Nov 2018 18:29:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181116182903.GF2447@work-vm>
References: <20181101021226.6353-1-zhangckid@gmail.com>
	<20181114104720.GB3955@xz-x1>
	<74cca5d1-d2b4-6b44-32fe-332136b8b171@redhat.com>
	<CAFEAcA8SeZfsihEeD0Rvoxtf-9iKjR_dtrXQLy=6MVzM0ZAD0A@mail.gmail.com>
	<CAK3tnvK_QinKras3ojAWksVu3otwKZcwAPrhQDmxQq___A2iGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3tnvK_QinKras3ojAWksVu3otwKZcwAPrhQDmxQq___A2iGA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH V2] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, quintela@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, peterx@redhat.com, qemu-devel@nongnu.org, "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>, f4bug@amsat.org

* Zhang Chen (zhangckid@gmail.com) wrote:
> On Wed, Nov 14, 2018 at 7:17 PM Peter Maydell <peter.maydell@linaro.org>
> wrote:
> 
> > On 14 November 2018 at 11:06, Thomas Huth <thuth@redhat.com> wrote:
> > > On 2018-11-14 11:47, Peter Xu wrote:
> > >> On Thu, Nov 01, 2018 at 10:12:26AM +0800, Zhang Chen wrote:
> > >>> This compilation issue will occur when user use --disable-replication
> > >>> to config Qemu.
> > >>>
> > >>> Reported-by: Thomas Huth <thuth@redhat.com>
> > >>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > >>
> > >> Hi,
> > >>
> > >> How's the status of this patch?  Are we gonna merge it for 3.1?
> > >>
> > >> I just posted a similar one without knowing this (until Dave pointed
> > >> it out).  IMHO it can be a good candidate for 3.1.
> > >
> > > Maybe Peter Maydell could apply this directly to the repo as a built fix?
> >
> > I'd rather it just went through the migration tree, really...
> > it isn't actually breaking any of our travis jobs or other CI.
> >
> >
> Hi Dave,
> 
> What do you think about peter's comments?

Yep, that's fine, as Peter Xu says, Juan's picking it up for the next
one so we should be OK.

Dave

> Thanks
> Zhang Chen
> 
> 
> > thanks
> > -- PMM
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
