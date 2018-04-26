Received: from eggs.gnu.org ([2001:4830:134:3::10]:59789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fBfkh-0004z1-Qs
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fBfkc-0000vn-9s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:11:55 -0400
Date: Thu, 26 Apr 2018 14:11:40 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20180426141140.7d7b39d0.olaf@aepfle.de>
In-Reply-To: <20180426121002.GG26812@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
	<20180426140807.4a4a577b.olaf@aepfle.de>
	<20180426121002.GG26812@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2QNB7caxwuAQZoROuDCFB+L";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

--Sig_/2QNB7caxwuAQZoROuDCFB+L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Thu, 26 Apr 2018 13:10:02 +0100
schrieb Daniel P. Berrang=C3=A9 <berrange@redhat.com>:

> Presumably the min-glib docker job didn't enable the vfio feature, which
> is what contained the bad code.

It is Linux=3Dy, every following commit would have failed too.
I suggest to revisit that testcase.

Olaf

--Sig_/2QNB7caxwuAQZoROuDCFB+L
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWuHB/AAKCRBdQqD6ppg2
flJnAJ9QxhK91QA3II7a/ILxLzKoy0ztbACdHj+BYeoKw5u2uNoKomZSNaHD7D8=
=BOt7
-----END PGP SIGNATURE-----

--Sig_/2QNB7caxwuAQZoROuDCFB+L--
