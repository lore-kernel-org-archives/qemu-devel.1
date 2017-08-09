Received: from eggs.gnu.org ([2001:4830:134:3::10]:51083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfU4y-0000Dd-2m
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfU4v-0004CJ-0U
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfU4u-0004Bu-MF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:43:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B33B381BE1
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 16:43:27 +0000 (UTC)
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-22-eblake@redhat.com>
	<87k22cn31f.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46a84732-098d-cc5a-978e-d7621c57a3c0@redhat.com>
Date: Wed, 9 Aug 2017 11:43:24 -0500
MIME-Version: 1.0
In-Reply-To: <87k22cn31f.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I7Abl0egFTxLD9U7GjBOov5MPOpqlBh57"
Subject: Re: [Qemu-devel] [PATCH v4 21/22] libqtest: Drop now-unused qmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I7Abl0egFTxLD9U7GjBOov5MPOpqlBh57
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <46a84732-098d-cc5a-978e-d7621c57a3c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 21/22] libqtest: Drop now-unused qmp()
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-22-eblake@redhat.com>
 <87k22cn31f.fsf@dusky.pond.sub.org>
In-Reply-To: <87k22cn31f.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 11:01 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> All callers have been converted to a form of qmp_cmd() or
>> qmp_args() that takes the command name with less boilerplate.
>> Therefore, we also know that all commands are using
>> interpolation, and can remove an assertion.
>>
>> This also means that we have fixed the testsuite to comply with
>> -Wformat checking on the strings being interpolated for qmp()
>> (similar to what we previously did for strings used in hmp(), and
>> matching the checking present on qobject_from_jsonf()).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> -     * A round trip through QObject is only needed if % interpolation=

>> -     * is used.  We interpolate through QObject rather than sprintf i=
n
>> -     * order to escape strings properly.
>> +     * A round trip through QObject (and not sprintf) is needed
>> +     * because % interpolation is used, and we must escape strings
>> +     * properly.
>>       */
>> -    if (!strchr(fmt, '%')) {
>> -        qmp_fd_send(s->qmp_fd, fmt);
>> -        return;
>> -    }
>> +    assert(strchr(fmt, '%'));
>=20
> What exactly is wrong with a @fmt that doesn't contain '%'?

Nothing, so much as proving to myself that I indeed converted all the
qmp() calls.  As before, the assertion is not vital to the series, and
can be omitted on the respin.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--I7Abl0egFTxLD9U7GjBOov5MPOpqlBh57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLO6wACgkQp6FrSiUn
Q2qLZgf+OJm2BZ/fOIqhyyTlIqdZOP1OVpkVnFBV0EoicHnIIQFFw/5hrR1qp/Y6
5DH/lwzLNWp75kLBUXy8dHi6GjsKkc6WspZ/GMElUOTs7T14w7pBYfoRs1jcTi+o
Lz9gJNfSBw4lLphfn6WUiSjI2I2iw++E6Q8EAGVycNtM10gmomXN2PzxvMgulYjU
R1eqffei+SdBLt3Ut/nCDE9GF+nY3sIALtCOUSw+IR8zbawyzoWlsXb2l7dBVv3Y
sGog77WlE7EyGF64Rjga082wkB9nvqRfe3I7zo6qJ53VCUingXpHyVAf7gICVeRu
dfoJaOYv05UXS2JgHtQophDwnfQIkQ==
=Fz63
-----END PGP SIGNATURE-----

--I7Abl0egFTxLD9U7GjBOov5MPOpqlBh57--
