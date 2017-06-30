Received: from eggs.gnu.org ([2001:4830:134:3::10]:42603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQvce-0007Ry-1K
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQvca-0003Kt-SU
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:06:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQvca-0003Jr-IF
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 488017A16D
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 13:06:03 +0000 (UTC)
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
	<1498536619-14548-5-git-send-email-peterx@redhat.com>
	<139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
	<20170630030321.GA24859@pxdev.xzpeter.org>
	<20170630071123.GE24859@pxdev.xzpeter.org>
	<c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42c0ecd8-01b5-6965-2f62-4275af7825d9@redhat.com>
Date: Fri, 30 Jun 2017 08:05:54 -0500
MIME-Version: 1.0
In-Reply-To: <c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oN5kcV7huxSMXa4FxGM3jdKj3xfnc9Xc2"
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oN5kcV7huxSMXa4FxGM3jdKj3xfnc9Xc2
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <42c0ecd8-01b5-6965-2f62-4275af7825d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/10] migration: let MigrationState be a
 qdev
References: <1498536619-14548-1-git-send-email-peterx@redhat.com>
 <1498536619-14548-5-git-send-email-peterx@redhat.com>
 <139475df-a7d8-80c6-ce21-a9a896e642ff@redhat.com>
 <20170630030321.GA24859@pxdev.xzpeter.org>
 <20170630071123.GE24859@pxdev.xzpeter.org>
 <c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
In-Reply-To: <c616d603-a744-dd6b-1f8b-91f0a7614436@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2017 07:33 AM, Max Reitz wrote:

>> The assertion is caused by migrate_add_blocker() called before
>> initialization of migration object. I'll fix it.
>=20
> Thanks!
>=20
>> But even with a fix (so I can pass 055 now), I still cannot pass some
>> of the other tests. Errors I got:
>>
>>   https://pastebin.com/ACqbXAYd
>>
>> I am not familiar with iotests. Is above usual? Looks like it still
>> includes 3 failures, and some output mismatch.
>=20
> Well, not usual. But 068 just is broken on master currently (Stefan has=

> sent "virtio: use ioeventfd in TCG and qtest mode" to fix it, and it's
> part of his latest pull request). The failure in test 087 is because yo=
u
> don't have aio=3Dnative enabled in your build, as the message says. :-)=


We could obviously patch 087 to gracefully skip instead of fail when the
build doesn't support running it.

>=20
> I'm not sure about 118. Maybe the os.chmod() doesn't work as intended o=
n
> your machine...? Because it tries to open a read-only image as
> read/write and wants to see it fail (which it doesn't in your case).

Maybe a run-as-root issue, where root can write to the file in spite of
permissions?  Ideally, I'm reluctant to run testsuites as root without
good reason (or at least a good sandbox), for fear that a bug in the
testsuite will hose my system.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oN5kcV7huxSMXa4FxGM3jdKj3xfnc9Xc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVkyyAAoJEKeha0olJ0Nqp1EH+wXx1o+EPkA61ciDvANHwOFh
MDXVyq2T8h7AxHNSp44ZMo8g/fJbUyIInsPlZG95h4lhxmhmjyAHBYSEHXS4DuqJ
mu/Db8acm0V/qlGAADl/EzDFyAKlGHnFrHBKp2shHkt4XZx3+l8P5BhYTCbV2CBi
tecMIttg3gIhZfoIL4wu1MSolXhUVLXcQG23kUrYx3k2up/MF/ObDyxNmCaT3Q8Z
nuNX9V4XonQ2OLljE5xM+dhZ/XZIsy0AP7/GhnCoHslsT/vEcp/jj3gaD7nfdw6I
ShjDggJTssI1p32/J+3Nkl6nh9+GenYDHQA2XsUBFVMtm3iqzcgXk/OJwUJE+bs=
=wWIV
-----END PGP SIGNATURE-----

--oN5kcV7huxSMXa4FxGM3jdKj3xfnc9Xc2--
