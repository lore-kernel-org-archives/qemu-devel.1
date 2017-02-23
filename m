Received: from eggs.gnu.org ([2001:4830:134:3::10]:39934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgukg-0000nG-Of
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgukb-0005yj-V6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:52:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgukb-0005ya-Ly
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:52:09 -0500
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
Date: Thu, 23 Feb 2017 08:52:01 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iCSdo9tLCCqKjO4KpcGSQ5B5aTD0G7u9P"
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
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iCSdo9tLCCqKjO4KpcGSQ5B5aTD0G7u9P
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
Subject: Re: [Qemu-devel] using fdt_setprop() to set properties to empty
 values
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
In-Reply-To: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 06:33 AM, Peter Maydell wrote:
> What's the right way to use libfdt's fdt_setprop to set a property
> to have an empty value? At the moment in QEMU we tend to use
>   fdt_setprop(fdt, nodeoffset, "propertyname", NULL, 0);
>=20
> and git grep 'fdt_setprop.*NULL' produces examples of this usage in
> PPC and ARM fdt creation code.
>=20
> However the fdt_setprop() documentation doesn't document that a NULL
> value pointer is OK if the length is 0, and indeed the implementation
> unconditionally calls memcpy(prop->data, val, len), which is
> undefined behaviour, and warned about by clang sanitizers if you
> build libfdt with them:
>  dtc/libfdt/fdt_rw.c:288:21: runtime error: null pointer passed
>    as argument 2, which is declared to never be null
>=20
> So what's the best thing to do here? I can't offhand think of a
> non-ugly/non-confusing way to pass a valid pointer here...

Does fdt_setprop(fdt, nodeoffset, "propertyname", "", 0) do the right thi=
ng?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iCSdo9tLCCqKjO4KpcGSQ5B5aTD0G7u9P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrvcRAAoJEKeha0olJ0NqxHIH/jfzulnBbWwj8eb/aF+FmtXr
TPTK309oiTE64QsjeUPDKeOT/HR5S25lvOAVlArqhun2QRFqnWSGQG9gOeWXKAM3
3k6gbPccMM4B8DMCRX/05B2tCUpE4I27yo5uA3p5SYmBmy1dKSsf9XVP9eyjgYcX
5pEFs77/ntWHsasl/lpE2F2rB3a2o3otDKE4Tpji/KrA8pa5ljXZ25Wg6GPga3yS
cquUh2fj9S/QuAXWLQon5BZFYdMPdsUGgN21eNslg7NSRDsXTH9hdddWRRNGgxDp
ft0RsOdMZKQ4TQo19e443d2fOzaI6Q/b+EV99U9fjj1iGbRTDnhwBrLSiIote8s=
=uyd0
-----END PGP SIGNATURE-----

--iCSdo9tLCCqKjO4KpcGSQ5B5aTD0G7u9P--
