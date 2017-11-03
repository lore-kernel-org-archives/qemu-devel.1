Received: from eggs.gnu.org ([2001:4830:134:3::10]:40269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAYwO-0007hW-QX
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAYwK-00014G-Ql
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:11:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAYwK-00013F-KV
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:11:04 -0400
Date: Fri, 3 Nov 2017 10:10:55 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171103101055.GD20155@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509638660.11873.13.camel@redhat.com>
	<20171102161103.GU32533@redhat.com>
	<1509691743.31823.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1509691743.31823.1.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] seabios serial console vs. sgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Nov 03, 2017 at 07:49:03AM +0100, Gerd Hoffmann wrote:
> On Thu, 2017-11-02 at 16:11 +0000, Daniel P. Berrange wrote:
> > On Thu, Nov 02, 2017 at 05:04:20PM +0100, Gerd Hoffmann wrote:
> > > =C2=A0 Hi,
> > >=20
> > > One problem we have with the serial console support in seabios and
> > > sgabios:=C2=A0=C2=A0It can happen that both are activated.=C2=A0=C2=
=A0We'll go fix that
> > > in
> > > qemu, but that'll work for new qemu versions only, not for the old
> > > already released ones.
> > >=20
> > > So I think it would be useful if seabios makes sure sgabios and
> > > serial
> > > console are not both active at the same time, i.e. in case we find
> > > "vgaroms/sgabios.bin" being present either turn off builtin serial
> > > console, or don't load sgabios (and possibly also enable builtin
> > > serial
> > > console).
> >=20
> > Historically libvirt will always use '-device sgabios' if the user
> > has
> > requested <bios useserial=3D'yes'/>.=C2=A0=C2=A0So if that -device ar=
g is given,
> > I
> > think QEMU must honour it, which implies QEMU must disable Seabios'
> > own built-in serial console impl in that scenario.
>=20
> Hmm, why?  The user asked for a serial console.  Whenever that is
> provided by seabios builtin support or the sgabios rom doesn't really
> matter, no?

Surely it has ABI implications for the guest if we stop putting the
sgabios option ROM into memory - changing layout of ROMS

> Also, the question is what seabios should do in case both are active.=20
> Which I think can happen today with libvirt if you configure a virtual
> machine without vga (libvirt passes -machine graphics=3Doff which
> activates builtin serial console) and with "<bios useserial=3D'yes'/>"
> (enables sgabios rom).

Libvirt doesn't use  '-machine graphics=3Doff' AFAIK, only '-nographic'.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
