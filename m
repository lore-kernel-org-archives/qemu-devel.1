Received: from eggs.gnu.org ([2001:4830:134:3::10]:39033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHQi-0005tn-GA
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHQh-0007Jn-JG
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:58:52 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-3-mreitz@redhat.com>
	<c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <afd63f12-6b1c-1981-ac3a-52d108725e2d@redhat.com>
Date: Mon, 26 Feb 2018 12:58:26 +0100
MIME-Version: 1.0
In-Reply-To: <c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lLE2FK2wI3IctvyK6LTaQHhngVyLA8WSF"
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lLE2FK2wI3IctvyK6LTaQHhngVyLA8WSF
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <afd63f12-6b1c-1981-ac3a-52d108725e2d@redhat.com>
Subject: Re: [PATCH v3 2/7] qapi: Add qobject_to()
References: <20180224154033.29559-1-mreitz@redhat.com>
 <20180224154033.29559-3-mreitz@redhat.com>
 <c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
In-Reply-To: <c8a20a6d-039f-544a-3b58-098f6be19ecf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-24 21:57, Eric Blake wrote:
> On 02/24/2018 09:40 AM, Max Reitz wrote:
>> This is a dynamic casting macro that, given a QObject type, returns an=

>> object as that type or NULL if the object is of a different type (or
>> NULL itself).
>>
>> The macro uses lower-case letters because:
>> 1. There does not seem to be a hard rule on whether qemu macros have t=
o
>> =C2=A0=C2=A0=C2=A0 be upper-cased,
>> 2. The current situation in qapi/qmp is inconsistent (compare e.g.
>> =C2=A0=C2=A0=C2=A0 QINCREF() vs. qdict_put()),
>> 3. qobject_to() will evaluate its @obj parameter only once, thus it is=

>> =C2=A0=C2=A0=C2=A0 generally not important to the caller whether it is=
 a macro or not,
>> 4. I prefer it aesthetically.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/qapi/qmp/qobject.h | 30 ++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 30 insertions(+)
>>
>=20
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -50,6 +50,22 @@ struct QObject {
>> =C2=A0 #define QDECREF(obj)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_decref(obj ? QOBJECT(obj) : NUL=
L)
>> =C2=A0 +/* Required for qobject_to() */
>> +#define QTYPE_CAST_TO_QNull=C2=A0=C2=A0=C2=A0=C2=A0 QTYPE_QNULL
>> +#define QTYPE_CAST_TO_QNum=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QTYPE_QNUM
>> +#define QTYPE_CAST_TO_QString=C2=A0=C2=A0 QTYPE_QSTRING
>> +#define QTYPE_CAST_TO_QDict=C2=A0=C2=A0=C2=A0=C2=A0 QTYPE_QDICT
>> +#define QTYPE_CAST_TO_QList=C2=A0=C2=A0=C2=A0=C2=A0 QTYPE_QLIST
>> +#define QTYPE_CAST_TO_QBool=C2=A0=C2=A0=C2=A0=C2=A0 QTYPE_QBOOL
>> +
>> +QEMU_BUILD_BUG_MSG(QTYPE__MAX !=3D 7,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "The QTYPE_CAST_TO_* list needs t=
o be extended");
>> +
>> +#define qobject_to(obj, type) \
>> +=C2=A0=C2=A0=C2=A0 container_of(qobject_check_type(obj, glue(QTYPE_CA=
ST_TO_, type))
>> ?: \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QOBJECT((type *)NULL)=
, \
>=20
> I guess the third (second?) branch of the ternary is written this way,
> rather than the simpler 'NULL', to ensure that 'type' is still somethin=
g
> that can have the QOBJECT() macro applied to it?=C2=A0 Should be okay.

It's written this way because of the container_of() around it.  We want
the whole expression to return NULL then, and without the QOBJECT()
around it, it would only return NULL if offsetof(type, base) =3D=3D 0 (wh=
ich
it is not necessarily).

OTOH, container_of(&((type *)NULL)->base, type, base) is by definition NU=
LL.

(QOBJECT(x) is &(x)->base)

Max

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 type, base)
>> +
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--lLE2FK2wI3IctvyK6LTaQHhngVyLA8WSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT9mISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOpQH/0d+bgWJzkfUb4frYYixMENXt6anQiX4
+DFFDwxBpvCr+05NJzCnnIxFDeOtoqpZE4mXcI7Ri9xLg50IG9VZ9B29YtL4xWCa
KnBta9PkWcNt/VHWq1pYjuMaB7VUWOkPWq9eFt/ibdvoVO3B1fsnAkujhJpIaMAD
wR9FaxFyQMg0yG41QFneJhLMuBAEb4pITzPKGd6bukgDJuHptVoa+cYNiu7vLhop
mSD1aCjgY5oTrAWSfhv5ZAj0kQoL6yty/hwq04SQL8LGyrymNXm4aDqVb56huLML
TBRiD3j65SG1kcEvWlFLEvVRZLs8EDe0duPs5ejongt7deUh0ExRQh8=
=4h0K
-----END PGP SIGNATURE-----

--lLE2FK2wI3IctvyK6LTaQHhngVyLA8WSF--
