Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC37C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C272084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C272084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqvX-0000ai-MS
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIqtt-0006oF-5b
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIqts-0004Xx-5S
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iIqtr-0004XZ-Vv
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D6F218CB908
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 09:07:51 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-231.brq.redhat.com [10.40.204.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D2B51001956;
 Fri, 11 Oct 2019 09:07:49 +0000 (UTC)
Date: Fri, 11 Oct 2019 11:07:45 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 1/4] tests/qapi-schema: Tidy up test output indentation
Message-ID: <20191011090745.GB1979@andariel.pipo.sk>
References: <20191011085027.28606-1-armbru@redhat.com>
 <20191011085027.28606-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20191011085027.28606-2-armbru@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 09:07:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 10:50:24 +0200, Markus Armbruster wrote:
> Command and event details are indented three spaces, everything else
> four.  Messed up in commit 156402e5042.  Use four spaces consistently.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/qapi-schema/doc-good.out         |  4 +-
>  tests/qapi-schema/event-case.out       |  2 +-
>  tests/qapi-schema/indented-expr.out    |  4 +-
>  tests/qapi-schema/qapi-schema-test.out | 52 +++++++++++++-------------
>  tests/qapi-schema/test-qapi.py         |  4 +-
>  5 files changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Peter Krempa <pkrempa@redhat.com>

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl2gRl4ACgkQHGwCByjY
1Gp3XBAA1ZHRIDyIrFX3pR8NYu5snX3UUfWF4KPkIrUAPbNej+kO7ShbByfJ/IiE
olh9lsEHxv52kOcbfZ/JzPU4EvHTb3vk2HbqoDkRk7PnHhbqXYlUvTcOhiZGBHT5
kdd6sW7A55AObDKJQl+P4oCXVoKDWwfhhRFj1mxi/JvjvBy6Z6VXiZbBUP5xuORr
umZvOX8X2dFHqIGiUXpEea3LhMitxmARbBNjm3oGJUr6A8zKsLPv/L1wctunOLd/
kpRwJMBWn9pUQf1+EnMhpEP/6RcMj+WW0jmSZPTzjMkv2lie/wMGXw8rR5CM3b3m
Qmtn04ckq01ubnvLozyINwDTvI9EulG7/lB33kvgVfd2EsCJNClaeDNkSsSt9kGq
BlrkVYxEzA1fD9eFCxDMs9gl8tKzNfrF4WwmXGXko+hBvupbTePmAxE6Qy8JSDHb
GepKxrRKCPQaYvsG8S6Yohn5XDpy5rNaYXxoZU51+2mg4SkFfX5Sgi/B6C0omU0x
URewmkvVIsGpfch5200nzalQWwXbLfYLoHOsF3lSVNAQwN4fcp7f/xBMtUDNAgHb
6D4fv0hbwFioFmyxmrWRrFn8rwusXmUx2JzcpQZKoC7kJkg2rYRpbW1aW+xoZHdz
DpNlFCQZm3uzPaKoK0vzuQ4s0JDZW9IrBneMnj1taOimteek67E=
=RvIG
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

