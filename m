Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FB4C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902F72078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KXKaGXiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902F72078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8bj3-0005Vy-Rp
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 23:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biK-00040g-C9; Wed, 19 Aug 2020 23:58:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58711 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biF-0007LF-Mc; Wed, 19 Aug 2020 23:58:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX9pt0nLZz9sR4; Thu, 20 Aug 2020 13:57:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597895878;
 bh=ni9aoStGjZN/B3YxXmoYh2NSqsQdo9+Zb5Bnfj9xeUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KXKaGXiM2jWMoi0cbpipwLKAkQap0MMmThElNan1Fp9QP5zh5n1XmWHaxUweJNxI8
 xq3kocenhWr7qFGN0Amf8DQ2C1W2w8732C8jo07L5Jh7zdOX5SHyJ6t5ZyxRMzxq04
 c11woCY568VUHEqmPjh4/Cp3x+cOmNOx/3XEcNXQ=
Date: Thu, 20 Aug 2020 12:15:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 04/10] spapr: add spapr_machine_using_legacy_numa() helper
Message-ID: <20200820021524.GK271315@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-5-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline
In-Reply-To: <20200814205424.543857-5-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 23:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 05:54:18PM -0300, Daniel Henrique Barboza wrote:
> The changes to come to NUMA support are all guest visible. In
> theory we could just create a new 5_1 class option flag to
> avoid the changes to cascade to 5.1 and under. The reality is that
> these changes are only relevant if the machine has more than one
> NUMA node. There is no need to change guest behavior that has
> been around for years needlesly.
>=20
> This new helper will be used by the next patches to determine
> whether we should retain the (soon to be) legacy NUMA behavior
> in the pSeries machine. The new behavior will only be exposed
> if::
>=20
> - machine is pseries-5.2 and newer;
> - more than one NUMA node is declared in NUMA state.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Seems reasonable.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c         | 12 ++++++++++++
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 22e78cfc84..073a59c47d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -308,6 +308,15 @@ static hwaddr spapr_node0_size(MachineState *machine)
>      return machine->ram_size;
>  }
> =20
> +bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> +
> +    return smc->pre_5_2_numa_associativity ||
> +           machine->numa_state->num_nodes <=3D 1;
> +}
> +
>  static void add_str(GString *s, const gchar *s1)
>  {
>      g_string_append_len(s, s1, strlen(s1) + 1);
> @@ -4602,8 +4611,11 @@ DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
>   */
>  static void spapr_machine_5_1_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_5_2_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
> +    smc->pre_5_2_numa_associativity =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 739a6a4942..d9f1afa8b2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -130,6 +130,7 @@ struct SpaprMachineClass {
>      bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
>      hwaddr rma_limit;          /* clamp the RMA to this size */
>      bool pre_5_1_assoc_refpoints;
> +    bool pre_5_2_numa_associativity;
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
> @@ -847,6 +848,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> +bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr);
> =20
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl893LwACgkQbDjKyiDZ
s5IiiQ//XkXhqMuryw7fIfN4KRzSJNXwduf3A1dAP2IF3x9Id5cAfC1Ab6k4O987
BSMA3y65BJGXqeEYp0O66ZrwLKGcKEROHq+T4Bm/L2GoymmYExO5T0nOpMev9IMH
7/USaqolQ0t6ykpkwLx+eORZ8kRk0RvJ+KMDWGxUZ9VoFBv5dfzbktakMizelklg
ThvW3XPJSoD7gUwYz9UC9puqIICQ8o7D//eyDwilGNvB9RZDHdILisd0/fRnUuKg
2fyeHYbnoh9WLKiz5P03zYEw4lCN+dwOSgbiiE+LrzSC7xb4k5IHYpsID3uIiqqm
CK1w6laBHYaYbVpyNq5BqVD4JQ+6m6l/7juvFGRwwW7cz+Bm21qSrd0rrB2BOlTg
8yrcq1wASXI4HWSyXVV96JFn/ujRZE2phRsMloQ/aN635PTkzLv6xre3AFca1lV9
bORp7CSDmASDmHRMSnaqv7ZCF03YpL57sLVgTHtzOH9k43a+vDdso+3UF9VZS19o
P3ovJe0b5wsaJhYopyFsqyzKTzyqgo0jA4UktDlbbMzNd0E/4j8YrZ2dqYiTg3zl
2EQuHyRPQrIrRb5Rc3Bn0rQ3bwjXwDeWdx1gKO7IcHKQ07VrpyHX1R9gfbJJxXc5
GEVHeVjKVA4uo9k2fJAaidraLINEtqQFb2dncs0MfTwrgZHqfY4=
=KGHY
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--

