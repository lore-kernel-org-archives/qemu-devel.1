Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B63C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7DE206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fD4d35XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7DE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk1le-0007SS-Di
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 04:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jk1kj-0006cq-6V; Sat, 13 Jun 2020 04:43:01 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54467 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jk1kf-0004oY-Gv; Sat, 13 Jun 2020 04:43:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49kWLq4sNYz9sQx; Sat, 13 Jun 2020 18:42:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592037763;
 bh=3SkkT5xIWqvrx0DJZE/d6sSWye0aU/8fRZv8vyOcIjc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fD4d35XCOpgFyTHh5Qtkj5GZ4QKKNZbHhmXz7AxH4MoFPQcmb308uLMUeGJpg13Gj
 GXTBBji6wGfBE9Jwj3JP6a3HAVMUL0iWshoFozPcAf4nQPENfF2hrdhVvjRmm9tfu0
 9s/9+MNO9d0jyRJcLsPe6h7hKkDb6k1q2xu91W14=
Date: Sat, 13 Jun 2020 17:18:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 4/4] spapr: Forbid nested KVM-HV in pre-power9 compat
 mode
Message-ID: <20200613071804.GE5861@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188283391.70166.16995399489383620172.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <159188283391.70166.16995399489383620172.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 03:40:33PM +0200, Greg Kurz wrote:
> Nested KVM-HV only works on POWER9.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Hrm.  I have mixed feelings about this.  It does bring forward an
error that we'd otherwise only discover when we try to load the kvm
module in the guest.

On the other hand, it's kind of a layering violation - really it's
KVM's business to report what it can and can't do, rather than having
qemu anticipate it.

Allowing POWER8 compat for an L2 is something we hope to have in the
fairly near future.  Allowing POWER8 compat for L1, which is what this
covers, is, I'll admit, likely to never happen.


> ---
>  HW/ppc/spapr_caps.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 27cf2b38af27..dfe3b419daaa 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -391,6 +391,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState=
 *spapr,
>                                      uint8_t val, Error **errp)
>  {
>      ERRP_AUTO_PROPAGATE();
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +
>      if (!val) {
>          /* capability disabled by default */
>          return;
> @@ -400,6 +402,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineStat=
e *spapr,
>          error_setg(errp, "No Nested KVM-HV support in TCG");
>          error_append_hint(errp, "Try appending -machine cap-nested-hv=3D=
off\n");
>      } else if (kvm_enabled()) {
> +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                              spapr->max_compat_pvr)) {
> +            error_setg(errp, "Nested KVM-HV only supported on POWER9");
> +            error_append_hint(errp,
> +                              "Try appending -machine max-cpu-compat=3Dp=
ower9\n");
> +            return;
> +        }
> +
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
>                         "KVM implementation does not support Nested KVM-H=
V");
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7kfawACgkQbDjKyiDZ
s5Liwg//czMZl9qI2uLH009zUxPGNLKe9oAWFVlG6yBoTLiEoROmHwfasz7HF5RE
B1+2hORMhC787J44qTQZM9TCwd32g112XVUWulc6aQCUaA2cph55bPH8VPWIoaM6
5oE0GU8alsuWXgzdvVvSY7RSsGM7OjyRyW6V7vRg45OM5Z+oQc+VHaE+Aj86asoB
Ce0tZHT8HLCkyGfDLubHMZ1r4cELx5BtZBQ5fDxkRYPj8TYP9xGPMgdxPBrQcrfg
BzTsDcRvMzr3sIPdO40Cs5IrhKXMDWazDlK7zjU5VMgyTml4+fc8Xk0M92G0DIMt
PyV3Rbm9ah0TtmtjCUt2KJ0/w5Jpz5lug3KTtMYicrrXelLugfQ6Q+7z1LTWvb9o
Ui2kNtfSzkGorHMVQZMTnpsBBCS5NLKhzbr+2ACR/lpydmiVvGFlszYt3yGEBqBd
hy5g7CRHXu4dPrAA52WP6CEoDKAWDLAEezyePM4Y0Mwz1dji65oDXg8li/T8m85B
1S+1/7aNau+QmvrUxOe88UyaAelK75zA4NDeY2VLUnTlEvpEkzDNNXg19hRFNflW
CMj4eZ88fy891l1neBaJGifZ6/+h+3fFTkaQd6eMrYaFuEKHLRHmyRPDsI9wW5Lr
5oM6MDaquPS/KOy5s9ZX3/pUCXfGSHmGqtfuShoEM76OXE49aPc=
=IrUQ
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--

