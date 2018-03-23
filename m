Received: from eggs.gnu.org ([2001:4830:134:3::10]:54682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ezN7k-00012J-Uk
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ezN7j-0004fX-JZ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:52:52 -0400
Date: Fri, 23 Mar 2018 16:52:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180323162223-mutt-send-email-mst@kernel.org>
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
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Mar 23, 2018 at 10:22:27AM +0000, Daniel P. Berrang=E9 wrote:
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
> with  srcdir !=3D builddir config.

Helps with the second point but I do not see how this will help address
the first point.

I see include "x.h" in source, it's natural to ask where it is.

I look for it in the c file directory. Not there.

I look for it in the include, it's not there. Where then?

qemu source root on the include path. Not there.

Oh tcg directory is in the include path for some reason. Not there.

Some other tree coming from a submodule maybe?

Oh *maybe* it will be generated by some script, I need to run
build to find out.

For the record, more remains to be done.
Here's a list from and oot build of virtio, with some comments:

cc -iquote /home/mst/qemu-oot/hw/virtio


 -iquote hw/virtio=20

<- same directory repeated twice.

<- also this is here just for trace.h . Better to just change code to poi=
nt at the right trace header -
   will look into it.

-iquote /home/mst/qemu/tcg

<- why does everyone want tcg? better to just include with tcg/

 -iquote /home/mst/qemu/tcg/i386

<- and i386 specifically?

 -I/home/mst/qemu/linux-headers

<- ok this is so we can override with our own version of headers

 -I/home/mst/qemu-oot/linux-headers

<- why do we have these at all?
   oh it's because we have asm-<arch> tricks like linux used to use years=
 ago,
   then we copy the correct asm headers:
     ls linux-headers/asm/
     bitsperlong.h  hyperv.h  kvm.h  kvm_para.h  unistd_32.h  unistd_64.h=
  unistd.h  unistd_x32.h

   a better strategy would be to have headers in arch/<arch>/asm like Lin=
ux does now,
   no code generation tricks.

 -iquote .

<- build directory. No headers there at all.

 -iquote /home/mst/qemu=20

<- turns out we still have headers in source root. Why not move them to i=
nclude/ ?

-iquote /home/mst/qemu/accel/tcg=20

<- more tcg goodness for everyone?

-iquote /home/mst/qemu/include=20

<- ok that's expected. Why isn't this first on the list though?

-I/usr/include/pixman-1

<- should be limited to ui files I guess?

  -I/usr/include/glib-2.0=20

<- ok we need that

-I/usr/lib64/glib-2.0/include=20

<- but that one does not exist

  -I/usr/include/p11-kit-1     -I/usr/include/libpng16  -I/usr/include/li=
bdrm

<- more GUI things?

  -I/home/mst/qemu/capstone/include

<- ok a bunch of disasm things.
	ls capstone/include/
	arm64.h  arm.h  capstone.h  mips.h  platform.h  ppc.h  sparc.h  systemz.=
h  x86.h  xcore.h
   can we add this just to disas.c?

  -I../linux-headers

<- all together now: same as qemu-oot but with a relative path now.

 -iquote ..

<- build directory - no headers there

 -iquote /home/mst/qemu/target/arm

<- this is a good idea why?

 -iquote /home/mst/qemu/include

<- deja vu

Wow that was fun.

>  If people are using srcdir =3D=3D builddir
> then they likely *want* all the generated files in their srcdir.
>=20
> IMHO it would be valid for us to consider if we could just mandate
> srcdir !=3D builddir, but if people object to such a proposal, then I
> don't think we should arbitrarily move all generated source files
> in this way, as that's effectively the same thing forced onto devs.
>=20
> Regards,
> Daniel

People don't really care.





> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
