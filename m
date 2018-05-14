Received: from eggs.gnu.org ([2001:4830:134:3::10]:43703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHLl-0000Kf-Ma
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIHLk-0007nB-UM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:33:29 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-22-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9ba3ad17-924c-c583-a914-8b81cff9ed42@redhat.com>
Date: Mon, 14 May 2018 19:33:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-22-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CHZK1XPLz8Q86wS2RUFYlSPH3DD1ZdTOx"
Subject: Re: [Qemu-devel] [PATCH 21/42] job: Replace BlockJob.completed with
 job_is_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CHZK1XPLz8Q86wS2RUFYlSPH3DD1ZdTOx
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <9ba3ad17-924c-c583-a914-8b81cff9ed42@redhat.com>
Subject: Re: [PATCH 21/42] job: Replace BlockJob.completed with
 job_is_completed()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-22-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-22-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> Since we introduced an explicit status to block job, BlockJob.completed=

> is redundant because it can be derived from the status. Remove the fiel=
d
> from BlockJob and add a function to derive it from the status at the Jo=
b
> level.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h |  3 ---
>  include/qemu/job.h       |  3 +++
>  blockjob.c               | 16 +++++++---------
>  job.c                    | 22 ++++++++++++++++++++++
>  qemu-img.c               |  4 ++--
>  5 files changed, 34 insertions(+), 14 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--CHZK1XPLz8Q86wS2RUFYlSPH3DD1ZdTOx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5yF0ACgkQ9AfbAGHV
z0AJfwgAoJQU+FGeSddXtw4jSIliOd7QdFvFmQgvSNdZl4ya6ucyGoeRaDlqdxo7
NJH7RNw2y8Xft7ltjwefVmft3o3/ttKD3Msp02TGvSTlO5SaTLR31LVAoim1H7ub
wHvt2T7YdKQjHQQHxxHqFRuxhI7qT+Fh2HQZ4NeFN4Yqmn0Y4XHNKgIo4JJ7epve
I4a2OakvDvFYaxLvvOUfE5D2NDZjb5f6Mc3Bk7/TnKtThoa071g21j7+mMQi1COh
5k84gyDp2S2cdPO89+xH9XKA4Ke4bYh3PpgDIXqhtNU9ddMxndH2wuwbQ22Ukwn7
doUsogaDEiaNjmfLKYral4lVyi0Fug==
=IUi7
-----END PGP SIGNATURE-----

--CHZK1XPLz8Q86wS2RUFYlSPH3DD1ZdTOx--
