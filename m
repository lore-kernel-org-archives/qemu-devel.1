Received: from eggs.gnu.org ([209.51.188.92]:45569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtgAk-0005bb-8l
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 17:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtgAj-0001pb-0R
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 17:04:58 -0500
References: <20190212200750.27521-1-jsnow@redhat.com>
	<44d4452d-8b94-205a-dc28-c617be80c29c@redhat.com>
	<87241634-5a14-f943-8446-07bd34f12aff@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <445f2f21-d769-14f5-2259-80b3ea6e9988@redhat.com>
Date: Tue, 12 Feb 2019 16:04:31 -0600
MIME-Version: 1.0
In-Reply-To: <87241634-5a14-f943-8446-07bd34f12aff@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b33FJip739WpUWkNsbwQjuxGLndZV9qgU"
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b33FJip739WpUWkNsbwQjuxGLndZV9qgU
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com,
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <445f2f21-d769-14f5-2259-80b3ea6e9988@redhat.com>
Subject: Re: [PATCH v2] blockdev: acquire aio_context for bitmap add/remove
References: <20190212200750.27521-1-jsnow@redhat.com>
 <44d4452d-8b94-205a-dc28-c617be80c29c@redhat.com>
 <87241634-5a14-f943-8446-07bd34f12aff@redhat.com>
In-Reply-To: <87241634-5a14-f943-8446-07bd34f12aff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/12/19 3:37 PM, John Snow wrote:
>=20
>=20
> On 2/12/19 3:16 PM, Eric Blake wrote:
>> On 2/12/19 2:07 PM, John Snow wrote:
>>> When bitmaps are persistent, they may incur a disk read or write when=
 bitmaps
>>> are added or removed. For configurations like virtio-dataplane, faili=
ng to
>>> acquire this lock will abort QEMU when disk IO occurs.
>>>
>>> We used to acquire aio_context as part of the bitmap lookup, so re-in=
troduce
>>> the lock for just the cases that have an IO penalty.
>>
>> It would be nice to call out which commit id dropped the aio_context
>> acquisition during bitmap lookup (making it easier to analyze how long=

>> this has broken, and which downstream builds need the backport.
>>
>=20
> OK, I will amend this.
>=20
> Looks like:
>=20
> commit 2119882c7eb7e2c612b24fc0c8d86f5887d6f1c3
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Mon Jun 5 14:39:03 2017 +0200
>=20
> since 2.10.

Hmm. block-dirty-bitmap-add's "persistent":true parameter was also added
in 2.10 in commit fd5ae4cc.  In fact, 2119882c was made at a time when
there were not persistent bitmaps; so I guess that this means we have
always been broken since fd5ae4cc.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--b33FJip739WpUWkNsbwQjuxGLndZV9qgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjQu8ACgkQp6FrSiUn
Q2o6SAf/eqTwF5W/m0rscZXHMLl9Si+CTvdFIsu8+fe8CHWJyhvnVVmziI1lhFVc
1RapKkZkP/tPOBMHwOagZgL99wIZpqQhLt6d2tUmpniwrFYo64i96LmbbeHJjR5a
oTmweFb1HpBrfWM8gGV+6NXnDUCZJVbWPkfOnzi0e65wip9p5ZosG+AJ4bxmiEzG
rgxNXJDBzUdJhlbgOXqkHBJe3Jw7Fab7TNJB9/bcLvIFWTRRg7xdFIFhhLLyNYeW
XZ+vam8pC+ILvJudqYrVfvvS4FpTxP+ffURCpx+PvJtt7P6VSNShVkutNK5ap6NC
Dfull1G3gWOIWMBqlD4HYGwLGVSK+Q==
=dIDc
-----END PGP SIGNATURE-----

--b33FJip739WpUWkNsbwQjuxGLndZV9qgU--
