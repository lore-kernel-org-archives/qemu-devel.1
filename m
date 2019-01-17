Received: from eggs.gnu.org ([209.51.188.92]:58266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4WT-0006oQ-2J
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4WS-000631-4G
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:03:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gk4WQ-000608-0M
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:03:39 -0500
Date: Thu, 17 Jan 2019 11:03:34 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190117100334.vh3nbg4pjfwo4eye@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<82a755097c6aaa16363348599110f9af3bb07583.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82a755097c6aaa16363348599110f9af3bb07583.1547681517.git.DirtY.iCE.hu@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 47/50] paaudio: channel-map option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Jan 17, 2019 at 12:37:20AM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> Add an option to change the channel map used by pulseaudio.  If not
> specified, falls back to an OSS compatible channel map.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  qapi/audio.json |  5 ++++-
>  audio/paaudio.c | 18 ++++++++++++++----
>  qemu-options.hx |  9 +++++++++
>  3 files changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 7bcea6240f..86078039dc 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -107,11 +107,14 @@
>  #
>  # @name: name of the sink/source to use
>  #
> +# @channel-map: channel map to use (default: OSS compatible map)
> +#
>  # Since: 4.0
>  ##
>  { 'struct': 'AudiodevPaPerDirectionOptions',
>    'data': {
> -    '*name': 'str' } }
> +    '*name':        'str',
> +    '*channel-map': 'str' } }

Ah, I see.  Thats why patch #1 creates a AudiodevPaPerDirectionOptions
struct with just one field ...

cheers,
  Gerd
