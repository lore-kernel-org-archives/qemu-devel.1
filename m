Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyG28-0007Vi-KI
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyG23-0005D7-KQ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:06:28 -0400
Date: Tue, 20 Mar 2018 14:05:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320135548-mutt-send-email-mst@kernel.org>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu: include generated files with <> and
 not ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Peter Chubb <peter.chubb@nicta.com.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, kvm@vger.kernel.org, qemu-block@nongnu.org, sheepdog@lists.wpkg.org, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>

On Tue, Mar 20, 2018 at 09:58:23AM +0100, Laurent Vivier wrote:
> Le 20/03/2018 =E0 02:54, Michael S. Tsirkin a =E9crit=A0:
> > QEMU coding style at the moment asks for all non-system
> > include files to be used with #include "foo.h".
> > However this rule actually does not make sense and
> > creates issues for when the included file is generated.
>=20
> If you change that, we can have issue when a system include has the sam=
e
> name as our local include. With "<FILE>", system header are taken first=
.

Are you sure? I just tested and that is not the case with
either gcc or clang.

> > In C, include "file" means look in current directory,
> > then on include search path. Current directory here
> > means the source file directory.
> > By comparison include <file> means look on include search path.
>=20
> Not exactly, there is the notion of "system header" too.
>=20
> https://gcc.gnu.org/onlinedocs/cpp/Include-Syntax.html
>=20
> #include <file>
> This variant is used for system header files. It searches for a file
> named file in a standard list of system directories. You can prepend
> directories to this list with the -I option (see Invocation).

This is exactly what we do.

> #include "file"
> This variant is used for header files of your own program. It searches
> for a file named file first in the directory containing the current
> file, then in the quote directories and then the same directories used
> for <file>. You can prepend directories to the list of quote directorie=
s
> with the -iquote option.

Since we do not use -iquote, "" just adds the current directory.


> > As generated files are not in the search directory (unless the build
> > directory happens to match the source directory), it does not make se=
nse
> > to include them with "" - doing so is merely more work for preprocess=
or
> > and a source or errors if a stale file happens to exist in the source
> > directory.
>=20
> I agree there is a problem with stale files. But linux, for instance,
> asks for a "make mrproper" to avoid this.

Using <> we avoid the problem completely and create slightly
less work for the preprocessor.

> > This changes include directives for all generated files, across the
> > tree. The idea is to avoid sending a huge amount of email.  But when
> > merging, the changes will be split with one commit per file, e.g. for
> > ease of bisect in case of build failures, and to ease merging.
> >=20
> > Note that should some generated files be missed by this tree-wide
> > refactoring, it isn't a big deal - this merely maintains the status q=
uo,
> > and this can be addressed by a separate patch on top.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> I think your idea conflicts with what Markus has started to do:
>=20
> commit d8e39b70625d4ba1e998439d1a077b4b978930e7
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Thu Feb 1 12:18:28 2018 +0100
>=20
>     Use #include "..." for our own headers, <...> for others
>=20
>     System headers should be included with <...>, our own headers with
>     "...".  Offenders tracked down with an ugly, brittle and probably
>     buggy Perl script.  Previous iteration was commit a9c94277f0.
>=20
>     Delete inclusions of "string.h" and "strings.h" instead of fixing t=
hem
>     to <string.h> and <strings.h>, because we always include these via
>     osdep.h.
>=20
>     Put the cleaned up system header includes first.
>=20
>     While there, separate #include from file comment with exactly one
>     blank line.
>=20
> commit a9c94277f07d19d3eb14f199c3e93491aa3eae0e
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Wed Jun 22 19:11:19 2016 +0200
>=20
>     Use #include "..." for our own headers, <...> for others
>=20
>     Tracked down with an ugly, brittle and probably buggy Perl script.
>=20
>     Also move includes converted to <...> up so they get included befor=
e
>     ours where that's obviously okay.
>=20
> Thanks,
> Laurent

I suspect we previously actually did have headers in the
same directory as source so it was somewhat helpful.
They all have been moved out to include now.

--=20
MST
