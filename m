Received: from eggs.gnu.org ([2001:4830:134:3::10]:38411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8TJk-0002bS-JS
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8TJh-0007uq-BE
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:14:20 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:33461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d8TJh-0007uc-6c
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:14:17 -0400
Received: by mail-qk0-x233.google.com with SMTP id y201so33227944qka.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 08:14:17 -0700 (PDT)
Date: Wed, 10 May 2017 11:14:14 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170510151414.GC19962@stefanha-x1.localdomain>
References: <1494330527-24163-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <1494330527-24163-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/8] pci, virtio, vhost: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 04:15:22PM +0300, Michael S. Tsirkin wrote:
> The following changes since commit dd1559bb267becbb838de41132ef60771d183e=
5d:
>=20
>   Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into=
 staging (2017-05-05 17:07:55 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>=20
> for you to fetch changes up to 6512fee18a330463f7cbe2524d92a53252664946:
>=20
>   ACPI: don't call acpi_pcihp_device_plug_cb on xen (2017-05-09 14:45:55 =
+0300)
>=20
> ----------------------------------------------------------------
> pci, virtio, vhost: fixes
>=20
> A bunch of fixes that missed the release.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ----------------------------------------------------------------
> Ard Biesheuvel (2):
>       hw/acpi-defs: replace leading X with x_ in FADT field names

Please rebase on qemu.git/master.  The following new commit conflicts:

  commit 77af8a2b95b79699de650965d5228772743efe84
  Author: Phil Dennis-Jordan <phil@philjordan.eu>
  Date:   Wed Mar 15 19:20:26 2017 +1300

      hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS=
 support.

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEy5GAAoJEJykq7OBq3PIhWIIALdwweWsKMrHskem3m5yWuN9
zD41GbgD9I8HAjyz8c52adSomGQCtmJBmBYE4K6vV/MudLhvkezrMNN+y4+D/e/W
G6HxmSCh/9zqvpq8Bi2i+pYjbG9qLmdBfOqI9wK4K5gpRw3YdMTkpgQhj5vioSx0
eBE3RY6m7XFM+LU5NcJ4dLCg/GJgN7rFVoee7DxJZuBBdX+aTOG1Q7+jaIvgtAbK
n4L5mRKf4rTGfLEN+J7ZcimDdtDfv1jRvpK8n7QPQ8XG0z0A5sa1rlEsu0MWFvV2
PeE+J7sfLNCpV2TL5bw1ip9qbhPMv0tq7ZXAyzEHFb4PA2j+3SfjZfI4BmLe+pc=
=edt3
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
