Received: from eggs.gnu.org ([2001:4830:134:3::10]:55677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9LUG-0007XO-O1
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9LUG-0006NS-1R
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:41:36 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<8e3622ca8e46a8f450dd94f6f2a485bfbe4a72ab.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7f65a4b7-1c41-2460-66d8-694ff40f724f@redhat.com>
Date: Mon, 8 Oct 2018 04:41:15 +0200
MIME-Version: 1.0
In-Reply-To: <8e3622ca8e46a8f450dd94f6f2a485bfbe4a72ab.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fWTue29B7T839mTfL8zpRDFbFS0svRxcj"
Subject: Re: [Qemu-devel] [PATCH 13/14] block: Remove flags parameter from
 bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fWTue29B7T839mTfL8zpRDFbFS0svRxcj
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <7f65a4b7-1c41-2460-66d8-694ff40f724f@redhat.com>
Subject: Re: [PATCH 13/14] block: Remove flags parameter from
 bdrv_reopen_queue()
References: <cover.1537367701.git.berto@igalia.com>
 <8e3622ca8e46a8f450dd94f6f2a485bfbe4a72ab.1537367701.git.berto@igalia.com>
In-Reply-To: <8e3622ca8e46a8f450dd94f6f2a485bfbe4a72ab.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> Now that all callers are passing all flag changes as QDict options,
> the flags parameter is no longer necessary, so we can get rid of it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 5 +++--
>  block/replication.c   | 6 ++----
>  include/block/block.h | 3 +--
>  qemu-io-cmds.c        | 2 +-
>  4 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--fWTue29B7T839mTfL8zpRDFbFS0svRxcj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6w8sACgkQ9AfbAGHV
z0DfSQf+MFdSUOVENmkzH0/BPMe5/7Hkpfe03e1d55rAsXc4gffeR669iQKM6O57
YMoQyi3z71sNunFF8AwRPIqCzfh33Y+6SIzxFaNp26+IO/BiTa9GhYExOqD/6KFg
yhcarOIkqByc+OUeRZ5TmQ98W/Tc7bKdKiisU3JV6+UmIzkDLBGeWuI2F2mQZkB/
A/8C/TeF+/voIvxKH3yvSOkqoPYj3jF1tg+GmIqXZygplTMW/Ml/2liUapR4z4T9
Wpc2tgG8wshYELDGl3Ch0i4cCsTDkNRhTj0zAhwonqq14A9JQQq24tLJDIZYoCDd
yg9ka1SqHy61E6DO9bEdCgbWzYBegQ==
=fTQU
-----END PGP SIGNATURE-----

--fWTue29B7T839mTfL8zpRDFbFS0svRxcj--
