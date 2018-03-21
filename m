Received: from eggs.gnu.org ([2001:4830:134:3::10]:47458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eydpJ-0000p3-Mg
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eydpI-0001Xt-GR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:30:49 -0400
Date: Wed, 21 Mar 2018 13:29:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180321132953.GK8551@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
	<20180320135548-mutt-send-email-mst@kernel.org>
	<459fa95d-8f0a-22fa-80fb-4af22ccf49b3@redhat.com>
	<20180321150543-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321150543-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] qemu: include generated files
 with <> and not ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, sheepdog@lists.wpkg.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Mar 21, 2018 at 03:08:36PM +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 21, 2018 at 08:16:00AM +0100, Thomas Huth wrote:
> > On 20.03.2018 13:05, Michael S. Tsirkin wrote:
> > > On Tue, Mar 20, 2018 at 09:58:23AM +0100, Laurent Vivier wrote:
> > >> Le 20/03/2018 =C3=A0 02:54, Michael S. Tsirkin a =C3=A9crit=C2=A0:
> > >>> QEMU coding style at the moment asks for all non-system
> > >>> include files to be used with #include "foo.h".
> > >>> However this rule actually does not make sense and
> > >>> creates issues for when the included file is generated.
> > >>
> > >> If you change that, we can have issue when a system include has th=
e same
> > >> name as our local include. With "<FILE>", system header are taken =
first.
> > >=20
> > > Are you sure? I just tested and that is not the case with
> > > either gcc or clang.
> > >=20
> > >>> In C, include "file" means look in current directory,
> > >>> then on include search path. Current directory here
> > >>> means the source file directory.
> > >>> By comparison include <file> means look on include search path.
> > >>
> > >> Not exactly, there is the notion of "system header" too.
> > >>
> > >> https://gcc.gnu.org/onlinedocs/cpp/Include-Syntax.html
> > >>
> > >> #include <file>
> > >> This variant is used for system header files. It searches for a fi=
le
> > >> named file in a standard list of system directories. You can prepe=
nd
> > >> directories to this list with the -I option (see Invocation).
> > >=20
> > > This is exactly what we do.
> > >=20
> > >> #include "file"
> > >> This variant is used for header files of your own program. It sear=
ches
> > >> for a file named file first in the directory containing the curren=
t
> > >> file, then in the quote directories and then the same directories =
used
> > >> for <file>. You can prepend directories to the list of quote direc=
tories
> > >> with the -iquote option.
> > >=20
> > > Since we do not use -iquote, "" just adds the current directory.
> >=20
> > So why don't we simply switch to use -iquote instead of -I for adding
> > search paths for our own headers? We then would get a clean separatio=
n
> > of QEMU headers from system headers.
> >=20
> >  Thomas
>=20
> It still leaves us with a host of problems e.g. the problem of stale
> headers in the source directory.

We have a patch on list which effectively solves the problem of stale
generated files in source directory, so that's largely a non-issue at
this point IMHO.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
