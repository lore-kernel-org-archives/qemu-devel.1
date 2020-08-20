Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23803C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24D22078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qSFWnha7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24D22078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Zcb-0007Lc-6q
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8Zbh-0005nq-F2; Wed, 19 Aug 2020 21:43:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43411 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8Zbb-0003xX-4T; Wed, 19 Aug 2020 21:43:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX6q52CWfz9sTQ; Thu, 20 Aug 2020 11:42:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597887777;
 bh=w6yaHSPJ+suLZGlr7hdiGhy9NdwW5uyb1EBYA/AZZ1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qSFWnha73P/CUXbJETXzFVzYsiWC/rYENSCNEg1GcWK17Dy2misYjLzlina61E8EO
 4Sd3Ki7zKRiEhwrQB5TZr653e7l4z8mdY1fhrPBaSzkgx/DbT5IPQOoG9LgPvIFoyd
 veAtXMhVnuOa3k1imRwXHJb9AP54ra3dENGSxbNE=
Date: Thu, 20 Aug 2020 11:17:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
Message-ID: <20200820011726.GF271315@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <20200814205424.543857-3-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:59:03
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barboza wrote:
> The pSeries machine does not support asymmetrical NUMA
> configurations.

This seems a bit oddly specific to have as a global machine class
property.

Would it make more sense for machines with specific NUMA constraints
to just verify those during their initialization?
>=20
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/core/numa.c      | 7 +++++++
>  hw/ppc/spapr.c      | 1 +
>  include/hw/boards.h | 1 +
>  3 files changed, 9 insertions(+)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index d1a94a14f8..1e81233c1d 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -547,6 +547,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, E=
rror **errp)
>   */
>  static void validate_numa_distance(MachineState *ms)
>  {
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      int src, dst;
>      bool is_asymmetrical =3D false;
>      int nb_numa_nodes =3D ms->numa_state->num_nodes;
> @@ -575,6 +576,12 @@ static void validate_numa_distance(MachineState *ms)
>      }
> =20
>      if (is_asymmetrical) {
> +        if (mc->forbid_asymmetrical_numa) {
> +            error_report("This machine type does not support "
> +                         "asymmetrical numa distances.");
> +            exit(EXIT_FAILURE);
> +        }
> +
>          for (src =3D 0; src < nb_numa_nodes; src++) {
>              for (dst =3D 0; dst < nb_numa_nodes; dst++) {
>                  if (src !=3D dst && numa_info[src].distance[dst] =3D=3D =
0) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index dd2fa4826b..3b16edaf4c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4512,6 +4512,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       */
>      mc->numa_mem_align_shift =3D 28;
>      mc->auto_enable_numa =3D true;
> +    mc->forbid_asymmetrical_numa =3D true;
> =20
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index bc5b82ad20..dc6cdd1c53 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -215,6 +215,7 @@ struct MachineClass {
>      bool nvdimm_supported;
>      bool numa_mem_supported;
>      bool auto_enable_numa;
> +    bool forbid_asymmetrical_numa;
>      const char *default_ram_id;
> =20
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl89zyQACgkQbDjKyiDZ
s5KibQ//XE02Z1zkAkRpxc569FBp3faWCXNgyLW5wKOsqjN/Seig2kifceGuAV7C
aB1q3DXXvgqUInut+Fb6ZtmcPe62jv2YDuOEBUsdB84X8lo13gciS91E5g4Otqfn
0sJqmDK9Jn0AbEHTbXYvvaR9CAlQkXVtk5Lmg2QCMuhntP5UQQRSStwJqMlBne0z
Gr+UOBk2E2tY1ETNEjefIC7UScPzb28rT4APmGSEsmE+JS76GAcnXUMdwwtSPYK+
RRinF/DtPm76j0s6vtHInhbiqIRFuIH6zc+ixj12P4PsOT+g91YFv5zbWPTioUoh
GnUwixfbbH1ijLeBWFLI8qWOtBaON1ETGrGAFeFSY414e5I6xvcJmIeDGbTm/T9x
NcwQI51HfFPA8GJnCuvuuRdKRYRIewpeofN/zrKPzfQT4+FQStkdkFhvM67pSipl
lofmaVSpW6gHqPsh4JRd17sIVZ7RPBXcNbSsN2rGQpIRfcIpQFeoe1vQRGnrrLcz
sSIwhtFQSk21RTGU1At7feWYd13nlk5DFMjDAPTWSbH0pAh82eWotd5HDFf4xUqv
hgJgBeKzdygSz3s4wAonUrebajx1d7MOwU2zOEPZ/k/D8PyyQ2JbnFPYp8YzQu7e
0/7yQWc25rDB6bTK5Y4qsvQH0kNM6lLYJaa/p+9dd72af75C0rw=
=AxAx
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--

