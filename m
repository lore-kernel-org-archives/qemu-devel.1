Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C7CC2BB84
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCCE20715
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 01:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cgPKKaR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCCE20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIiYW-00011U-6S
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 21:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXe-0008ST-9B; Wed, 16 Sep 2020 21:16:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kIiXb-0002Rq-Oh; Wed, 16 Sep 2020 21:16:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BsJvy2J37z9sVj; Thu, 17 Sep 2020 11:16:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600305406;
 bh=bgcul57NhEMdzuaeviqp/zLLnzvP6O8eAApf8ed9dG8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cgPKKaR4MDDp0CQMNHHsoS1OCDK15BqHT6IGxL0It3Gk4wi/OmNbbDADVNSFbK4WZ
 XEGGIiFztwhJMszCx26Qu8kCTcrLSV3dlUxzWawhp8Ugvq9C1H0edugWbSqZE6pCyS
 XJFHRRqQk8HonvIc7Rbs/A9HA0NHHMhSxE+P32XA=
Date: Thu, 17 Sep 2020 11:15:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [SPAM] Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
Message-ID: <20200917011525.GI5258@yekko.fritz.box>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <20200915134340.0cc3f9eb@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 01:43:40PM +0200, Greg Kurz wrote:
> On Tue, 15 Sep 2020 13:58:53 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>=20
> > 14.09.2020 15:35, Greg Kurz wrote:
> > > As recommended in "qapi/error.h", add a bool return value to
> > > spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
> > > of local_err in spapr_memory_plug().
> > >=20
> > > Since object_property_get_uint() only returns 0 on failure, use
> > > that as well.
> >=20
> > Why are you sure? Can't the property be 0 itself?
> >=20
>=20
> Hmmm... I've based this assumption on the header:
>=20
>  * Returns: the value of the property, converted to an unsigned integer, =
or 0
>  * an error occurs (including when the property value is not an integer).
>=20
> but looking at the implementation, I don't see any check that
> a property cannot be 0 indeed...

Yeah, indeed I'm pretty sure it can.

> It's a bit misleading to mention this in the header though. I
> understand that the function should return something, which
> should have a some explicitly assigned value to avoid compilers
> or static analyzers to yell, but the written contract should be
> that the value is _undefined_ IMHO.

Hrm... I think the description could be clearer, but returning 0
explicitly on the failure case has some benefits too.  If 0 is a
reasonable default for when the property isn't present (which is a
plausibly common case) then it means you can just get a value and
ignore errors.

> In its present form, the only way to know if the property is
> valid is to pass a non-NULL errp actually. I'd rather even see
> that in the contract, and an assert() in the code.

Maybe... see above.

> An alternative would be to convert it to have a bool return
> value and get the actual uint result with a pointer argument.

I don't think this is a good idea.  Returning success/failure as the
return value is a good rule of thumb because it reduces the amount of
checking of out-of-band information you need to do.  If you move to
returning the actual value you're trying to get out of band in this
sense, it kind of defeats that purpose.

I think this one is a case where it is reasonable to make it required
to explicitly check the error value.

> > > Also call ERRP_GUARD() to be able to check the status of void
> > > function pc_dimm_plug() with *errp.
>=20
> I'm now hesitating to either check *errp for object_property_get_uint()
> too or simply drop this patch...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9iuK0ACgkQbDjKyiDZ
s5KC7w/+P2BGehqqYJs5jbRaYUtMh+84IpHnFgo12owErch3dwpldfC2WkaUA9gB
oqKg9cDWBpVstmEgSboq5sm5eN42KH/Ef9f8WXmEMP2k6eNn1IJAghFdkJQ+npg2
+OmivfizBX/82HIVPsuUL+4ys/JtznNd0zb+0qNETcRJPAxVkFqfNsjpmOc4uf1l
MWPWlLqXRccbM90YSxkQntWyvRUbcQL8WUDH8AGV4xObtzzSujXb3ft6V8dv1k8V
5tZKo/g/cu1Jj20WujX0iX/Fjgfd07+Olbs0m0PX5IDSDroRAm7HKPaa2+A2B3+j
mmmP477zied8t1Wnpb8nPKi6Q5AOZvBpt2Qr8eQfQ9aA7E/13SoGvarPzJDMnO7d
PiGZkac6komQqf3ryDAqpyo3inUIYE3+l0Fg+tGTEOocdmh5szW1ZfqBFNlHaivR
RUNtTNt58fZCncuPHpwqPHQxEuimImfdeuS0ZG/yJcxHg3JxcppK9SqPDM1axX+t
KYlbAGTxZCtpc5eWnfQLJVRggVhuG/PxclzLBAUDSh7ew4LYFYubFKfa4siA+V6S
ss/lwcG5YuYnxQn0VZ1O7UjPaLeou12YnGXneCo/J3Pz9SOn545IxstnitWwA1Q9
TCEVeN9SmcWPXGg/CZ9SsKMDzTfLjGYE1nED3rN5P6Y7S/MQ0jc=
=9TfS
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--

