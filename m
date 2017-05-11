Received: from eggs.gnu.org ([2001:4830:134:3::10]:53489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8piq-0001aD-04
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8pio-0006Jw-Tw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8pio-0006Jb-Kw
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90DBFC04B951
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:09:41 +0000 (UTC)
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
	<8737cbv53y.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d09d75e7-e0a6-bd50-7cb0-2862f7314fe8@redhat.com>
Date: Thu, 11 May 2017 10:09:37 -0500
MIME-Version: 1.0
In-Reply-To: <8737cbv53y.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hiXDRFSlP2wPWlKcA1N0jBqItcxMlimtG"
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hiXDRFSlP2wPWlKcA1N0jBqItcxMlimtG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <d09d75e7-e0a6-bd50-7cb0-2862f7314fe8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
 <20170509173559.31598-5-marcandre.lureau@redhat.com>
 <8737cbv53y.fsf@dusky.pond.sub.org>
In-Reply-To: <8737cbv53y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 09:29 AM, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> We would like to use a same QObject type to represent numbers, whether=

>> they are int, uint, or floats. getters will allow some compatibility
>=20
> Please start your sentence with a capital letter ...
>=20
>> between the various types if the number fits other representations
>=20
> ... and end them with a period.
>=20

>> +++ b/block/qapi.c
>> @@ -595,9 +595,11 @@ static void dump_qobject(fprintf_function func_fp=
rintf, void *f,
>>                           int comp_indent, QObject *obj)
>>  {
>>      switch (qobject_type(obj)) {
>> -        case QTYPE_QINT: {
>> -            QInt *value =3D qobject_to_qint(obj);
>> -            func_fprintf(f, "%" PRId64, qint_get_int(value));
>> +        case QTYPE_QNUM: {
>> +            QNum *value =3D qobject_to_qnum(obj);
>> +            char *tmp =3D qnum_to_string(value);
>> +            func_fprintf(f, "%s", tmp);
>> +            g_free(tmp);
>>              break;
>>          }
>>          case QTYPE_QSTRING: {
>=20
> Becomes a bit awkward due to the dynamically allocated buffer.  Let's
> ignore that for now.
>=20
> Aside: I don't like that the block layer has its own dump_qobject().

I should really revive my patches for a QAPI JSON output visitor.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hiXDRFSlP2wPWlKcA1N0jBqItcxMlimtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFH6xAAoJEKeha0olJ0NqKasH/R0e/TI3zYwG2wtECXhPhEwR
yJShtEsbf6dZZb6a6Ur3aQNIm7Wks3A7PPxcGwA39q18fRspjopX2ag+rgB/YYEu
qlYI3m52RaYfdfWwndy5JtnMFrzD+aSXVJYlpVyKVmL6dPEklznII7Qp/g2C276x
YeWlnFG/rcLusOUthFh/DC3D0RRh0nLKDjq0h+d4+5UOAKKSUrBiBRV5JLLqqVeB
N5rW6+6JOhtLLtowtbWs5nA+nqBH8IXi9rTCBe5YbgqXTB8LMvr3/6higUtSiJ/4
5Vhw9BPOECw8UulZnSw0C7mE1y63GtJ6IJQYFyPVdTCtZglhkX9LAs68YFTm9tg=
=3/wq
-----END PGP SIGNATURE-----

--hiXDRFSlP2wPWlKcA1N0jBqItcxMlimtG--
