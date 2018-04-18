Received: from eggs.gnu.org ([2001:4830:134:3::10]:53297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8p9R-0001S2-Td
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1f8p9R-0002km-Av
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:37:41 -0400
Date: Wed, 18 Apr 2018 17:37:33 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180418173733.776f7851.olaf@aepfle.de>
In-Reply-To: <7df49e91-aa65-d775-78eb-ddf53676dd7f@redhat.com>
References: <20180418145443.6332-1-olaf@aepfle.de>
	<7df49e91-aa65-d775-78eb-ddf53676dd7f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/vnM7h09mz1kKubJZjYxExxr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] configure: require glib-2.24 on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/vnM7h09mz1kKubJZjYxExxr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 18 Apr 2018 10:04:03 -0500
schrieb Eric Blake <eblake@redhat.com>:

> avoid g_realloc_n()?

I guess there is some global header for this, to prevent further accidents?

extern void *g_realloc_n_can_not_be_used(void);
#define g_realloc_n(a,b,c) g_realloc_n_can_not_be_used()


Olaf

--Sig_/vnM7h09mz1kKubJZjYxExxr
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWtdmPQAKCRBdQqD6ppg2
fsgoAJ9Xqi23OaNpm8DnQJjQzHVI8AXIHwCfZFjBJl+87e8Ivolo/pTg1lJMhJY=
=s9nE
-----END PGP SIGNATURE-----

--Sig_/vnM7h09mz1kKubJZjYxExxr--
