Received: from eggs.gnu.org ([2001:4830:134:3::10]:37506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyEUg-0004uH-UY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyEUf-0005ty-Of
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:27:50 -0400
Date: Tue, 20 Mar 2018 10:27:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180320102719.GF4530@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
	<20180320094406.GD4530@redhat.com>
	<CAFEAcA-eoyPokMLqUBcHvEgp=GQnODv3r3A_9LRkc=8do6ea1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-eoyPokMLqUBcHvEgp=GQnODv3r3A_9LRkc=8do6ea1A@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Ben Warren <ben@skyportsystems.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Peter Chubb <peter.chubb@nicta.com.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, kvm-devel <kvm@vger.kernel.org>, Qemu-block <qemu-block@nongnu.org>, sheepdog@lists.wpkg.org, qemu-arm <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, qemu-ppc@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Tue, Mar 20, 2018 at 10:01:24AM +0000, Peter Maydell wrote:
> On 20 March 2018 at 09:44, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > We can follow what autoconf does, and add a check to configure to see=
 if
> > there are generated files left in the source dir, when configuring wi=
th
> > builddir !=3D srcdir, and exit with error, telling user to clean thei=
r
> > src dir first.
>=20
> We already do this in our makefile...it just doesn't check every
> single generated file.

Ah yes, indeed:

$ make
Makefile:59: *** This is an out of tree build but your source tree
(/home/berrange/src/virt/qemu) seems to have been used for an in-tree
build. You can fix this by running "make distclean && rm -rf *-linux-user
 *-softmmu" in your source tree.  Stop.


It is checking for existance of config-host.mak.

We have a convenient list of generated files in $(GENERATED_FILES), so
I wonder if there's a practical way to check all of those too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
