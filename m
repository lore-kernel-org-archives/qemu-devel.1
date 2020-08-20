Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D227C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02421207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n2yrrZou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02421207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Zdq-0001DQ-9a
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8Zbh-0005nv-Ht; Wed, 19 Aug 2020 21:43:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51613 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8Zbb-0003xV-Lw; Wed, 19 Aug 2020 21:43:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX6q543bwz9sTR; Thu, 20 Aug 2020 11:42:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597887777;
 bh=iuIpG/F8UrzE4lEermCKFopXr2gJt10aW1SE2pBmWe4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n2yrrZouE29lyrigx+mk7CFoZ/CrGdn3UszPT6VeXrObvFIzLwgBwqJAkbPdlBZ3S
 EolxzTlzOf6oaakKDlEQqSgvrQPFRA45vVvqZME78OZqfkxWN+Ww36KNt1+5Rmf2uY
 SiNDDAOu7Q5qa24DVjwII9MiISeuQP79qZ4yVp9c=
Date: Thu, 20 Aug 2020 11:42:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v6 0/8] Generalize start-powered-off property from ARM
Message-ID: <20200820014238.GI271315@yekko.fritz.box>
References: <20200819164306.625357-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <20200819164306.625357-1-bauerman@linux.ibm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 01:42:58PM -0300, Thiago Jung Bauermann wrote:
> This version has one small fix in patch 7, and adds Philippe's Reviewed-b=
ys.
>=20
> Applies cleanly on dgibson/ppc-for-5.2.
>=20
> Original cover letter below, followed by changelog:
>=20
>=20
> The ARM code has a start-powered-off property in ARMCPU, which is a
> subclass of CPUState. This property causes arm_cpu_reset() to set
> CPUState::halted to 1, signalling that the CPU should start in a halted
> state. Other architectures also have code which aim to achieve the same
> effect, but without using a property.
>=20
> The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
> before cs->halted is set to 1, causing the vcpu to run while it's still in
> an unitialized state (more details in patch 3).
>=20
> Peter Maydell mentioned the ARM start-powered-off property and
> Eduardo=A0Habkost suggested making it generic, so this patch series does
> that, for all cases which I was able to find via grep in the code.
>=20
> The only problem is that I was only able to test these changes on a ppc64=
le
> pseries KVM guest, so except for patches 2 and 3, all others are only
> build-tested. Also, my grasp of QOM lifecycle is basically non-existant so
> please be aware of that when reviewing this series.
>=20
> The last patch may be wrong, as pointed out by Eduardo, so I marked it as
> RFC. It may make sense to drop it.

Applied to ppc-for-5.2.

>=20
> Changes since v5:
>=20
> Patch "ppc/e500: Use start-powered-off CPUState property"
> Patch "mips/cps: Use start-powered-off CPUState property"
> Patch "sparc/sun4m: Remove main_cpu_reset()"
> Patch "target/s390x: Use start-powered-off CPUState property"
> - Added Philippe's Reviewed-by.
>=20
> Patch "sparc/sun4m: Use start-powered-off CPUState property"
> - Move call to qdev_realize_and_unref() right after object_property_set_b=
ool(),
>   as suggested by Philippe.
>=20
> Changes since v4:
>=20
> Patch "ppc/e500: Use start-powered-off CPUState property"
> Patch "sparc/sun4m: Use start-powered-off CPUState property"
> - Use qdev_realize_and_unref() instead of qdev_realize(), as suggested
>   by=A0Igor.
> - Pass &error_fatal to qdev_realize_and_unref() instead of manually
>   reporting the error and exiting QEMU, as suggested by Philippe.
> - Changed object_property_set_bool() to use &error_fatal instead of
>   &error_abort.
>=20
> Patch "mips/cps: Use start-powered-off CPUState property"
> - Use qdev_realize_and_unref() instead of qdev_realize(), as suggested
>   by=A0Igor.
> - Use existing errp argument to propagate error back to the caller, as
>   suggested by Philippe.
> - Changed object_property_set_bool() to use existing errp argument to
>   propagate error back to the caller instead of using &error_abort.
>=20
> Changes since v3:
>=20
> General:
> - Added David's, Greg's and Cornelia's Reviewed-by and Acked-by to some
>   of the patches.
> - Rebased on top of dgibson/ppc-for-5.2.
>=20
> Patch "ppc/e500: Use start-powered-off CPUState property"
> Patch "mips/cps: Use start-powered-off CPUState property"
> Patch "sparc/sun4m: Use start-powered-off CPUState property"
> - Initialize CPU object with object_new() and qdev_realize() instead
>   of cpu_create().
> - Removed Reviewed-by's and Acked-by's from these patches because of
>   these changes.
>=20
> Changes since v2:
>=20
> General:
> - Added Philippe's Reviewed-by to some of the patches.
>=20
> Patch "ppc/spapr: Use start-powered-off CPUState property"
> - Set the CPUState::start_powered_off variable directly rather than using
>   object_property_set_bool(). Suggested by Philippe.
>=20
> Patch "sparc/sun4m: Remove main_cpu_reset()"
> - New patch. Suggested by Philippe.
>=20
> Patch "sparc/sun4m: Use start-powered-off CPUState property"
> - Remove secondary_cpu_reset(). Suggested by Philippe.
> - Remove setting of `cs->halted =3D 1` from cpu_devinit(). Suggested by P=
hilippe.
>=20
> Patch "Don't set CPUState::halted in cpu_devinit()"
> - Squashed into previous patch. Suggested by Philippe.
>=20
> Patch "sparc/sun4m: Use one cpu_reset() function for main and secondary C=
PUs"
> - Dropped.
>=20
> Patch "target/s390x: Use start-powered-off CPUState property"
> - Set the CPUState::start_powered_off variable directly rather than using
>   object_property_set_bool(). Suggested by Philippe.
> - Mention in the commit message Eduardo's observation that before this
>   patch, the code didn't set cs->halted on reset.
>=20
> Thiago Jung Bauermann (8):
>   target/arm: Move start-powered-off property to generic CPUState
>   target/arm: Move setting of CPU halted state to generic code
>   ppc/spapr: Use start-powered-off CPUState property
>   ppc/e500: Use start-powered-off CPUState property
>   mips/cps: Use start-powered-off CPUState property
>   sparc/sun4m: Remove main_cpu_reset()
>   sparc/sun4m: Use start-powered-off CPUState property
>   target/s390x: Use start-powered-off CPUState property
>=20
>  exec.c                  |  1 +
>  hw/core/cpu.c           |  2 +-
>  hw/mips/cps.c           | 14 ++++++++++----
>  hw/ppc/e500.c           | 14 ++++++++++----
>  hw/ppc/spapr_cpu_core.c | 10 +++++-----
>  hw/sparc/sun4m.c        | 31 ++++---------------------------
>  include/hw/core/cpu.h   |  4 ++++
>  target/arm/cpu.c        |  4 +---
>  target/arm/cpu.h        |  3 ---
>  target/arm/kvm32.c      |  2 +-
>  target/arm/kvm64.c      |  2 +-
>  target/s390x/cpu.c      |  2 +-
>  12 files changed, 39 insertions(+), 50 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl891Q4ACgkQbDjKyiDZ
s5Ln+Q//ej17/yk3foCu19l8rVPvvPIR6cf0KzAFa0NjildGpMbU3VJ8MMBSoMrP
HVFfD66xgPXEFhsmv+0DmQxOds2eAFLREnvRslNCee/RK1tHjiJ3S9lxrmFJN24V
NHMJwx/1iitfNGX5MYaXTC68goiP6YHAwiHsgOzhIHGDHqc9Ue+mYQk9whaHnZY4
vzOMIgnlJ2+B1+MkNBm0IlVu0FCJGVdpm7zsTOM3Lr/9PZV43BmUb2ItytrBnruM
CRrLahXRHUAyibpiTG6t+dhiB1iZlq/tNlozN26JZVYXNe5OLpy+gnu/0Hp/+38Y
rVa0k9aMT3MH6wnJavlqB+jaqvNvKtdqKzq8obMzZ1HZbZnWo4gV/7J/I9uSA4wx
1S4J4Oe2AwcISH1KrMeSm7UdL6zywT9ZrheCyzGifFBOqR96IWpeUjdPk+QsJ/W7
MyayVlUWg0dZpMmpagSW0D+9yc6r0e/OGQ8CeKByl1Wx8am0uHdnax7mL63RWXvl
q3oMZ/M04gP0YI+SKAa6hL699K8Ms/nqGSzg6QqQLMqP5LlufnRDetlFTsa27j6I
0Cd4+CEMeFnEcGRPelgKq9iynjexfe0vR1AdGW1/n51EsJv54G70GQ70RPG/RSUI
Z/7zt76NMvIpDL3RNASXrjpwlj8oPwBzM3ftj1PR40zcxD4SpsY=
=fFNL
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--

