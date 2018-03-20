Received: from eggs.gnu.org ([2001:4830:134:3::10]:56448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyLOu-0004Gd-Lt
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyLOs-0001Oq-Sg
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:50:20 -0400
Date: Tue, 20 Mar 2018 19:49:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320194454-mutt-send-email-mst@kernel.org>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<b068cb91-b8ba-175c-40f5-a7c9c8163575@weilnetz.de>
	<20180320185130-mutt-send-email-mst@kernel.org>
	<20180320173401.GG4530@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320173401.GG4530@redhat.com>
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
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, sheepdog@lists.wpkg.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Hannes Reinecke <hare@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Richard W.M. Jones" <rjones@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcel Apfelbaum <marcel@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Xie Changlong <xiechanglong.d@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Greg Kurz <groug@kaod.org>, Anthony Perard <anthony.perard@citrix.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Juan Quintela <quintela@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, Mar 20, 2018 at 05:34:01PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 20, 2018 at 07:10:42PM +0200, Michael S. Tsirkin wrote:
> > On Tue, Mar 20, 2018 at 05:33:42PM +0100, Stefan Weil wrote:
> > > Using <> for system include files and "" for local include files is=
 a
> > > convention, and as far as I know most projects adhere to that
> > > convention. So does QEMU currently. Such conventions are not only
> > > important for humans, but also for tools. There are more tools than=
 the
> > > C preprocessor which handle <> and "" differently. For example the =
GNU
> > > compiler uses -MD or -MMD to automatically generate dependency rule=
s for
> > > make. While -MD generates dependencies to all include files, -MMD d=
oes
> > > so only for user include files, but not for system include files. "=
user"
> > > and "system" means the different forms how include statements are
> > > written. QEMU still seems to use -MMD:
> > >=20
> > > rules.mak:QEMU_DGFLAGS +=3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> >=20
> > To my knowledge, and according to my limited testing,
> > system headers in this context means
> > the default ones not supplied with -I.
>=20
> GCC's definition of system header is here:
>=20
>   https://gcc.gnu.org/onlinedocs/cpp/System-Headers.html
>=20
>=20
> Regards,
> Daniel

Proves my point, does it not?  You will note that it does not refer to
include <> anywhere.

    2.8 System Headers
    The header files declaring interfaces to the operating system and run=
time libraries often cannot be written in strictly conforming C. Therefor=
e, GCC gives code found in system headers special treatment. All warnings=
, other than those generated by =E2=80=98#warning=E2=80=99 (see Diagnosti=
cs), are suppressed while GCC is processing a system header. Macros defin=
ed in a system header are immune to a few warnings wherever they are expa=
nded. This immunity is granted on an ad-hoc basis, when we find that a wa=
rning generates lots of false positives because of code in macros defined=
 in system headers.

    Normally, only the headers found in specific directories are consider=
ed system headers. These directories are determined when GCC is compiled.=
 There are, however, two ways to make normal headers into system headers:

    Header files found in directories added to the search path with the -=
isystem and -idirafter command-line options are treated as system headers=
 for the purposes of diagnostics.
    There is also a directive, #pragma GCC system_header, which tells GCC=
 to consider the rest of the current include file a system header, no mat=
ter where it was found. Code that comes before the =E2=80=98#pragma=E2=80=
=99 in the file is not affected. #pragma GCC system_header has no effect =
in the primary source file.


Conclusion: #include <> is ignored for purposes of determining whether a =
header is
a system one or not.


> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
