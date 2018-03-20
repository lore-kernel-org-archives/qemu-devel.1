Received: from eggs.gnu.org ([2001:4830:134:3::10]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyHLf-0002rq-Dc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyHLb-0002L2-G7
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:30:43 -0400
Date: Tue, 20 Mar 2018 15:30:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320152446-mutt-send-email-mst@kernel.org>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<20180320131041.GB24329@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320131041.GB24329@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu: include generated files
 with <> and not ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, sheepdog@lists.wpkg.org, Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, Mar 20, 2018 at 01:10:41PM +0000, Stefan Hajnoczi wrote:
> On Tue, Mar 20, 2018 at 03:54:36AM +0200, Michael S. Tsirkin wrote:
> > QEMU coding style at the moment asks for all non-system
> > include files to be used with #include "foo.h".
> > However this rule actually does not make sense and
> > creates issues for when the included file is generated.
> > 
> > In C, include "file" means look in current directory,
> > then on include search path. Current directory here
> > means the source file directory.
> > By comparison include <file> means look on include search path.
> > 
> > As generated files are not in the search directory (unless the build
> > directory happens to match the source directory), it does not make sense
> > to include them with "" - doing so is merely more work for preprocessor
> > and a source or errors if a stale file happens to exist in the source
> > directory.
> > 
> > This changes include directives for all generated files, across the
> > tree. The idea is to avoid sending a huge amount of email.  But when
> > merging, the changes will be split with one commit per file, e.g. for
> > ease of bisect in case of build failures, and to ease merging.
> > 
> > Note that should some generated files be missed by this tree-wide
> > refactoring, it isn't a big deal - this merely maintains the status quo,
> > and this can be addressed by a separate patch on top.
> 
> Stale header files are a pain.  I often do make distclean before
> checking out a radically different QEMU version to avoid the problem.
> 
> This patch trades off the stale header file issue for a new approach to
> using <> vs "", which will be hard to use consistently

The proposed rule is to use <> everywhere except if the file is in the
source directory.  It will be very easy to use consistently for the
simple reason that compiler will enforce it.  If you use <> for a header
in the current directory build fails. So you are forced to use "".

> in the future
> since it is unconventional.

All compilers I know without exception implement
include <> meaning look in -I search path, and
include "" meaning look in current directory then
in -I search path.

Looks conventional to me.

> Is the build time improvement worth it (please post numbers)?
> 
> Stefan

Haven't tested it frankly. Will it convince anyone if it's marginally
faster?

-- 
MST
