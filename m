Received: from eggs.gnu.org ([2001:4830:134:3::10]:39696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJ3m8-0000cG-Fj
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJ3m3-0005si-R0
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:11:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJ3m3-0005sQ-Hi
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 16:11:19 -0400
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-6-marcandre.lureau@redhat.com>
	<56127bd4-c7b5-6589-9dc6-58dc955e7103@redhat.com>
	<1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64380e4d-bfe8-55ea-ae49-a0bdc3ffcc2a@redhat.com>
Date: Thu, 8 Jun 2017 15:11:12 -0500
MIME-Version: 1.0
In-Reply-To: <1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gTtSaOBP9UIFMkMtb9Vqi8h0D7nePGtg8"
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gTtSaOBP9UIFMkMtb9Vqi8h0D7nePGtg8
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 peter maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <64380e4d-bfe8-55ea-ae49-a0bdc3ffcc2a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] coccinelle: prefer glib g_new/g_renew
 macros
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
 <20170607074632.13162-6-marcandre.lureau@redhat.com>
 <56127bd4-c7b5-6589-9dc6-58dc955e7103@redhat.com>
 <1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
In-Reply-To: <1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 03:23 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Your script differs from Markus', we should figure out if they can be
>> merged into one.
>=20
> One notable difference is that I abuse expression, instead of type. I d=
idn't manage to teach spatch about the includes and custom type (--all-in=
cludes didn't work). I just tried with expression and it was happy, I hav=
en't searched further.
>=20
>>
>>> (
>>> - g_malloc0(sizeof(*e2))
>>> + g_malloc0(sizeof(*e2))
>>
>> Huh?
>>
>>> |
>>> - g_malloc(sizeof(*e2))
>>> + g_malloc(sizeof(*e2))
>>
>> Huh?
>=20
> That's what I explained in the cover letter, I don't wont those to be t=
ouched, but they would because I abuse expressions...

Ah. So you're writing a multi-pass filter: if it matches the first
branch, then don't try later branches; otherwise if it matches the later
branch, perform the substitution in the later branch.

But that can be written:

(
 g_malloc0(sizeof(*e2))
|
 g_malloc(sizeof(*e2))
|
- ...
+ ...
)

where you don't have to use -/+ patch form for the lines that you are
intentionally leaving unchanged because they are already in the right
form and where you therefore don't want any subsequent branches of the
pattern to be matched.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gTtSaOBP9UIFMkMtb9Vqi8h0D7nePGtg8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOa9gAAoJEKeha0olJ0Nq1JoH/jqG+wR6Vy56FBA9YYFPOd/w
jW2IqcJihX35MFDAFbv9uYAWYSMLSpWJhATYuL0Qgh6mF4y2fuB347Kiv16NFErq
04HVYDDmmwsMsCpAb799RB+cWwTzUFeszrPsvwMKd3Y8MXKq9tXYNwLQV0HttJsa
R3flgXDpS8pkdTM7wYmcSG9AYRDl8MmRmzki2z2Uq+yV8o4Xx4StB1OaIDaw1Wc6
2hIaWgFRi8PCMx52Hol3ySUmNdj9utxUNbUOvtCyVGIlro198Pv1MEvZX3efZmOY
Mly80kc8GPD4M7EZN8bGCdvINh5hI4X3b5aq6mebYLRTcyGpilamb6iKfRlqgpg=
=THoW
-----END PGP SIGNATURE-----

--gTtSaOBP9UIFMkMtb9Vqi8h0D7nePGtg8--
