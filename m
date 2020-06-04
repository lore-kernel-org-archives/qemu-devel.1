Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD74520734
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kzqaisgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD74520734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgj8b-0001uy-4j
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgj7C-0000Tg-L8; Thu, 04 Jun 2020 02:12:34 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55285 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgj7A-0002nV-V9; Thu, 04 Jun 2020 02:12:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cwRc6t8lz9sSy; Thu,  4 Jun 2020 16:12:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591251148;
 bh=UfHpIetu+x/sdr/nACJK1BSB+jKFre6qOnaLAnl7EJs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kzqaisgWWJgjbD8dV3icCSi5cQzy6y9IW1peDkPPtTg8SKJuj5Yc5sAGfnNr9y2bs
 t8o/abqTw9cXJe1FqNd7QpJTAc3nWXahDplyl3vd5k8+OtBUU4Y0Tg/vMmJjZvWP/5
 Vjsrc2dRgbCNzW/xH+klIv2H7jj/KjtaC4gritTg=
Date: Thu, 4 Jun 2020 15:56:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC v2 14/18] guest memory protection: Rework the
 "memory-encryption" property
Message-ID: <20200604055638.GF228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-15-david@gibson.dropbear.id.au>
 <4061fcf0-ba76-5124-74eb-401a0b91d900@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <4061fcf0-ba76-5124-74eb-401a0b91d900@linaro.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 08:54:42PM -0700, Richard Henderson wrote:
> On 5/20/20 8:43 PM, David Gibson wrote:
> > +++ b/include/hw/boards.h
> > @@ -12,6 +12,8 @@
> >  #include "qom/object.h"
> >  #include "hw/core/cpu.h"
> > =20
> > +typedef struct GuestMemoryProtection GuestMemoryProtection;
> > +
>=20
> I think this needs to be in include/qemu/typedefs.h,
> and the other typedef in patch 10 needs to be moved there.
>=20
> IIRC, clang warns about duplicate typedefs.

Not, apparently, with the clang version I have, but I've made the
change anyway.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7YjRQACgkQbDjKyiDZ
s5IpmQ/+JtlwtOGwoMALm7UoBUn1GIlIXce9xTHg9BnZan8axwvpQc46HsCtjcK8
CPcTRq5w6MXbxIskXMo3+hmkYRWIcH/SkSbzTVxWm4Tl8Bit7AWyaGOoFzZTqahz
2/hyCdcRoKjQ6Ur2pWRhtdImFl1hT/tFW8pkfzhn9s5N8s/C5Re2JjugdYvKFljs
ICcUgtqJzbsG1MPEBy1SL3S7FQpqTTwe57+KkGZ0YdY2v1zTY9tUREPp+HlFBXx+
mdaleEekfAbqC4Eddxhjgyg74332oNYooMOAAqx1X5+kJww0MiptBABGH99iFlyJ
lVNbJ3ZCuF+Tm0m4JqBsnTnVcElyi5vHthwgrduj7u9nJXtic8tveHDvLvdWxqbh
mr/Mi4pMfozVqgfmce6cXiNnupqMhcLUuST5CgpOkKw0shZZUU+YmR3Jv3+koAaI
r+d9mW3dtzdnupNafpckbBJB0NX6VUslT82mJxj8yC0xBZnec9G0n14qYyD4cn/X
pAjGu0US6lA5U8iLZJmjmV9HY4G4xUmdoQKwgTGTJoOyZzZ0WOYtq3MSAmrDK2xk
jpvUrzleaQLAAdsaAjUUHto0rVmtSId0UgLvDPlUpoUxSvIF2BQTjNJBz7miomWr
NZ/Q8Vpfl+YpjSkQNTfJFjA0tAAlHzwLapJEwDsy8bqCFCvf3oM=
=sAi+
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--

