Received: from eggs.gnu.org ([2001:4830:134:3::10]:50449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eH8MC-0006b5-DU
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eH8MB-0001iy-F4
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:12:56 -0500
References: <cover.1511230683.git.jcody@redhat.com>
	<d21a7bb5d13a8d8db55bea05e46f5f4e18ed481e.1511230683.git.jcody@redhat.com>
	<20171121104946.GA25265@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <072692b7-3b3e-b44d-02c8-9d8f4e745b67@redhat.com>
Date: Tue, 21 Nov 2017 14:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171121104946.GA25265@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fwgVVUr94qi5fa5j4e3RpSlQNUMc8wbfn"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 1/4] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fwgVVUr94qi5fa5j4e3RpSlQNUMc8wbfn
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 famz@redhat.com, kwolf@redhat.com
Message-ID: <072692b7-3b3e-b44d-02c8-9d8f4e745b67@redhat.com>
Subject: Re: [PATCH v2 for-2.11 1/4] blockjob: do not allow coroutine double
 entry or entry-after-completion
References: <cover.1511230683.git.jcody@redhat.com>
 <d21a7bb5d13a8d8db55bea05e46f5f4e18ed481e.1511230683.git.jcody@redhat.com>
 <20171121104946.GA25265@stefanha-x1.localdomain>
In-Reply-To: <20171121104946.GA25265@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 21/11/2017 11:49, Stefan Hajnoczi wrote:
> On Mon, Nov 20, 2017 at 09:23:23PM -0500, Jeff Cody wrote:
>> @@ -291,10 +291,10 @@ void block_job_start(BlockJob *job)
>>  {
>>      assert(job && !block_job_started(job) && job->paused &&
>>             job->driver && job->driver->start);
>> -    job->co =3D qemu_coroutine_create(block_job_co_entry, job);
>>      job->pause_count--;
>>      job->busy =3D true;
>>      job->paused =3D false;
>> +    job->co =3D qemu_coroutine_create(block_job_co_entry, job);
>>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
>>  }
>=20
> Please see discussion on v1 about this hunk.
>=20
> The rest looks good.

I'm okay with this hunk, but I would appreciate that the commit message
said why it's okay to delay block job cancellation after
block_job_sleep_ns returns.

Thanks,

Paolo


--fwgVVUr94qi5fa5j4e3RpSlQNUMc8wbfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloUJkAACgkQv/vSX3jH
roP7IQf/RY2OUQ3mAkB4NqGkmbYUa5bWnIOpxlkfv+edRudny2h9eswT5w15O6x6
pzNVXRZ5NUPY1XcMGCM1tDEXPxPqT6TcA738CSzyE8nxpHmLnnY7/IS5UwXVPXEH
5FgxV2m0SFVcz+uraaA7yYMmkazgpqYGc0UBVxYGQhCMv1WHLWLXoQdCDYcsJSjr
wdIUlHdUZJv4feEOMaRHomoCS4yQLhLuPkkRkKUvVt8qiuPlt4IBpprzaXlQlO2T
52A7N1Vcosfx76Exn8cHxkVWmraJx9zna0gRDy4imBjny7x/RB4DQ7dCz6Vxf6Fm
5FhtZUBgZjic02vQGYrdc9d9Vjm3Qg==
=xIFQ
-----END PGP SIGNATURE-----

--fwgVVUr94qi5fa5j4e3RpSlQNUMc8wbfn--
