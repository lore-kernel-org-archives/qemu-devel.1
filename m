Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79767C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF6F20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iWrv9F/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF6F20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbGeL-0006cj-Pa
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 23:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57553)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc4-000551-Ud
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbGc2-0006mA-3M
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:41:20 -0400
Received: from ozlabs.org ([203.11.71.1]:37391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hbGbz-0006hZ-66; Wed, 12 Jun 2019 23:41:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45PTzp4RbTz9sNR; Thu, 13 Jun 2019 13:41:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560397270;
 bh=oLAaE9ujw9vK0P8Z+0lVNW+gxyP5umaXW0Pms6g9Bl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iWrv9F/gYxUhG9K/tMgUMOTmdGl9lVL0Wr1i0E3AItrhvOEOuYDNd5IcigKx4Hggq
 dQxa3YH3/vgxigF1TuEkVUCtPu5LGQ8x+kCX49k6M0y7x6eQf1DKDh3W8YxWN9YT0z
 3HuIN3Z4jfDGH2Td3WKmQbKhTSUKqalCSZICWkNs=
Date: Thu, 13 Jun 2019 10:04:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190613000434.GB18900@umbus.fritz.box>
References: <20190612174345.9799-1-clg@kaod.org>
 <5749e4b4-cca7-e6a0-4951-431a9493581f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <5749e4b4-cca7-e6a0-4951-431a9493581f@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 0/2] ppc/pnc: fix XSCOM MMIO base address
 for P9 machines with multiple chips
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


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 07:47:20PM +0200, C=E9dric Le Goater wrote:
> On 12/06/2019 19:43, C=E9dric Le Goater wrote:
> > Hello,
> >=20
> > The base address of the MMIO window of the XSCOM bus is incorrect on
> > P9 machines with multiple chips. Provide a fix for that to prepare
> > ground for future PowerNV chips.
>=20
> David,
>=20
> I just noticed the 'pnc' in the title. If you were to merge, can you=20
> fix it ?

Done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0BkxIACgkQbDjKyiDZ
s5J/sw/9Hws+fw0y0147VpaA/N+GZ7bsr4wAZSH427CebAZQWx0cCCT7O9+noIxf
bCUZkIvXi8opQ/F4Pe0viDKSOKcPulXwFJ6QPpX07jGB/xbhYILyOZc3NVyYhKv2
mbvZpOgu4tTirF+mKlc0agmGwY7odNziusqMgUB8EQJgizALbLXVuLG9lNNj3B5t
SE8XgxnZdSa6lbqqk6SfSwKTcjN4zyr3twC7av6dCd8xV9YQWnl1PvWUfRmz+mn5
iyQOMMPi5ItiLLdScjJWdd5JxPGci5BO3TzisPGfuJo49AYrzDTB+AUMD2tS0/d+
+zjYo4a+Lzvw1fmhpLmuYiruv4lysYl3NJh3xngqNF0+Nqiq2hx490r0eMAbUAuj
o9F5RfPHRIBax6GeU/L2yD0Qbq2+xWYHXbKhqw+c5szrax3ZpfAUp141IBt6bJvh
d0OUi0QhFDJdjg1IHJ5xBcAmGdXtu5tJMu4N0KNRB98J5g/j9c/ebAsmF+8yFUPU
OE4s+Cpo5cVXcgHxss4FXIWfpvRmtcEQL/TTt9P2OgTrh24VlKOwjTC2BxLmecn2
te5vhPNiTHr2A7WJMm9gxwte1GqiUJ5RZ+OFJaAD4yVo3pRIElD5a+ZVidrJE91o
/WFhCpV0N/gbIipUkbWLfFkw8c8m7mobDv16nd8jJO7g5P5Qi8c=
=EZeL
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

