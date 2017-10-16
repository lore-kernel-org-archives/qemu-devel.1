Received: from eggs.gnu.org ([2001:4830:134:3::10]:46743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e44Zk-0001nL-6O
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1e44Zh-00058A-Jr
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:32:56 -0400
Received: from jessie.kos.to ([212.47.231.226]:52352 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1e44Zh-00057S-Cx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:32:53 -0400
Date: Mon, 16 Oct 2017 12:32:50 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171016123250.GB1918@kos.to>
References: <20170925231924.31303-1-carenas@gmail.com>
	<CAPUEspg5AO_XzLa1n3cCTrz+22WYk5BZrE28ufDjPP7Y3KN2+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspg5AO_XzLa1n3cCTrz+22WYk5BZrE28ufDjPP7Y3KN2+Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] linux-user: refactor socket.h into architecture
 specific sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carlo Arenas <carenas@gmail.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu

On Wed, Oct 11, 2017 at 12:10:04AM -0700, Carlo Arenas wrote:
> ping

Thanks for your patience
=20
> some of the patches already have a Reviewed-by as shown by :
>=20
>   http://patchwork.ozlabs.org/patch/818378/

Can you send the series without the whitespace-only changes?
=20
> On Mon, Sep 25, 2017 at 4:19 PM, Carlo Marcelo Arenas Bel=C3=B3n
> <carenas@gmail.com> wrote:
> > the definitions in socket.h are meant to reflect the ones in linux fo=
r each
> > respective target, but are sometimes difficult to maintain.
> >
> > hppa (AKA parisc) was initially merged with an independent file that =
mirrors
> > more closely the corresponding one in linux but hasn't been updated s=
ince.
> >
> > this series updates hppa with the latest bits from linux 4.14 and mak=
es sure
> > all relevant architectures had a sockbits file that would be easy to =
maintain
> > going forward.
> >
> > most of the changes are pretty mechanical and I had made (thanks to L=
aurent's
> > tough review) every effort to ensure no value gets changed accidental=
y and
> > all changes (even the ones where the value remains but is now in a di=
fferent
> > base to better match what was used in the linux headers) are document=
ed, so
> > it should be fairly safe and will fix bugs (mostly for sparc).
> >
