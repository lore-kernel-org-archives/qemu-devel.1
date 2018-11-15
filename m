Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gNNdF-0007Ai-9n
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gNNdE-00037U-13
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:48:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gNNdC-00031w-4b
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:48:51 -0500
Received: by mail-wr1-x444.google.com with SMTP id b13so22470295wrx.6
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 11:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20181115154639.29949-1-dgilbert@redhat.com>
In-Reply-To: <20181115154639.29949-1-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Nov 2018 23:48:32 +0400
Message-ID: <CAJ+F1CJq7VHKTJw-OKYoEdwaZJWS9v-v8ENkEWLByZAWYNOZZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.1] x86: Add 3.1 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Nov 15, 2018 at 7:47 PM Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> x86 doesn't need a 3.1 machine type, because there's no incompatibility,
> but it looks odd not having one, especially since s390, ppc and ARM have
> it.  Join the party.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

I sent same patch already reviewed by Michael a few weeks ago:
https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06574.html

> ---
>  hw/i386/pc_piix.c    | 15 ++++++++++++---
>  hw/i386/pc_q35.c     | 13 +++++++++++--
>  include/hw/i386/pc.h |  3 +++
>  3 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index dc09466b3e..7092d6d13f 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,21 +428,30 @@ static void pc_i440fx_machine_options(MachineClass =
*m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>  }
>
> -static void pc_i440fx_3_0_machine_options(MachineClass *m)
> +static void pc_i440fx_3_1_machine_options(MachineClass *m)
>  {
>      pc_i440fx_machine_options(m);
>      m->alias =3D "pc";
>      m->is_default =3D 1;
>  }
>
> +DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
> +                      pc_i440fx_3_1_machine_options);
> +
> +static void pc_i440fx_3_0_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_3_1_machine_options(m);
> +    m->is_default =3D 0;
> +    m->alias =3D NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> +}
> +
>  DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
>                        pc_i440fx_3_0_machine_options);
>
>  static void pc_i440fx_2_12_machine_options(MachineClass *m)
>  {
>      pc_i440fx_3_0_machine_options(m);
> -    m->is_default =3D 0;
> -    m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>  }
>
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 532241e3f8..6799b3e553 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -311,19 +311,28 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->max_cpus =3D 288;
>  }
>
> -static void pc_q35_3_0_machine_options(MachineClass *m)
> +static void pc_q35_3_1_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias =3D "q35";
>  }
>
> +DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
> +                    pc_q35_3_1_machine_options);
> +
> +static void pc_q35_3_0_machine_options(MachineClass *m)
> +{
> +    pc_q35_3_1_machine_options(m);
> +    m->alias =3D NULL;
> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> +}
> +
>  DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
>                      pc_q35_3_0_machine_options);
>
>  static void pc_q35_2_12_machine_options(MachineClass *m)
>  {
>      pc_q35_3_0_machine_options(m);
> -    m->alias =3D NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>  }
>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 136fe497b6..c37d4333a0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -294,6 +294,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>
> +#define PC_COMPAT_3_1 \
> +    HW_COMPAT_3_1

you shouldn't need that, right?

> +
>  #define PC_COMPAT_3_0 \
>      HW_COMPAT_3_0 \
>      {\
> --
> 2.19.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
