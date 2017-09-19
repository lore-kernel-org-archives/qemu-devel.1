Received: from eggs.gnu.org ([2001:4830:134:3::10]:60485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKI9-0004bq-6c
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duKI6-0007Mq-Et
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duKI6-0007Lg-5u
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:18:26 -0400
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-5-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbb8a1c1-a2a8-fb7d-1fea-f66da7417a89@redhat.com>
Date: Tue, 19 Sep 2017 10:18:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170919072719.11815-5-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L6a6Tk3vp3Ofp6uNNOEwfECUVqsWRIvqF"
Subject: Re: [Qemu-devel] [PATCH v9 04/13] tests: Add a test key pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L6a6Tk3vp3Ofp6uNNOEwfECUVqsWRIvqF
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <dbb8a1c1-a2a8-fb7d-1fea-f66da7417a89@redhat.com>
Subject: Re: [PATCH v9 04/13] tests: Add a test key pair
References: <20170919072719.11815-1-famz@redhat.com>
 <20170919072719.11815-5-famz@redhat.com>
In-Reply-To: <20170919072719.11815-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 02:27 AM, Fam Zheng wrote:
> This will be used by setup test user ssh.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/keys/README     |  6 ++++++
>  tests/keys/id_rsa     | 27 +++++++++++++++++++++++++++
>  tests/keys/id_rsa.pub |  1 +
>  3 files changed, 34 insertions(+)
>  create mode 100644 tests/keys/README
>  create mode 100644 tests/keys/id_rsa
>  create mode 100644 tests/keys/id_rsa.pub
>=20
> diff --git a/tests/keys/README b/tests/keys/README
> new file mode 100644
> index 0000000000..f381ac0698
> --- /dev/null
> +++ b/tests/keys/README
> @@ -0,0 +1,6 @@
> +This folder contains a well-known key pair used in QEMU tests.

s/key/ssh key/ ?

> +
> +Some guests require the key to exist prior to provisioning the guest; =
also,
> +reusing a pre-built key avoids consuming entropy every time the testsu=
ite is
> +run.  Because the private key is well-known, care must be taken to use=
 the key
> +ONLY in situations that cannot be compromised by external network clie=
nts.

Thanks; that helps.

> +++ b/tests/keys/id_rsa.pub
> @@ -0,0 +1 @@
> +ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCikC46WYtXotUd0UGPz9547Aj0KqC4gk=
+nt4BBJm86IHgCD9FygSGX9EFutXlhz9KZIPg9Okk7+IzXRHCWI2MNvhrcjyrezKREm71z08j=
9iwfxY3340fY2Mo+0khwpO7bzsgzkljHIHqcOg7MgttPInVMNH/EfqpgR8EDKJuWCB2Ny+EBF=
N/3dAiff0X/EvKle9PUrY70EkSycnyURS8HZReEqj8lN9J5kXzA8F6jBo/0Q42Ttv6e4k5Yca=
DrwmLrBWLra2PCXZLNyHqXEiFkGmdXtA1Eox9gc/p4jIXim6xrPNmpN6WyrrEjaCF5xYvNv8w=
XkD6uSWwbHYU24lIAn qemu-test

Let's make the comment even longer (I think you can use 'ssh-keygen -C
"some useful comment"', but
https://serverfault.com/questions/442933/add-comment-to-existing-ssh-publ=
ic-key
has more information): maybe along the lines of:

ssh-rsa AAAAB...IAn well-known key for qemu-test, do not use on any
machine exposed to an external network

But either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--L6a6Tk3vp3Ofp6uNNOEwfECUVqsWRIvqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBNTkACgkQp6FrSiUn
Q2oK1gf/Z1iXWIudlZj8Ay67xyqpLi46Y8kZCPXpVN7E2i8HXXL+0rs5SD0LOL+F
3qcpLe48pb0GPYrNYh3Bke86D5Yeo+pEAxdouuWyhQtLgHUMo0YJEgCr+ZvPjBnh
Mu58FMG4M2CQPNLa04TrOfiErW5H4yadsBQx4Q9JXtJf5shCxhPFyrXuLVfTlslu
qxcDkL1cUO/Cf6qNfj+pezxZ2vAnKtsW8Qn7lkXLtUakdNMWw6ju50hq+JtepdUi
FDeABWho75fiPwxao4DIzRrnVmFNKRhyP6Uqp75NhrUKE3tyePRVcFs1aWToPvmG
YpYb98wipZVKphK5vycpU8b97NtWZA==
=nLyX
-----END PGP SIGNATURE-----

--L6a6Tk3vp3Ofp6uNNOEwfECUVqsWRIvqF--
