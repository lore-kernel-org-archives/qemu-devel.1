Received: from eggs.gnu.org ([2001:4830:134:3::10]:60608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAdc5-0007ou-2o
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAdc1-00088f-UO
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:10:29 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:47933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eAdc1-00087d-MO
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:10:25 -0400
Received: by mail-wm0-x242.google.com with SMTP id r196so2159095wmf.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 08:10:25 -0700 (PDT)
Date: Fri, 3 Nov 2017 15:10:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103151021.GA10959@stefanha-x1.localdomain>
References: <2896466deb1ff8d832e39ce389ce268ee38e4e4f.1504935362.git.maozy.fnst@cn.fujitsu.com>
	<20170912101629.GE6123@stefanha-x1.localdomain>
	<b3ee14cb-9d20-156b-2f68-f069ccd89f1d@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <b3ee14cb-9d20-156b-2f68-f069ccd89f1d@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4] pci: Set err to errp directly rather
 than through error_propagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 10:44:26AM +0800, Mao Zhongyi wrote:
> On 09/12/2017 06:16 PM, Stefan Hajnoczi wrote:
> > On Sat, Sep 09, 2017 at 02:22:26PM +0800, Mao Zhongyi wrote:
> > > ioh3420_interrupts_init() pass error message to local_err, then
> > > propagate it to errp by error_propagate(), which is not necessary.
> > > So eliminate it and pass errp directly instead of local_err.
> > >=20
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Marcel Apfelbaum <marcel@redhat.com>
> > > Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> > > Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> > > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > ---
> > > v4:
> > > it not apply clearly on HEAD, so rebase it and modify the commit
> > > message.
> > > ---
> > >=20
> > >  hw/pci-bridge/ioh3420.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Hi,
>=20
> Long time no news. Ping...

This patch should go through Michael Tsirkin's tree.

Stefan

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/IbdAAoJEJykq7OBq3PIWYkH/1l6jOpCmrGJFwX132CvLLCq
BzN6nASBS/G05Hl+72jLluOklNuRc0bzYhBGn2d4yTrEzgWW4wn06EsIOUjrKUdZ
SiRT+ifoRXydtrXIBPi/zQxPxA56V18L3XMMjAQEpOOUWi3SISun/fB9RoTq1EjW
FXp1VU3yc7Z0nq27JXTI94rQpxzK6FR1+UgwOGKpPXTSv/ImrCgxRUdxWfl5kb7y
8LBYgmCKoo6cIYkYjvFjk06heeCCpL4DEZp+CPEgdGwrZqaNn0sxeyQLjCRH1OGz
Ou9NjkaaAYabJPzyqTR2pZRONBASm9wtMikLKnJ0kdxcVu2PrUWjxt1q3cvhWLM=
=B6gi
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
