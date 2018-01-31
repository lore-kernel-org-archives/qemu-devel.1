Received: from eggs.gnu.org ([2001:4830:134:3::10]:47329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egoIo-0003li-9T
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egoIj-0000KA-O6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:03:34 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:35661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1egoIj-0000JK-EF
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:03:29 -0500
Received: by mail-it0-x231.google.com with SMTP id e1so4189449ita.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 01:03:28 -0800 (PST)
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
	<1516372482.3278.29.camel@redhat.com>
	<1516702111.31897.2.camel@redhat.com>
	<20180123112025.GI11419@umbus> <1516709019.31897.4.camel@redhat.com>
	<20180123124922.GB14832@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <52a52f21-2946-b004-17be-53178ae60a08@ozlabs.ru>
Date: Wed, 31 Jan 2018 20:03:21 +1100
MIME-Version: 1.0
In-Reply-To: <20180123124922.GB14832@umbus>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1vdFeWT0CJiTde3NYhOqa0LwjAeFuk7bV"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1vdFeWT0CJiTde3NYhOqa0LwjAeFuk7bV
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52a52f21-2946-b004-17be-53178ae60a08@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
References: <20180119050906.18930-1-aik@ozlabs.ru>
 <20180119051926.GI30352@umbus.fritz.box>
 <6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
 <1516372482.3278.29.camel@redhat.com> <1516702111.31897.2.camel@redhat.com>
 <20180123112025.GI11419@umbus> <1516709019.31897.4.camel@redhat.com>
 <20180123124922.GB14832@umbus>
In-Reply-To: <20180123124922.GB14832@umbus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/01/18 23:49, David Gibson wrote:
> On Tue, Jan 23, 2018 at 01:03:39PM +0100, Andrea Bolognani wrote:
>> On Tue, 2018-01-23 at 22:20 +1100, David Gibson wrote:
>>>> David, I know you're busy with linux.conf.au, but it would be
>>>> really helpful if you could carve out five minutes to look over
>>>> Alexey's proposal again, with my reply above in mind, and let us
>>>> know whether it looks a reasonable design. Doesn't have to be a
>>>> review, just a quick feedback on the high-level idea.
>>>
>>> It looks ok, I think, but I don't think I'm really the right person t=
o
>>> ask.  I do wonder if creating a throwaway instance could cause
>>> trouble, especially for something like machine that might well have
>>> gotten away with having global side-effects in the past.  I think we
>>> need to talk with someone who knows more about qom and qapi - Markus
>>> seems the obvious choice.
>>
>> Good point. CC'ing Markus to try and grab his attention :)
>=20
> It's also occurred to me that making a spapr specific approach to this
> might not be quite as horrible as I initially thought.  The
> capabilities table is global (and immutable) so coding up a
> "get-spapr-caps" qapi entry point which encodes the stuff there into
> json giving the names and allowed values of each cap would be fairly
> straightforward.
>=20
> Accurately retreiving default values would be trickier, not sure if
> that's important or not.



So, do we want to push it further? Markus has not reacted, added Paolo.

http://patchwork.ozlabs.org/patch/863325/


--=20
Alexey


--1vdFeWT0CJiTde3NYhOqa0LwjAeFuk7bV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlpxhlkOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILlCZw//U4Z0wE7gwEWBHiwQQXUHvwsYXidjbhP2fe/F
UxoyacSHEj/FOKO4+nPR1R8LTKolEiPaG4yBg3GbGrOVM+7TYR+pHBnbtq00IYvw
URZrnwr6mpN9OT5axtaigEW5RZRIFLz5PYiUk0Wco9QrsWFeVQXcq8DjYtw1uv8W
hTqcCgDC+YH+/Da3Oglcusocbd9RdOT2mpp0DtuFu68AGv2HZNjeW/ZED0Pdeolz
WvujtSvrIfOJjKGJgHJRAxswNCS7Yy7BVHt1Lp33P2GX8wnQFX2/eJrKUhl7BM6z
VzMWTH2anJVAl2HeKakYWaOuUtInWUdyfHEeJgOGuGq3lkVyQzLD05CssZ2DfYS3
rSLgzrrx23TOqPXmO6KSrAXaJe4qeT5ai0SRl9CcDTelMfMA9YUxolSBUjE9kFkH
zbQnGgrFfE3v8hbQUilS7a/CtHNrtm/0qpkrf2xDKWGn+6uRrnI3h3TkFDtjld3D
3L5Q+ZOhYe8X9C6bRiXMBvvOkfq2oOCkFAWQ6MXPbzJTacvuGnh8SShRVcv+562E
2eGkjw2XywJuFb3bvA2sYMyrgfoSEJRKvKsQEnQdW5i8W0I5l7DdzFh3Yf5CPQRS
g8FgkFv9gNehBoGs+z+2CrJ0d0IWJVmVfG13Tx5vDaT6XYJP64FwIalQ51lz0nTK
PdNhxUg=
=MBAM
-----END PGP SIGNATURE-----

--1vdFeWT0CJiTde3NYhOqa0LwjAeFuk7bV--
