Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38FE204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lV3E2aFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38FE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Yql-0006xI-DH
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3Ypv-0005n0-6R; Thu, 06 Aug 2020 01:53:07 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k3Ypt-0006wO-Dx; Thu, 06 Aug 2020 01:53:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BMd232B6wz9sSG; Thu,  6 Aug 2020 15:52:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596693179;
 bh=lgTsRzjMmVBG5qWj5LT5in6hUMox5nSoTbrkFoowdRQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lV3E2aFmWelN1iQaXE5dVCnS25ujrdUEbYcoWliszaYb/p7qMnzmaBHnTtnE9SlPn
 J++K4R86UY9yXit+FW/zP5E4OHjGl6Ux+GUe1fS0s1WVGj7pWXoossumQWk4TWfJsj
 xwIgrkKDVQmuGLjCmth+yhBK3Af+10NSw7RcE9nI=
Date: Thu, 6 Aug 2020 15:13:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
Message-ID: <20200806051355.GA157233@yekko.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <878sf3uojf.fsf@morokweng.localdomain>
 <20200730005947.GO84173@umbus.fritz.box>
 <CAAdtpL5Mtaf7Xwu74U33eGTCAiFZNNXeCST8COwQeW8S9j8ZVQ@mail.gmail.com>
 <87a6zh3uyv.fsf@morokweng.localdomain>
 <874kph58o5.fsf@morokweng.localdomain>
 <CAFEAcA-Yi754zyxHd+bggjny5vXw=rrs5fm6SZCcxwVUeoTtOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Yi754zyxHd+bggjny5vXw=rrs5fm6SZCcxwVUeoTtOg@mail.gmail.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 08:04:11PM +0100, Peter Maydell wrote:
> On Wed, 5 Aug 2020 at 18:01, Thiago Jung Bauermann
> <bauerman@linux.ibm.com> wrote:
> > Any news on this? Is there something I should be doing? I saw -rc3 today
> > but not these patches.
>=20
> Sorry, you've missed the bus for 5.1 at this point. I'd assumed
> that the relevant bits of the patchset would go into a PPC pullreq
> if it was important for 5.1.

Ah, bother.  Meanwhile I assumed that since it was cross-target it was
going in separately, so I didn't take it through my tree.

Oh well, I guess we apply ASAP in 5.2 and we'll do a backport
downstream.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8rkZMACgkQbDjKyiDZ
s5Kjug//YImhtTXWaAu4zBB39Ef1w1Ff+d+LbgxUQnLKZtEyG4c/hLHYpKyzdntK
jxrpJ55yFL8M2+nfqJ8e8J0iO1c9/uyO4o2OR7y4jisX+NoIJxl7ngoeKP7CiiSo
wr+wzvNBf64AjKZy/L9ddAkk+ZKrm7M8SKcFRaPxbkRbsPL386SvvURHG2R3UZp5
HZiul6Ge9Qg97MEvp5KQizWeWHrXIhR6mW5da4voPtAJVxDPG7ES4gE5KEpost9p
kB3heCy2e5wLEyjXb0JFwUErKo3Fz+XsYmh+jpugE5luDnUwnUfIuA9J4bhcDUsG
2XrU9wxoifWhInrSYtgX1/7kHu0yAqZuW9+wqjlYXi+uJrJxIIicOWamta3tc7l6
czfN+jVLp2EP8X0alp8S7QcKcNDDkcO6WEHXJ1pO/LrZzwChydPFn6XYvOnTVfF0
XUj3QRbIGOI0JyR6xkOhUxPkkv8ZEopkb2D3XzU+/N0T8lt0lRO583yWCNLtrslq
GddoWrdf/RZ24JxzFrSHspMfPqZDR2C5wPfi1bUbjdOyapynNKKRJFNRbC9CM6pu
O4EF5fCS0SH//Q9pD4ngrnEbhQjmRxPVC9xY4r3edHFlrYKAL+oNoBWPWfvw3jZ2
ehSsheA5Ry4cRlb7XcGjWcJBG/ZhM94uYLNsx04XcbexDgnK3eg=
=B/Xv
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

