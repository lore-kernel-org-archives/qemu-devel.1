Received: from eggs.gnu.org ([2001:4830:134:3::10]:58329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMTY-0007Sd-0o
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMTT-0004kJ-UM
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:16:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCMTT-0004j4-Nj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:16:43 -0500
Date: Wed, 8 Nov 2017 09:16:28 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108091628.GI12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171108022828.7242-6-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/i386: deprecate the pc-0.10 and
 pc-0.11 machines
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

On Tue, Nov 07, 2017 at 11:28:27PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Both are deprecated since 2.9.0
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/pc_piix.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index f79d5cb694..c462b702ff 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -941,6 +941,7 @@ static void pc_i440fx_0_11_machine_options(MachineC=
lass *m)
>      pc_i440fx_0_12_machine_options(m);
>      m->hw_version =3D "0.11";
>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
> +    m->deprecated_reason =3D "Too old";
>  }
> =20
>  DEFINE_I440FX_MACHINE(v0_11, "pc-0.11", pc_compat_0_13,
> @@ -976,6 +977,7 @@ static void pc_i440fx_0_10_machine_options(MachineC=
lass *m)
>      pc_i440fx_0_11_machine_options(m);
>      m->hw_version =3D "0.10";
>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_10);
> +    m->deprecated_reason =3D "Too old";
>  }

Any deprecation message should give users useful information about what
they should do instead to avoid the problem.

More generally though, what would removing these two machines types allow
us to actually achieve ? Seems quite arbitrary to pick 0.10 and 0.11 but
leave the other 20+ machine types.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
