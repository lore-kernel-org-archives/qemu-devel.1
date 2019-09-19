Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F28C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA75F207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA75F207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtka-0007Ux-EX
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtiC-0005Aa-SF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtiB-0004YE-O4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtiB-0004Xx-HZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2544308FC4D;
 Thu, 19 Sep 2019 10:30:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F01E819C6A;
 Thu, 19 Sep 2019 10:30:47 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:30:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919103046.GK3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-9-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k18oBAwMkTg3OUap"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-9-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 19 Sep 2019 10:30:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 08/22] module: check module wasn't
 already initialized
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k18oBAwMkTg3OUap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:35PM +0000, Oleinik, Alexander wrote:
> The virtual-device fuzzer must initialize QOM, prior to running
> vl:qemu_init, so that it can use the qos_graph to identify the arguments
> required to initialize a guest for libqos-assisted fuzzing. This change
> prevents errors when vl:qemu_init tries to (re)initialize the previously
> initialized QOM module.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  util/module.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k18oBAwMkTg3OUap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DWNYACgkQnKSrs4Gr
c8hYTAgAubYlptHJRH9RB47G35ZPR659x0R2LYa1r9KJieMX1UNGusZcXkk1W+SG
Rivv27g5MSYcZJybyuJ3AZESJVbqzNzYbGpbLuX+Q9weXAY+tmitRu2fx8Rdyd49
zlxCOwk5GZ/3WwOs1zN59iCzXVirmR3reC19zvVLxM2ImdFYWFSMmgw26AL4X47D
Y4w6NW+eEMkphCF4H+FIqnBssevQPtAASiHtVkX6ATwjQNCeaIgtP8mA1UoTah00
MDYkO3r2I7FeFWU0G/FNhVyDLBSlurUGgtp+9XFZ8JIj60AUqrhKKGFfI07WBeqw
NRMaatVbS8ScQqxytFHw2sm27py7tg==
=MRll
-----END PGP SIGNATURE-----

--k18oBAwMkTg3OUap--

