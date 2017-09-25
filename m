Received: from eggs.gnu.org ([2001:4830:134:3::10]:41860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLlO-0008NT-1i
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLlK-0004Hc-Uf
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:17:02 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-12-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d7f0fab4-f082-ae7f-3d2d-489ebc51522b@redhat.com>
Date: Mon, 25 Sep 2017 07:16:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/34] i386/pc: use TYPE_PORT92
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 05985d4927..f116cede91 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1577,7 +1577,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_i=
rq *gsi,
>          qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
>          qdev_init_nofail(dev);
>      }
> -    port92 =3D isa_create_simple(isa_bus, "port92");
> +    port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
>      port92_init(port92, a20_line[1]);
>      g_free(a20_line);

Reviewed-by: Thomas Huth <thuth@redhat.com>
