Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB395C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A155D207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A155D207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtqQ-00068z-Dc
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtlu-0001Dz-PK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtlt-0005sS-Fv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtlt-0005sD-9b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:34:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56FE5301E135;
 Thu, 19 Sep 2019 10:34:44 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A101E19C5B;
 Thu, 19 Sep 2019 10:34:41 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:34:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919103440.GN3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-13-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XBg9NAhDNArbJUtw"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-13-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 19 Sep 2019 10:34:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 12/22] libqos: move useful qos-test
 funcs to qos_external
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XBg9NAhDNArbJUtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:39PM +0000, Oleinik, Alexander wrote:
> The moved functions are not specific to qos-test and might be useful
> elsewhere. For example the virtual-device fuzzer makes use of them for
> qos-assisted fuzz-targets.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/Makefile.include      |   1 +
>  tests/libqos/qos_external.c | 151 ++++++++++++++++++++++++++++++++++++
>  tests/libqos/qos_external.h |  10 +++
>  tests/qos-test.c            | 140 ++-------------------------------
>  4 files changed, 167 insertions(+), 135 deletions(-)
>  create mode 100644 tests/libqos/qos_external.c
>  create mode 100644 tests/libqos/qos_external.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XBg9NAhDNArbJUtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DWcAACgkQnKSrs4Gr
c8if5QgAqmHUZ60LcUGU9tKeJi3UZb+NZSAerlq5CWkmy7jx7W3H3rvuvs3huje7
vzzK8Nxs7OWgTdsfE4TeN5X1gJ924iBBo3NC0PRj2xohKKZ53fjU3TXl00FivRna
h517ofAG8vMve6P78CTYonkA9O9hltkvRVi7r+ZYw6H+F5E55X+ypj0Tca76/GX1
xiChIAMfxg0c3lZeWDDJt9R8ep7w3AsyZdhP0OguAP5dmz4pgQXZHasyBb77RFES
YNGCWFjIWWqmoNsMxgIXvXSZ5u+hheC6jE25/BTY0GYJuW8R4EcPYZ1rKcbyiOQY
DQp/pk6Qvy8jUd9Z1ACMARMTdqB2jQ==
=pglG
-----END PGP SIGNATURE-----

--XBg9NAhDNArbJUtw--

