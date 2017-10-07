Received: from eggs.gnu.org ([2001:4830:134:3::10]:42669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hSD-0002KL-Ms
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hSC-0008Ro-0i
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:15:13 -0400
Date: Sat, 7 Oct 2017 15:39:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171007043934.GE10050@umbus.fritz.box>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-57-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
In-Reply-To: <20171006235023.11952-57-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 56/88] PowerPC: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 08:49:51PM -0300, Philippe Mathieu-Daud=E9 wrote:
> From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> [PMD: one more change in target/ppc/translate_init.c, added
> target/ppc/kvm.c]

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc.c                |  8 ++++----
>  hw/ppc/ppc_booke.c          |  4 ++--
>  target/ppc/kvm.c            |  2 +-
>  target/ppc/translate_init.c | 14 +++++++-------
>  4 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 05da316e0b..647d70fc13 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -965,7 +965,7 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint3=
2_t freq)
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>      ppc_tb_t *tb_env;
> =20
> -    tb_env =3D g_malloc0(sizeof(ppc_tb_t));
> +    tb_env =3D g_new0(ppc_tb_t, 1);
>      env->tb_env =3D tb_env;
>      tb_env->flags =3D PPC_DECR_UNDERFLOW_TRIGGERED;
>      if (env->insns_flags & PPC_SEGMENT_64B) {
> @@ -1224,10 +1224,10 @@ clk_setup_cb ppc_40x_timers_init (CPUPPCState *en=
v, uint32_t freq,
>      ppc_tb_t *tb_env;
>      ppc40x_timer_t *ppc40x_timer;
> =20
> -    tb_env =3D g_malloc0(sizeof(ppc_tb_t));
> +    tb_env =3D g_new0(ppc_tb_t, 1);
>      env->tb_env =3D tb_env;
>      tb_env->flags =3D PPC_DECR_UNDERFLOW_TRIGGERED;
> -    ppc40x_timer =3D g_malloc0(sizeof(ppc40x_timer_t));
> +    ppc40x_timer =3D g_new0(ppc40x_timer_t, 1);
>      tb_env->tb_freq =3D freq;
>      tb_env->decr_freq =3D freq;
>      tb_env->opaque =3D ppc40x_timer;
> @@ -1332,7 +1332,7 @@ int ppc_dcr_init (CPUPPCState *env, int (*read_erro=
r)(int dcrn),
>  {
>      ppc_dcr_t *dcr_env;
> =20
> -    dcr_env =3D g_malloc0(sizeof(ppc_dcr_t));
> +    dcr_env =3D g_new0(ppc_dcr_t, 1);
>      dcr_env->read_error =3D read_error;
>      dcr_env->write_error =3D write_error;
>      env->dcr_env =3D dcr_env;
> diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
> index 23bcf1b138..dafc6aa3fc 100644
> --- a/hw/ppc/ppc_booke.c
> +++ b/hw/ppc/ppc_booke.c
> @@ -339,8 +339,8 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t =
freq, uint32_t flags)
>      booke_timer_t *booke_timer;
>      int ret =3D 0;
> =20
> -    tb_env      =3D g_malloc0(sizeof(ppc_tb_t));
> -    booke_timer =3D g_malloc0(sizeof(booke_timer_t));
> +    tb_env      =3D g_new0(ppc_tb_t, 1);
> +    booke_timer =3D g_new0(booke_timer_t, 1);
> =20
>      cpu->env.tb_env =3D tb_env;
>      tb_env->flags =3D flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 171d3d8040..d8565fd4a3 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -364,7 +364,7 @@ struct ppc_radix_page_info *kvm_get_radix_page_info(v=
oid)
>      if (kvm_vm_ioctl(s, KVM_PPC_GET_RMMU_INFO, &rmmu_info)) {
>          return NULL;
>      }
> -    radix_page_info =3D g_malloc0(sizeof(*radix_page_info));
> +    radix_page_info =3D g_new0(struct ppc_radix_page_info, 1);
>      radix_page_info->count =3D 0;
>      for (i =3D 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
>          if (rmmu_info.ap_encodings[i]) {
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index c6399a3a0d..850ff038ca 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9341,13 +9341,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
>              nb_tlb *=3D 2;
>          switch (env->tlb_type) {
>          case TLB_6XX:
> -            env->tlb.tlb6 =3D g_malloc0(nb_tlb * sizeof(ppc6xx_tlb_t));
> +            env->tlb.tlb6 =3D g_new0(ppc6xx_tlb_t, nb_tlb);
>              break;
>          case TLB_EMB:
> -            env->tlb.tlbe =3D g_malloc0(nb_tlb * sizeof(ppcemb_tlb_t));
> +            env->tlb.tlbe =3D g_new0(ppcemb_tlb_t, nb_tlb);
>              break;
>          case TLB_MAS:
> -            env->tlb.tlbm =3D g_malloc0(nb_tlb * sizeof(ppcmas_tlb_t));
> +            env->tlb.tlbm =3D g_new0(ppcmas_tlb_t, nb_tlb);
>              break;
>          }
>          /* Pre-compute some useful values */
> @@ -10442,11 +10442,11 @@ static void ppc_cpu_defs_entry(gpointer data, g=
pointer user_data)
>      }
> =20
>      typename =3D object_class_get_name(oc);
> -    info =3D g_malloc0(sizeof(*info));
> +    info =3D g_new0(CpuDefinitionInfo, 1);
>      info->name =3D g_strndup(typename,
>                             strlen(typename) - strlen(POWERPC_CPU_TYPE_SU=
FFIX));
> =20
> -    entry =3D g_malloc0(sizeof(*entry));
> +    entry =3D g_new0(CpuDefinitionInfoList, 1);
>      entry->value =3D info;
>      entry->next =3D *first;
>      *first =3D entry;
> @@ -10473,11 +10473,11 @@ CpuDefinitionInfoList *arch_query_cpu_definitio=
ns(Error **errp)
>              continue;
>          }
> =20
> -        info =3D g_malloc0(sizeof(*info));
> +        info =3D g_new0(CpuDefinitionInfo, 1);
>          info->name =3D g_strdup(alias->alias);
>          info->q_typename =3D g_strdup(object_class_get_name(oc));
> =20
> -        entry =3D g_malloc0(sizeof(*entry));
> +        entry =3D g_new0(CpuDefinitionInfoList, 1);
>          entry->value =3D info;
>          entry->next =3D cpu_list;
>          cpu_list =3D entry;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnYWoYACgkQbDjKyiDZ
s5IwOQ//Ry2mV+Zysjvm9moddET2YEEleN+XXnrIyd0EwoAEtUxjXE81OpWTiMUr
HtFuDTk2L14WHl+idbzgcfuL3w7/bHUSJ1EeipPkYQO7t4xosThIa2xpgs2jTdfH
yM1HiKevP0jM3M8hEl7Gj3tRRtsvphJL5MWNMyLj9Dj8LnZii7bWqrNvZ03qSvGk
FFzROn8h2D+DmGoyVkpgFNfhZYOlHf2V3T3WCNdnuVBFX7sYHW8WVrLMIzINudkE
dUcqWIf/Eoi53rgIY4cCre9i1QdAqEF2bzjWeuX5vjdHrcHTyvKmHvonBGYX7rZu
DvT857jbGY3zEDDd2jPZ15sn20SB9u8NaiM4IxWzKCq1ZrlBRV6R3hnIeJ0mfmyN
Hpz/as4J/8xYU5zQ28RSSZ+F2qcS4cmatRhxtZ+UIJX1FG87uG8jxV8b2t2k54vO
ZLh4OIko1vTF+O+4lCC+gcJVzUweSnfAAn33mG2hyeslDoCNdzvfi/+mGgDFkeRK
oIqlGEOk9qIqYlHfs/hwbDG8tPXYtfnhavtpHoCO+VIN/zyE4NPCEKDtgu1ocV69
i5g5jwPhGKEnPhRYw65lSLPNBlfaFbK2QMEwzKJjwjnrEoUPa88upI13YTkqIMP2
F7l6M0g8LDSI5QwTmPG+eVMR7k5hZAnD3GgHWQIZOy5II4kMj3A=
=swfk
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
