Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D2C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 11:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8DD20665
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 11:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MQYB3tTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8DD20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdZDQ-0005Kg-Ix
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 07:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hdZCq-0004vk-Qo
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 07:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hdZCp-0000BZ-Ln
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 07:56:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46535 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hdZCn-00007z-9J; Wed, 19 Jun 2019 07:56:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45TNhk6JTxz9sN6; Wed, 19 Jun 2019 21:56:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560945398;
 bh=v/GtsvSdmwRg41OkslfVPSiDPLYnM7AB+nC1XtQOlso=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MQYB3tTf3F68LpLAEWNUGFuewFHbvZVxQ1Q/oZ5d9neNTq3CfO4K8bFxKh1VmORYB
 kjf0Us43UtoK8/o8YJHVZaANfdRomuOmjdRpGpHHJsAx1KI9mg7X6T3MdcB9PJWELA
 8fK+MDz4NvMzS5+s3ntnhsUFq+0yKpx1LvHmtU0g=
Date: Wed, 19 Jun 2019 21:13:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190619111350.GE22560@umbus.BigPond>
References: <156051052402.224162.13664250996245267046.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <156051052402.224162.13664250996245267046.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 0/7] ppc: Get rid of some CONFIG_KVM guards
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


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 01:08:44PM +0200, Greg Kurz wrote:
> There are several places where CONFIG_KVM is used to guard code that
> should only be built when KVM is supported. It is generally preferable
> to avoid that and leave such guards in header files for improved
> readability.
>=20
> In many cases, the execution of the code is also conditionned by
> kvm_enabled() which expands to (0) when CONFIG_KVM is not defined.
> This is likely to cause the compiler to optimize the code out,
> and if it doesn't, the right way to address compiling issues is
> to add stubs.
>=20
> Successfuly compile tested on x86_64 and ppc64le linux. Travis shows
> this builds fine on OSX as well.

1..5 applied.  Still need to look at 6..7 more closely.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0KGO4ACgkQbDjKyiDZ
s5JWeRAAhzZp8WOoDL4JXoY6B6VP7nLsrz5CFXUDE/nRQZ6GpRmkGA+jieSgQlzD
G71Fx4Lg08nD9rXhxE01X5dMGzVLeypbOhKUBc7abBwoanfA+et9G8ysBrbqhOFa
KwryNA3PJnYLy204mTmSHs/gUPF8Sdu5WMuYQ1cJJ7/AuF1qpNZRkgHa+qgfC58H
eyxOPOuzMMGSVADRSFyaNu1ZZi7IeFc6+USiXgaNb9xTwo8Iz5GZx5AAYvVphNLb
oIrsdXiazEY123qkPqwh9xlTXIuvQ4i49jRCm8c358hXqg4lIwpJpQfIRuiqmle1
oJzExuytzo03ocx3uyOnuc2UbO2qQxHoBp+n8hef6ju9s6YQwTtVPKzoZBarGKeo
N0T2UBfcoEvbl+NHsbMFyef98ijOZv3ruTZSFGRaojaWZJF2BD1RjOikgOfj7JDB
8bU9s5x378tS0qyzbVs51g2/UfBMJUcyM1YlqU3tQ37wfU660rxkFi5tXISYPoK8
CBxxRj4eki3EQMnvc1RPybG0lz/67tDYELOt+F4njYwkyPWPXw5eEppMW5+0N/bR
cyM1Yg8P4CSQTOtUJKCBoAJA2L/O4Z/BawT3+cekjnlsYwVxTwyme5SMeO7+h4e9
+WCWW9wiK811O9t/94Ew0Bn0VeNBeGBy0U5fSqZOydDYDJM1XQI=
=2MSr
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

