Received: from eggs.gnu.org ([2001:4830:134:3::10]:59922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx6To-00082Z-P7
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx6Tk-0008D4-QE
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:14:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fx6Tk-0008Co-Kx
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:14:28 -0400
Date: Tue, 4 Sep 2018 09:14:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180904081423.GA22349@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-7-sameeh@daynix.com>
	<20180903115406.GA14377@redhat.com>
	<ee81457c-5df4-974f-29fa-7fdcc6649ea7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee81457c-5df4-974f-29fa-7fdcc6649ea7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 6/6] virtio-net: rss: Add bpf filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org

On Tue, Sep 04, 2018 at 11:07:38AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B409=E6=9C=8803=E6=97=A5 19:54, Daniel P. Berrang=C3=A9 w=
rote:
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2=
 or later.
> > > + * See the COPYING file in the top-level directory.
> > > + *
> > > + */
> > > +
> > > +#include <linux/bpf.h>
> > > +
> > > +#ifndef BPF_RSS_INSNS
> > > +#define BPF_RSS_INSNS
> > > +
> > > +/* bpf_insn array matching l3_l4 section. see tap_bpf_program.c fi=
le */
> > > +struct bpf_insn l3_l4_hash_insns[] =3D {
> > > +{0xbf , 0x6 , 0x1 , 0x0000 , 0x00000000},
> > > +{0x28 , 0x0 , 0x0 , 0x0000 , 0x0000000c},
> > > +{0xbf , 0x8 , 0x0 , 0x0000 , 0x00000000},
> > [snip]
> >=20
> > > +};
> > This massive array is presumably an auto-generated content.
> >=20
> > We shouldn't be storing this in GIT. We need to store the
> > original preferred source format, and providing makefile
> > rules to generate it.
> >=20
> >=20
>=20
> This is possible. But it depends on eBPF toolchain (e.g recent version =
of
> LLVM) to work which is inflexible or impossible to make it work on some
> distributions. Providing compiled bytecode does not have such limitatio=
n.

Those distros can fix their toolchain if they wish to have the BPF featur=
e
enabled when building QEMU, just like they would for any other dependancy
that is needed by QEMU.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
