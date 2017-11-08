Received: from eggs.gnu.org ([2001:4830:134:3::10]:34553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCOfF-0006ko-E6
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCOfA-0004oh-Ef
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:37:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCOfA-0004nv-9C
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:36:56 -0500
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-6-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4a07565a-235c-48cc-b0aa-3bd9938a4154@redhat.com>
Date: Wed, 8 Nov 2017 12:36:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171108022828.7242-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 08.11.2017 03:28, Philippe Mathieu-Daud=C3=A9 wrote:
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

As Daniel already mentioned it, I'd also suggest to use a more helpful
message instead (e.g. "Use a newer version of pc-i440fx instead" ?).

>  }
> =20
>  DEFINE_I440FX_MACHINE(v0_11, "pc-0.11", pc_compat_0_13,
> @@ -976,6 +977,7 @@ static void pc_i440fx_0_10_machine_options(MachineC=
lass *m)
>      pc_i440fx_0_11_machine_options(m);
>      m->hw_version =3D "0.10";
>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_10);
> +    m->deprecated_reason =3D "Too old";

I think you don't need the second hunk here since the function is
calling pc_i440fx_0_11_machine_options(), too.

 Thomas
