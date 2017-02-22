Received: from eggs.gnu.org ([2001:4830:134:3::10]:58203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXGm-0006Ib-7E
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXGl-0002uA-F6
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:47:48 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-15-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2a156bea-c179-40df-41b6-73e60e077317@redhat.com>
Date: Wed, 22 Feb 2017 14:47:38 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-15-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5wEHnxn8Q14C7Adg9MreQX2LEjoj0cko3"
Subject: Re: [Qemu-devel] [PATCH 14/54] block: Let callers request
 permissions when attaching a child node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5wEHnxn8Q14C7Adg9MreQX2LEjoj0cko3
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <2a156bea-c179-40df-41b6-73e60e077317@redhat.com>
Subject: Re: [PATCH 14/54] block: Let callers request permissions when
 attaching a child node
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-15-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-15-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> When attaching a node as a child to a new parent, the required and
> shared permissions for this parent are checked against all other parent=
s
> of the node now, and an error is returned if there is a conflict.
>=20
> This allows error returns to a function that previously always
> succeeded, and the same is true for quite a few callers and their
> callers. Converting all of them within the same patch would be too much=
,
> so for now everyone tells that they don't need any permissions and allo=
w
> everyone else to do anything. This way we can use &error_abort initiall=
y
> and convert caller by caller to pass actual permission requirements and=

> implement error handling.
>=20
> All these places are marked with FIXME comments and it will be the job
> of the next patches to clean them up again.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 66 +++++++++++++++++++++++++++++++++++++++=
++------
>  block/block-backend.c     |  8 ++++--
>  include/block/block_int.h | 15 ++++++++++-
>  3 files changed, 78 insertions(+), 11 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5wEHnxn8Q14C7Adg9MreQX2LEjoj0cko3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitlnoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALWAH/0BBq222r8GXd2yLGqB0tsAd4Sj61K0+
ehQf071mqCg8u3yRBtI5bUSCfmWrjB0Y2koCcmsg2yDnaxt4BgJAeaKE4x+3KXzu
0SfpDwEDWjrQwkBuQLU9RTvpYH+wVGZplZkUiYbuWlzRlG9Si5pJU7zyO2c5ncWL
40aqmCRlFdcNTZ0PB90V/fLcJn3CiltxW9zhOA/5h8COgqASCPOYlqsgmIqIO0J/
2GKHO/TR/m65gEymmT8111er73EgR9x1qdVaUHh0bqbf9Sn2WQ/yRzpwYenLTTO3
LNmywxvEAeOK+43IfIOabdmDIMBQ29VSAiZ4fs2N19xJGHbxQ02h8Uc=
=cs/n
-----END PGP SIGNATURE-----

--5wEHnxn8Q14C7Adg9MreQX2LEjoj0cko3--
