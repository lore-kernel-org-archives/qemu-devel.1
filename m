Received: from eggs.gnu.org ([2001:4830:134:3::10]:45925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez5ti-0000iI-KA
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez5th-0007LZ-FL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:29:14 -0400
Date: Thu, 22 Mar 2018 21:29:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180322211902-mutt-send-email-mst@kernel.org>
References: <1521642402-197739-1-git-send-email-mst@redhat.com>
	<20180321153439.GC3898@localhost.localdomain>
	<20180321175452-mutt-send-email-mst@kernel.org>
	<20180321162203.GE3898@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321162203.GE3898@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] qemu: replace "" with <> in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, Mar 21, 2018 at 05:22:03PM +0100, Kevin Wolf wrote:
> > It's all still very much a non-standard convention and so less robust
> > than prefixing file name with a project-specifix prefix.
> 
> I've always had the impression that it's by far the most common
> convention, to the point that I'd blindly assume it when joining a new
> project.

Any examples?

> > > > As another example of problems, a header by the same name in the source
> > > > directory will always be picked up first - before any headers in
> > > > the include directory.
> > > > 
> > > > Let's change the scheme: make sure all headers that are not
> > > > in the source directory are included through a path
> > > > starting with qemu/ , thus:
> > > > 
> > > >  #include <>
> > > > 
> > > > headers in the same directory as source are included with
> > > > 
> > > >  #include ""
> > > > 
> > > > as per standard.
> > > > 
> > > > This (untested) patch is just to start the discussion and does not
> > > > change all of the codebase. If there's agreement, this will be
> > > > run on all code to converting code to this scheme.
> > > 
> > > Renaming files is always painful. If that's the fix, the cure might be
> > > worse than the disease. As far as I know, the conflict is only
> > > theoretical, so in that case I'd say: If it ain't broke, don't fix it.
> > > 
> > > Kevin
> > 
> > It's broke I think, it's very hard for new people to contribute to QEMU.
> > Look e.g. at rdma which all has messed up includes - and that's from an
> > experienced conributor who just isn't an experienced maintainer.
> 
> I don't think the problem is that the convention is hard to apply (it's
> definitely not). It's knowing about the convention. This problem isn't
> going away by switching to a different, less common convention. We're
> only going to see more offenders then.

Not if we have some automatic tools to catch violators.

> > Amount of time spent on teaching new people trivia about our
> > conventions just isn't funny. They should be self-documenting
> > and violations should cause the build to fail.
> 
> Yes, but your proposal doesn't achieve this. You can still use
> "qemu/foo.h" instead of <qemu/foo.h> and it will build successfully.
> That's something we can't change, as far as I know, because the include
> path for "foo.h" is always a superset of <foo.h>.

If the rule is that "" is only for files in the current directory
then we can easily code up a checkpatch script to catch violators.

> If anything, this means that we should prefer "foo.h" for local headers
> (i.e. the way it currently is) because we can let the compiler enforce
> it: <foo.h> for "foo.h" can become a build error, and does so with your
> -iquote patch, but the other way round doesn't work.
> 
> Then it's only system headers that you can possibly get wrong, but for
> those everyone should be used to using <foo.h> anyway.
> 
> Kevin

If my proposal to prefix all include directories with qemu/
is accepted, then we can solve the stale file problem
by prohibiting a directory named qemu everywhere in source.


-- 
MST
