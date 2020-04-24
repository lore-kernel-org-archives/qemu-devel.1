Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60759C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 01:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA9E20728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 01:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="axGm8j/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA9E20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRnSF-0006DZ-9P
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 21:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jRnPk-00047K-Hq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 21:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jRnPi-0005El-9K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 21:45:59 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36571 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jRnPf-0004Rw-2R; Thu, 23 Apr 2020 21:45:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 497cSj5r8Zz9sSh; Fri, 24 Apr 2020 11:45:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587692741;
 bh=fx/RvWPWW/yGqVkD0phHBQ/hvQWAEBqdQawyS11EGao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=axGm8j/3eI1ZsS8SWCLCdtelG6UgOUeG1EoeiMMOjmkD0bSqZoGozSu1y6ANBaKju
 AZeKF0BNbGL0vvHcBuNtpWU3zVJjpmFal/AxuZA2soMe4i/JN3gSsFV6DEnLBZov2b
 g07TRgvNZij/4ZlYNnBPelCrc7jhtQkF8lPzUPXw=
Date: Fri, 24 Apr 2020 11:45:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH] spapr_nvdimm.c: make 'label-size' mandatory
Message-ID: <20200424014532.GB121306@umbus.fritz.box>
References: <20200413203628.31636-1-danielhb413@gmail.com>
 <20200414020117.GB48061@umbus.fritz.box>
 <84c6f5c7-de31-84ef-e873-58b10af14bc0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <84c6f5c7-de31-84ef-e873-58b10af14bc0@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 08:04:29AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 4/13/20 11:01 PM, David Gibson wrote:
> > CCing Xiao, Michael and Igor for generic NVDIMM perspective.
> >=20
> > On Mon, Apr 13, 2020 at 05:36:28PM -0300, Daniel Henrique Barboza wrote:
> > > The pseries machine does not support NVDIMM modules without label.
> > > Attempting to do so, even if the overall block size is aligned with
> > > 256MB, will seg fault the guest kernel during NVDIMM probe. This
> > > can be avoided by forcing 'label-size' to always be present for
> > > sPAPR NVDIMMs.
> > >=20
> > > The verification was put before the alignment check because the
> > > presence of label-size affects the alignment calculation, so
> > > it's not optimal to warn the user about an alignment error,
> > > then about the lack of label-size, then about a new alignment
> > > error when the user sets a label-size.
> > >=20
> > > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> >=20
> > So, this would get the job done, but it seems a bit inelegant compared
> > to having the device default to working settings.  I'm looking at how
> > this interacts with the generic constraints on label-size.
> >=20
> > The generic nvdimm code has a MIN_NAMESPACE_LABEL_SIZE of 128 kiB, and
> > values of label-size less than that are rejected.  Except that if
> > label-size is not set at all, it is left as 0.
> >=20
> > Is that intended behaviour?  Do x86 (or whatever) NVDIMMs have a label
> > of at least 128kiB, unless they have no label at all?  Or could we
> > make the default label-size 128kiB generically?
>=20
> My limited understanding on how NVDIMM works in x86 is that x86 NVDIMMs c=
an
> work with and without label, but the label has a minimum size of 128kiB.

Ok.  Kinda weird, but ok.

But.. the thing that bothers me about this is that the guest is
crashing in generic code.  If the generic code can handle a label-less
nvdimm on x86, why is it dying on power.

After a bit of poking, I think the answer is that x86 is explicitly
treating label_size=3D=3D0 as "label not supported" and returning explicit
errors for the get_label_size/read_label/write_label low level
operations, which the generic code is handling.  ppc, I think, is
instead just returning bogus/meaningless values which the generic code
is choking on.

So, I really think we should have the spapr_scm driver on the guest
side check for the zero sized label case and return similar errors,
for robustness.

But, I don't care enough to do it myself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6iRLwACgkQbDjKyiDZ
s5JFAA//S2R96ZmwA6oYD7UYyg259Tqk2kWkeloFyGV1orR/sjvCqO9Xia1P9O5x
LPWFdL1CkUp42qQXf/fm/gWhlB67mbupj3vHbQsyEZ5HAtsbcc+WYQ8JsMzKBScN
ibyVHG+4H/1Mf0b0CJHeRm5A4oGigNdPshuJQTGgAiOtR52QyCGKno7hZHF1RbUG
3UZ8bSw0Mw+xfkRQxZjYjVqwIzi3pbDA2fUIcgqGpV6n8M+uFAmEK6Q4Pc4zfBYB
4Odqq8+ZXzbRa4X2HFPGr21SxMFoSTtaQleESIo1E5LFq0nvaPmtPvsq8Wkn4aVx
yz4yeeQzwRlUh52QhSVU07+WKPuvnOfa8ZY8WVVcGsTaPb19+lefo2vON+ukJkIO
bFb1dSgUJ5cU4divwupKi2hSU2QJEDUrIEbOI97vRNf+7vqOE5gDZK9FqzjMIx8y
h1oXYXWVqmKhWHrhKGsecJMj4FTo9nu3id/HyWVuMe58S+UMzwWGqb0WKkIim2HV
3hbP2QdNxyAtn5Ddj17qQ8Cwqey0a2PIMr791ibAl8o0wlklb27lBqzGdkhHlokq
2gHNOZx2sr2EH05/EnoEoRd9ksThGQNzbAqsq2HyCua2lbv8Y8bRGzRpsLJaQhzy
jn4F9WWc+jnNTuLMrfQ9uu6KpVwTMF/Q5vC1uH4w9bXXoVh5ICU=
=tv2a
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

