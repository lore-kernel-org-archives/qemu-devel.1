Received: from eggs.gnu.org ([2001:4830:134:3::10]:33604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn3S2-0008Gp-24
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn3Rz-0004o0-GA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:54:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dn3Rz-0004no-6X
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:54:35 -0400
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-2-marcandre.lureau@redhat.com>
	<8b2a2be0-cf5f-29e4-b204-1da6b20539b7@redhat.com>
	<87r2vtgt7r.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff74a968-d71f-a1f7-9fa8-3235bb4fa9be@redhat.com>
Date: Wed, 30 Aug 2017 08:54:28 -0500
MIME-Version: 1.0
In-Reply-To: <87r2vtgt7r.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x76Prg3B3pwwlh9gPe279TmLqq6gsJuhe"
Subject: Re: [Qemu-devel] [PATCH v2 01/14] qdict: add qdict_put_null() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x76Prg3B3pwwlh9gPe279TmLqq6gsJuhe
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <ff74a968-d71f-a1f7-9fa8-3235bb4fa9be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/14] qdict: add qdict_put_null() helper
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
 <20170825105913.4060-2-marcandre.lureau@redhat.com>
 <8b2a2be0-cf5f-29e4-b204-1da6b20539b7@redhat.com>
 <87r2vtgt7r.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2vtgt7r.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 07:01 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 08/25/2017 05:59 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> A step towards completeness.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  include/qapi/qmp/qdict.h | 4 +++-
>>>  target/i386/cpu.c        | 4 ++--
>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> Is it worth touching up scripts/coccinelle/qobject.cocci at the same t=
ime?
>=20
> Let's keep it up-to-date.  I can do it when I apply.
>=20
>> I guess we don't care about a qlist_append_null() variant?
>=20
> Only if we have users.

Most (all?) of our qlist_ users tend to be heterogenous; we insert list
members that have the same type. I don't see anyone wanting a list of
all null objects any time soon; about the only reason to support it
would be if we wanted a list of the StrOrNull alternate type, where some
list elements can be null.  But you're right that we don't have to add
it now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--x76Prg3B3pwwlh9gPe279TmLqq6gsJuhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmmw5QACgkQp6FrSiUn
Q2qfjggAmNVvYKZxFNkmiSy9gD56VqhptRaOVnZpP8atcs0ajIFSjFRPZF53Qv4V
i+1Fvmno+2DyQ6B+AO17QwqTH+XzVs+TUZBmbosS6qr5Cn5yCYq2b6E7duaufsYh
Zk7HlzDf82GiIXU6GvJOv09AGNTpOZm2JuTBtc5KxBL6uEbthWsYABz0PVHqH6jq
WwSn0rL7hwFlxc7S8NHFtDP60JeFM+ctCgecieMUFxEzBPZBwkJsLmdQJM9iBn4w
IcGDxFwucWKoj3ICmZcqRdgET91l1Ku/K+dYnDLGwH3AmQHq7OH859LspZ+5aEYq
mKq9QtEXlpwxS4K1y02n0XG0ztkzVw==
=JD5C
-----END PGP SIGNATURE-----

--x76Prg3B3pwwlh9gPe279TmLqq6gsJuhe--
