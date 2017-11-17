Received: from eggs.gnu.org ([2001:4830:134:3::10]:44610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFjwP-0006UO-DK
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFjwO-0006iG-EI
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:56:33 -0500
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<fb5c092b-9db5-c5bf-3f61-9317a6371168@redhat.com>
	<bb7ce518-8542-f3ab-ac42-7d1106f52b69@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1882eba-b363-1864-f08c-5204bff6249b@redhat.com>
Date: Fri, 17 Nov 2017 10:56:13 -0600
MIME-Version: 1.0
In-Reply-To: <bb7ce518-8542-f3ab-ac42-7d1106f52b69@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2WgIL08eodS5fEHFB4r4ECHuGRd9c6w5i"
Subject: Re: [Qemu-devel] [PATCH v22 00/30] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2WgIL08eodS5fEHFB4r4ECHuGRd9c6w5i
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <e1882eba-b363-1864-f08c-5204bff6249b@redhat.com>
Subject: Re: [PATCH v22 00/30] qcow2: persistent dirty bitmaps
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <fb5c092b-9db5-c5bf-3f61-9317a6371168@redhat.com>
 <bb7ce518-8542-f3ab-ac42-7d1106f52b69@virtuozzo.com>
In-Reply-To: <bb7ce518-8542-f3ab-ac42-7d1106f52b69@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:

>> Nothing in this series touched qemu-img.=C2=A0 At the very minimum, it=
 would
>> be nice if 'qemu-img info' were to display a summary of all bitmaps in=

>> the qcow2 file; the QMP type ImageInfoSpecificQCow2 should be updated =
to
>> mention this information, and qemu-img updated to output it.=C2=A0 Bei=
ng able
>> to create and remove persistent bitmaps from an at-rest qcow2 file
>> without having to fire up qemu to issue QMP commands to do so would al=
so
>> be nice.
>>
>> It's a bit late for getting this request into 2.12, but had it been

Make that "too late for 2.11"

>> available, it would make my work at testing that 'qemu-img commit'
>> doesn't corrupt persistent bitmaps.
>>
>=20
> You are right, this is needed, but I can't promise something for the
> nearest future..

And as we both agree it is work for 2.12 or later, it is not needed
right away; so we have a couple of months.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2WgIL08eodS5fEHFB4r4ECHuGRd9c6w5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPFK0ACgkQp6FrSiUn
Q2oPYAf/YMUS41RdkEF7MP0BMMANt+422Avrei1ZBaTNuO3B27ldigcWWrj1vDEZ
yOv0w9jdKQz/xc+9UUpSTptQYYjdFbprpCovT2i6KK/BbR5DwYh+JMPFiDFf9Wqe
zQW4vK8ZneI96+KnnLFYNdoR6IAalI+bkcRHVtvx6AUZNebEJCti3vDh6kUe0iDo
j58MbP3cyFOw6Ct8mOFgkWaSK6FSPg5nkDNSGhKFODjC4BG4gTV6ocmEIY7uYXQ0
61kpyIp885k63Abjnx74BhZNfQS5f560T/cVDK+Kvzq4Ch68WOOn6GGMRgYSziJX
wUEwx258PGMkTKQpCRcoVscoeusYJw==
=j0Pe
-----END PGP SIGNATURE-----

--2WgIL08eodS5fEHFB4r4ECHuGRd9c6w5i--
