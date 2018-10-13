Received: from eggs.gnu.org ([2001:4830:134:3::10]:58987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcE-0002Dk-MG
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcD-0008WO-QU
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:34 -0400
Date: Sat, 13 Oct 2018 17:23:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181013062351.GC16167@umbus.fritz.box>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
	<364642df-1e17-dbea-1cec-a5cf6c606b27@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <364642df-1e17-dbea-1cec-a5cf6c606b27@linaro.org>
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 10:41:33AM -0700, Richard Henderson wrote:
> On 10/11/18 8:24 PM, David Gibson wrote:
> > When the balloon is inflated, we discard memory place in it using madvi=
se()
> > with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
> > sounds like it makes sense but is actually unnecessary.
> >=20
> > The misleadingly named MADV_DONTNEED just discards the memory in questi=
on,
> > it doesn't set any persistent state on it in-kernel; all that's necessa=
ry
> > to bring the memory back is to touch it.
>=20
> Isn't the point of deflate to free up host memory, for use by other guest=
s or
> whatever?

As Eric notes, I think you have inflate and deflate the wrong way around.

> If you do nothing upon deflate, then that doesn't actually happen.  It se=
ems to
> me that this is backward and you should use DONTNEED on deflate and then
> inflate should do nothing.
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvBj3QACgkQbDjKyiDZ
s5JgiQ/+PrwaCna0NBdVkkmMfKphF/OB2fBK+PSbHev5MRd0Yy/aHx0ihGCRqwee
vp7tNCvMUfCKkk4CahP+1Y8RSVsW49sURhiLG6+SB87dUoD35LJTJNfSOG8/AsRV
e94jZP5y8y7ZaWg+anAWG8aeRpvr4rdzuJibLJNIH6c9zGba9qSb7gFn7eaev4Ke
pja5pbCzlfDppwNVF6/kBetGVEfoTr+YHiEwXlLi1HBNJVLrCSemYf72A2r+XI0X
ivv8au54GC9JNDlEO7cykJdL3gfLvWUgweZjYMAkJSfihVQDwbNnB3E0U1duNJdZ
Bd6GLj5Kn7wdU5o3iVyROY3e5BYXhYGoX5OMKHbZr+k/FyKaDKalnUKKer3E6TrS
T5UmBmZJp7Jft8fYgViOCnatWntE8wqdatlzFBCS7+OrvL3hqyI0K1GpurtujiTg
p2rNkTFAx6PIpD5kqyqoN+2Qs70QGniqSbX0td3cJEa1xh5T62Ikfl4qeyw4ohGx
x/5fiqCcy4Vk3BRb23SCLKlFALlE+af1VZBh6CiZRUCncgemcB4L7O16fnq+NhaJ
OkBdAPNXsdY0rqc5T9NYVS/h0m/pvvvgP2TfoBFrKoFWU0pw9sxe1Ipl9TLaUwIO
nnqwnZ9glFB65LOYsIqZNUaSup1RtBeneL3jmJNdTXQFyUKknoo=
=hqDV
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
