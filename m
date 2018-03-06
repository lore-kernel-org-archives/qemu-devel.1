Received: from eggs.gnu.org ([2001:4830:134:3::10]:47585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etANa-0003Tp-9a
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etANW-0003t9-Aj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:03:34 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:44658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1etANW-0003sz-0k
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:03:30 -0500
Received: by mail-wr0-x233.google.com with SMTP id v65so20448534wrc.11
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:03:29 -0800 (PST)
Date: Tue, 6 Mar 2018 11:03:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306110326.GC31045@stefanha-x1.localdomain>
References: <151847184922.10299.8486156753106334227.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <151847184922.10299.8486156753106334227.malonedeb@wampee.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1749016] [NEW] VHDX BAT and Metadata Region
 Header Required Bit Not Set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1749016 <1749016@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 09:44:09PM -0000, Michael Fruchtman wrote:
> Public bug reported:
>=20
> When converting a VMDK to VHDX the resulting VHDX's Region table has a
> small error. According to the VHDX specification the BAT and Metadata
> entries for the region header required bit should be set to 1.  In a
> VHDX created by qemu-img, this bit is not set.

CCing Jeff Cody, VHDX maintainer.

>=20
> See Table 4: Known Region Properties of the VHDX specification.
>=20
> The structure format is as following from Structure 4: Region Table
> Entry:
>=20
> struct VHDX_REGION_TABLE_ENTRY {
> GUID Guid;
> UINT64 FileOffset;
> UINT32 Length;
> UINT32 Required:1;
> UINT32 Reserved:31;
> }
>=20
> The Required bit for VHDX specified BAT and Metadata Regions Required
> bit in the entry is not set as required in the current specification.
>=20
> VHDX Region Table in a valid VHDX
>=20
> Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
> 0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
> 0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
> 0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 01 00 00 00 =20
> 0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
> 0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 01 00 00 00
>=20
> VHDX Region Table in a VHDX converted by qemu-img from VMDK
>=20
> Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
> 0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
> 0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
> 0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 00 00 00 00 =20
> 0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
> 0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 00 00 00 00
>=20
> The fist bit at 0x0003002A and 0x0003004A should be set to 1.
>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
>=20
> ** Tags: qemu-img vhdx
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1749016
>=20
> Title:
>   VHDX BAT and Metadata Region Header Required Bit Not Set
>=20
> Status in QEMU:
>   New
>=20
> Bug description:
>   When converting a VMDK to VHDX the resulting VHDX's Region table has a
>   small error. According to the VHDX specification the BAT and Metadata
>   entries for the region header required bit should be set to 1.  In a
>   VHDX created by qemu-img, this bit is not set.
>=20
>   See Table 4: Known Region Properties of the VHDX specification.
>=20
>   The structure format is as following from Structure 4: Region Table
>   Entry:
>=20
>   struct VHDX_REGION_TABLE_ENTRY {
>   GUID Guid;
>   UINT64 FileOffset;
>   UINT32 Length;
>   UINT32 Required:1;
>   UINT32 Reserved:31;
>   }
>=20
>   The Required bit for VHDX specified BAT and Metadata Regions Required
>   bit in the entry is not set as required in the current specification.
>=20
>   VHDX Region Table in a valid VHDX
>=20
>   Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
>   0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
>   0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
>   0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 01 00 00 00 =20
>   0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
>   0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 01 00 00 00
>=20
>   VHDX Region Table in a VHDX converted by qemu-img from VMDK
>=20
>   Offset(h)    00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
>   0x00030000   72 65 67 69 AE 8C 6B C6 02 00 00 00 00 00 00 00
>   0x00030010   66 77 C2 2D 23 F6 00 42 9D 64 11 5E 9B FD 4A 08
>   0x00030020   00 00 30 00 00 00 00 00 00 00 10 00 00 00 00 00 =20
>   0x00030030   06 A2 7C 8B 90 47 9A 4B B8 FE 57 5F 05 0F 88 6E
>   0x00030040   00 00 20 00 00 00 00 00 00 00 10 00 00 00 00 00
>=20
>   The fist bit at 0x0003002A and 0x0003004A should be set to 1.
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1749016/+subscriptions
>=20

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJannV+AAoJEJykq7OBq3PIax4IAJGXMz8VhJmwDGDQuAXwEzmd
r5o+K8A+ZeSsujU1aeeLfUkFtux6zLv3ygQXJQDEwKv6875yigfTecFleeEE0T2N
b1qaJruz0R+1E3I1D9CCuiF1/4gowcJu/Olei75sKUjzmbKBVE7+qWP11+gBsJwW
RrADSUiSoadrM3pBQU+EXFwk86wbZDnxTMRZ1ZR7VPjV4sgMfSoLmibyh+vCNrLz
9dtRNBfAEPXTjfzO1fpSnjg7hFBDm/YUKIEaKCyuEdnnMolW6q2YW7uUbFg1PARG
hwR45h/5PbXu9M029Z6XZM7lNCsge3/qJqhrqAw3xpXGNPHGQGwmReI7X59MeXY=
=mIt3
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
