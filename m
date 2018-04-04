Received: from eggs.gnu.org ([2001:4830:134:3::10]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3g0m-0007EC-9q
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3g0h-0007B1-KY
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:51:28 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3g0h-0007Ai-Aw
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:51:23 -0400
Received: by mail-wm0-x242.google.com with SMTP id t67so20010904wmt.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:51:23 -0700 (PDT)
References: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1521034084-17344-3-git-send-email-abdallah.bouassida@lauterbach.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521034084-17344-3-git-send-email-abdallah.bouassida@lauterbach.com>
Date: Wed, 04 Apr 2018 11:51:20 +0100
Message-ID: <87in97ckif.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 2/3] target/arm: Add "_S"
 suffix to the secure version of a sysreg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, khaled.jmal@lauterbach.com, qemu-arm@nongnu.org


Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:

> This is a preparation for the coming feature of creating dynamically an X=
ML
> description for the ARM sysregs.
> Add "_S" suffix to the secure version of sysregs that have both S and NS =
views
> Replace (S) and (NS) by _S and _NS for the register that are manually def=
ined,
> so all the registers follow the same convention.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index db8c925..1360a14 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -695,12 +695,12 @@ static const ARMCPRegInfo cp_reginfo[] =3D {
>       * the secure register to be properly reset and migrated. There is a=
lso no
>       * v8 EL1 version of the register so the non-secure instance stands =
alone.
>       */
> -    { .name =3D "FCSEIDR(NS)",
> +    { .name =3D "FCSEIDR",
>        .cp =3D 15, .opc1 =3D 0, .crn =3D 13, .crm =3D 0, .opc2 =3D 0,
>        .access =3D PL1_RW, .secure =3D ARM_CP_SECSTATE_NS,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.fcseidr_ns),
>        .resetvalue =3D 0, .writefn =3D fcse_write, .raw_writefn =3D raw_w=
rite, },
> -    { .name =3D "FCSEIDR(S)",
> +    { .name =3D "FCSEIDR_S",
>        .cp =3D 15, .opc1 =3D 0, .crn =3D 13, .crm =3D 0, .opc2 =3D 0,
>        .access =3D PL1_RW, .secure =3D ARM_CP_SECSTATE_S,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.fcseidr_s),
> @@ -716,7 +716,7 @@ static const ARMCPRegInfo cp_reginfo[] =3D {
>        .access =3D PL1_RW, .secure =3D ARM_CP_SECSTATE_NS,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.contextidr_el[1]),
>        .resetvalue =3D 0, .writefn =3D contextidr_write, .raw_writefn =3D=
 raw_write, },
> -    { .name =3D "CONTEXTIDR(S)", .state =3D ARM_CP_STATE_AA32,
> +    { .name =3D "CONTEXTIDR_S", .state =3D ARM_CP_STATE_AA32,
>        .cp =3D 15, .opc1 =3D 0, .crn =3D 13, .crm =3D 0, .opc2 =3D 1,
>        .access =3D PL1_RW, .secure =3D ARM_CP_SECSTATE_S,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.contextidr_s),
> @@ -1967,7 +1967,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[=
] =3D {
>                                     cp15.c14_timer[GTIMER_PHYS].ctl),
>        .writefn =3D gt_phys_ctl_write, .raw_writefn =3D raw_write,
>      },
> -    { .name =3D "CNTP_CTL(S)",
> +    { .name =3D "CNTP_CTL_S",
>        .cp =3D 15, .crn =3D 14, .crm =3D 2, .opc1 =3D 0, .opc2 =3D 1,
>        .secure =3D ARM_CP_SECSTATE_S,
>        .type =3D ARM_CP_IO | ARM_CP_ALIAS, .access =3D PL1_RW | PL0_R,
> @@ -2006,7 +2006,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[=
] =3D {
>        .accessfn =3D gt_ptimer_access,
>        .readfn =3D gt_phys_tval_read, .writefn =3D gt_phys_tval_write,
>      },
> -    { .name =3D "CNTP_TVAL(S)",
> +    { .name =3D "CNTP_TVAL_S",
>        .cp =3D 15, .crn =3D 14, .crm =3D 2, .opc1 =3D 0, .opc2 =3D 0,
>        .secure =3D ARM_CP_SECSTATE_S,
>        .type =3D ARM_CP_NO_RAW | ARM_CP_IO, .access =3D PL1_RW | PL0_R,
> @@ -2060,7 +2060,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[=
] =3D {
>        .accessfn =3D gt_ptimer_access,
>        .writefn =3D gt_phys_cval_write, .raw_writefn =3D raw_write,
>      },
> -    { .name =3D "CNTP_CVAL(S)", .cp =3D 15, .crm =3D 14, .opc1 =3D 2,
> +    { .name =3D "CNTP_CVAL_S", .cp =3D 15, .crm =3D 14, .opc1 =3D 2,
>        .secure =3D ARM_CP_SECSTATE_S,
>        .access =3D PL1_RW | PL0_R,
>        .type =3D ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
> @@ -5563,7 +5563,8 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(E=
rror **errp)
>
>  static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>                                     void *opaque, int state, int secstate,
> -                                   int crm, int opc1, int opc2)
> +                                   int crm, int opc1, int opc2,
> +                                   const char *name)
>  {
>      /* Private utility function for define_one_arm_cp_reg_with_opaque():
>       * add a single reginfo struct to the hash table.
> @@ -5573,6 +5574,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, con=
st ARMCPRegInfo *r,
>      int is64 =3D (r->type & ARM_CP_64BIT) ? 1 : 0;
>      int ns =3D (secstate & ARM_CP_SECSTATE_NS) ? 1 : 0;
>
> +    r2->name =3D g_strdup(name);
>      /* Reset the secure state to the specific incoming state.  This is
>       * necessary as the register may have been defined with both states.
>       */
> @@ -5804,19 +5806,24 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cp=
u,
>                          /* Under AArch32 CP registers can be common
>                           * (same for secure and non-secure world) or ban=
ked.
>                           */
> +                        char *name;
> +
>                          switch (r->secure) {
>                          case ARM_CP_SECSTATE_S:
>                          case ARM_CP_SECSTATE_NS:
>                              add_cpreg_to_hashtable(cpu, r, opaque, state,
> -                                                   r->secure, crm, opc1,=
 opc2);
> +                                                   r->secure, crm, opc1,=
 opc2,
> +                                                   r->name);
>                              break;
>                          default:
> +                            name =3D g_strdup_printf("%s_S", r->name);
>                              add_cpreg_to_hashtable(cpu, r, opaque, state,
>                                                     ARM_CP_SECSTATE_S,
> -                                                   crm, opc1, opc2);
> +                                                   crm, opc1, opc2, name=
);
> +                            g_free(name);
>                              add_cpreg_to_hashtable(cpu, r, opaque, state,
>                                                     ARM_CP_SECSTATE_NS,
> -                                                   crm, opc1, opc2);
> +                                                   crm, opc1, opc2, r->n=
ame);
>                              break;
>                          }
>                      } else {
> @@ -5824,7 +5831,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>                           * of AArch32 */
>                          add_cpreg_to_hashtable(cpu, r, opaque, state,
>                                                 ARM_CP_SECSTATE_NS,
> -                                               crm, opc1, opc2);
> +                                               crm, opc1, opc2, r->name);
>                      }
>                  }
>              }


--
Alex Benn=C3=A9e
