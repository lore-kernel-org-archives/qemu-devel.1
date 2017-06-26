Received: from eggs.gnu.org ([2001:4830:134:3::10]:60806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPXM7-0004xb-4i
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPXM6-0001gl-Aj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:59:19 -0400
Date: Mon, 26 Jun 2017 19:58:32 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170626165832.32mzemh4jiwpquo4@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
	<20170626145234.GE29664@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tsjffcupujphbbb"
Content-Disposition: inline
In-Reply-To: <20170626145234.GE29664@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 4/8] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--4tsjffcupujphbbb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 03:52:34PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jun 23, 2017 at 03:46:56PM +0300, Manos Pitsidianakis wrote:
>> +static bool throttle_group_exists(const char *name)
>> +{
>> +    ThrottleGroup *iter;
>> +    bool ret =3D false;
>> +
>> +    qemu_mutex_lock(&throttle_groups_lock);
>
>Not sure if this lock or the throttle_groups list are necessary.
>
>Have you seen iothread.c:qmp_query_iothreads()?  All objects are put
>into a container (the parent object), so you can just iterate over its
>children.  There's no need for a separate list because QOM already has
>all the objects.
>

>> +static void throttle_group_obj_complete(UserCreatable *obj, Error **err=
p)
>> +{
>> +    char *name =3D NULL;
>> +    Error *local_error =3D NULL;
>> +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> +
>> +    name =3D object_get_canonical_path_component(OBJECT(obj));
>> +    if (throttle_group_exists(name)) {
>> +        error_setg(&local_error, "A throttle group with this name alrea=
dy \
>> +                                  exists.");
>> +        goto ret;
>> +    }
>
>QOM should enforce unique id=3D<ID>.  I don't think this is necessary.
>
>> +
>> +    qemu_mutex_lock(&throttle_groups_lock);
>> +    tg->name =3D name;
>> +    qemu_mutex_init(&tg->lock);
>> +    QLIST_INIT(&tg->head);
>> +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
>> +    tg->refcount++;
>> +    qemu_mutex_unlock(&throttle_groups_lock);
>> +

Sorry for the multiple replies but I just remembered this.

This is necessary because throttle groups are created by other=20
interfaces as well. Of course block/throttle-groups.c could use only QOM=20
objects internally to eliminate the housekeeping.

--4tsjffcupujphbbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllRPTgACgkQc2J8L2kN
9xDrIxAAtqsA7/AJG5t5wL/iwEfX/Ch41qVpPdvxer8ZNMUHGr72xYL/EeLrfU47
ZxeDcwXnIUZ98wc9f1llJB9+2HytEvaxWzF8g2DpzCtBz6nt+9dliH5OJUi62Eg4
aPFRfANzrJ1u3rPL+3x3Fq451dkT4R0aKSYdhrI2qf/rSN7mVaSPPaV7tbVT20Zc
RoSlJqmbAOwtVpGDUTuaWNJoAHiv46PQc5jtU59Q/RXjv1mXPWSs4+kwAEG2VReZ
WuIzNi8KdIAc87G7HZZwGx09IitdUQN5bkx8A77T6Ogy4CEgyx5R3CLoIn28nauz
WfLqVat5ElMaktVgtbhG2n5WnMOm7evW8+3EJ89p92J8JFPIAf4YJ28ALqjBr9eT
ac+K3Jy3oJlMyYdQXLaA1868BI10D+UUsLIs8M3COasRdyhBIS7JdJkdP+kZ3tHi
sSpFpjqZiv9wdhD1nHtWbSZDYEmU2zqIaas4fL/FFgL4KeayJUPA2i0JumXFek0p
mLkq0LvJDvw9Lw7T1e8NxNenpAllplGyA7slLmnWjWbRM7UEe2CDWou3ryUfjpWm
FMRtH0F6UYROBeN9IcjZWQhP8+D5rkyIiKAtDKaqyUHt6m6rktI0SlqF5KpckDpQ
fLNT3hYr7S1qtxlzrqveEQW50e5GD/e2a8zJeCEXFxFbR5wUirc=
=0qLg
-----END PGP SIGNATURE-----

--4tsjffcupujphbbb--
