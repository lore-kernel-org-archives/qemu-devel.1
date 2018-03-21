Received: from eggs.gnu.org ([2001:4830:134:3::10]:41981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eydUi-0007Ck-C3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eydUe-0005Ef-7P
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:09:32 -0400
Date: Wed, 21 Mar 2018 15:08:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180321150543-mutt-send-email-mst@kernel.org>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
	<20180320135548-mutt-send-email-mst@kernel.org>
	<459fa95d-8f0a-22fa-80fb-4af22ccf49b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <459fa95d-8f0a-22fa-80fb-4af22ccf49b3@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, sheepdog@lists.wpkg.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, Mar 21, 2018 at 08:16:00AM +0100, Thomas Huth wrote:
> On 20.03.2018 13:05, Michael S. Tsirkin wrote:
> > On Tue, Mar 20, 2018 at 09:58:23AM +0100, Laurent Vivier wrote:
> >> Le 20/03/2018 =E0 02:54, Michael S. Tsirkin a =E9crit=A0:
> >>> QEMU coding style at the moment asks for all non-system
> >>> include files to be used with #include "foo.h".
> >>> However this rule actually does not make sense and
> >>> creates issues for when the included file is generated.
> >>
> >> If you change that, we can have issue when a system include has the =
same
> >> name as our local include. With "<FILE>", system header are taken fi=
rst.
> >=20
> > Are you sure? I just tested and that is not the case with
> > either gcc or clang.
> >=20
> >>> In C, include "file" means look in current directory,
> >>> then on include search path. Current directory here
> >>> means the source file directory.
> >>> By comparison include <file> means look on include search path.
> >>
> >> Not exactly, there is the notion of "system header" too.
> >>
> >> https://gcc.gnu.org/onlinedocs/cpp/Include-Syntax.html
> >>
> >> #include <file>
> >> This variant is used for system header files. It searches for a file
> >> named file in a standard list of system directories. You can prepend
> >> directories to this list with the -I option (see Invocation).
> >=20
> > This is exactly what we do.
> >=20
> >> #include "file"
> >> This variant is used for header files of your own program. It search=
es
> >> for a file named file first in the directory containing the current
> >> file, then in the quote directories and then the same directories us=
ed
> >> for <file>. You can prepend directories to the list of quote directo=
ries
> >> with the -iquote option.
> >=20
> > Since we do not use -iquote, "" just adds the current directory.
>=20
> So why don't we simply switch to use -iquote instead of -I for adding
> search paths for our own headers? We then would get a clean separation
> of QEMU headers from system headers.
>=20
>  Thomas

It still leaves us with a host of problems e.g. the problem of stale
headers in the source directory.

--=20
MST
