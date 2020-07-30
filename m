Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76806C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412C72075D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 01:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BkgzC6JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412C72075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0wwo-0002Qm-G2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 21:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0wvY-000197-3n; Wed, 29 Jul 2020 21:00:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0wvW-0006Vh-6l; Wed, 29 Jul 2020 21:00:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BHBsC1RPyz9sRN; Thu, 30 Jul 2020 10:59:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596070799;
 bh=N2A3QinCPcXfIXYlyWTtIuIP8c79od3Ol5bcww38GDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BkgzC6JEWlUYrzHr6/X5wgJd8DMKfkx6HjuEJnHl6uG5c5Z28+qYfosdxlAZLHpQL
 2YPNGuGvUjyJ7cMNMO+V4PHpQb8sGdS/9kMIkKgYs1TW7+v9CaXMT05i3gMZw0hoWD
 IQAMzb9tKmq432y7bD5knKCdexuY84F9bCzd13HU=
Date: Thu, 30 Jul 2020 10:59:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
Message-ID: <20200730005947.GO84173@umbus.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <878sf3uojf.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Content-Disposition: inline
In-Reply-To: <878sf3uojf.fsf@morokweng.localdomain>
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


--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 09:56:36PM -0300, Thiago Jung Bauermann wrote:
>=20
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>=20
> > The ARM code has a start-powered-off property in ARMCPU, which is a
> > subclass of CPUState. This property causes arm_cpu_reset() to set
> > CPUState::halted to 1, signalling that the CPU should start in a halted
> > state. Other architectures also have code which aim to achieve the same
> > effect, but without using a property.
> >
> > The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
> > before cs->halted is set to 1, causing the vcpu to run while it's still=
 in
> > an unitialized state (more details in patch 3).
>=20
> Since this series fixes a bug is it eligible for 5.1, at least the
> patches that were already approved by the appropriate maintainers?

Ok by me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8iG4MACgkQbDjKyiDZ
s5Iveg//aisagDLxRmaDf7/etcVy4HN1kI/iGlxxbZLocT+xUb7bXLcYA/ZDUCJ0
T1v+xN5a5e4c2S1JBOqrBnvqP8MKhFtV4p8ZtRCR8mGIKahMrDwJkKjeD6mexioc
d+Lbe/lwilT8d0dmRHGt/W6u0UVocboMLoNfx567Rqd22EuUB8CsVjthZ6ZXvsr/
QFNYHPqfnnzANLr62kvf+DHW8TppOEcbUPrG4pmOYaQCBy7Tj3NRsYnnikohTpY4
4QpUoO02Lny1TapaGFYObTYP++65i/hbWjgS+qSwVZvsfF0nBjfvjUp5nt7tH9A6
aV0o/4WlIY5FDpsnrqxj2TIBbbH0uFpg1/OAorrcNnwLArJylJ2/vqpUv81p/qlk
LUL7ZVYAhEQkhmNh/cRWT9v71jcdx5RNwIpQusoXNbrurP8qGyeGh9NH3ZrPaLA0
5hEyg2CMxCZ7xF5ZhLrLtTYL9rHgA5mDvw4FmKfpVHHymKa7u956xhP7YF9hJwrh
Yr5uc9CsM24THQONchQuXfmTl55cbZFOocI30qSvYRy8f64tjfMcrRJyL/4hsXZR
kwYBzeQUfwyzIlf4zhYhFQIA8+FBHqKs0/hyuNfZGEMZatzoSZNdjxLnWy0VTnkf
ob+uofgZYTol74NZYvpYmV4PVEk0iKDr3bMgIsfDggv7yFkvKeI=
=TTOn
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--

