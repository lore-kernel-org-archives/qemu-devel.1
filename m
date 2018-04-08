Received: from eggs.gnu.org ([2001:4830:134:3::10]:38496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f56bh-0001q6-C9
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f56bd-0005u5-C3
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:27:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f56bd-0005tf-64
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:27:25 -0400
Date: Sun, 8 Apr 2018 17:27:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180408092714.GC2862@lemon.usersys.redhat.com>
References: <CAEMkAmGoPm8p0MKumctDPodaD4PCUYi4X=ovs+kMO9xTKGkLeQ@mail.gmail.com>
	<20180403031147.GC6839@lemon.usersys.redhat.com>
	<CAEMkAmGrW=h5Z1YncOQ4v2nmHt99-0Wg6aP6yCTd2p-ooToA4A@mail.gmail.com>
	<20180403033033.GD6839@lemon.usersys.redhat.com>
	<20180404134122.GS4467@stefanha-x1.localdomain>
	<CAEMkAmETfoekTw=VP1K5c=z1P9uSb7pm7VNkrJjgEdd1NLjAnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMkAmETfoekTw=VP1K5c=z1P9uSb7pm7VNkrJjgEdd1NLjAnA@mail.gmail.com>
Subject: Re: [Qemu-devel] Loadable block drivers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lindsay Mathieson <lindsay.mathieson@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

On Thu, 04/05 11:40, Lindsay Mathieson wrote:
> On 4 April 2018 at 23:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> 
> > On Tue, Apr 03, 2018 at 11:30:33AM +0800, Fam Zheng wrote:
> > > On Tue, 04/03 13:17, Lindsay Mathieson wrote:
> > > > On 3 April 2018 at 13:11, Fam Zheng <famz@redhat.com> wrote:
> > > >
> > > > > On Tue, 04/03 12:59, Lindsay Mathieson wrote:
> > > > > > Hi all, was looking at developing a block driver for qemu - have
> > examined
> > > > > > the drivers at:
> > > > > >
> > > > > >   https://github.com/qemu/qemu/tree/master/block
> > > > > >
> > > > > > And it seems straightforward enough.
> > > > > >
> > > > > > One thing that is unclear - all the drivers appear to be compiled
> > > > > directly
> > > > > > into qemu. Is there no way to load them dynamically as .so modules?
> > > > >
> > > > > './configure --enable-modules' will enable building block drivers as
> > .so
> > > > > objects, and they are loaded dynamically. These are in-tree .so
> > modules;
> > > > > out-of-tree modules like in Linux kernel are intentionally forbidden.
> > > > >
> > > > > Fam
> > > > >
> > > >
> > > >
> > > >
> > > > Rats, I take it that means I can't develop a testing block module and
> > load
> > > > it with an pre-existing qemu install.
> > >
> > > No, that's not possible.
> >
> > Depending on what you are trying to do, you could use the blkdebug,
> > null-co, NBD, or iSCSI drivers to perform your testing.
> >
> > blkdebug does fault injection (e.g. you can test what happens when
> > certain I/O requests fail).
> >
> > null-co is a nop block driver useful for some types of performance
> > testing and it also supports introducing an artificial delays.
> >
> > NBD and iSCSI can be used to forward I/O requests to an external server
> > where you can implement any behavior you want.
> >
> > We can discuss it more if you can explain what you're trying to do.
> >
> > Stefan
> >
> 
> 
> 
> Thanks Stefan, looking to develop a lizardfs block driver. A process that
> only involved building a module rather than the entire qemu tree would mike
> life easier, especially if I could test it on a live system (proxmox
> cluster). A custom qemu install is not an option for that.

I cannot think of a way to hot plugging a block driver to a running QEMU, but
perhaps you can live migrate the VM from the stock QEMU to a custom built one to
achieve similar.

Fam
