Received: from eggs.gnu.org ([2001:4830:134:3::10]:56863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMMG-0005Gk-R4
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMMD-0000pU-KT
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCMMD-0000pE-EC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:09:13 -0500
Date: Wed, 8 Nov 2017 09:09:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108090900.GF12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171108022828.7242-7-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] hw/i386: deprecate the "isapc"
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Tue, Nov 07, 2017 at 11:28:28PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Deprecated since 2.9.0, guests should be able to use "pc" instead.

Isn't isapc important to allow QEMU to old operating systems that
predate the PCI era. I do recall seeing some messages about specific
cases where you cannot use the 'pc' machine type and we suggested
used of 'isapc' instead, but can't remember the exact details..

I know that's not a typical usecase for modern cloud / data center
virt, but it is interesting for usage of QEMU as a archeology tool,
so I'm loathe to see this removed unless it is demonstrably causing
an unacceptable maint burden to keep it.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/pc_piix.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c462b702ff..df4669c6d3 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -1114,6 +1114,7 @@ static void isapc_machine_options(MachineClass *m=
)
>      pcmc->smbios_legacy_mode =3D true;
>      pcmc->has_reserved_memory =3D false;
>      m->default_cpu_type =3D X86_CPU_TYPE_NAME("486");
> +    m->deprecated_reason =3D "Use the \"pc\" machine instead";
>  }
> =20
>  DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
