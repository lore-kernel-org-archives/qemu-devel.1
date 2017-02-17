Received: from eggs.gnu.org ([2001:4830:134:3::10]:34891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepYz-0001ci-1a
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepYv-0006qm-I0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:55:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cepYv-0006qL-BV
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:55:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6399FFAF4D
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:55:29 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-19-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0b5e67a-0bd0-0c09-6972-dd0e2fc7654c@redhat.com>
Date: Fri, 17 Feb 2017 14:55:27 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-19-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="igkckNcv4jSpemTcfRL3qO7kSTlaLP9Gf"
Subject: Re: [Qemu-devel] [PATCH 18/24] tests/test-cutils: Use
 qemu_strtosz() more often
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--igkckNcv4jSpemTcfRL3qO7kSTlaLP9Gf
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e0b5e67a-0bd0-0c09-6972-dd0e2fc7654c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/24] tests/test-cutils: Use qemu_strtosz()
 more often
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-19-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> Use qemu_strtosz() instead of qemu_strtosz_mebi() where it doesn't
> really make a difference.

Rebase churn to Paolo's naming suggestion on 15/24, but that shouldn't
stop you from adding:

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--igkckNcv4jSpemTcfRL3qO7kSTlaLP9Gf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp2M/AAoJEKeha0olJ0NqpAoH+QGHMhGuL9sQzQmPHr6mB51L
7qYt5lnO+Chb2AsM8VytoC3PnfvM9Bg8yNoMM+x2pzQxuVyDOKtW776QyFtttnPN
2iLQK9cYlzC2RKDlSl4jrmxxNdwu9bcmD7gzNkr6y0iIWWJSY+TSkfJ+5Lvza+RK
Da3ZHgsB/e1+4mSRZDno1/ME0FyM6KqMXBB8TVkpLN+Uow6ua23JyoJdlz4U0ax3
VnAfubfK8+0XuQ8PBtLG65eCqYRx3GzaHfHTMy73Jo3Fl0MhcybDU4yMHZFOFS18
/trgrxFKsHChhTy2/vYI7ahNdrftlSFlNrXq/IGVK3nQ6yAwREE/UiLoEC2nmnM=
=CU2d
-----END PGP SIGNATURE-----

--igkckNcv4jSpemTcfRL3qO7kSTlaLP9Gf--
