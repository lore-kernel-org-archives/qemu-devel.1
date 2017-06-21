Received: from eggs.gnu.org ([2001:4830:134:3::10]:38867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dNdUm-0003bR-I7
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dNdUj-0001B2-Ag
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:08:24 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dNdUj-0001Al-1O
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:08:21 -0400
Received: by mail-lf0-x244.google.com with SMTP id u62so20239143lfg.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 04:08:20 -0700 (PDT)
Date: Wed, 21 Jun 2017 12:08:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170621110817.GF16183@stefanha-x1.localdomain>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<20170619100813.GB17304@stefanha-x1.localdomain>
	<4cec825b-d92e-832e-3a76-103767032528@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <4cec825b-d92e-832e-3a76-103767032528@redhat.com>
Subject: Re: [Qemu-devel] [RFC] virtio-mem: paravirtualized memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 12:26:52PM +0200, David Hildenbrand wrote:
> On 19.06.2017 12:08, Stefan Hajnoczi wrote:
> > On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
> >> Important restrictions of this concept:
> >> - Guests without a virtio-mem guest driver can't see that memory.
> >> - We will always require some boot memory that cannot get unplugged.
> >>   Also, virtio-mem memory (as all other hotplugged memory) cannot beco=
me
> >>   DMA memory under Linux. So the boot memory also defines the amount of
> >>   DMA memory.
> >=20
> > I didn't know that hotplug memory cannot become DMA memory.
> >=20
> > Ouch.  Zero-copy disk I/O with O_DIRECT and network I/O with virtio-net
> > won't be possible.
> >=20
> > When running an application that uses O_DIRECT file I/O this probably
> > means we now have 2 copies of pages in memory: 1. in the application and
> > 2. in the kernel page cache.
> >=20
> > So this increases pressure on the page cache and reduces performance :(.
> >=20
> > Stefan
> >=20
>=20
> arch/x86/mm/init_64.c:
>=20
> /*
>  * Memory is added always to NORMAL zone. This means you will never get
>  * additional DMA/DMA32 memory.
>  */
> int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
> {
>=20
> The is for sure something to work on in the future. Until then, base
> memory of 3.X GB should be sufficient, right?

I'm not sure that helps because applications typically don't control
where their buffers are located?

Stefan

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZSlOhAAoJEJykq7OBq3PIvj8IAIYB7fWhiMFR7qGpHgnD6tM3
6RMqMgAoTe7NBIeh3tFbsGjp/XjzeCT7iiEhbrO7MtFrP7IxXylQFRmzBMNb6WlU
EyhwQ4Ajyj3TP8Rey+xApJe8ZQkieWHq8ovTI/ozXXMJ+9k/XwiwVaXzPkThy1v2
Ne6vfF/nONpRi55kOst8zGw6MzmAHK3hnoIR9KAqWXfm6jrw71m3NyL/1K9n/QH9
YnUi6WC98xgk9CJlCnuUR6am2sr5Xly+lN9jrKQ8DJZn3KjjcvwTJTNEYrJpK2gh
CZ+UGkmWbdWftyIB0uHnJAtyO+eDobaldJ6gD89T7ysDpuh8CdpPGpKEyzxP40w=
=SMQf
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
