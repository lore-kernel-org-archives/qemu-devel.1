Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfU3V-0007QN-Sn
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfU3S-0003bR-Q2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:42:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfU3S-0003bD-Gl
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:41:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C1FA381BC9
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 16:41:57 +0000 (UTC)
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-20-eblake@redhat.com>
	<87o9ron34y.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77053a1d-b68e-0f7c-16dd-0be36f629728@redhat.com>
Date: Wed, 9 Aug 2017 11:41:56 -0500
MIME-Version: 1.0
In-Reply-To: <87o9ron34y.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GsDeBmAW7MBAmpxMT5XDxrjuBMMmWVsx3"
Subject: Re: [Qemu-devel] [PATCH v4 19/22] libqtest: Add qmp_args_dict()
 helper
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
--GsDeBmAW7MBAmpxMT5XDxrjuBMMmWVsx3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <77053a1d-b68e-0f7c-16dd-0be36f629728@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 19/22] libqtest: Add qmp_args_dict()
 helper
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-20-eblake@redhat.com>
 <87o9ron34y.fsf@dusky.pond.sub.org>
In-Reply-To: <87o9ron34y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:59 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Leaving interpolation into JSON to qobject_from_jsonf() is more
>> robust than building QMP input manually; however, we have a few
>> places where code is already creating a QDict to interpolate
>> individual arguments, which cannot be reproduced with the
>> qobject_from_jsonf() parser.  Expose a public wrapper
>> qmp_args_dict() for the internal helper qmp_args_dict_async()
>> that we needed earlier for qmp_args(), and fix a test to use
>> the new helper.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +++ b/tests/device-introspect-test.c
>> @@ -36,8 +36,7 @@ static QList *qom_list_types(const char *implements,=
 bool abstract)
>>      if (implements) {
>>          qdict_put_str(args, "implements", implements);
>>      }
>> -    resp =3D qmp("{'execute': 'qom-list-types',"
>> -               " 'arguments': %p }", args);
>> +    resp =3D qmp_args_dict("qom-list-types", args);
>>      g_assert(qdict_haskey(resp, "return"));
>>      ret =3D qdict_get_qlist(resp, "return");
>>      QINCREF(ret);
>=20
> If we had five of these, the helper would be worth its keep.

This patch only  has one client, but 20/22 adds another.  Is having 2
clients sufficient to keep it (not quite the 5 that makes it obvious,
but still a good reuse of code)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GsDeBmAW7MBAmpxMT5XDxrjuBMMmWVsx3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLO1QACgkQp6FrSiUn
Q2rgCwf9HQbNiJ9kW8wsBn4UBdSHpzEpfMc11JmD1630/D6fxRiiCQkxVElUqQAG
Km5i5LlZcyE1AyFEjSu04DlqMW82a5K/T55EWlW8yp2dprb+0mKwUvookf2d2B3k
TwBJ16dU6Cafsk0+gAD/ajXTkIGs9R/7I4E0BRH4RRY6N7PiQ4QoPKZqEzud/MVj
gPvJoHh9f95jdgZ3wg0hL/ebEKb9KJCJ/19rmPt+CAXzRjnjYdxZgLZbpwOhP6Ph
iDU0o0vgaTnaW1JjBu2gFJ14UJyIp6uhlRkrKt1XGG8X2cerankNS9fVCAylZTzm
SQIf3A8huzInKraINYov7FR6Y3BZ2A==
=03aF
-----END PGP SIGNATURE-----

--GsDeBmAW7MBAmpxMT5XDxrjuBMMmWVsx3--
