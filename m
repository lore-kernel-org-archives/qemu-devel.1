Received: from eggs.gnu.org ([209.51.188.92]:55670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghPO6-0001Yh-Jv
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghPO4-00085z-QO
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:44:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghPO2-00083w-Nu
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:44:00 -0500
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com>
Date: Wed, 9 Jan 2019 19:43:51 -0600
MIME-Version: 1.0
In-Reply-To: <c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8oT1zrfAvKcK3Ci1aEGgBu1ZTAjzDiayK"
Subject: Re: [Qemu-devel] [PATCH v2 43/52] audio: add mixeng option
 (documentation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8oT1zrfAvKcK3Ci1aEGgBu1ZTAjzDiayK
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <65a00798-9a26-b0bb-b70a-cfd292169123@redhat.com>
Subject: Re: [PATCH v2 43/52] audio: add mixeng option (documentation)
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
 <c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <c374ab1ece7bfc933669d8807a54bf362d715a23.1545598229.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/23/18 2:52 PM, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
> This will allow us to disable mixeng when we use a decent backend.
>=20
> Disabling mixeng have a few advantages:
> * we no longer convert the audio output from one format to another, whe=
n
>   the underlying audio system would just convert it to a third format.
>   We no longer convert, only the underlying system, when needed.
> * the underlying system probably has better resampling and sample forma=
t
>   converting methods anyway...
> * we may support formats that the mixeng currently does not support (S2=
4
>   or float samples, more than two channels)
> * when using an audio server (like pulseaudio) different sound card
>   outputs will show up as separate streams, even if we use only one
>   backend
>=20
> Disadvantages:
> * audio capturing no longer works (wavcapture, and vnc audio extension)=

> * some backends only support a single playback stream or very picky
>   about the audio format.  In this case we can't disable mixeng.
>=20
> However mixeng is not removed, only made optional, so this shouldn't be=

> a big concern.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  qapi/audio.json | 5 +++++
>  qemu-options.hx | 6 ++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 56d8ce439f..180bf207a8 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -184,6 +184,10 @@
>  #
>  # General audio backend options that are used for both playback and re=
cording.
>  #
> +# @mixeng: #optional use QEMU's mixing engine to mix all streams insid=
e QEMU.

The #optional tag is no longer necessary (the docs generator figures it
out from the '*mixeng' name below).

> +#          When set to off, fixed-settings must be also off.  Not ever=
y backend
> +#          compatible with the off setting (default on)

Missing a '(since 4.0)' tag.

> +#
>  # @fixed-settings: #optional use fixed settings for host input/output.=
  When
>  #                  off, frequency, channels and format must not be spe=
cified
>  #                  (default on)
> @@ -207,6 +211,7 @@
>  ##
>  { 'struct': 'AudiodevPerDirectionOptions',
>    'data': {
> +    '*mixeng':         'bool',
>      '*fixed-settings': 'bool',
>      '*frequency':      'int',
>      '*channels':       'int',


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--8oT1zrfAvKcK3Ci1aEGgBu1ZTAjzDiayK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2o1cACgkQ3g5py3or
ov0qJQf+PWhaH3DH32yyzu6YQ8F+PdyjpSQ0HK6qnh3kxmTp5rBcL7r9kpy4fNIK
mWq+Te1lrvQUYOppt0hh68rpcDO+oRSKIuUnJdngDWkiu3ym7oznPh9lWbA5EPUy
cgU/24dFD5KIKWF67nrqT0kXFDfv1XsGFoJZrzH096SMLSZUW62NMICWjDxX4M+0
YyoqP5EUgt9hlIhu9ZDw1tB6/io2Gn4RKyL6eVm/exrn/PUdE4UZ/yQhy6f31MpC
Fju5KADjsRlotlse5P2gdaKiOw4utv0IefIRJI3BcwI3CFL6Wb+N67/laXMBSySH
3brAu4IGp0GCCE1gCEDafac8Y+n7Bg==
=39k3
-----END PGP SIGNATURE-----

--8oT1zrfAvKcK3Ci1aEGgBu1ZTAjzDiayK--
