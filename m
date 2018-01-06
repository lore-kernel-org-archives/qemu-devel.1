Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXe6Q-00073e-R2
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXe6Q-0005Sq-4Z
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:20:54 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180104144046.30793-6-f4bug@amsat.org>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104144046.30793-6-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 5 Jan 2018 18:20:22 -0800
Message-ID: <CAKmqyKPs2pZh=SSqAsZyBm41b4UkrfdwWrvspJbWdHfPViqgqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/net/cadence_gem: add FDT names
 as alias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 4, 2018 at 6:40 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/net/cadence_gem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 3943187572..b7b4540d91 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1544,6 +1544,12 @@ static void gem_class_init(ObjectClass *klass, voi=
d *data)
>
>  static const TypeInfo gem_info =3D {
>      .name  =3D TYPE_CADENCE_GEM,
> +    .aliases       =3D (const char * []) {
> +                        "cdns,gem",
> +                        "cdns,zynq-gem",    /* Zynq-7xxx SoC */
> +                        "cdns,zynqmp-gem",  /* Zynq Ultrascale+ MPSoC */
> +                        NULL
> +                     },
>      .parent =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size  =3D sizeof(CadenceGEMState),
>      .instance_init =3D gem_init,
> --
> 2.15.1
>
>
