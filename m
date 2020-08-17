Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A54C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 04:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E42A206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 04:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EBYRjiq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E42A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7X5A-0004Gg-Od
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 00:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7X4U-0003d1-2t; Mon, 17 Aug 2020 00:48:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7X4Q-0003Md-96; Mon, 17 Aug 2020 00:48:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVM4R5hHpz9sPC; Mon, 17 Aug 2020 14:48:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597639703;
 bh=VXX1nkfPf1296LwI59CJofxvm7VBziZ/FvWkzXpbIoI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EBYRjiq8fwLudq36WfqbF/K9VG3UqWf/qsByafZxEXN0nCIY4yUBfe7KFno9Cudqy
 6sw58jeN0jD8Mq9ULbXKvP37SEZGgl5MDylSmuVI/oCCh0wdR2zah3MkJMcT6Pw4W6
 aTfhzQHqOMVlJpjdLxHVe40KifLqVkiY/UqO6jIU=
Date: Mon, 17 Aug 2020 14:47:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
Message-ID: <20200817044730.GK12805@yekko.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="08ATZu8fEq0x2T3M"
Content-Disposition: inline
In-Reply-To: <20200723025657.644724-1-bauerman@linux.ibm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--08ATZu8fEq0x2T3M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:56:49PM -0300, Thiago Jung Bauermann wrote:
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
>=20
> Applies cleanly on yesterday's master.

This series appears to break the Travis build for a MIPS target:

Unexpected error in qdev_prop_set_after_realize() at /home/travis/build/dgi=
bson/qemu/hw/core/qdev-properties.c:30:
qemu-system-mips64el: Attempt to set property 'start-powered-off' on anonym=
ous device (type 'I6400-mips64-cpu') after it was realized
Broken pipe
/home/travis/build/dgibson/qemu/tests/qtest/libqtest.c:175: kill_qemu() det=
ected QEMU death from signal 6 (Aborted) (core dumped)
Aborted (core dumped)
ERROR qom-test - too few tests run (expected 8, got 0)
/home/travis/build/dgibson/qemu/tests/Makefile.include:650: recipe for targ=
et 'check-qtest-mips64el' failed

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
>  hw/mips/cps.c           |  6 +++---
>  hw/ppc/e500.c           | 10 +++++++---
>  hw/ppc/spapr_cpu_core.c | 10 +++++-----
>  hw/sparc/sun4m.c        | 28 ++--------------------------
>  include/hw/core/cpu.h   |  4 ++++
>  target/arm/cpu.c        |  4 +---
>  target/arm/cpu.h        |  3 ---
>  target/arm/kvm32.c      |  2 +-
>  target/arm/kvm64.c      |  2 +-
>  target/s390x/cpu.c      |  2 +-
>  12 files changed, 27 insertions(+), 47 deletions(-)
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--08ATZu8fEq0x2T3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl86C+AACgkQbDjKyiDZ
s5IasA//UAzW7n1nwIF+zVjma/VBtVTA0QH1jDCDAOAnXO8qXxK1Gq6ElUB4DMZv
ZwsrjMYNfTChbmj1rioJ6MX5kkgKARceOaYoNFmlvXHOHcu1nzVqLWQAx8ffdOWK
p6pA/XYhs9SEHh7rhF1I2jhg3L9T9Y4HLjOgn64AjKVBzFHuHZAE+uBBjBryqzPY
OpztM0/b50Xai/4pfuueY98aGJPDtQ0EOvc6VPqfLUhbepypEKGNEv9mStACGDs5
X4b8Qz9vxbEmhbh+hgK/vps9/qNX8X7QuGWmI3OB69Yo4jVgn5F/LnB8a6brj4Mf
8+NA0T8USG1++p7BYfeqqJKGMwIzwXo81nxv6l8eFnnDgotxFL11JVDML+tXnrVu
KSZAN6uQqQsj1lwglBEN3/t2tHv35r3zLQV67iMbcXU1sO+J6XC/3FfnbldtORuE
hGVok9kAYb9/KkKnSwLdeE+Nx6XURBtkr2cQuBxk/opDcNn9wF2O9VhjMHpajcc5
d/MffC6w+riYG066P1BRsBHozJB9EQL0Vinq8d5hKCFm6vizQH0x1ExxG4lkVTLC
hhANZtS5sZMJD7ycCdeMgtqnLNX+Bv48nQCiYjphja0p3U0Wl8XxQbz9gnmIEp4I
28Jv+fmowW0/UNVJDJU2NlwRlGSmqr0ctSjKwT9cOPWaKDHIS28=
=my/u
-----END PGP SIGNATURE-----

--08ATZu8fEq0x2T3M--

