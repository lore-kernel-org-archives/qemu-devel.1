Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E34206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ERrIuaIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E34206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZp9S-0004VI-IV
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 01:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZp8V-0003bk-Fm; Sat, 16 May 2020 01:13:23 -0400
Received: from ozlabs.org ([203.11.71.1]:57365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZp8T-0003Ay-1H; Sat, 16 May 2020 01:13:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49PD1w6mDcz9sTL; Sat, 16 May 2020 15:13:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589605988;
 bh=VglAUnrHhp5oWI/Q1diT6NZWQAM5I8+eJY/ZhE7YTME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ERrIuaINavmYYzTkzquqSAoBT1tF7bYFb/HB3lFYv4aAOw655s16D74JQsuJeK0qW
 8vsZQDni0xu7Vt/fOGPTp0OtOzEVwK+m8/2YJEZWpz0wKC7vo75JLrm4N7E9aJVEuV
 QNtg3ZjFLqMeTfqhKE3lTKmX+Zh3ha2Leh1s/gYU=
Date: Fri, 15 May 2020 23:39:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/6] target/ppc: Various clean-up and fixes for radix64
Message-ID: <20200515133913.GI2183@umbus.fritz.box>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
 <20200514065249.GC2183@umbus.fritz.box>
 <20200515085807.7315539a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r21wuLfwIlf/vvzy"
Content-Disposition: inline
In-Reply-To: <20200515085807.7315539a@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 01:13:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r21wuLfwIlf/vvzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 08:58:07AM +0200, Greg Kurz wrote:
> On Thu, 14 May 2020 16:52:49 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, May 14, 2020 at 12:56:42AM +0200, Greg Kurz wrote:
> > > First three patches of this series are simple cleanups. The other
> > > ones fix some regressions introduced by Cedric's recent addition
> > > of partition-scoped translation.
> >=20
> > Applied to ppc-for-5.1, thanks.
> >=20
>=20
> Could you please refresh your ppc-for-5.1 branch on github ?

Done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r21wuLfwIlf/vvzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6+m4AACgkQbDjKyiDZ
s5K5txAAkvVCBk+ffdWECmq36c33E2DpFrUEmwekoBEu7UiUpevE4ia90rmyXkzL
z9JGRw+uBphGylPVmhkpCuULAaU6Ic72vUUCE7nGfOE1w7bVB+5c/KDYCShJZzay
ooojPdDFcfWzGA8726fIsmeBZ7+N3BZ7dWLjRk7bPhQsejgYcSqRdKIgODNPCkJo
tY1iZbt1UV9rlebfVEm1cm79QWxLRwPT1+y1ThqzGCJYNfuEhpXK7k8TfmquGNEy
nwDT2fu9rPpCJi4+hchinu7MtPUTS9ie0MUJyMzap49UuAL2ke1v769Nlln7pbx5
vPAQn/rQuTsM4ssJyYzcz/wK9KrwdD93VL27k4auzPK6ZB1Ekqpwi/nxrtKT3B7X
92INEfo8IZAPV4O8zjf3/LuvnHT7/JcdjB4UMu5WeIQeoh3tUNYrc9c6Z9rtgLfe
11/gIUZI4uINtwjM/ErD9UZHkWJgE/XZfTx5mstX5byFHOsjg+yENiudW/LvdpA0
sZ/3jrTGLeca7dIhn1eAHL6fhBXvOu2TMn24KsJTWYAesMQU/8lC9Bt9fA2Wwr/c
cUSGsjepc9586c2nLgQLjAR7zBm9BAaDmplsnkRJG1P3S8LeGBWd1qtFu2WVWq5T
JNgUUw0eJUKYnb1YKblpFh8t9YXUXyYiSq86a8cefAnbLJZnxWw=
=ny5Y
-----END PGP SIGNATURE-----

--r21wuLfwIlf/vvzy--

