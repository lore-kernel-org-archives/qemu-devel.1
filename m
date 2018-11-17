Received: from eggs.gnu.org ([2001:4830:134:3::10]:57168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gO1bo-0000gx-5V
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 09:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gO1bn-000748-9q
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 09:30:04 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gO1bn-00072n-3L
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 09:30:03 -0500
Received: by mail-wr1-x436.google.com with SMTP id j26-v6so27645779wre.1
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 06:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20181101021226.6353-1-zhangckid@gmail.com>
	<20181114104720.GB3955@xz-x1>
	<74cca5d1-d2b4-6b44-32fe-332136b8b171@redhat.com>
	<CAFEAcA8SeZfsihEeD0Rvoxtf-9iKjR_dtrXQLy=6MVzM0ZAD0A@mail.gmail.com>
	<CAK3tnvK_QinKras3ojAWksVu3otwKZcwAPrhQDmxQq___A2iGA@mail.gmail.com>
	<20181116182903.GF2447@work-vm>
In-Reply-To: <20181116182903.GF2447@work-vm>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 17 Nov 2018 22:29:50 +0800
Message-ID: <CAK3tnvJpxdYhUd=Zdu_MpxBbq257shcbbTyWWr9Q+XiL_ehEJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, peterx@redhat.com, qemu-devel@nongnu.org, "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>, f4bug@amsat.org

On Sat, Nov 17, 2018, 2:29 AM Dr. David Alan Gilbert <dgilbert@redhat.com
wrote:

> * Zhang Chen (zhangckid@gmail.com) wrote:
> > On Wed, Nov 14, 2018 at 7:17 PM Peter Maydell <peter.maydell@linaro.org>
> > wrote:
> >
> > > On 14 November 2018 at 11:06, Thomas Huth <thuth@redhat.com> wrote:
> > > > On 2018-11-14 11:47, Peter Xu wrote:
> > > >> On Thu, Nov 01, 2018 at 10:12:26AM +0800, Zhang Chen wrote:
> > > >>> This compilation issue will occur when user use
> --disable-replication
> > > >>> to config Qemu.
> > > >>>
> > > >>> Reported-by: Thomas Huth <thuth@redhat.com>
> > > >>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > >>
> > > >> Hi,
> > > >>
> > > >> How's the status of this patch?  Are we gonna merge it for 3.1?
> > > >>
> > > >> I just posted a similar one without knowing this (until Dave pointed
> > > >> it out).  IMHO it can be a good candidate for 3.1.
> > > >
> > > > Maybe Peter Maydell could apply this directly to the repo as a built
> fix?
> > >
> > > I'd rather it just went through the migration tree, really...
> > > it isn't actually breaking any of our travis jobs or other CI.
> > >
> > >
> > Hi Dave,
> >
> > What do you think about peter's comments?
>
> Yep, that's fine, as Peter Xu says, Juan's picking it up for the next
> one so we should be OK.
>
>
>
OK~ Thanks Peter Xu and Dave.

Zhang Chen



> Dave
>
> > Thanks
> > Zhang Chen
> >
> >
> > > thanks
> > > -- PMM
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
