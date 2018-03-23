Received: from eggs.gnu.org ([2001:4830:134:3::10]:40289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ezKmQ-0003TG-6D
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ezKmP-0007oS-64
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:22:42 -0400
Date: Fri, 23 Mar 2018 12:21:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180323112143.GC5025@localhost.localdomain>
References: <1521746188-496856-1-git-send-email-mst@redhat.com>
	<20180323102227.GF16270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180323102227.GF16270@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] make: move generated headers to
 qemu-build/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

Am 23.03.2018 um 11:22 hat Daniel P. Berrang=E9 geschrieben:
> On Thu, Mar 22, 2018 at 09:27:55PM +0200, Michael S. Tsirkin wrote:
> > Make sure all generated files go into qemu-build subdirectory.
> > We can then include them like this:
> >  #include "qemu-build/trace.h"
> >=20
> > This serves two purposes:
> > - make it easy to detect which files are in the source
> >   directory (a bit more work for writers, easier for readers)
> > - reduce chances of conflicts with possible stale files in source
> >   directory (which could be left over from e.g. old patches, etc)
>=20
> If people care about this, then they can just be doing a build
> with  srcdir !=3D builddir config.  If people are using srcdir =3D=3D b=
uilddir
> then they likely *want* all the generated files in their srcdir.
>=20
> IMHO it would be valid for us to consider if we could just mandate
> srcdir !=3D builddir, but if people object to such a proposal, then I
> don't think we should arbitrarily move all generated source files
> in this way, as that's effectively the same thing forced onto devs.

Not necessarily. I build from the srcdir simply because it's more
convenient to be able to easily start the editor and make from the same
directory (or sometimes start make from inside the editor). I suppose
that (or for users, being too lazy to create a second directory for that
one-time build) is the motivation for most other users of srcdir =3D=3D
builddir, too.

I don't really mind where generated source files are stored, they just
happen to end up in my root source directory if I want to be able to
build from there without dealing with paths. I won't be angry if they
are suddenly in a different directory as long as it doesn't mean more
typing for me. Moving them to a separate directory might in fact make
things a bit nicer occasionally. Not enough for me to actively propose
such a change, but if Michael wants to do this, I'm certainly not
opposed.

Kevin
