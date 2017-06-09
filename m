Received: from eggs.gnu.org ([2001:4830:134:3::10]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJM44-0007Ui-SA
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJM40-0000D6-AC
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJM40-0000Cs-1E
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:43:04 -0400
References: <20170609133337.31183-1-marcandre.lureau@redhat.com>
	<650896fb-d42b-3ce7-8660-4c1275a5e360@redhat.com>
	<87wp8lb2el.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88c191e7-612f-4c7d-1594-fc1f73318489@redhat.com>
Date: Fri, 9 Jun 2017 10:42:58 -0500
MIME-Version: 1.0
In-Reply-To: <87wp8lb2el.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HJ1hwkGo4ooh0RDTIhON7HqqlBEFBxdaA"
Subject: Re: [Qemu-devel] [PATCH] tests: check-qom-proplist: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HJ1hwkGo4ooh0RDTIhON7HqqlBEFBxdaA
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Message-ID: <88c191e7-612f-4c7d-1594-fc1f73318489@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: check-qom-proplist: fix leak
References: <20170609133337.31183-1-marcandre.lureau@redhat.com>
 <650896fb-d42b-3ce7-8660-4c1275a5e360@redhat.com>
 <87wp8lb2el.fsf@dusky.pond.sub.org>
In-Reply-To: <87wp8lb2el.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 10:34 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 06/09/2017 08:33 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> user_creatable_add_opts() returns a reference (the other reference is=

>>> for the root parent/child link).
>>>
>>> Leak introduced in commit a1af255f065cc.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  tests/check-qom-proplist.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
>>> index 8e432e9ab6..a3cd7ab29f 100644
>>> --- a/tests/check-qom-proplist.c
>>> +++ b/tests/check-qom-proplist.c
>>> @@ -428,6 +428,8 @@ static void test_dummy_createcmdl(void)
>>>      g_assert(err =3D=3D NULL);
>>>      error_free(err);
>>> =20
>>> +    object_unref(OBJECT(dobj));
>>
>> This should be spelled QDECREF(dobj);
>=20
> Caution, this is object_unref(), not qobject_decref().

Indeed - now that I re-read it closely, I see that you are right.  Oh
well - I didn't waste much time improving the qobject coccinelle script,
even though this patch proposal is unrelated to that one. :)

>=20
> We suck at naming.

Not the first time.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HJ1hwkGo4ooh0RDTIhON7HqqlBEFBxdaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOsICAAoJEKeha0olJ0NqSuUIAIvPMO0uAwJfr2tHLS4rqyp/
fc/J8SXaEkVywxHehBRI27FFzAJZxEx3neyNs9epK2al2BGb0qxTlKyyK9+Y2is2
cuafdDQCeSt1Wmg8pX/xPCdRFjSau6ar4KU0TQKc8PYVFsUlcJyjbM6+CU6bT/my
xmsmbjX0yNMPSZAVB3buMQOc6NpI4JmU/Drs2Sks01dsNuQ27PsuRsXkQEniekcL
NxTyt4mv4frRDRY5m5g85axVsVHKF11zGUpOyxKTV8xXEPPejeSCXM5n8FusjxmU
jeGJ8euS/4u0PL8y68KqcqghZPFOmfpybuMGSfpHeY+6HWdoJrF0Wrvj73EkokM=
=bmDk
-----END PGP SIGNATURE-----

--HJ1hwkGo4ooh0RDTIhON7HqqlBEFBxdaA--
