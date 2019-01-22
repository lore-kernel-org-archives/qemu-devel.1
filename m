Received: from eggs.gnu.org ([209.51.188.92]:45024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1nR-0007fN-Pr
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1iB-0007ij-6p
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:27:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm1i9-0007P1-8n
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:27:49 -0500
References: <20190122181822.1505-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6415e48b-ae20-2be7-590e-bd79142620b8@redhat.com>
Date: Tue, 22 Jan 2019 13:27:32 -0600
MIME-Version: 1.0
In-Reply-To: <20190122181822.1505-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mqSeycR3mPp8XiAL6PPHpSwQiBLlt8t5n"
Subject: Re: [Qemu-devel] [PATCH 0/2] slirp: fix -Waddress-of-packed-member
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mqSeycR3mPp8XiAL6PPHpSwQiBLlt8t5n
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 patches@linaro.org
Message-ID: <6415e48b-ae20-2be7-590e-bd79142620b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] slirp: fix -Waddress-of-packed-member
 warnings
References: <20190122181822.1505-1-peter.maydell@linaro.org>
In-Reply-To: <20190122181822.1505-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 12:18 PM, Peter Maydell wrote:
> These patches fix the clang -Waddress-of-packed-member warnings
> in the slirp code. For slirp, the structs marked as packed
> are already naturally packed/aligned, so adding the 'packed'
> attribute doesn't change their layout but means the compiler
> has to assume they might be misaligned. Instead, for the structs
> which map to on-the-wire packet formats, we add build time
> assertions that they have the sizes we think they should.
>=20
> The 'struct ipq' and 'struct ipasfrag' aren't on-the-wire
> packet representations, so it's not clear why they were
> marked packed in the first place. (They contain host pointers
> and so have a size that depends on the host.) Here we just
> assert the only thing that's documented as a layout restriction:
> that struct ipq's frag_link and struct ipasfrag's ipf_link
> are at the same offset.
>=20
> Together, this fixes all the -Waddress-of-packed-member warnings
> in slirp, which I think was the only set remaining without
> patches at least being on-list. (Some of the block/ warning fixes
> are still working their way through the relevant trees.)

How does this series play with the ongoing effort to make libslirp an
independent project?  I'm assuming your use of QEMU_BUILD_BUG_ON() will
have to be translated into whatever libslirp-specific mechanism we want
to split off into that project.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mqSeycR3mPp8XiAL6PPHpSwQiBLlt8t5n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHbqQACgkQp6FrSiUn
Q2qGJQf+J3Layxp5zx3LfghjoLSVfgn4mDpNDs0ZhPyokyQe8h7Y+1wGvpwYutLY
qHYvaV36iD1hw//aLvG0hrewldpgPErfdOgyVVym8xuzWR9u7f3W2noCjpppujd8
p7jkhYrHnMF4iwxvPjfjVGxolpD7+XKS4v47N4H6DJ1zdFwNgd3o1RJIsngnPH4X
GrUw+q+WcJ22DY3bWQFyJCNtxtjG7aExGieExghJJqC+WhDwQWbdbIS5CODkejVc
Km3TAAnaRjaANQLdd4Z9Mr8a0yuKb7/5ewDEZg5a6zuRp/PpQ/yTGkgiSm+P7Znn
dV9lJ/zS2UtIPgFHAlzL5lbjaytsOg==
=Abe3
-----END PGP SIGNATURE-----

--mqSeycR3mPp8XiAL6PPHpSwQiBLlt8t5n--
