Received: from eggs.gnu.org ([2001:4830:134:3::10]:45072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnRzm-0007PB-9T
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnRzh-0003Ue-G5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:07:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnRzh-0003UO-6r
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:07:01 -0400
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09158e7a-0c19-1573-5eaf-e90eed0b59ed@redhat.com>
Date: Thu, 31 Aug 2017 11:06:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170831112210.19921-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4KIiOe5mgot4qgWlgEX9O3kswuut9iwe4"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4KIiOe5mgot4qgWlgEX9O3kswuut9iwe4
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09158e7a-0c19-1573-5eaf-e90eed0b59ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
References: <20170831112210.19921-1-famz@redhat.com>
 <20170831112210.19921-4-famz@redhat.com>
In-Reply-To: <20170831112210.19921-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 06:22 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-block | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 tests/docker/test-block


> +cd "$BUILD_DIR"
> +
> +build_qemu --target-list=3Dx86_64-softmmu
> +cd tests/qemu-iotests
> +./check -raw
> +./check -qcow2

Should we also run ./check -nbd?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4KIiOe5mgot4qgWlgEX9O3kswuut9iwe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmoNB8ACgkQp6FrSiUn
Q2pXbAf+K8MJAHBIj7gKgMEUy4ls650A062FrdmhlBSt7KMva9JEIIW4mGCV0x23
1LVa8q8K2ZmPprCeMcpEXHfHP/6pzCPnLJ2ct5Y9G9BMdu2s9IWA/b7qc4CMAXrr
Q+0a1pBA4YguSAst/64kiNj4PTqrGaGctKqlROX+xZGwu2Qf/bsvu2OmYxF/P/vb
AlfOOVm7guepPu2po1ufI9DRsT9uuYlUMKB5Zc1RMINVyN5fFUeDctiGKZ6RwfKE
I7aBgMEC6NMQbUZHPVAT5asHgqsHufogfTPeU3mia1hRMxZiCEFAY8krbUswmZ0w
Z/8RGJhNA41Ce8DEn03J+43U/AbONQ==
=aZBv
-----END PGP SIGNATURE-----

--4KIiOe5mgot4qgWlgEX9O3kswuut9iwe4--
