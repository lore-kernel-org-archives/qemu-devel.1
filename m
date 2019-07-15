Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A5C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A77E20838
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mPm/D7Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A77E20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmuQX-0005US-Af
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 02:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hmuQH-0004og-9x
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hmuQG-0004n8-89
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:25:17 -0400
Received: from ozlabs.org ([203.11.71.1]:42883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hmuQF-0004gX-T3; Mon, 15 Jul 2019 02:25:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nD6B1Q1wz9sDQ; Mon, 15 Jul 2019 16:25:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563171906;
 bh=ew2r9S6hGad52Ds/Pb0JtHyFsdClTvKTtZMVXS7GIBA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mPm/D7VeRQ1BdjVxL7EX3J0VtZOs3hnRM7yGpNeABuyuZxM2Lj77u50oaidTqKNKo
 eN+opQbE9eqqwHdEIbWPuG5ZwV9ONJFMh6ZiNgrJlfz5aB+CF6yCc2uugtnhnTu9g9
 2dNJrkVA55l1zEelQsCgXv5y8wKZmhmHnOt722Kk=
Date: Mon, 15 Jul 2019 12:25:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <20190715022555.GB3440@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
 <20190712011934.29863-2-mdroth@linux.vnet.ibm.com>
 <20190712064027.GF2561@umbus.fritz.box>
 <156294442813.22588.13951961791159970871@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <156294442813.22588.13951961791159970871@sif>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs: initial spec summary for
 Ultravisor-related hcalls
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2019 at 10:13:48AM -0500, Michael Roth wrote:
> Quoting David Gibson (2019-07-12 01:40:27)
> > On Thu, Jul 11, 2019 at 08:19:33PM -0500, Michael Roth wrote:
> > > For now this only covers hcalls relating to TPM communication since
> > > it's the only one particularly important from a QEMU perspective atm,
> > > but others can be added here where it makes sense.
> > >=20
> > > The full specification for all hcalls/ucalls will eventually be made
> > > available in the public/OpenPower version of the PAPR specification.
> > >=20
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > Thanks for adding this documentation.  Is there a PAPR extension
> > proposal which covers this, which we could cite as the source?
>=20
> We have an internal document/repo that serves as a catch-all for the Ultr=
avisor
> related spec changes. We could make that available publically via github =
and
> cite it here until it hits the full spec. Would that work?

Yes, that sounds good.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0r5DMACgkQbDjKyiDZ
s5Jv0RAAtB2cTgMvGCWAondC4rDAi8nB1Rgp9bKQC5ZfVGMkpCiHc3sN1R2qpZse
7CkVFxzYPaVGslcnip9wOXKGLoYAhUfC5nTIsZY1LIuC3pPvtUnaktjPpb9Wf9SD
vzw/Yeaiw0x4IYWn2yRIsv7oxJDtDVfYqhY3E1A4SeWtKNKOfGWtdUIBjQKlWY+n
dO4sfk0Ov3rleQCYZW9yNwL9eG7+Za6HueNKLbw/Tnlh32ye1UkLMANBTeeC1ZO+
l+b2L7t0LH9KNe87R/A7x7Y4WtmzGZEe7i3IpOvBCZJ2dRi6mKhAxQQWmQ8NN/5s
i/Vkv4iJkMw9FKxr1mg5ligG17BoaNC+4ZtUZTHW19NCwI/+ddEoxA0vTHHXZ5VY
QnpfNoeqEbdgJ60zVMYWgaZ9MRkyF53W1q7FP/wLXdb5wlJp9Rua9w+pQMUlTHbF
7BbdsVGXJCYLeP52Xl+IC3y/TjhQDGNQ8CtlKZmILq2ij1BVgL/KPJXCuLFmJgsQ
8+rpKxjT5eW+/LbnJNROI5tkl9EZVLNHAalJNqSuZqz6MSj03Sy7IT/E4MaAYdH8
PBCsBSLCF2By+BK1YN8auwlF7Pb6bJRQpOE96eeG1mpPhSwZ1DgMqCmVx0MPHwe6
riKtKNkewsrUE5mRY3Ig39TG87H7JXL9npmdll8siJHO8sPFXKE=
=yLsx
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

