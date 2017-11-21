Received: from eggs.gnu.org ([2001:4830:134:3::10]:41826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eH7sg-0006rf-4Q
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eH7sf-0005sU-D6
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:42:26 -0500
Date: Tue, 21 Nov 2017 13:42:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171121124209.GA11073@localhost.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
	<20171120111653.GB4516@stefanha-x1.localdomain>
	<b910238b-d42c-abfe-9d57-1db2c97728cc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <b910238b-d42c-abfe-9d57-1db2c97728cc@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.11.2017 um 23:25 hat Paolo Bonzini geschrieben:
> On 20/11/2017 12:16, Stefan Hajnoczi wrote:
> > This raises questions about the ability to cancel sleep:
> >=20
> > 1. Does something depend on cancelling sleep?
>=20
> block_job_cancel does, but in practice the sleep time is so small
> (smaller than SLICE_TIME, which is 100 ms) that we probably don't care.

Just note that this is something that can happen during the final
migration phase when the VM is already stopped. In other words, with
non-shared storage, these up to 100 ms are added to the migration
downtime.

Kevin

> I agree with Jeff that canceling the sleep by force-entering the
> coroutine seemed clever but is probably a very bad idea.
>=20
> Paolo

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaFB8hAAoJEH8JsnLIjy/W3RQQAMP79WhLzHIic5UTw4sOfsAf
1u0PiKRdG4Lj7n8zxBqLgtAhz/Ib3YKRMLDlY0/uNwbyHSvIlAhBixFY2BWkY+XY
0liPyg/0+l634ISJ4G6cIzT46mme3SbUO46g77nivIkRFuJGNn1R6hwtekflmtbj
nlmbF86ZYgOQBU7i/h11c24lvgKgUFAd/JXt+1wJ9NgQRrTsgm8m+U9XfbKd5P8H
PzrrtwfNpFdv5z9eMIGCvnJF7Vav6K6+cNxOWTPO2DmMRriD6ku2U4FjthhVJV7y
e2S6YmABM/DI6dnUQGepDqVyHt8ClOCOUsTHibvgfbBZggDirnQUCsnR+rCbT/rG
BA45nnU9GvqUPzI9Sor3A3wK/4LShns8/SCx9el6g0QkhWWs64q0Db5y/t6EOcV0
T/9wrPreKZAo403W/PtyV9eN7zeAM6x6lbiU9ZF4gT03GRXfAS6+xlVJG10fcEqg
j1RWdxSXTKI/jK3ZPGrPNsVHAq0qURcxV+8/Xd+SHSsYhNTT5X+MONmczzdySaQI
PrT5Mhcu5VBPw1fburK7PR/w9ZKsjuzFx8+qawLYrkyhICPEaD2nMSJc87VRR+OB
oMZUv6xVGeaqPKSiae3dc8QO1nFq9EiqhT5mtNdxCTBIYACgFXUKPv/OBt0SPCOJ
dwQaS+qbt38kekPsEsQ5
=TCKX
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
