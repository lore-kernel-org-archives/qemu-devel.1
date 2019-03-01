Received: from eggs.gnu.org ([209.51.188.92]:58270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzXc2-0004Ns-9t
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 21:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzXc0-0006X5-9X
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 21:09:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gzXbz-0006WZ-NP
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 21:09:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so10774421wmg.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 18:09:19 -0800 (PST)
References: <1551185735-17154-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1551185735-17154-10-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <07b3eb94-30a5-910b-760a-0058e52d23b3@redhat.com>
Date: Fri, 1 Mar 2019 03:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <1551185735-17154-10-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5zA0XhxbjLKnQssdu3C3BXp3Uc5VwSUEk"
Subject: Re: [Qemu-devel] [PATCH v4 9/9] target/mips: Add support for DSPRAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, Yongbok Kim <yongbok.kim@mips.com>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-devel@nongnu.org, arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net, Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5zA0XhxbjLKnQssdu3C3BXp3Uc5VwSUEk
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Yongbok Kim <yongbok.kim@mips.com>, Luc Michel <luc.michel@greensocs.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-devel@nongnu.org, arikalo@wavecomp.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <07b3eb94-30a5-910b-760a-0058e52d23b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 9/9] target/mips: Add support for DSPRAM
References: <1551185735-17154-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1551185735-17154-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551185735-17154-10-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yongbok, Aleksandar.

(I believe this is the v6 of this patched, included in a v4 series).

On 2/26/19 1:55 PM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
>=20
> The optional Data Scratch Pad RAM (DSPRAM) block provides a general scr=
atch pad RAM
> used for temporary storage of data. The DSPRAM provides a connection to=
 on-chip
> memory or memory-mapped registers, which are accessed in parallel with =
the L1 data
> cache to minimize access latency

I made some comments around, but the most important is simply:

"please move create_dspram() into mips_cps".

Now I also made high level review (long mail, sorry), thus I Cc'ed
Peter/Luc/Alistair who worked on multi-core object design in QEMU.

>=20
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  default-configs/mips-softmmu-common.mak |  1 +
>  hw/mips/cps.c                           |  3 ++-
>  hw/mips/mips_malta.c                    | 31 +++++++++++++++++++++++++=
++++++
>  hw/misc/Makefile.objs                   |  1 +
>  include/hw/mips/cps.h                   |  2 ++
>  target/mips/cpu.h                       |  5 +++++
>  target/mips/internal.h                  |  1 +
>  target/mips/op_helper.c                 | 10 ++++++++++
>  target/mips/translate.c                 |  8 ++++++++
>  target/mips/translate_init.inc.c        |  2 ++
>  10 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index ded7498..d3f85b0 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -35,6 +35,7 @@ CONFIG_ISA_TESTDEV=3Dy
>  CONFIG_EMPTY_SLOT=3Dy
>  CONFIG_MIPS_CPS=3Dy
>  CONFIG_MIPS_ITU=3Dy
> +CONFIG_MIPS_DSPRAM=3Dy
>  CONFIG_I2C=3Dy
>  CONFIG_R4K=3Dy
>  CONFIG_MALTA=3Dy
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index fc97f59..97e2232 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -102,7 +102,8 @@ static void mips_cps_realize(DeviceState *dev, Erro=
r **errp)
>          object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-=
present",
>                                   &err);
>          if (saar_present) {
> -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->C=
P0_SAAR);
> +            qdev_prop_set_ptr(DEVICE(&s->itu), "saar",
> +                              (void *) &env->CP0_SAAR[0]);

No need to cast.

>          }
>          object_property_set_bool(OBJECT(&s->itu), true, "realized", &e=
rr);
>          if (err !=3D NULL) {
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 7a403ef..306d701 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1170,6 +1170,36 @@ static void create_cps(MaltaState *s, const char=
 *cpu_type,
>      *cbus_irq =3D NULL;
>  }
> =20
> +static void create_dspram(void)
> +{
> +    MIPSCPU *cpu =3D MIPS_CPU(first_cpu);
> +    CPUMIPSState *env =3D &cpu->env;
> +    bool dspram_present =3D (bool) env->dspramp;
> +    Error *err =3D NULL;
> +
> +    env->dspram =3D g_new0(MIPSDSPRAMState, 1);
> +
> +    /* DSPRAM */
> +    if (dspram_present) {
> +        if (!(bool) env->saarp) {
> +            error_report("%s: DSPRAM requires SAAR registers", __func_=
_);
> +            exit(1);

I recommend you to give this function a 'Error **errp' argument and set
errp here, and call it with errp=3D&error_fatal. This will help further
improvement of the DSPRAM as QOM and add qtesting.

> +        }
> +        object_initialize(env->dspram, sizeof(MIPSDSPRAMState),
> +                          TYPE_MIPS_DSPRAM);
> +        qdev_set_parent_bus(DEVICE(env->dspram), sysbus_get_default())=
;
> +        qdev_prop_set_ptr(DEVICE(env->dspram), "saar",
> +                          (void *) &env->CP0_SAAR[1]);

Again, you can drop the cast.

> +        object_property_set_bool(OBJECT(env->dspram), true, "realized"=
, &err);
> +        if (err !=3D NULL) {
> +            error_report("%s: DSPRAM initialisation failed", __func__)=
;
> +            exit(1);

This now becomes error_propagate().

> +        }
> +        memory_region_add_subregion(get_system_memory(), 0,

Here you map the DSPRAM at 0x0 of the whole system memory... This is
currently not wrong, because the model is limited, but this doesn't
scale at all. Also it is not obvious base address 0x0 is the reset value
of the SAAR register. Can you add a comment?

> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(env->dspram)=
, 0));
> +    }
> +}
> +
>  static void mips_create_cpu(MaltaState *s, const char *cpu_type,
>                              qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
> @@ -1178,6 +1208,7 @@ static void mips_create_cpu(MaltaState *s, const =
char *cpu_type,
>      } else {
>          create_cpu_without_cps(cpu_type, cbus_irq, i8259_irq);
>      }
> +    create_dspram();

Well, the DSPRAM is definitively not a machine feature, but a SoC one.

The current implementation doesn't differency between
Cluster/Core/Thread. QEMU is not very clear about that (yet).
Recently the TYPE_CPU_CLUSTER got introduced.

The CPS is actually a "Core" which creates various virtual processors
(threads), an ITU, and is where the DSPRAM belongs.

Note that there is no multi-cluster model, we can see the current model
as a single cluster of a single core. This core can has upto 'num-vp'
threads.
A core share an ITU and a DSPRAM between all his threads. There is an
unique SAAR register per core.
Each thread is a QEMU MIPS_CPU, and has his own SAARI register.

My understanding is the following schema:

+---------------------------------------------------+
| +-------------------------------------------+     |
| | +-----------------------------+   +-----+ |     |
| | |                             |   | IOCU| |     |
| | |   +---------+      +------+ |   +-----+ |     |
| | |   |         |      |DSPRAM| +---+       +--+  |
| | |   | +-------+---+  +------+ |   |       |  |  |
| | |   | |           |           |   |       |  |  |
| | |   +-+  +--------+--+        |   +---+   |  |  |
| | |     |  |           |        |   |   |   |  |  |
| | |     +--+  +--------+--+     |   |   |   |  |  |
| | |        |  |           |     |   |   |   |  |  |
| | | +---+  +--+  Thread   |     |   |   |   |  |  |
| | | |ITU|     |           |     |   |   |   |  |  |
| | | +---+     +-----------+     |   |   |   |  |  |
| | +---------------------- Core--+   |   |   |  |  |
| |     |                             |   |   |  |  |
| |     +---+-------------------Core--+   |   |  |  |
| |         |                             |   |  |  |
| | +----+  +-----------------------Core--+   |  |  |
| | |IOCU|                                    |  |  |
| | +----+                                    |  |  |
| +---------------------------------Cluster---+  |  |
|     |                                          |  |
|     +---------------------------------Cluster--+  |
|                                                   |
+-------------I6500 Multiprocessing System----------+


Moving the create_dspram() code in cps.c, you already has access to
saar_present and also the the 'container' object representing the Core.
This allow you to restrict the DSPRAM to the Core (instead of having it
exposed to the whole system), registering it as a subregion of the Core
(=3Dcontainer).

Since this version still [*] doesn't include content of
hw/misc/mips_dspram.c I'm unable to understand/test the extend of this
device implementation.

=46rom the System Programmer=E2=80=99s Guide:

  "SPRAM blocks can be as small as 4 K and as large as 1 MB.
  The tags and sizes of all SPRAMs are configured at build
  time and are not modifiable by software."

And:

  "When the TARGET field of the SAARI register is set to 0x01,
  kernel software programs the SAAR register with the base address
  and size of the DSPRAM block. Hardware then uses this information
  to program the internal SAAR1_DSPRAM register that is dedicated to
  the DSPRAM, thereby setting the base address and the size of the
  DSPRAM block."

Although I understand you are modelling this for the I6500, I still
prefer this base addr to be explicit.
Since the SPRAM addr/sizes are variables, we should use them as object
property.

[*] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02670.html

>  }
> =20
>  static
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 74c91d2..37c4108 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -60,6 +60,7 @@ obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.=
o
>  obj-$(CONFIG_MIPS_CPS) +=3D mips_cmgcr.o
>  obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
>  obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
> +obj-$(CONFIG_MIPS_DSPRAM) +=3D mips_dspram.o
>  obj-$(CONFIG_MPS2_FPGAIO) +=3D mps2-fpgaio.o
>  obj-$(CONFIG_MPS2_SCC) +=3D mps2-scc.o
> =20
> diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
> index aab1af9..a637036 100644
> --- a/include/hw/mips/cps.h
> +++ b/include/hw/mips/cps.h
> @@ -25,6 +25,7 @@
>  #include "hw/intc/mips_gic.h"
>  #include "hw/misc/mips_cpc.h"
>  #include "hw/misc/mips_itu.h"
> +#include "hw/misc/mips_dspram.h"
> =20
>  #define TYPE_MIPS_CPS "mips-cps"
>  #define MIPS_CPS(obj) OBJECT_CHECK(MIPSCPSState, (obj), TYPE_MIPS_CPS)=

> @@ -41,6 +42,7 @@ typedef struct MIPSCPSState {
>      MIPSGICState gic;
>      MIPSCPCState cpc;
>      MIPSITUState itu;
> +    MIPSDSPRAMState dspram;

Again, no idea how is defined MIPSDSPRAMState, hard to review...

>  } MIPSCPSState;
> =20
>  qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index a10eeb0..da21d2b 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1022,6 +1022,7 @@ struct CPUMIPSState {
>      uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStat=
us */
>      uint64_t insn_flags; /* Supported instruction set */
>      int saarp;
> +    int dspramp;
> =20
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> @@ -1039,6 +1040,7 @@ struct CPUMIPSState {
>      QEMUTimer *timer; /* Internal timer */
>      struct MIPSITUState *itu;
>      MemoryRegion *itc_tag; /* ITC Configuration Tags */
> +    struct MIPSDSPRAMState *dspram;
>      target_ulong exception_base; /* ExceptionBase input to the core */=

>  };
> =20
> @@ -1181,6 +1183,9 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq=
, int level);
>  /* mips_itu.c */
>  void itc_reconfigure(struct MIPSITUState *tag);
> =20
> +/* mips_dspram.c */
> +void dspram_reconfigure(struct MIPSDSPRAMState *dspram);
> +
>  /* helper.c */
>  target_ulong exception_resume_pc (CPUMIPSState *env);
> =20
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 8f6fc91..766350c 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -62,6 +62,7 @@ struct mips_def_t {
>      uint64_t insn_flags;
>      enum mips_mmu_types mmu_type;
>      int32_t SAARP;
> +    int32_t DSPRAMP;

Since 'P' is for is_Present, why not use a boolean?

>  };
> =20
>  extern const struct mips_def_t mips_defs[];
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 0f272a5..e49fe05 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1614,6 +1614,11 @@ void helper_mtc0_saar(CPUMIPSState *env, target_=
ulong arg1)
>                  itc_reconfigure(env->itu);
>              }
>              break;
> +        case 1:
> +            if (env->dspram) {
> +                dspram_reconfigure(env->dspram);
> +            }

               else?

> +            break;

I'd add an explicit:

           default:
               /* "Writes to reserved values will be dropped." */
               break;
>          }
>      }
>  }
> @@ -1631,6 +1636,11 @@ void helper_mthc0_saar(CPUMIPSState *env, target=
_ulong arg1)
>                  itc_reconfigure(env->itu);
>              }
>              break;
> +        case 1:
> +            if (env->dspram) {
> +                dspram_reconfigure(env->dspram);
> +            }
> +            break;

Ditto.

>          }
>      }
>  }

mf[h]c0_saar() return from env->CP0_SAAR: no need to add helpers, OK.

> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3b17020..dd50c52 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -29925,6 +29925,8 @@ void cpu_state_reset(CPUMIPSState *env)
>      env->active_fpu.fcr31 =3D env->cpu_model->CP1_fcr31;
>      env->msair =3D env->cpu_model->MSAIR;
>      env->insn_flags =3D env->cpu_model->insn_flags;
> +    env->saarp =3D env->cpu_model->SAARP;
> +    env->dspramp =3D env->cpu_model->DSPRAMP;
> =20
>  #if defined(CONFIG_USER_ONLY)
>      env->CP0_Status =3D (MIPS_HFLAG_UM << CP0St_KSU);
> @@ -30079,6 +30081,12 @@ void cpu_state_reset(CPUMIPSState *env)
>          msa_reset(env);
>      }
> =20
> +    /* DSPRAM */
> +    if (env->dspramp) {
> +        /* Fixed DSPRAM size with Default Value */
> +        env->CP0_SAAR[1] =3D 0x10 << 1;

Hmmmmm this start to get messy...
CP0_SAAR is not thread-related, but core-related. Remember, Mips Core =3D=

container of Mips threads (aka QEMU MIPS_CPU).
So the CP0_SAAR should redirect to the container object, and this
register is reset only once in that object reset handler.

Now each thread do have a SAARI register.

I think how this object model is currently implemented in QEMU is via
'link property'. You instanciate the Core container, then create threads
that expects DEFINE_PROP_LINK. You set the thread's link property with
the container object, then the thread can access the container member
(CP0_SAAR).

64KiB is indeed the default reset value for the I6500,
and default base address 0x00000000_00000000.

Isn't the size a cpu-specific value (and belongs to mips_defs[])?

What about adding mips_defs[I6500].dspram_size =3D 0x10 and use this valu=
e
in the reset handler? ...

> +    }
> +
>      compute_hflags(env);
>      restore_fp_status(env);
>      restore_pamask(env);
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_i=
nit.inc.c
> index bf559af..4c49a0e 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -760,6 +760,8 @@ const mips_def_t mips_defs[] =3D
>          .PABITS =3D 48,
>          .insn_flags =3D CPU_MIPS64R6 | ASE_MSA,
>          .mmu_type =3D MMU_TYPE_R4000,
> +        .SAARP =3D 1,
> +        .DSPRAMP =3D 1,

=2E.. We could even use directly 'dspram_size' and consider a size of zer=
o
as Data Scratchpad RAM not present (.DSPRAMP =3D 0):

           .dspram_size =3D 0x10, /* 64 KiB of Data Scratchpad RAM */

So we can remove env->dspramp and mips_defs.DSPRAMP variables, and check:=


    /* DSPRAM */
    if (env->cpu_model->dspram_size) {
        /* Default DSPRAM size value, base address 0x0..0 */
        env->CP0_SAAR[1] =3D env->cpu_model->dspram_size << 1;

But still I'd rather use a property link... such:

        env->CP0_SAAR[1] =3D core_container_of(env)->dspram_size << 1;

>      },
>      {
>          .name =3D "Loongson-2E",
>=20

I apologize it took me 5 months to review this, and for the long mail!

Regards,

Phil.


--5zA0XhxbjLKnQssdu3C3BXp3Uc5VwSUEk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlx4lEwACgkQoqP9bt6t
wN7heA/+KCePdBGmdIk8z8KXDBVlnBsC4SSy8xuz08Hg7szc/CQOdED2ZmPuXvaX
CHJNAlHzumYke4InSZqoij8vmLRfCv6MxqncX29k2wpzfj8l0U/oK4vbQWbkUWCk
3DoX7EPzddHqZJL/lfoHPI9QzI3P6fk4Wzw/KiOMmE8ePwq7zqfXcqz4/hv3/7d0
yaFBW+/9l7zMXOhk7NN5tWSWzJYBv0PvYjgfpnoNhKxP/s4meFyYuCdq4EX5x45E
FBkFuCSe23ZbTgSX5NZm2yZ1IiCdL1AKYywMRFetITyVIrOap0uzsl2XVBy3v+ip
bCgokT3hoB6gk3g5I4JQDsxvwULiYLQ+7LM46wM7eZhFkkFCLi6XKVrtPyK3ETdE
w/k28oQGxPMQuK+qGKLzD4VecqX6sZEc1CM2aieoGexankXehTvh39HeKWES162E
Tk/zjGi3K1ayU0TT1U87JaioUTX/xNMu7rBn3b1it5B2k94RxJAZpjRPYPQPL0oP
Uam1A5I13lldzPberd7SqipPnFGi2oQq0tiEEknUA8gTYrNsENoldJStWwGJSBTo
hnAr7O5XqHMGoBGAT+hp3Nw7Iq2CAImAvG4hcfIb+fhXm5Uq03SE0M06w/k3qzYD
w5o8FS+9CdrAFERp0orN/HiTz8mSjxpos6e3zM3BEPj5wLbYEDo=
=Sff9
-----END PGP SIGNATURE-----

--5zA0XhxbjLKnQssdu3C3BXp3Uc5VwSUEk--
