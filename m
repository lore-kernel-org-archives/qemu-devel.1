Received: from eggs.gnu.org ([2001:4830:134:3::10]:38034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e078h-0005Xl-9L
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1e078g-00076x-6W
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:28:39 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:55945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1e078g-00076g-1h
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:28:38 -0400
Received: by mail-it0-x241.google.com with SMTP id p185so1530050itc.4
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:28:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507211474-188400-35-git-send-email-imammedo@redhat.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-35-git-send-email-imammedo@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 5 Oct 2017 16:28:15 +0200
Message-ID: <CACXAS8D37uUgDSjX01MOP+zyRZiBAFjJUkzVkqt1ut1DOxCcfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 34/40] sparc: leon3: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fabien Chouteau <chouteau@adacore.com>

On Thu, Oct 5, 2017 at 3:51 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
> CC: mark.cave-ayland@ilande.co.uk
> CC: atar4qemu@gmail.com
> CC: chouteau@adacore.com
> ---
>  hw/sparc/leon3.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index ec2816b..8c66d5a 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -107,7 +107,6 @@ static void leon3_set_pil_in(void *opaque, uint32_t p=
il_in)
>  static void leon3_generic_hw_init(MachineState *machine)
>  {
>      ram_addr_t ram_size =3D machine->ram_size;
> -    const char *cpu_model =3D machine->cpu_model;
>      const char *kernel_filename =3D machine->kernel_filename;
>      SPARCCPU *cpu;
>      CPUSPARCState   *env;
> @@ -122,11 +121,7 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
>      ResetData  *reset_info;
>
>      /* Init CPU */
> -    if (!cpu_model) {
> -        cpu_model =3D "LEON3";
> -    }
> -
> -    cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> +    cpu =3D SPARC_CPU(cpu_create(machine->cpu_type));
>      env =3D &cpu->env;
>
>      cpu_sparc_set_id(env, 0);
> @@ -222,6 +217,7 @@ static void leon3_generic_machine_init(MachineClass *=
mc)
>  {
>      mc->desc =3D "Leon-3 generic";
>      mc->init =3D leon3_generic_hw_init;
> +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("LEON3");
>  }
>
>  DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
> --
> 2.7.4
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
