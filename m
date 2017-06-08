Received: from eggs.gnu.org ([2001:4830:134:3::10]:40411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJ3pp-00026H-NK
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJ3pm-0007EG-IC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:15:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJ3pm-0007DM-9G
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:15:10 -0400
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-6-marcandre.lureau@redhat.com>
	<56127bd4-c7b5-6589-9dc6-58dc955e7103@redhat.com>
	<1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
	<87r2yug8x5.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab7a8be9-ab79-984c-0059-03034d267314@redhat.com>
Date: Thu, 8 Jun 2017 15:15:02 -0500
MIME-Version: 1.0
In-Reply-To: <87r2yug8x5.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7IoRdgg6vKQ2EiKkhcnEq9mMVhWOr9Qkd"
Subject: Re: [Qemu-devel] [PATCH 5/5] coccinelle: prefer glib g_new/g_renew
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7IoRdgg6vKQ2EiKkhcnEq9mMVhWOr9Qkd
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 peter maydell <peter.maydell@linaro.org>
Message-ID: <ab7a8be9-ab79-984c-0059-03034d267314@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] coccinelle: prefer glib g_new/g_renew
 macros
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
 <20170607074632.13162-6-marcandre.lureau@redhat.com>
 <56127bd4-c7b5-6589-9dc6-58dc955e7103@redhat.com>
 <1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
 <87r2yug8x5.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2yug8x5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 03:50 AM, Markus Armbruster wrote:
>>> Your script differs from Markus', we should figure out if they can be=

>>> merged into one.
>>
>> One notable difference is that I abuse expression, instead of type. I =
didn't manage to teach spatch about the includes and custom type (--all-i=
ncludes didn't work). I just tried with expression and it was happy, I ha=
ven't searched further.
>=20
> Does your semantic patch more, less, or both?

I have not tried to find out - but the idea would be:
if you run Markus' script first, does Marc-Andr=C3=A9's find anything?
if you run Marc-Andr=C3=A9's script first, does Markus' find anything?

>> Sadly, my script is really far from perfect. And I don't how much time=
 it will take me to make it better, and if I really want to spend that ti=
me for this. In any case, the result needs careful review. So thought it =
would be easier to provide a patch that I manually changed/reviewed, rath=
er than a full cocci script.

On the other hand, since it is something that we have done repeatedly,
having it reviewed into a full cocci script that we store in git will
make future re-runs easier (we can incrementally improve the cocci
script as we gain experience with additional patterns that work).

>=20
> I can play with the script when this series reaches the front of my
> review queue.

Fingers crossed that your review queue isn't a year long any more (even
if I do understand that you will not be reviewing much during your time
off later this month).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7IoRdgg6vKQ2EiKkhcnEq9mMVhWOr9Qkd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZObBGAAoJEKeha0olJ0NqZnUIAKKpIBTCeu/N4PGfW98yiGZv
cljgmEv21F4A0PZ/9AXYJmDlCXE847zKR2iHNSoUERIRt47PtycREzEynbv9q8Zd
UqLg3FiEGy97bSrjc01w9LJ/beByFShB19TW9vzpTd0hw1kPgbCdSJ50CnRMgFg9
/TVPCd7LlbCTOPP96QunB9nO2CQnUBSp+O5LDAgIOaseXjwhNni2U74a3fC7sUWA
OBTBVdckfPuh0O9DXsPU78t7tP6MK+X37SE3O851BHaipd0eEmfUg7a85WpT9myo
N/ujxvgf/sU1yQNyBZCyT0UCP+/dP4CnaGB13O1srhPf8MQWIM9oTk4yrb0Cr6k=
=sgf0
-----END PGP SIGNATURE-----

--7IoRdgg6vKQ2EiKkhcnEq9mMVhWOr9Qkd--
