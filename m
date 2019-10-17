Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059DAECE599
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 00:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33C021928
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 00:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aKGi5hfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33C021928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKu16-0004ux-TD
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 20:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iKtzg-0003jo-RS
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 20:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iKtze-0006Yi-Fd
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 20:50:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34277 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iKtzd-0006SO-Eo; Wed, 16 Oct 2019 20:50:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46trDM0FVRz9sPV; Thu, 17 Oct 2019 11:50:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571273411;
 bh=4c6OdtewzD73zXbG2cVjN6fv9sbWN1rUR/s8+Oh9tqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aKGi5hfp1IRvSDY//X6CQ2HAntc0/AribBmOybOmoG1bss/IMxoQWs1PZIZi3biJp
 oo8qBjgaNy4Fuk58hllg/jMcBxzu3vB3TVxqgTmwC4gWlEOYaIJ/UV52z+MeajGrmi
 fm67mepoTjrSy3z3SXfe5tcfhWWyWUHoLB2gBr8k=
Date: Thu, 17 Oct 2019 11:26:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 00/19] spapr: IRQ subsystem cleanup
Message-ID: <20191017002645.GA2000@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191016180404.6cbfce9f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20191016180404.6cbfce9f@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 06:04:04PM +0200, Greg Kurz wrote:
> On Wed,  9 Oct 2019 17:07:59 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This is a substantial rework to clean up the handling of IRQs in
> > spapr.  It includes some cleanups to both the XICS and XIVE interrupt
> > controller backends, as well as more to the common spapr irq handling
> > infrastructure.
> >=20
>=20
> Patches up to 16 have been reviewed. Any chance you merge them before
> soft freeze (12 days left) ?

Seems reasonable, merged to ppc-for-4.2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2ntUMACgkQbDjKyiDZ
s5Is9w//XsVK15VRaJoqXI9QEkOwQ5CnEglA+4Pg8XbHHLcPMSfiPp1RDk8Mdm51
gahx9kfDK28O92382I7TE7AMzmpObDUG6ofQe/ExW0+E8xz70ww5VbJ/WfLLYzQz
WDJ1zbDROsEpud2jC7DHnZSx+BVPbqxZjgzL5naEuKXzLboDcROGL0VjvI5rQ0Ty
PDTF2KY0W5KjzeENbKV18iuefU6S8sLBhpdj/EeqnAniKuwjPr/14R9RqSV89t8h
Axm4Dcnh3QuIanr0qJHnTt13V/G4K5c+gmXfbUnZl6Jt/kzkq4vLRh3sDLm5Ov6m
2JiSffjj7ycNJfI41zRZO649BTvoAUtVqfdeRrNGg+E1KJIxEn9JXZFnBfOPOs4u
We1fIkjFBMYkC6lsXFGzoiQGZSr3gAp2C9v8REVhKuCq1rqjbLxUqbN3ObhAZWSP
mIH1pwTjAekEPaBuMAoXzIrJCJ2GDViwlYavOuN6on76nhqqfr3DrNxwoiYThXjO
LvyLpYK+vs8L6xBmC26hSRp0gSiWL/ays+XxSgxAumTZ04HPQjcQVktt6N8ZhV1B
3ti4yb97LsjF6jGP0+ozr+4W3xAlstsdLK1+fV85Vl6QaOf1dUDiKv9z+D31tfwX
hVDLFU1/yDfKjjdQpg6hOZq2kThsVQbXhxAKGPsyQf+s5hNnJN4=
=+82w
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

