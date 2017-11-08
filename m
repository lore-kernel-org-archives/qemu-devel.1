Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMUr-00084C-Vd
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMUn-0005iP-Os
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:18:09 -0500
Date: Wed, 8 Nov 2017 09:17:45 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108091745.GJ12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171108022828.7242-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] hw/arm: deprecate the EP108 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Tue, Nov 07, 2017 at 11:28:24PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> From: Alistair Francis <alistair.francis@xilinx.com>
>=20
> The EP108 was an early access development board that is no longer used.
> Add an info message to convert any users to the ZCU102 instead. On QEMU
> they are both identical.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/xlnx-zcu102.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index e2d15a1c9d..d42b6e3d3a 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -164,6 +164,8 @@ static void xlnx_ep108_init(MachineState *machine)
>  {
>      XlnxZCU102 *s =3D EP108_MACHINE(machine);
> =20
> +    info_report("Please use the ZCU102 machine instead of this machine=
.");

Why do we need this, in addition to the generic deprecation message that
says basically the same thing ?

> +
>      xlnx_zynqmp_init(s, machine);
>  }
> =20
> @@ -180,11 +182,13 @@ static void xlnx_ep108_machine_class_init(ObjectC=
lass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> =20
> -    mc->desc =3D "Xilinx ZynqMP EP108 board (Deprecated, please use xl=
nx-zcu102)";
> +    mc->desc =3D "Xilinx ZynqMP EP108 board";
>      mc->init =3D xlnx_ep108_init;
>      mc->block_default_type =3D IF_IDE;
>      mc->units_per_default_bus =3D 1;
>      mc->ignore_memory_transaction_failures =3D true;
> +    mc->deprecated_reason =3D
> +        "The ZCU102 machine has the same features supported";
>  }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
