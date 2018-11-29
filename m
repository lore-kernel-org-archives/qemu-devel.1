Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIXu-0001xT-3D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIXs-0007S0-Pq
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:23:42 -0500
References: <20180203061621.7033-1-stefanha@redhat.com>
	<20180215103721.GG23321@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0b23d2b-6627-4f4a-d9c1-0b4221150ef4@redhat.com>
Date: Thu, 29 Nov 2018 10:23:15 +0100
MIME-Version: 1.0
In-Reply-To: <20180215103721.GG23321@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UtXVF43qus4mZpUdUOnRR8zCdMi5ZRQKT"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] block/iscsi: fix ioctl cancel
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UtXVF43qus4mZpUdUOnRR8zCdMi5ZRQKT
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>
Message-ID: <e0b23d2b-6627-4f4a-d9c1-0b4221150ef4@redhat.com>
Subject: Re: [PATCH v2 0/3] block/iscsi: fix ioctl cancel use-after-free
References: <20180203061621.7033-1-stefanha@redhat.com>
 <20180215103721.GG23321@stefanha-x1.localdomain>
In-Reply-To: <20180215103721.GG23321@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/02/18 11:37, Stefan Hajnoczi wrote:
> On Sat, Feb 03, 2018 at 07:16:18AM +0100, Stefan Hajnoczi wrote:
>> v2:
>>  * It was unnecessary to avoid duplicate iscsi_schedule_bh() calls sin=
ce this
>>    function already protects against duplicate calls internally [Stefa=
n]
>>
>> Patches 1 & 2 are cleanups.
>>
>> Patch 3 fixes cancellation of ioctls.  Felipe showed me a trace where =
an acb is
>> cancelled and then completes twice.  The second time around crashes QE=
MU.
>>
>> Compile-tested only.
>>
>> Felipe: Please let us know if this fixes the issue you are seeing.  Th=
anks!
>>
>> Stefan Hajnoczi (3):
>>   block/iscsi: drop unused IscsiAIOCB->buf field
>>   block/iscsi: take iscsilun->mutex in iscsi_timed_check_events()
>>   block/iscsi: fix ioctl cancel use-after-free
>>
>>  block/iscsi.c | 33 ++++++++++++++++++++++-----------
>>  1 file changed, 22 insertions(+), 11 deletions(-)
>=20
> Thanks for the reviews, Paolo and Felipe.
>=20
> Paolo: Please merge this, I'll send an additional patch that works
> around libiscsi's missing cancellation callback.
>=20

Queued now for 4.0.  It's only been 9 months...

I also queued "block/iscsi: cancel libiscsi task when ABORT TASK TMF
completes".

Paolo


--UtXVF43qus4mZpUdUOnRR8zCdMi5ZRQKT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlv/sAUACgkQv/vSX3jH
roPisAf/RVRt3tUM108/Yr86rnO5T0viE5s2IiBjQLhz1DqIksIGH7LJJ+jEidIr
3qmzHQx3qsoMZQv1kbYwHc3acXL/dnQ3KCHO2Mu9HtomBxazCbpZx9+3wu9qPzn/
xVcW/ISl0SLjbmG691dKUHBrJUkbVl63Ucq1UIFiFPeXBeCOQIO2bWr5ik6Z1+82
LwwR8fGkHXraJjKV5jUwpDUrHxSwF9J7SA4BcZ92G4ynMPXOqGzP2jqQRUrU9YuO
NZ+BgxWV1yyeTAYOJo7Ov4WBy4vhMN7yTrhPN3iqzqgVDoCsBzE2vTPoQK9Wt/5K
160aDUtgEXOd3B5t+sf+SZWbqPT8tQ==
=AYNE
-----END PGP SIGNATURE-----

--UtXVF43qus4mZpUdUOnRR8zCdMi5ZRQKT--
