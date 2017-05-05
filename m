Received: from eggs.gnu.org ([2001:4830:134:3::10]:49313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fSS-0006GX-6o
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6fSO-0000Vl-5x
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:47:52 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6fSN-0000Vb-Ve
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:47:48 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so2132270wmb.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:47:47 -0700 (PDT)
Date: Fri, 5 May 2017 16:47:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505154744.GH14316@stefanha-x1.localdomain>
References: <20170504071811.3547-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/30] audio patch queue
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


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 09:17:41AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> First audio pull for 2.10, with a bunch of cleanups sent during the
> freeze, and two memory leak fixes.
>=20
> please pull,
>   Gerd
>=20
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kraxel.org/qemu tags/pull-audio-20170504-1
>=20
> for you to fetch changes up to 9ea5ada76f34a0ef048b131c3a166d8564199bdb:
>=20
>   audio: Use ARRAY_SIZE from qemu/osdep.h (2017-05-04 09:16:05 +0200)
>=20
> ----------------------------------------------------------------
> audio: cleanups, bugfixes (memory leaks).
>=20
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       audio: release capture buffers
>=20
> Juan Quintela (26):
>       adlib: Remove support for YMF262
>       audio: remove Y8950 configuration
>       audio: Remove YM3526 support
>       audio: YM3812 was always defined
>       audio: Remove UINT8
>       audio: remove UINT16
>       audio: remove UINT32
>       audio: Remove INT8
>       audio: remove INT16
>       audio: Remove INT32
>       audio: Unfold OPLSAMPLE
>       audio: Remove Unused OPL_TYPE_*
>       audio: Remove type field
>       audio: Remove unused fields
>       audio: GUSbyte is uint8_t
>       audio: remove GUSchar
>       audio: GUSword is uint16_t
>       audio: GUSword is uint16_t
>       audio: GUSsample is int16_t
>       audio: OPLSetIRQHandler is not used anywhere
>       audio: OPLSetUpdateHandler is not used anywhere
>       audio: IRQHandler is not used anymore
>       audio: UpdateHandler is not used anymore
>       audio: Remove unused typedefs
>       audio: un-export OPLResetChip
>       audio: Use ARRAY_SIZE from qemu/osdep.h
>=20
> Marc-Andr=E9 Lureau (1):
>       audio: fix WAVState leak
>=20
> Zihan Yang (2):
>       hw/audio: replace exit with unrealize in hda_codec_device_class_init
>       hw/audio: convert exit callback in HDACodecDeviceClass to void
>=20
>  hw/audio/fmopl.h        | 175 +++++++++---------------------
>  hw/audio/gusemu.h       |  22 +---
>  hw/audio/intel-hda.h    |   2 +-
>  audio/audio.c           |   2 +
>  audio/wavcapture.c      |   1 +
>  hw/audio/adlib.c        |  47 +-------
>  hw/audio/fmopl.c        | 277 ++++++++----------------------------------=
------
>  hw/audio/gus.c          |   2 +-
>  hw/audio/gusemu_hal.c   |  74 ++++++-------
>  hw/audio/gusemu_mixer.c |  28 ++---
>  hw/audio/hda-codec.c    |   3 +-
>  hw/audio/intel-hda.c    |   5 +-
>  hw/audio/Makefile.objs  |   2 -
>  13 files changed, 160 insertions(+), 480 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDJ6gAAoJEJykq7OBq3PIwRgH/34gCSq0bOZs7eGBHyH6Vqf6
NpJ5T1nuLfU+FKp94m1I/EDzPk3427K89v9F10XEjJpzHDmBihmqbzTNN+Uq/YXO
Z9Gf1wRk4olq3u4TKYiwmGhTeJn15vrjmmeqp26fkTqKVCozyuDmfPXcNDyVK7AS
68nlPMa76uCIbQBcE4p3vPbGdHlVIO//Y/jgXdbCOQHRZDz5cFfG8aZNc2t1LIa+
nuBX0pqIcqGKRap3JeFg8zl9gT+GweVHCSTgm43qcY/9OBtjrtohxYMVQ5SGDPJc
/MJlKvGnb6qdrZ6ViUblqsO/yACFDuwAdzhFlP/igwa4F8W+evTA9bE7InqzWS4=
=CTPW
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
