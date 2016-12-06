Received: from eggs.gnu.org ([2001:4830:134:3::10]:51955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMCu-0000Hy-CC
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMCp-0002BC-Dx
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:19:20 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEMCp-0002Ax-7Y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:19:15 -0500
Received: by mail-wj0-f194.google.com with SMTP id xy5so45954420wjc.1
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:19:15 -0800 (PST)
Date: Tue, 6 Dec 2016 20:18:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206201811.GC2521@stefanha-x1.localdomain>
References: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
	<20161206153945-mutt-send-email-mst@kernel.org>
	<20161206173337.GB30363@stefanha-x1.localdomain>
	<20161206211034-mutt-send-email-mst@kernel.org>
	<66ab8815-b9bb-7068-1809-0a31367534ff@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <66ab8815-b9bb-7068-1809-0a31367534ff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 01:30:12PM -0600, Eric Blake wrote:
> On 12/06/2016 01:22 PM, Michael S. Tsirkin wrote:
> > On Tue, Dec 06, 2016 at 05:33:37PM +0000, Stefan Hajnoczi wrote:
> >> On Tue, Dec 06, 2016 at 03:40:49PM +0200, Michael S. Tsirkin wrote:
> >>> On Tue, Dec 06, 2016 at 05:29:13PM +0800, Gonglei wrote:
> >>>> Zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> >>>> for key material security.
> >>>>
>=20
> >>>> +            /* Zeroize and free request data structure */
> >>>> +            memset(op_info, 0, sizeof(*op_info) + max_len);
> >>>> +            g_free(op_info);
> >>>
> >>> Write into memory, then free it?  This looks rather strange. Why are =
we
> >>> doing this?
> >>
> >> Common practice with sensitive information (key material, passwords,
> >> etc).
> >=20
> > Some kind of explanation about what makes this one
> > more sensitive than others would be nice.
>=20
> Even mentioning existing practice would go a long way; see commit 8813800=
b.
>=20
> >=20
> > Also, what makes it 2.8 material? Considering the pointer math
> > involved, it's not risk-free.
> >=20
> >> coredumps, memory disclosure bugs when heap memory is reused, etc.
> >>
> >> Sensitive information is sometimes also held in mlocked pages to preve=
nt
> >> it being swapped to disk but that's not being done here.
>=20
> And existing practice is that we aren't going to be that paranoid at
> this time (and yes, I asked Dan that same question on his commit
> mentioned above).

Okay.  I am not merging this for QEMU 2.8.0-rc3, it should go through
Michael Tsirkin's tree.

Stefan

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRx0DAAoJEJykq7OBq3PIGEgH/jtsmn2vCpu3Zn8jmlus6Xqa
atM9+BEqaE9+7cROpl7MnGT2NaVDKvbeZR8+dwOEUVRPpkt0W7Ni/2Y4lGrXWJB9
yTaeMt+OwuBIAkgoWsxq/npkPvehMbB72K3TISLBV4TZ7tBl+oJJOBZNPq8Ec0dV
y91iALFEmhUzvO32yGR07zUIVJXliC6lrxETiqxHGWJoPDgjFNl2TuuD1CPQxZEW
pFD8yYwHS9cL7gTLV6EXPsTyH7mCM9LpwaP3WvKGAwSd9UX6zEl7z3LL4ngKkc6Z
DVOkxY2asjT+3zVmuq35GLTIZmSmHk4m0zrbh5XmxlVHpKQlS9X+XIoVwQNRlCM=
=+ojI
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
