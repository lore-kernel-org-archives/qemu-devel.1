Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEVmr-0000gd-Nt
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEVmq-0006M5-RE
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:09:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEVmq-0006Kb-Kz
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:09:52 -0400
Date: Fri, 4 May 2018 09:09:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180504080950.GA18897@stefanha-x1.localdomain>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-22-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <1525376963-79623-22-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 21/67] trace: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:50:59PM +0300, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  trace/qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa7BVOAAoJEJykq7OBq3PI3TcIAIU/97nt8YoXYXTBPyCJmDfR
yPrT1HPnKt1K4fqxknUCKE4lR/QyqAwEhPowRLB6yari3zlDQ3TnHDBFwU0QS2WY
BqToMXj/3hmVVAiierbpT90lC4WOzMzw9xSMVS8uyCymmXfPnw6erMY6reX1hmpx
2C7IGbdk3PSU3Ndetl49noMedwz3+hy+NSn2/34goijfQGRY1tT8mVf0agLEQjH5
704MDwoyVzJdtlYHc0qh2KJtPFqPFmc6YcWDWioWYvMKX4uCUwGKV7jCdM9DcMio
7sqqCsuGegjUu1swgaZdZyfYbA+l8+aROMC4aG+TMheeb9bjE1DN8K+0vJfQt7s=
=ga26
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
