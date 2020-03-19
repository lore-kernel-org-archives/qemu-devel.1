Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5C2C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B22520724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 05:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EZpjQXQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B22520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEnkk-00066V-N3
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 01:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjm-00052w-Rp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEnjl-0004M7-5J
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 01:28:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34553 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEnjk-0004Bx-Mv; Thu, 19 Mar 2020 01:28:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jb6q6SB0z9sPR; Thu, 19 Mar 2020 16:28:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584595731;
 bh=Gr2D+3/VhF3+XL4S9Dlc3nwicPz1HJ+RscFhzW2+0fc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EZpjQXQ4VMSbGmEK2XNCceeh5VN91DHoYUOxlX1SBLg9ADigD9CoEb5hYHFMHd1YZ
 J7KrD/LvPkdTiFLmU4LylyGBnJwNdbX/352/K5k3LqjqAI/Ir+aBUp2JycTSJXr5ZZ
 Y/Ct4ayJNN8qavWo4t4k1k2tzKSmbKp/JJaMVqQc=
Date: Thu, 19 Mar 2020 16:19:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/spapr: Set the effective address provided flag in
 mc error log.
Message-ID: <20200319051915.GD628315@umbus.fritz.box>
References: <158451653844.22972.17999316676230071087.stgit@jupiter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
In-Reply-To: <158451653844.22972.17999316676230071087.stgit@jupiter>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Qemu-devel <qemu-devel@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, Qemu-ppc <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 01:04:20PM +0530, Mahesh Salgaonkar wrote:
> Per PAPR, it is expected to set effective address provided flag in
> sub_err_type member of mc extended error log (i.e
> rtas_event_log_v6_mc.sub_err_type). This somehow got missed in original
> fwnmi-mce patch series. The current code just updates the effective addre=
ss
> but does not set the flag to indicate that it is available. Hence guest
> fails to extract effective address from mce rtas log. This patch fixes
> that.
>=20
> Without this patch guest MCE logs fails print DAR value:
>=20
> [   11.933608] Disabling lock debugging due to kernel taint
> [   11.933773] MCE: CPU0: machine check (Severe) Host TLB Multihit [Recov=
ered]
> [   11.933979] MCE: CPU0: NIP: [c000000000090b34] radix__flush_tlb_range_=
psize+0x194/0xf00
> [   11.934223] MCE: CPU0: Initiator CPU
> [   11.934341] MCE: CPU0: Unknown
>=20
> After the change:
>=20
> [   22.454149] Disabling lock debugging due to kernel taint
> [   22.454316] MCE: CPU0: machine check (Severe) Host TLB Multihit DAR: d=
eadbeefdeadbeef [Recovered]
> [   22.454605] MCE: CPU0: NIP: [c0000000003e5804] kmem_cache_alloc+0x84/0=
x330
> [   22.454820] MCE: CPU0: Initiator CPU
> [   22.454944] MCE: CPU0: Unknown
>=20
>=20
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Applied to ppc-for-5.0, thanks.

> ---
> Change in v2:
> - Fixed coding style issues.
> ---
>  hw/ppc/spapr_events.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 8b32b7eea5..cb6bfedc53 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -243,6 +243,14 @@ struct rtas_event_log_v6_mc {
>  #define RTAS_LOG_V6_MC_TLB_PARITY                        1
>  #define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
>  #define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
> +/*
> + * Per PAPR,
> + * For UE error type, set bit 1 of sub_err_type to indicate effective ad=
dr is
> + * provided. For other error types (SLB/ERAT/TLB), set bit 0 to indicate
> + * same.
> + */
> +#define RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDED               0x40
> +#define RTAS_LOG_V6_MC_EA_ADDR_PROVIDED                  0x80
>      uint8_t reserved_1[6];
>      uint64_t effective_address;
>      uint64_t logical_address;
> @@ -726,6 +734,22 @@ void spapr_hotplug_req_remove_by_count_indexed(Spapr=
DrcType drc_type,
>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
>  }
> =20
> +static void spapr_mc_set_ea_provided_flag(struct mc_extended_log *ext_el=
og)
> +{
> +    switch (ext_elog->mc.error_type) {
> +    case RTAS_LOG_V6_MC_TYPE_UE:
> +        ext_elog->mc.sub_err_type |=3D RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDE=
D;
> +        break;
> +    case RTAS_LOG_V6_MC_TYPE_SLB:
> +    case RTAS_LOG_V6_MC_TYPE_ERAT:
> +    case RTAS_LOG_V6_MC_TYPE_TLB:
> +        ext_elog->mc.sub_err_type |=3D RTAS_LOG_V6_MC_EA_ADDR_PROVIDED;
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
>  static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
>                                          struct mc_extended_log *ext_elog)
>  {
> @@ -751,6 +775,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *c=
pu, bool recovered,
>              ext_elog->mc.sub_err_type =3D mc_derror_table[i].error_subty=
pe;
>              if (mc_derror_table[i].dar_valid) {
>                  ext_elog->mc.effective_address =3D cpu_to_be64(env->spr[=
SPR_DAR]);
> +                spapr_mc_set_ea_provided_flag(ext_elog);
>              }
> =20
>              summary |=3D mc_derror_table[i].initiator
> @@ -769,6 +794,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *c=
pu, bool recovered,
>              ext_elog->mc.sub_err_type =3D mc_ierror_table[i].error_subty=
pe;
>              if (mc_ierror_table[i].nip_valid) {
>                  ext_elog->mc.effective_address =3D cpu_to_be64(env->nip);
> +                spapr_mc_set_ea_provided_flag(ext_elog);
>              }
> =20
>              summary |=3D mc_ierror_table[i].initiator
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zANMACgkQbDjKyiDZ
s5LLNRAA0ZN4MveS6DjClIRDwLBp5Gv+4wQIRZJE6FT79Z8mnhrLgAurZEt0oJYC
pbIhienGf+bZ8+xwquoZHaOMgQKCcI2Wek/2/cxu/QT+8M/rdE+szf7qbc4buKUa
1uL0qTHt1+knZe73+b/aQOxlKrf/Ps5RzPYxAfqWwW05a+RKirLPDKQhGxT6ke/I
7FRhJgMun+eo6azd3qBCSNchAdV7UAh6rYTkfJUoUiiOOu7/e329sL93SdHpEWJt
qK1LuLIiuvD+ZUkKO66UPavryqd8//IO+H69T0t8e1FuyNld3AeXgl+iBUCN7OsQ
QesvY3uuxYq1MXXULIjqqFbOb50UFaXqqxCq00pSY6L5MJm+1qCZcBKmdvbwdYUD
hCe5NJLiCh0CqUm6ng8JvAXGBFi5UBHrKDiI3sKLLVtIp45akjB9dI8pl1wY7TxQ
y4YkCpCmdpJo0Z1yst0C2M7ZhYAseFUlr3Cupruvl1myHxXGFOO8KIl5pYvgeQ1v
ecSBsfRTzB3E8Fc/iA7j9Axb+d1RdMTdTQnkzLuw0ug5ab1oWGuTySQ6cFxACuvb
s5UzwXqQURqY17/CWZ+XutRqoqiEBNIh4VmMqVKM0/d7A8ca4iGouvNQ++kE50XM
UJrdrYCApLnlBr5BTo+Z2BYkQjudAtYUdJ/2qgimLZt83duVGzA=
=B+w6
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--

