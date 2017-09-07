Received: from eggs.gnu.org ([2001:4830:134:3::10]:33164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dq29e-0001Kj-Dy
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dq29Z-0002Yx-Km
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dq29Z-0002YS-Bs
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 15:07:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 625AD81DFD
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 19:07:52 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-28-eblake@redhat.com>
	<ef46a4d8-27f8-296a-1336-2678beb1a332@redhat.com>
	<ea485554-e4fd-44e1-f0ab-579ca0ead575@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <718433c5-59b8-f949-12a1-6f2cd3242d3c@redhat.com>
Date: Thu, 7 Sep 2017 21:07:42 +0200
MIME-Version: 1.0
In-Reply-To: <ea485554-e4fd-44e1-f0ab-579ca0ead575@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="udjwfcU8urBjkNHb3q0DAc2VpDmKFhg1U"
Subject: Re: [Qemu-devel] [PATCH v6 27/29] libqtest: Make qtest_init()
 accept format string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--udjwfcU8urBjkNHb3q0DAc2VpDmKFhg1U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.2017 20:00, Eric Blake wrote:
> On 09/05/2017 07:46 AM, Thomas Huth wrote:
>> On 01.09.2017 20:03, Eric Blake wrote:
>>> Several callers were formatting a string into a temporary
>>> variable before calling qtest_init(); factor that into the
>>> common code.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>=20
>>> -QTestState *qtest_init(const char *extra_args);
>>> +QTestState *qtest_init(const char *extra_args, ...) GCC_FMT_ATTR(1, =
2);
>>
>> Maybe the parameter should be called "fmt" or "format" now instead?
>> (similar to printf() and friends)
>=20
> Sure.
>=20
>>
>>>  /**
>>>   * qtest_init_without_qmp_handshake:
>>> @@ -518,7 +519,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const v=
oid *data);
>>>   */
>>>  static inline QTestState *qtest_start(const char *args)
>>>  {
>>> -    global_qtest =3D qtest_init(args);
>>> +    global_qtest =3D qtest_init("%s", args);
>>
>> That's a little bit sad that there are some spots which need an explic=
it
>> "%s" now ... maybe it would be nicer to add a new function called
>> qtest_initf() instead and keep the old one (without the "f") as it is?=

>=20
> Indeed, and looking back over my series, I see we could also benefit
> from a va_list form.
>=20
> Also, since you already questioned me on the churn from qtest_start() =3D=
>
> qtest_init() =3D> qtest_start(), I can make less churn in the next spin=
 by
> converging on qtest_start() from the get-go.
>=20
> So I will go with qtest_start() (plain string), qtest_startf()
> (formatted like sprintf), and qtest_vstartf() (formatted like vsprintf)=
=2E

Thanks, that sounds like a better way to me, too!

 Thomas



--udjwfcU8urBjkNHb3q0DAc2VpDmKFhg1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZsZkCAAoJEC7Z13T+cC21TDMQAIAfIuE59Gerdk2ow9qoOqZ5
5xKO1be06BRyuTF/spXKfSSHfSoaWViWvcMzsGFJkplHdGk/d6F9c+v6Yqags5JZ
dfwWARQpwGxR2yQWl6I768mI+F4oNlbZ4rovGv/JVunzBIXquthZFbkw35ItRA9i
lawjP0BENXa+mMGVBTuIcUKk3NbePe+jP1m2w89EhpMcKIETrH9qe32OpdrIvUlB
ZmEu2AopJc7/+dBgDqjdFSxHL+tVI6C5vEjaty4Kg9QdPL8hwscFlJufkAz/64aG
pKchd4qxZx6sgKqPq1KV52hutnNOhRaNo+FgzFiDsSd99DsM+okYjWXKwIe2Mghm
XEYy8ndtZP/UOZfe+h6tB0xB7Pk5b3gDpaZ4m5VISaetJHfM10DwEoUFgSGUbHB3
pJ4Qyr4MMRngGleo69UaJ7O9QCnKUi0c31M1w3Lsi35ne6yW1QUednLFyRkWbvMb
0p+WFHpJKmKlyXc3dZqdDK1Z6oiQCc/lMslT1jaA0odjwQlxAAFTYXBEIc1oFqZL
3qWBI0o38wNY9hxOTldd4Rq/BsnER1VXUYVi6hxyCB7yShviVOFTkIP92F/J+7mZ
cnWEIx+HpQxxRH82Elo7c965qOCDgOYJlMTTLJH+c5kR8No7+FglJER/Sz2OKcYE
+0Zs+v3QGltsQmVXUx2P
=vRXN
-----END PGP SIGNATURE-----

--udjwfcU8urBjkNHb3q0DAc2VpDmKFhg1U--
