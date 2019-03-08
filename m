Received: from eggs.gnu.org ([209.51.188.92]:55212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Cmr-0006ay-Os
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Cmp-0002jz-CV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:31:33 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-10-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9a4ee1fd-25ec-6113-496a-c5c4f51435f2@redhat.com>
Date: Fri, 8 Mar 2019 11:31:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] hw/nvram/fw_cfg: Free file_slots
 in common_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Called by fw_cfg_common_realize(), fw_cfg_file_slots_allocate()
> allocates various buffers.
> Free them in fw_cfg_common_unrealize().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index ca58d279a4..b73a591eff 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -971,6 +971,10 @@ static void fw_cfg_common_unrealize(DeviceState *d=
ev, Error **errp)
>      FWCfgState *s =3D FW_CFG(dev);
> =20
>      g_free(s->files);
> +
> +    g_free(s->entries[0]);
> +    g_free(s->entries[1]);
> +    g_free(s->entry_order);
>  }
> =20
>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
