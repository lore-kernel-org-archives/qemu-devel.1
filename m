Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE53DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23BA2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 23:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DGBk51S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23BA2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK960-0008H9-Mm
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 19:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jK954-0007j2-Nm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jK952-0000gk-Mx
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 19:17:02 -0400
Received: from ozlabs.org ([203.11.71.1]:50365)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jK950-0000QF-8x; Thu, 02 Apr 2020 19:17:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48tf8g60ttz9sQx; Fri,  3 Apr 2020 10:16:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585869411;
 bh=HftRPbDacazwi+xrN+kbG/QWP3Bo9JoI4h44BdaZLs0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DGBk51S+LoxDJwcOyjQL2yao4qw8lb5FpueKBL2QOSwwfHCHmIWdbowRxpiOMHbFj
 frjWoUh1S9pnGde+bgpiz/cozIpMTkHasJkiyu/Yw2bycDVIBdRe23U8nHcij7VlJb
 xfEbK4shRS23YSbqFU6r4rMk++d1nywnE9WrTbLE=
Date: Fri, 3 Apr 2020 10:16:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs on
 drmem_v2
Message-ID: <20200402231645.GT47772@umbus.fritz.box>
References: <20200402172339.622720-1-leonardo@linux.ibm.com>
 <20200402224925.GN47772@umbus.fritz.box>
 <6eaedb1c412f1e5194b5e9a6e6718af98da5abdd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JfVplkuTfB13Rsg5"
Content-Disposition: inline
In-Reply-To: <6eaedb1c412f1e5194b5e9a6e6718af98da5abdd.camel@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Bharata B Rao <bharata.rao@in.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JfVplkuTfB13Rsg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 08:00:57PM -0300, Leonardo Bras wrote:
> Hello David,
>=20
> On Fri, 2020-04-03 at 09:49 +1100, David Gibson wrote:
> >=20
> > The change looks reasonable.  Is there a PAPR RFC I can see describing
> > the new bit, though?
>=20
> The ACR is approved and I already added the change to LoPAPR/LOPAR,
> it's just a matter of time to get it released.
> (I think it's accessible to members of OpenPower Foundation)

Hrm.  The latest LoPAPR I can find is from 2016, so a "matter of time"
isn't very encouraging.

>=20
> This is the snippet of the change:
>=20
> At the bottom of "Table 3.11: Flag Word", add another line containing:
> Hot-removable Memory	| 0x00000100 	| If b'1', this LMB can be hot-
> removed.=20
> 			|		| If b'0', this LMB may not be hot-
> removed
>=20
> Best regards,
> Leonardo Bras



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JfVplkuTfB13Rsg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6GcloACgkQbDjKyiDZ
s5IA8w/+K6zMUiav1kJKEsYBCsHsQpBO165BUguyCEpO5djC8asjl+Me0uTbx2YH
ZNCOwHhJTQFzAYImp1TKnnnkPr9tFA8amIYTxTflDtRGQfvBxWKsM4sysjjBV/1q
Dl/aSlF3HwXJF2/2N2COr2ntQypnACaRmPZ/BH4fb2bbQpIZDsIk/j31Ne2kVwH8
uIber1EgVuyUpA53Bbty3hyN3Wejk/omLUETkx3Jei9K/mud6nz4ApbnHBU3fWaE
xd6Q6K2JFCEqPy37IxwX+id/Wo7yR4f0ghG2OmLhDev+DFLIkO8r0enb5twI88kl
ug1J8SSboT7ToiKYBYHUWbK/mguHegsWR6AIT8xTUfIYmGMXlzEJQhZjdBb3cgPo
nbg/JeIcE7bFZYW5zqaEZAykqX/V749ZrSpN4PPHUlKb4lxPaYzL5F9WU1+aS69/
+5h6Qy+sYelfTKr9owdXqlzP/FUGVu6St98+OodGdA2GlufOXKT6nVIejAtNQXkc
7NgBeWKDeB6wNB4a3S14ZSP/FmGsGX3HaOLlQwH9NkXB+I4GaVvW/EQ9EG2fhnZ4
jxewOAwY1hKXfBApHvUjr2P9QN1odR/cS10qb0KZHfETlZLy6I/58D12zYSsdP4Y
ogmrx/ThGe1tbpETJmUFxGEF7OAx+QG85MzdjwY34evIgfE7njY=
=hO8B
-----END PGP SIGNATURE-----

--JfVplkuTfB13Rsg5--

