Received: from eggs.gnu.org ([209.51.188.92]:59656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0ne-0000FQ-8L
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJ0l5-0004CQ-L1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:07:12 -0400
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-8-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <499877a9-e657-d071-c7b7-5db5e8e82017@redhat.com>
Date: Tue, 23 Apr 2019 21:06:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190422195020.1494-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] hw/sparc64: Implement
 fw_cfg_arch_key_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 04/22/19 21:50, Philippe Mathieu-Daud=C3=A9 wrote:
> Implement fw_cfg_arch_key_name(), which returns the name of a
> sparc64-specific key.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/sparc64/sun4u.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 399f2d73c81..4230b17b873 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -91,6 +91,25 @@ typedef struct EbusState {
>  #define TYPE_EBUS "ebus"
>  #define EBUS(obj) OBJECT_CHECK(EbusState, (obj), TYPE_EBUS)
> =20
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    static const struct {
> +        uint16_t key;
> +        const char *name;
> +    } fw_cfg_arch_wellknown_keys[] =3D {
> +        {FW_CFG_SPARC64_WIDTH, "width"},
> +        {FW_CFG_SPARC64_HEIGHT, "height"},
> +        {FW_CFG_SPARC64_DEPTH, "depth"},
> +    };
> +
> +    for (size_t i =3D 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i=
++) {
> +        if (fw_cfg_arch_wellknown_keys[i].key =3D=3D key) {
> +            return fw_cfg_arch_wellknown_keys[i].name;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>                              Error **errp)
>  {
>=20

Same questions. From my POV:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
