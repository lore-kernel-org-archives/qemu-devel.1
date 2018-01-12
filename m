Received: from eggs.gnu.org ([2001:4830:134:3::10]:55549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2bp-00016y-GL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2bo-0008Fk-AR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:55:13 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-7-vsementsov@virtuozzo.com>
	<a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
	<624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fedadb51-af71-82b1-ee73-135a7ce689eb@redhat.com>
Date: Fri, 12 Jan 2018 10:54:56 -0600
MIME-Version: 1.0
In-Reply-To: <624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Fdta46sxIvQszgJwnIbVeUqfiXim1XUjX"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fdta46sxIvQszgJwnIbVeUqfiXim1XUjX
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <fedadb51-af71-82b1-ee73-135a7ce689eb@redhat.com>
Subject: Re: [PATCH v2 6/6] iotest 201: new test for qmp nbd-server-remove
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-7-vsementsov@virtuozzo.com>
 <a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
 <624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
In-Reply-To: <624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 05:43 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> +++ b/tests/qemu-iotests/201.out
>>> @@ -0,0 +1,5 @@
>>> +.......
>>> +--------------------------------------------------------------------=
--
>>> +Ran 7 tests
>> I'm not a fan of python tests that are difficult to debug.=C2=A0 Your
>> additions to 147 in patch 4/6 are okay (hard to debug, but an
>> incremental addition); but is it possible to rewrite this test in a bi=
t
>> more verbose manner?=C2=A0 See test 194 and this message for more deta=
ils:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00234.html
>=20
> hmm, what do you mean by "difficult to debug"? This is a usual python
> unittest based test.

And the list archives show several threads of people complaining that
=2E/check failing with a diff that merely shows:

-.....
+..E..

makes it rather hard to see WHAT test 2 was doing that caused an error
instead of a pass, let alone set up a reproduction scenario on JUST the
failing test.  Yes, a lot of existing iotests use this unittest layout,
and on that grounds, I'm not opposed to adding another one; but test 194
really IS easier to debug when something goes wrong.

> And there 3 test cases, sharing same setUp. Do not you say that unittes=
t
> becomes
> deprecated in qemu? I think, if we have only one testcase, we may use
> 194-like approach,
> but if we have more, it's better to use unittest.

Yes, I think a nice goal for improved testing is to write more
python-based iotests in the style that uses actual output, and not just
the unittest framework, in the test log.  It's not a hard requirement as
long as no one has converted existing tests, but is food for thought.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Fdta46sxIvQszgJwnIbVeUqfiXim1XUjX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpY6GAACgkQp6FrSiUn
Q2oFWwf/aqvbpmYEywUIIqyXPs1uH0N9Hic230bCH04c8aqjDynDiJK3touaZniL
BdLnQJX4liayBCwBn2nRd9Rzn8d3kCf4ga7uYKULRGcLL66qZZV1jJlFJ/IWSKUk
cxWypMmAgRiLJvsCWiB1ErA1YXro57CPTOWXqyCetz9EVz5nmdpCT9SoRshHW0Y6
dxt/qhlHG4I1lWHixcIjVGlrq3t9J9rtqOYKP2FMI9lQTEA3rzuWnlbYo0zXPTdt
SiKdGU7TYL3uDOooY79GuGjRozWCo9WzpF+PQj/FiTWHUbC0Qb5LCB+2sgqRtTMd
2ffz9rd3lxq3OVLvlCa6sdep6aFOvQ==
=lc44
-----END PGP SIGNATURE-----

--Fdta46sxIvQszgJwnIbVeUqfiXim1XUjX--
