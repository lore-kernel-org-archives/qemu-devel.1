Received: from eggs.gnu.org ([2001:4830:134:3::10]:48520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIu2l-0003QX-Bb
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIu2k-0007BK-O0
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:52:27 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-33-kwolf@redhat.com>
	<43ee7ce4-a57f-0805-070e-e80eca6a8a36@redhat.com>
	<20180515125948.GD4442@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4b9189bd-770e-29ab-6dfb-461c63cd2180@redhat.com>
Date: Wed, 16 May 2018 12:52:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180515125948.GD4442@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0QTJXbwfoYSiJCVAgX2nHw4SPDyogEKda"
Subject: Re: [Qemu-devel] [PATCH 32/42] job: Move completion and
 cancellation to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0QTJXbwfoYSiJCVAgX2nHw4SPDyogEKda
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com,
 armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org
Message-ID: <4b9189bd-770e-29ab-6dfb-461c63cd2180@redhat.com>
Subject: Re: [PATCH 32/42] job: Move completion and cancellation to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-33-kwolf@redhat.com>
 <43ee7ce4-a57f-0805-070e-e80eca6a8a36@redhat.com>
 <20180515125948.GD4442@localhost.localdomain>
In-Reply-To: <20180515125948.GD4442@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-15 14:59, Kevin Wolf wrote:
> Am 14.05.2018 um 22:53 hat Max Reitz geschrieben:
>> On 2018-05-09 18:26, Kevin Wolf wrote:
>>> This moves the top-level job completion and cancellation functions fr=
om
>>> BlockJob to Job.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
>>> @@ -3362,7 +3362,7 @@ static void bdrv_close(BlockDriverState *bs)
>>> =20
>>>  void bdrv_close_all(void)
>>>  {
>>> -    block_job_cancel_sync_all();
>>> +    job_cancel_sync_all();
>>
>> Do we really want to cancel jobs that might have nothing to do with th=
e
>> block layer?
>=20
> Yes, though I admit it's a bit ugly to do it here. Alternatively, I
> could assert here that no jobs are running and pull the
> job_cancel_sync_all() into the callers. For vl.c, this is trivial.
> qemu-nbd.c uses 'atexit(bdrv_close_all);', so I'd have to introduce a
> wrapper function that calls both job_cancel_sync_all() and
> bdrv_close_all().
>=20
> Would you prefer that?

Yes, I'd like that.

Thanks!

Max


--0QTJXbwfoYSiJCVAgX2nHw4SPDyogEKda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr8DWEACgkQ9AfbAGHV
z0ADrQf4ucBm7WrZSU32yXu621oy2WZWbhhNoMshMPXyzkLdGwAE/LqqeEJYkovG
xbMfu47lWsBBAkPxG0mM+RlHO6s1xXg7Aq0a9+djWCMTv8nBYYnxwBcaQCz3CoX1
s75JYrq6brUpSAaarotEdU86e5GaD7XH7+YHMhmLpDZwvTSiKBAgZ5eNyQxQ38R1
wzAxl5zdp2KvYA5L5VuhqZhug9KxYdkMZn6z3yNkwUA9kadKe4a8YQuFH8UHRykg
DPZWPfYlp0doewMlQMTSlvvp7uHzbvczFZGJj6g8Aps2H3q1ZfjdUZNQUPFCnl9P
Eqm2EoikfPsdYK+wCGpNyazhVl9Z
=7+V3
-----END PGP SIGNATURE-----

--0QTJXbwfoYSiJCVAgX2nHw4SPDyogEKda--
