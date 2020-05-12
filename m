Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C2CC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0292206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eGpmjp60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0292206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLhj-0006mb-5g
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jYLgu-0005lr-F0; Mon, 11 May 2020 23:34:48 -0400
Received: from ozlabs.org ([203.11.71.1]:37721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jYLgs-0001pO-0a; Mon, 11 May 2020 23:34:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49Lk243c5Vz9sSg; Tue, 12 May 2020 13:34:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589254476;
 bh=gGahroeaTim0FjgSz+hr+x3pqmkGlST3ysBXTZOj4C8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eGpmjp60MKBOlSy7y71kqpH7rYiRkAFDLpYzwgSAzv/TWOonx02PikaOhHjpkOfSE
 qIqqnmKenOZmnqzh2avK88BX9UMw1QTMqVopbqw5aYcdzjaXbgGvkx4JGA3O+sozQw
 AmjpRd5NrVegBx4KDJLLDKde/hRL2mwOnaNtMARw=
Date: Tue, 12 May 2020 10:00:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/6] target/ppc: Various clean-up and fixes for radix64
Message-ID: <20200512000020.GV2183@umbus.fritz.box>
References: <158887239173.1564424.16721638327458334129.stgit@bahia.lan>
 <20200511014426.GO2183@umbus.fritz.box>
 <20200511185521.1601dbde@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JEhTuUFIcUlI65CC"
Content-Disposition: inline
In-Reply-To: <20200511185521.1601dbde@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:34:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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


--JEhTuUFIcUlI65CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 06:55:21PM +0200, Greg Kurz wrote:
> On Mon, 11 May 2020 11:44:26 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, May 07, 2020 at 07:26:32PM +0200, Greg Kurz wrote:
> > > First three patches of this series are simple cleanups. The other
> > > ones fix some regressions introduced by Cedric's recent addition
> > > of partition-scoped translation.
> >=20
> > 1-5/6 applied to ppc-for-5.1.  I have some comments on 6/6.
> >=20
>=20
> As said in another mail, since patch 3 breaks build with gcc-9.3.1, I
> intend to send a v2 for the whole series later this week. I suggest
> you simply drop the patches you've applied for now.

Ok, done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JEhTuUFIcUlI65CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl655xIACgkQbDjKyiDZ
s5L9zw/+Kofkp5JFQgai8R8LX8jRUVop/zrDG3Zd+44QMBFVuAPCw2dePncetwcd
9c8fvjnZS5ne2nZbJZeHiZ85lw0JKXywNa3cmcoFD62+r0r/FzX3Lzlr49r+YpZW
NB/hsvglmB5L3HvxqClUlJ1mC1sdiNB8elCWNOy9SJuO+qsrvJzaszrCSIF+n+aB
SeKVjv6b/A3evMX8bdU7MQRkqaHA8iUsKcdOI7xmcfbN5WQLCDVMpSxCI0weJUtx
TjfTboHiNF2Xmara0BXhH2zTOSCIKwOtscdsIWwsleEp2PhsjVzUnwMd7kmYHYvT
d2YwbNs1XsM3o+gfp4/wkegEqokOns1TyYImncRfyFGqiUpGrtTh3BMSeuWRbuvm
+cM1dhR94jmYemNkuqiozqGcIZXIP4XUlZaMTlW0K2LujUUeJ8kY+sKtAY+ham1k
Bv+5a6MoNk+/es8vWHqsdu6+rq7j5NOq6Nv7zfJozWpULwMGfdIUCIdvz+6FvKAe
QfWDlJgUhYCR0AFhfN1rF9kgLBjNAAvX+k68ycsCq8tInsJo9YgLSkpZHKtoterY
ze1dpjmfjrfWYROlHa47keZ2jl5eUjjwp9oQELqZhQCWpcKDl1v4ZW/45mjO/3Pp
kavLqZu2CF90QeMAQVhlA7OyQ/jy/JLFnFPbwont/brftIU6TpE=
=N5nf
-----END PGP SIGNATURE-----

--JEhTuUFIcUlI65CC--

