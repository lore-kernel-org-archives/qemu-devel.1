Received: from eggs.gnu.org ([2001:4830:134:3::10]:37220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqb9-0008Uc-0O
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqb5-0007YR-Ra
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXqb5-0007Xu-I8
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:09:07 -0400
References: <1500452149-9520-1-git-send-email-lu.zhipeng@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1e4c4e4-4cc6-66cc-9f66-02111defe968@redhat.com>
Date: Wed, 19 Jul 2017 10:09:04 -0500
MIME-Version: 1.0
In-Reply-To: <1500452149-9520-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5sh382xXGxvT3didF4DUBO7ajhsFHRb4m"
Subject: Re: [Qemu-devel] [PATCH] qga: Add support network interface
 statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5sh382xXGxvT3didF4DUBO7ajhsFHRb4m
From: Eric Blake <eblake@redhat.com>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org
Message-ID: <f1e4c4e4-4cc6-66cc-9f66-02111defe968@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: Add support network interface
 statistics in guest-network-get-interfaces command
References: <1500452149-9520-1-git-send-email-lu.zhipeng@zte.com.cn>
In-Reply-To: <1500452149-9520-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 03:15 AM, ZhiPeng Lu wrote:
> we can get the network interface statistics inside a virtual machine by=

> guest-network-get-interfaces command. it is very useful for us to monit=
or
> and analyze network traffic.
>=20
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  qga/commands-posix.c | 72 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  qga/qapi-schema.json | 38 ++++++++++++++++++++++++++-
>  2 files changed, 108 insertions(+), 2 deletions(-)

Isn't this a repost of an earlier version of the same proposal? If so,
including an appropriate v2, and documenting how it differs from v1,
aids reviewers.

Unfortunately, this has missed soft freeze for 2.10 and is a new
feature, so...

> +++ b/qga/qapi-schema.json
> @@ -643,6 +643,38 @@
>             'prefix': 'int'} }
> =20
>  ##
> +# @GuestNetworkInterfaceStat:
> +#
> +# @rx-bytes: total bytes received
> +#
> +# @rx-packets: total packets received
> +#
> +# @rx-errs: bad packets received
> +#
> +# @rx-dropped: receiver dropped packets
> +#
> +# @tx-bytes: total bytes transmitted
> +#
> +# @tx-packets: total packets transmitted
> +#
> +# @tx-errs: packet transmit problems
> +#
> +# @tx-dropped: dropped packets transmitted
> +#
> +# Since: 2.10

this needs to be changed to 2.11

> @@ -651,12 +683,16 @@
>  #
>  # @ip-addresses: List of addresses assigned to @name
>  #
> +# @statistics: various statistic counters related to @name
> +# (since 2.10)

likewise

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5sh382xXGxvT3didF4DUBO7ajhsFHRb4m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvdhEACgkQp6FrSiUn
Q2oXnAgAqMTXeOK1CAUR9Rl/yuKmG9fWTGwoqWiWF+/9Qv8F7uFAvZOwOaLsyO2g
c1gxowSiyZcBUAvOVQz+lvbUhMeFVlaLYfc95/PQOfxtrq7jGoQyyXbR9OuH4PIQ
DFo1OeWKFVn4rpay0BaHmuOItkmlvKnlkItOhPgDEu629KTPY/NrtN12V2iClQLG
5Rcc7VwCAsQtPqkSgtJRlxGjuvGW0QgPDwplVoOs3wtEiqRT/RBPojqq9XsGx3ly
zgCsdw2oN7y6bMyCntPhuaumWjMn8kG1IIc6ciXYIfBao9LGY77SVUevRl3sQqwq
OZsqTif0YeedWJxC5inngWbDd1stxA==
=dhIP
-----END PGP SIGNATURE-----

--5sh382xXGxvT3didF4DUBO7ajhsFHRb4m--
