Received: from eggs.gnu.org ([2001:4830:134:3::10]:38498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBkEu-0006Lu-PC
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBkEq-0007UY-JH
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:54:52 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBkEq-0007UB-CI
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:54:48 -0400
Received: by mail-wm0-x241.google.com with SMTP id k15so17828413wmh.3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:54:48 -0700 (PDT)
Date: Fri, 19 May 2017 16:54:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170519155445.GF30573@stefanha-x1.localdomain>
References: <20170519112415.19191-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <20170519112415.19191-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] audio patch queue.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 01:24:12PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> Smallish audio patch queue, renaming moving soundhw init code.
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-audio-20170519-1
>=20
> for you to fetch changes up to 8a824e4d74213a2da39323304f949c5b4243e1fb:
>=20
>   audio: Rename hw/audio/audio.h to hw/audio/soundhw.h (2017-05-19 10:48:=
54 +0200)
>=20
> ----------------------------------------------------------------
> audio: move & rename soundhw init code.
>=20
> ----------------------------------------------------------------
> Eduardo Habkost (3):
>       audio: Move arch_init audio code to hw/audio/soundhw.c
>       audio: Rename audio_init() to soundhw_init()
>       audio: Rename hw/audio/audio.h to hw/audio/soundhw.h
>=20
>  include/hw/audio/{audio.h =3D> soundhw.h} |   3 +
>  include/sysemu/arch_init.h              |   2 -
>  arch_init.c                             | 126 +-------------------------
>  hw/audio/ac97.c                         |   2 +-
>  hw/audio/adlib.c                        |   2 +-
>  hw/audio/cs4231a.c                      |   2 +-
>  hw/audio/es1370.c                       |   2 +-
>  hw/audio/gus.c                          |   2 +-
>  hw/audio/intel-hda.c                    |   2 +-
>  hw/audio/pcspk.c                        |   2 +-
>  hw/audio/sb16.c                         |   2 +-
>  hw/audio/soundhw.c                      | 156 ++++++++++++++++++++++++++=
++++++
>  hw/ppc/prep.c                           |   3 +-
>  vl.c                                    |   3 +-
>  hw/audio/Makefile.objs                  |   2 +
>  15 files changed, 174 insertions(+), 137 deletions(-)
>  rename include/hw/audio/{audio.h =3D> soundhw.h} (81%)
>  create mode 100644 hw/audio/soundhw.c
>=20

Coding style violations are pre-existing.  That's fine.

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHxVFAAoJEJykq7OBq3PIkoQH/jNaIVXKBfgghBgr0QtaXsKG
zW2n3Pkky3SjsYisXBbs1PzoqtZU6DI9OqTc8L3XiJq8z9Ggo5vCdPI6GbfXMjLS
3mve0DvhNRo7W1LAF8A0R2Eoat5LgTw/Tx/1igMUMVgviP3jTLB4032QFjpbsq7j
pdR1qeDlELGdpPBXc4ATCDYk/S/pXecPn4mC8SgHspVnUmmTH7ip9TnSUwnPSZUj
9db9S0uyRfOcrICmAxUr3eHwShLJePFtoEyC1gGgbcs0g7EQeglhcVWFYxM0FNKv
JgVINiTq4jLMtHu3VWJ85BDOZMxJHfcZPdzoHUPdF7aUdtnbbq9NTx0mjogWWFo=
=wj4M
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
