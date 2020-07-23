Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634C6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8F620657
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gXyYB4f4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8F620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyRdn-00017C-EH
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbF-0006IC-3k; Wed, 22 Jul 2020 23:08:49 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59779 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyRbB-0006T9-1b; Wed, 22 Jul 2020 23:08:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBy2v4wbGz9sSJ; Thu, 23 Jul 2020 13:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595473719;
 bh=SuFKnJtCX3Fir48Plm6JLHASs5M1Y7sRHGO+Nub+nCk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gXyYB4f4zZemW/JvVg618Yfl0Vh9m40E4hpkjwLLN7Ze+vJWjHrID6hY8srmQBcfI
 pq03WecoTTmpqSgCGRJ7iX55AjwXmaLOa662feRF6iCeUPuuDxlgCsvXS7OXdplKtF
 j57YtXZ6fsKr4N6Li9yL9FWTpzIsdnm5lCRV/bzU=
Date: Thu, 23 Jul 2020 13:06:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 3/8] ppc/spapr: Use start-powered-off CPUState property
Message-ID: <20200723030651.GN5513@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-4-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WeDu0lr7bteb/II5"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-4-bauerman@linux.ibm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WeDu0lr7bteb/II5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:52PM -0300, Thiago Jung Bauermann wrote:
65;6003;1c> PowerPC sPAPR CPUs start in the halted state, and spapr_reset_v=
cpu()
> attempts to implement this by setting CPUState::halted to 1. But that's t=
oo
> late for the case of hotplugged CPUs in a machine configure with 2 or more
> threads per core.
>=20
> By then, other parts of QEMU have already caused the vCPU to run in an
> unitialized state a couple of times. For example, ppc_cpu_reset() calls
> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
> kicks the new vCPU while it has CPUState::halted =3D 0, causing QEMU to i=
ssue
> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
> start-cpu RTAS call to initialize its register state.
>=20
> This problem doesn't seem to cause visible issues for regular guests, but
> on a secure guest running under the Ultravisor it does. The Ultravisor
> relies on being able to snoop on the start-cpu RTAS call to map vCPUs to
> guests, and this issue causes it to see a stray vCPU that doesn't belong =
to
> any guest.
>=20
> Fix by setting the start-powered-off CPUState property in
> spapr_create_vcpu(), which makes cpu_common_reset() initialize
> CPUState::halted to 1 at an earlier moment.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_cpu_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> NB: Tested on ppc64le pseries KVM guest with two threads per core.=20
> Hot-plugging additional cores doesn't cause the bug described above
> anymore.
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c4f47dcc04..2125fdac34 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -36,11 +36,6 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
> =20
>      cpu_reset(cs);
> =20
> -    /* All CPUs start halted.  CPU0 is unhalted from the machine level
> -     * reset code and the rest are explicitly started up by the guest
> -     * using an RTAS call */
> -    cs->halted =3D 1;
> -
>      env->spr[SPR_HIOR] =3D 0;
> =20
>      lpcr =3D env->spr[SPR_LPCR];
> @@ -274,6 +269,11 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *s=
c, int i, Error **errp)
> =20
>      cs =3D CPU(obj);
>      cpu =3D POWERPC_CPU(obj);
> +    /*
> +     * All CPUs start halted. CPU0 is unhalted from the machine level re=
set code
> +     * and the rest are explicitly started up by the guest using an RTAS=
 call.
> +     */
> +    cs->start_powered_off =3D true;
>      cs->cpu_index =3D cc->core_id + i;
>      spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
>      if (local_err) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WeDu0lr7bteb/II5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y/ssACgkQbDjKyiDZ
s5KYVxAAv7P27aed2Mohc1UK3Bum8vJaeFcPpfr/EPEfJb78dgyvscEPglAvIBal
Ia2ElTiYxzROnRiD209HoBR432VeEELIvXtaO99yp/u0sF2QRBrNtMVcZ3DyUWr2
MbTcD4BSR4Qq1GiCKBGvXtC6fGQv6R1vy3Z31eMqDdPXwnE67DjoiRuuXjQs+DzY
J2v5BTMhBWcfMJyirzJq02OReKCSZwhRu15l77j/Wyc7LC9nYM/fZxYHxwKGVEL/
D0w0YpBy7wwtioxKUhuqkeO6ONGc/tWrNTzzDTenfZHUyJ/EC2azYFcSj9y24SiI
2NjUOsTTtvekOlD+4lW2mS2ZonkgIzYiTTa0PLPIZdJZ8P50ZEO3jbuFdmyPc7ur
Mz4STuZQT/mPxFuuKU7RPQY04E++cSFIWjYhna3IqTK9K3trICGaC9OhrSQ3EUJp
hBepwmoeA+Ik+xte4HR7/r+xRnVWME0hEuR/v4qhMiQ3FuK4j1mNBal9x47LTsUg
r39CO8a0b6V/t3NKRT5CShsBDjQPikk2DX4wyMheRL697Tw4N3pkzI40Cpx0QZgP
ludgUrzuZ+waEfujZCrPYHac7oRoSrUimV3K54hPoQE4xAAm3rDl97oBpKGHObqk
2AhiTzBtdkoB1ALG9XLNixXU/gExcrfhxYw84SdfbUYd8zdCxBc=
=H/Oe
-----END PGP SIGNATURE-----

--WeDu0lr7bteb/II5--

