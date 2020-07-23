Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8C7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7CA2086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D4BEZOPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7CA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyPd7-0002mF-C2
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 21:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPaw-0008QX-6P; Wed, 22 Jul 2020 21:00:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53295 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jyPau-0007HK-5O; Wed, 22 Jul 2020 21:00:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BBvBk5hgVz9sRk; Thu, 23 Jul 2020 11:00:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595466014;
 bh=tr7gQrN42u5aEHaqrxncV5QaQ2nEQSjtEEwFVJkNzAo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D4BEZOPLe5WPvlQqRD22k1IHcutUcFSpDgl/8p0znAMxDe4Ml169YJVlfRkZqOqW3
 u+llE1hg1RUKpX9gojNfwSYVd9kgpxcGTI72rcEXHKsCkS3Q0qNU79a5EBYYH2qgxw
 0uKvEqls3EmGVm143t2eyCMvfQx2Dh5oSOX2SG+k=
Date: Thu, 23 Jul 2020 10:55:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2 2/9] target/arm: Move setting of CPU halted state to
 generic code
Message-ID: <20200723005549.GH5513@umbus.fritz.box>
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
 <20200722035016.469075-3-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <20200722035016.469075-3-bauerman@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 20:52:06
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 12:50:09AM -0300, Thiago Jung Bauermann wrote:
> This change is in a separate patch because it's not so obvious that it
> won't cause a regression.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/core/cpu.c    | 2 +-
>  target/arm/cpu.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> NB: I was only able to test that this patch builds. I wasn't able to
> run it on an ARM machine. I did on a ppc64le pseries KVM guest.
>=20
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 594441a150..71bb7859f1 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -258,7 +258,7 @@ static void cpu_common_reset(DeviceState *dev)
>      }
> =20
>      cpu->interrupt_request =3D 0;
> -    cpu->halted =3D 0;
> +    cpu->halted =3D cpu->start_powered_off;
>      cpu->mem_io_pc =3D 0;
>      cpu->icount_extra =3D 0;
>      atomic_set(&cpu->icount_decr_ptr->u32, 0);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ec65c7653f..b6c65e4df6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -175,7 +175,6 @@ static void arm_cpu_reset(DeviceState *dev)
>      env->vfp.xregs[ARM_VFP_MVFR2] =3D cpu->isar.mvfr2;
> =20
>      cpu->power_state =3D s->start_powered_off ? PSCI_OFF : PSCI_ON;
> -    s->halted =3D s->start_powered_off;
> =20
>      if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
>          env->iwmmxt.cregs[ARM_IWMMXT_wCID] =3D 0x69051000 | 'Q';
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Y4BUACgkQbDjKyiDZ
s5K3iRAApLHWr2t2WVJoDwgdjlDiUu5LgaiieQH4R6cxApqBnNYE/0oMTnsMSK9g
LmBG1CcRcjs751PUdZTPECu8HeIk1Jjlsw6m3TZLR8k2JFYlbNjOPFJs4GqZDU74
KQVuUp0/wIjCppuYNcpjL/i2vnRBiErKvOXy00Z3M9I3Vuux5kWjV9gpMDRuQlCG
97KgCVmO7YR7eYDX7T4jR1DSNCz1gMeuD5AbiPPR3vk76z9wwoQ48y5+vnLA5TXk
+iOhHsgtDtlJVVoVCCnmJuoowRzBZDuCiM8BZeGmj0smkn8+h3CcujoX5t7gE0G5
PdaLewLS3FsZMR89LgsTVGj41EeKpN/ITUxwkdPN9pBxDWhb/pXlzQIAfJadotzZ
AvaenDHeue4e66oLHe54XGdyTqQBq6tzAq4/Zi3qnALIjRZxC7l2Y2STuB+wkWEX
JU6sAfme+YLZpIW3FvhvB6jbK+jwDDrRmZ3Z3j5JNy3eJeaz5XCHdZerUVAp/7F5
SGXRmh+bjX4yb2DDI0/Q57qwaOJWUgp+53mL6758qQ9mktGL0Eekq6i1oeh5xnGZ
LMLBY2nuftk4QCnhL5IKhxZGmcGHHqWvU/w6MjbYPjd+AG0pwqBfw3JD6R8vDVRv
SkQQCxZRV1+APEPRjoHBH+BfdP6xagns2j/lostFo/iOVK4lD7I=
=n6yt
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

