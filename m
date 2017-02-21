Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgDDw-0004vF-J0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgDDt-0000Sa-Un
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:23:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgDDt-0000SS-Ly
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:23:29 -0500
References: <20170221104256.5153-1-pbonzini@redhat.com>
	<20170221104256.5153-2-pbonzini@redhat.com>
	<48da68cf-67bf-1be8-206e-f082fbd024fc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7afa895-8923-cd10-0294-1aca5e76f2ee@redhat.com>
Date: Tue, 21 Feb 2017 17:23:24 +0100
MIME-Version: 1.0
In-Reply-To: <48da68cf-67bf-1be8-206e-f082fbd024fc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0GBX7QOdHcdUXxP8AtHDkJfbuVDHWxI78"
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0GBX7QOdHcdUXxP8AtHDkJfbuVDHWxI78
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org
Message-ID: <c7afa895-8923-cd10-0294-1aca5e76f2ee@redhat.com>
Subject: Re: [PATCH 1/3] qom-qobject: introduce object_property_{g,s}et_ptr
References: <20170221104256.5153-1-pbonzini@redhat.com>
 <20170221104256.5153-2-pbonzini@redhat.com>
 <48da68cf-67bf-1be8-206e-f082fbd024fc@redhat.com>
In-Reply-To: <48da68cf-67bf-1be8-206e-f082fbd024fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/02/2017 16:57, Eric Blake wrote:
>> +    /* You can retrieve a covariant (superclass) type... */
>> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
>> +                                  UserDefZero, &local_err);
>> +    g_assert(!local_err);
>> +
>> +    g_assert_cmpint(ret->integer, =3D=3D, 0);
>> +    qapi_free_UserDefZero(ret);
>=20
> You coded a non-strict visitor above to allow this to happen, but is it=

> really what we want?  It basically means we are grabbing the property
> fields we care about, while ignoring the rest of the property.  I guess=

> it may be okay.

The tests were very useful to write, because I had hardly gotten any of
the corner cases right. :)  I think these semantics make the most sense.

Yeah, it uses non-strict mode but this test provides a reason (namely,
covariant return types) why non-strict mode is useful.  It makes
backwards-compatibility easier.

>> +
>> +    /* Test that the property has not been modified at all */
>> +    ret =3D OBJECT_PROPERTY_GET_PTR(OBJECT(dobj), "qv",
>> +                                  UserDefZero, &local_err);
>> +    g_assert(!local_err);
>> +
>> +    g_assert_cmpint(ret->integer, =3D=3D, 0);
>> +    qapi_free_UserDefZero(ret);
>> +}
>> +
>> +++ b/tests/qapi-schema/qapi-schema-test.json
>> @@ -91,6 +91,14 @@
>>              '*enum1': 'EnumOne' } }   # intentional forward reference=

>> =20
>>  ##
>> +# @UserDefOneMore:
>> +# for testing nested structs
> Is nested the right word here?

Just copied from UserDefOne. :)  I'll change both to "derived".

Paolo


--0GBX7QOdHcdUXxP8AtHDkJfbuVDHWxI78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrGl8AAoJEL/70l94x66DmRsIAKlqDt2bPs4z2vmbS8jo4Yvv
ag8ODBrFvfkI/xx+CXB/ULAYdbxNYnkR13ZuNTZ7wkP2FWPVNTyXpuYdomxbmb2m
rWKehN1FF1m1bnP2d5z8Np19QGPbCtA9yCdIOXXEAz8gmHfVhVm7hHjLhIWA7pWO
KOXq94MhRjGNnijOn3Fq9q9eOyaypk7+vbaCuwaM5E379C6vdbaqsPQgZL3pc1pE
XPuMOBiXwc7s/HXgH0xlV1kABXmAmrXX1Nj7TR3L/vkrA5SIeQZT6arSwmnCVoL+
+bTgbJs5I9tVW5LvNgI5O+gEUsF/dbd1mgyw7B9VHHbkD2OWJ5/W+keRw5arpCI=
=uoHg
-----END PGP SIGNATURE-----

--0GBX7QOdHcdUXxP8AtHDkJfbuVDHWxI78--
