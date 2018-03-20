Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyG8K-00005T-TI
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyG8G-0008SQ-US
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:12:52 -0400
Date: Tue, 20 Mar 2018 14:12:24 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320141107-mutt-send-email-mst@kernel.org>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
	<20180320094406.GD4530@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180320094406.GD4530@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Peter Chubb <peter.chubb@nicta.com.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, kvm@vger.kernel.org, qemu-block@nongnu.org, sheepdog@lists.wpkg.org, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>

On Tue, Mar 20, 2018 at 09:44:06AM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Mar 20, 2018 at 09:58:23AM +0100, Laurent Vivier wrote:
> > Le 20/03/2018 =E0 02:54, Michael S. Tsirkin a =E9crit=A0:
> > > QEMU coding style at the moment asks for all non-system
> > > include files to be used with #include "foo.h".
> > > However this rule actually does not make sense and
> > > creates issues for when the included file is generated.
> >=20
> > If you change that, we can have issue when a system include has the s=
ame
> > name as our local include. With "<FILE>", system header are taken fir=
st.
>=20
> > > In C, include "file" means look in current directory,
> > > then on include search path. Current directory here
> > > means the source file directory.
> > > By comparison include <file> means look on include search path.
> >=20
> > Not exactly, there is the notion of "system header" too.
> >=20
> > https://gcc.gnu.org/onlinedocs/cpp/Include-Syntax.html
> >=20
> > #include <file>
> > This variant is used for system header files. It searches for a file
> > named file in a standard list of system directories. You can prepend
> > directories to this list with the -I option (see Invocation).
> >=20
> > #include "file"
> > This variant is used for header files of your own program. It searche=
s
> > for a file named file first in the directory containing the current
> > file, then in the quote directories and then the same directories use=
d
> > for <file>. You can prepend directories to the list of quote director=
ies
> > with the -iquote option.
> >=20
> > > As generated files are not in the search directory (unless the buil=
d
> > > directory happens to match the source directory), it does not make =
sense
> > > to include them with "" - doing so is merely more work for preproce=
ssor
> > > and a source or errors if a stale file happens to exist in the sour=
ce
> > > directory.
> >=20
> > I agree there is a problem with stale files. But linux, for instance,
> > asks for a "make mrproper" to avoid this.
>=20
> We can follow what autoconf does, and add a check to configure to see i=
f
> there are generated files left in the source dir, when configuring with
> builddir !=3D srcdir, and exit with error, telling user to clean their
> src dir first.
>=20
> > > This changes include directives for all generated files, across the
> > > tree. The idea is to avoid sending a huge amount of email.  But whe=
n
> > > merging, the changes will be split with one commit per file, e.g. f=
or
> > > ease of bisect in case of build failures, and to ease merging.
> > >=20
> > > Note that should some generated files be missed by this tree-wide
> > > refactoring, it isn't a big deal - this merely maintains the status=
 quo,
> > > and this can be addressed by a separate patch on top.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > I think your idea conflicts with what Markus has started to do:
>=20
> Yes, I don't think we should revert what Markus started.   Both ways of
> referencing QEMU headers have downsides, but I think "..." has fewer
> downsides that "<....">.

Could you please explain what the advantage of "" is?
It seems to be gone since we moved headers away from
source.

> The problem Michael is tackling should be pretty rare, because moist
> developers aren't frequently switching between srcdir=3D=3Dbuilddir and
> srcdir!=3Dbiulddir setups - they have their preference for which to use
> and stick with it. As long as we get ./configure to warn about the
> dirty srcdir it should be good enough
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
