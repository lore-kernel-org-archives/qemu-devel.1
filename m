Received: from eggs.gnu.org ([2001:4830:134:3::10]:43150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCi-0007qm-Eu
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dkuCe-0002Jn-HG
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dkuCe-0002JF-7H
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:37:52 -0400
References: <20170822044155.2451-1-famz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8805ba9c-a509-ed81-70e3-16b33bb1135c@redhat.com>
Date: Thu, 24 Aug 2017 11:06:59 -0400
MIME-Version: 1.0
In-Reply-To: <20170822044155.2451-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jvJktQiEVWk8F4CvNvPHPGvPhkqEOS91p"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] tests: Add VM based build tests
 (for non-x86_64 and/or non-Linux)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jvJktQiEVWk8F4CvNvPHPGvPhkqEOS91p
From: Cleber Rosa <crosa@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <8805ba9c-a509-ed81-70e3-16b33bb1135c@redhat.com>
Subject: Re: [PATCH v3 00/10] tests: Add VM based build tests (for non-x86_64
 and/or non-Linux)
References: <20170822044155.2451-1-famz@redhat.com>
In-Reply-To: <20170822044155.2451-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/22/2017 12:41 AM, Fam Zheng wrote:
> v3: Drop RFC.
>     Add Stefan's and Kamil's reviewed-bys.
>     Use optparse. [Stefan]
>     Drop the VGA patch. [Paolo, Stefan]
>     Improve exit/exit code/doc. [Stefan]
>     Drop unused line from basevm.py. [Stefan]
>     Drop "--target-list" form Makefile.
>     More intelligent '-j'.
>     Add README. [Stefan]
>=20
> v2: - Add docstring. [Stefan]
>     - Call self._load_io_lod. [Stefan]
>     - Use "info usernet" and dynamic ssh_port forwarding. [Stefan]
>     - Add image checksum.
>     - Use os.rename() and os.makedirs(). [Stefan]
>     - Fix NetBSD URL. [Kamil]
>=20
> Build tests in one 32 bit Linux guest and three BSD images are defined =
in this
> series. This is a more managable way than the manually maintained virtu=
al
> machines in patchew. Also, one big advantage of ephemeral VMs over long=
 running
> guests is the reduced RAM usage of host, which makes it possible to hav=
e one
> host test all these BSD variants and probably more.
>=20
> The BSD guest templates are manually prepared following
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> as it is not easy to automate. (The ideal approach is like the ubuntu.i=
386
> script, which configures the guest on top of an official released image=
, fully
> automatically.)
>=20

I replayed manually the FreeBSD VM setup, just to get a sense of how it
could be automated.  Taking a few steps back, I realized that:

 * describing how to prepare a given OS to build QEMU is a generic task,
not really bound to this VM setup
 * cloud-init, while unarguably a sound solution, is bound to not only
VMs, but to already prepared (with cloud-init support) images

What if we attempt to switch the "build environment setup" automation to
use a more generic tool such as ansible?  Having an in-tree playbook
that could be executed against a VM seems like slightly better than
syncing the WIKI pages.

I'm no expert in ansible, but I can give it that a try if you fancy the
idea.

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--jvJktQiEVWk8F4CvNvPHPGvPhkqEOS91p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlme65MACgkQZX6NM6Xy
CfMuzA/+N3EonFUpO0csdt6aNZaGQajkqPykrDBpk5g5tkpsucziy5BY04VZZXrD
HdyawuyJGb9N2A5u2S/76qwHwb+qrevPA+Ypl6NlgJRH5pRxBLg8hqA8WEi9FBvQ
pGsrFSVwDfnLpSjp2klr8du0b4juYs4AZsVrm8zVIMNFl9IJZaXa3wcqWWz+JTSH
hKO75jCJkLfACy0WqGUj/8ER2JeWMdx6CMuAb9WLRbJwMFboeu+Zjub+V5TvbPX3
x4qolK1pxWyzIp7vCmBbf1WWtQnVu8C+FURJZ8+xsvOX/EmZLGIDVOym/tRs6inG
icB+CW4VPUCKkfOJTa14w59K4MvzuHlxRzpRHHVMLaRVZI60COBK11m7pFyAQCBl
YyVFPvGFfLF1k3/En5iXCu/9t2cVkE5kZWw+Dd3AsQwnUFRU8Fpv29WYPKNBjaTu
ykhPzt3ycHZBm74I2crriRMBb+pKflqTxUj1wlHixnDTUfw3veTowCz6R9RX64tb
KNSVoxlovaUd+ceT0Fm+Zz1n5fYMzV7FRSAeYJB5WtXHiUeo4zXzNHyH84eYdntL
f4untWo0Jmv1qElEIlQCi9KcfTr3PnWWa/WNHBuslRjAY17EfGBkl09tqW9DCFBp
euIO7UIr2QVLdXTwUu+ZoERZ0tKwRgXFmJpRHeqpdB6R9/VqaZ4=
=tczA
-----END PGP SIGNATURE-----

--jvJktQiEVWk8F4CvNvPHPGvPhkqEOS91p--
