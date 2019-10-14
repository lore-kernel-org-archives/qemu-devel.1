Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71BFC47404
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 04:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4F020874
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 04:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k5UKLPLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4F020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJrjz-0000Hp-NO
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 00:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJrj8-0008Cj-Dv
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 00:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJrj7-000789-47
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 00:12:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50303 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iJrj5-000778-Q6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 00:12:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46s4sY261hz9sPh; Mon, 14 Oct 2019 15:12:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571026369;
 bh=aP8fMmjNnIMjG6ZH7O8s6BtbJNV52gP7ywWnwiuPynE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k5UKLPLt86tZrBhYMDespRd4cRmU1IiURTPbZTtDGFmrcW3YhvnQHEbbN4hz1H0wC
 UHEzD3eKHlCvrIqT9nUOT13X/ZpIj40lJLfvYQ26x7bifCVkJSexqrEOnUAMIWgtkX
 CACB+y8NsSec4KK42YiTdBTcqJpe40d/Dfz9J7fA=
Date: Mon, 14 Oct 2019 14:54:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v7 00/22] tcg/ppc: Add vector opcodes
Message-ID: <20191014035407.GM4080@umbus.fritz.box>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
 <20191014002501.GL4080@umbus.fritz.box>
 <dddc5aaf-6572-3cbe-4028-976a2be1e519@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c8UbHMnQwI7BF+TB"
Content-Disposition: inline
In-Reply-To: <dddc5aaf-6572-3cbe-4028-976a2be1e519@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--c8UbHMnQwI7BF+TB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2019 at 08:31:59PM -0700, Richard Henderson wrote:
> On 10/13/19 5:25 PM, David Gibson wrote:
> >=20
> > Uh.. do you want me to merge this?  Probably best to CC me if you
> > do.. otherwise I'm likely to miss it.
>=20
> No thanks, it's now in a tcg pull request.

Ok, cool.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c8UbHMnQwI7BF+TB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2j8VwACgkQbDjKyiDZ
s5Lk5w/9FS/1lnwJB1GsgyjBX2P+fx57X5bXfqDWUlA1EWWObV8wgx2P7S4Edv1w
fab597g1fjPvmnME8/p688FOIF7H73vOACsHH+s1QdJAArlEGt4IEAK6tCcIhAGV
1u3pS1E1NL8Z3zzFvGX1bS2b+fj4Ye3U+vwh+pscAL2UkMAFBkQ8AVDXGhyjECDd
R1/zqhcQ5Yc2C7l2znpH/+gUATg/ziusPUWa3XbN2GZt+BJA8FquYl+ZqZJ7nEEu
3wEQ3No1fPo3oQOaWWzEaKE7Gn8Z4G2DH/z4frYT/Y/Xoxamjy55l7tmCbjvhe7J
Tn2Gr9OqhPxOVhISD3QyweYJL1JZy1yrUKS/R1Ev9dzEORVjRuVzorj22ERpEir3
0/lMim2TW2zUhuBDC1gcqe/RoSR1vkQ7BEhNO99N84K14kKe3HRZED15nCHcheTy
UXId/v0EegVtNKbhSHEeflpyBS8hqZX4cwGDzSf6ejaxsaVhqTpWplJNwFT84c5W
mmp/R+8DU2e2+BjjeLNSGxVWQZMWcw2Zv0gm2qie3wALmPmc4c/VDfVuUiyXjCzl
PvVBYJ180DJTaVNPP+2uaIDEb9/sOLI9WAnI9T1Q+jAsOw3CqKAtEJlLZK5B/0zJ
JShUasLO3D+/OAW3pooRLMeBLT6YSgZhbL6FXfhk+Bo7u1HeGkE=
=myAB
-----END PGP SIGNATURE-----

--c8UbHMnQwI7BF+TB--

