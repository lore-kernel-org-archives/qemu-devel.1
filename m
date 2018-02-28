Received: from eggs.gnu.org ([2001:4830:134:3::10]:59799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1er43H-0005mp-EH
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1er43G-0003Hr-H7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:53:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1er43G-0003HV-Ac
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:53:54 -0500
References: <20180216165015.30715-1-stefanha@redhat.com>
	<20180228154843.GA1248@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1feab120-ec48-e6b4-ba3c-e1545ccd9a1a@redhat.com>
Date: Wed, 28 Feb 2018 16:53:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180228154843.GA1248@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A5QbeFFofaaalcbJhjz45IQvVg85PU6Vx"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] block: fix blk_aio_*() segfault
 when blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A5QbeFFofaaalcbJhjz45IQvVg85PU6Vx
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <1feab120-ec48-e6b4-ba3c-e1545ccd9a1a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] block: fix blk_aio_*() segfault when
 blk->root == NULL
References: <20180216165015.30715-1-stefanha@redhat.com>
 <20180228154843.GA1248@stefanha-x1.localdomain>
In-Reply-To: <20180228154843.GA1248@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28/02/2018 16:48, Stefan Hajnoczi wrote:
> On Fri, Feb 16, 2018 at 04:50:10PM +0000, Stefan Hajnoczi wrote:
>> v3:
>>  * Add Patch 1 to rename aio_context_in_iothread() to
>>    in_aio_context_home_thread() [Eric]
>> v2:
>>  * Introduce AIO_WAIT_WHILE() since aio_poll(ctx, true) is not allowed=
 [Paolo]
>>
>> Using bdrv_inc_in_flight(blk_bs(blk)) doesn't work since BlockBackend-=
>root may
>> be NULL.
>>
>> This patch series solves the issue by adding an BlockBackend->in_fligh=
t counter
>> so requests can be tracked even when there is no BlockDriverState.
>>
>> This should fix the IDE and virtio-blk segfaults that have been encoun=
tered
>> when there is no BlockDriverState.
>>
>> The patch is based on work by Kevin Wolf.
>>
>> Kevin Wolf (1):
>>   block: test blk_aio_flush() with blk->root =3D=3D NULL
>>
>> Stefan Hajnoczi (4):
>>   aio: rename aio_context_in_iothread() to in_aio_context_home_thread(=
)
>>   block: extract AIO_WAIT_WHILE() from BlockDriverState
>>   block: add BlockBackend->in_flight counter
>>   Revert "IDE: Do not flush empty CDROM drives"
>>
>>  tests/Makefile.include     |   2 +
>>  util/Makefile.objs         |   2 +-
>>  include/block/aio-wait.h   | 116 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/block/aio.h        |   7 ++-
>>  include/block/block.h      |  40 +++-------------
>>  include/block/block_int.h  |   7 ++-
>>  block.c                    |   7 ++-
>>  block/block-backend.c      |  60 ++++++++++++++++++++---
>>  block/io.c                 |  10 +---
>>  hw/ide/core.c              |  10 +---
>>  tests/test-block-backend.c |  82 ++++++++++++++++++++++++++++++++
>>  util/aio-wait.c            |  40 ++++++++++++++++
>>  12 files changed, 318 insertions(+), 65 deletions(-)
>>  create mode 100644 include/block/aio-wait.h
>>  create mode 100644 tests/test-block-backend.c
>>  create mode 100644 util/aio-wait.c
>=20
> Any more comments?
>=20

Not from me. :)

Paolo


--A5QbeFFofaaalcbJhjz45IQvVg85PU6Vx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlqW0IgACgkQv/vSX3jH
roNqzggAh+zP8/1b9DaHSQEEooqNHIKtDid40AazsY1L+Xhe4Fw8+O/gu1Rcg056
nMa+PtYkNhmvyDg3vo/lAJqAclSEV49sA6CqCq/dAP5C+OZ8h57o0smeaCzmLlru
FRyKWsPlay3FNfNOUlCFxoGo/okLwk3j3XUu/bLj6i7Qp5HbDOj5G8nYsCHNdhYZ
YmKeAULKrbU0ki115vCEiOkm+sQqcETMi0GIwFA3Vy2xbqO0i2W5Ud4N9qgnRQ4W
/kik2cjdRZ5vGU9fgwQF5cLzi/T/i0vhAML/exg4GNRsHAmoUBncgCO8bLTqKUGG
KMfpgidi6AdV+3dY0fk86ra+CZHaww==
=6yux
-----END PGP SIGNATURE-----

--A5QbeFFofaaalcbJhjz45IQvVg85PU6Vx--
