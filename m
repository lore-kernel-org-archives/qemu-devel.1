Received: from eggs.gnu.org ([2001:4830:134:3::10]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2iz-0003ee-5M
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2iv-0005sx-V3
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:23:01 -0500
Received: from ozlabs.org ([103.22.144.67]:60955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ch2iv-0005ri-4m
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:22:57 -0500
Date: Fri, 24 Feb 2017 09:49:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223224911.GC17615@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
Subject: Re: [Qemu-devel] using fdt_setprop() to set properties to empty
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 08:52:01AM -0600, Eric Blake wrote:
> On 02/23/2017 06:33 AM, Peter Maydell wrote:
> > What's the right way to use libfdt's fdt_setprop to set a property
> > to have an empty value? At the moment in QEMU we tend to use
> >   fdt_setprop(fdt, nodeoffset, "propertyname", NULL, 0);

That's what I've always used..

> > and git grep 'fdt_setprop.*NULL' produces examples of this usage in
> > PPC and ARM fdt creation code.
> >=20
> > However the fdt_setprop() documentation doesn't document that a NULL
> > value pointer is OK if the length is 0, and indeed the implementation
> > unconditionally calls memcpy(prop->data, val, len), which is
> > undefined behaviour, and warned about by clang sanitizers if you
> > build libfdt with them:
> >  dtc/libfdt/fdt_rw.c:288:21: runtime error: null pointer passed
> >    as argument 2, which is declared to never be null

=2E.but indeed that isn't really technically right.

> > So what's the best thing to do here? I can't offhand think of a
> > non-ugly/non-confusing way to pass a valid pointer here...
>=20
> Does fdt_setprop(fdt, nodeoffset, "propertyname", "", 0) do the right thi=
ng?

That should work, but it's a bit clunky.

I guess I should add an fdt_setprop_empty() to libfdt.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr2bkAAoJEGw4ysog2bOSFsQQAM3hVa4HQrPqieglSnzU9cz6
H1kQhO4Gg8wU07TPeiZYwdBSv/hyIKCck6w4r4q+iczEZyDsKKbCdNTdg4sZGxZo
hnSy16cI2qL1dr4UrbDR60L+yO+DphR4RH2ztCsmtZ6ODwBTcc4k91xhM4zes3dO
+8sMX/MoCQzTAvMQ6t2iAyZD7Seozf0JIwGlCRvg57k0A1bRgJNqnk4sMVqrWHtY
HEbzPD7lyZbJ2JmrGgqORkElD9Z2rquLxfWBEJOKmZ6HuLckNNmIYdMp965VW3XH
OM0k1bNNZkjz4h8n+ulHqK5D08eahSGFoZ0bBVoZ2pTQCTBjL0Z571JxNdIA+YXK
24PlW1z6zCYULMsr2N5lS3gg/e6UBUuB6gXlhZgKoREM/fnyX7NpJz6VOlVPZ24K
YYuQrGJMV9oKU8eLhnCjFpjaR/o1SWnrnHNV/zkWoOrx9emLq98zfiQjQ1XQ6jne
wp0jyC/Dbfcds7lf5cKA7vn1IbLGDJSZCy+3tchnTAnx9TlPAm7PKC99XDm3QRz+
3uzHfMDq9l09axdBghxQrUaGgPRhNzIPgy1EJ624y2nkzBYS6sXxGzzHhGMriXZq
/9ecxe4sHwj6kVRGShyWYt91Usi7MXLJsQ/Mlrso6F6WXVqFL6MdJzbaDZaaHUaZ
nJJt7h3pOFrRnrTklf81
=Y/B7
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
