Received: from eggs.gnu.org ([2001:4830:134:3::10]:46835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Kez-0004qk-Pg
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Key-0002PA-Ro
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:48:37 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<570b9109b10c519aceb6c333a6e0d0a59795defb.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3f3f17cf-31ab-9b27-04f7-eff9aa37587c@redhat.com>
Date: Mon, 8 Oct 2018 03:48:11 +0200
MIME-Version: 1.0
In-Reply-To: <570b9109b10c519aceb6c333a6e0d0a59795defb.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sWEYPqNOmngIChthSdI38tTVqBFlIhqnc"
Subject: Re: [Qemu-devel] [PATCH 10/14] block: Drop bdrv_reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sWEYPqNOmngIChthSdI38tTVqBFlIhqnc
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3f3f17cf-31ab-9b27-04f7-eff9aa37587c@redhat.com>
Subject: Re: [PATCH 10/14] block: Drop bdrv_reopen()
References: <cover.1537367701.git.berto@igalia.com>
 <570b9109b10c519aceb6c333a6e0d0a59795defb.1537367701.git.berto@igalia.com>
In-Reply-To: <570b9109b10c519aceb6c333a6e0d0a59795defb.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> No one is using this function anymore, so we can safely remove it

Is this such a minor action to you that you think it doesn't need a full
stop? ;-)

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 21 ---------------------
>  include/block/block.h |  1 -
>  2 files changed, 22 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--sWEYPqNOmngIChthSdI38tTVqBFlIhqnc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6t1sACgkQ9AfbAGHV
z0Dk5AgAps5HbuljonF3BTfW1oH1jp+e2jnqBJxNt/GovEU31tuvKz+aU4qoOMcZ
e/LFzH5y95/xKnsjbaCxeVt+uoC4nx78opOeL2kVLRzW/kLkLvzMICE4fZUG4H7s
XyrNUv+wcYVK3O9El8Ph9mduq2gcwNc+E2KGWCYqrgDDvTIoF+JuBusBKPaT+5be
lAROcBAxYeu9URqN+hdtSUahDVm5IQw7stDPArMemzcWmXVn/gg/NG2EmwWOSnMj
JQ6y4MLB3LsfQJKJNbHkm64DJ9Ya4aT27VydwyexowwL178UgvGmGfmCoL+RBa2W
Yw0OnWVh/wMQy/VAZwSHHMe4CCUuAA==
=vMnS
-----END PGP SIGNATURE-----

--sWEYPqNOmngIChthSdI38tTVqBFlIhqnc--
