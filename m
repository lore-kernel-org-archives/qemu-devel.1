Received: from eggs.gnu.org ([209.51.188.92]:35060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goMek-0001hs-IO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goMej-0005ct-U2
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:13:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1goMej-0005cV-MD
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:13:57 -0500
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
	<92b6dc0f167f0c0f53ad9c0fbf127ea255b7429f.1548714862.git.DirtY.iCE.hu@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bfdf1243-9bf1-128a-3f6d-93e425a0839c@redhat.com>
Date: Tue, 29 Jan 2019 07:13:46 +0100
MIME-Version: 1.0
In-Reply-To: <92b6dc0f167f0c0f53ad9c0fbf127ea255b7429f.1548714862.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/14] audio: -audiodev command line
 option: documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Libvirt <libvir-list@redhat.com>

On 2019-01-28 23:43, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
> This patch adds documentation of an -audiodev command line option, that
> deprecates the old QEMU_* environment variables for audio backend
> configuration.  It's syntax is similar to existing options (-netdev,
> -device, etc):
>=20
>   -audiodev driver_name,property=3Dvalue,...
>=20
> Although now it's possible to specify multiple -audiodev options on
> command line, multiple audio backends are not supported yet.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  qemu-options.hx | 222 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 219 insertions(+), 3 deletions(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 521511ec13..a12931899b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -416,14 +416,230 @@ The default is @code{en-us}.
>  ETEXI
> =20
> =20
> +HXCOMM Deprecated by -audiodev
>  DEF("audio-help", 0, QEMU_OPTION_audio_help,
> -    "-audio-help     print list of audio drivers and their options\n",
> +    "-audio-help     show -audiodev equivalent of the currently specif=
ied audio settings\n",
>      QEMU_ARCH_ALL)

Note that if you want to deprecate a parameter "officially" (in the
sense that it could be removed in a future release), you also have to
add an entry to qemu-deprecated.texi. But that could also be done in an
additional patch later, so no need to respin just because of this.

 Thomas
