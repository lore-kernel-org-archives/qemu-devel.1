Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37268C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E25B238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKgsOwy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E25B238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbFa-0002R9-ES
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbEj-0001w9-VY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbEh-0005yb-1C
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:05:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600992313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EwQEEkKF1JGGQlyw0QlQcO5QEARn0NVIGNgFR2X8uU4=;
 b=bKgsOwy+sDN+S4oUk/Lh3iJ6vVw3vbDV6avOpaDmtECPjMw3jHGYG7ZbeqlA0qRT3mUaLS
 N63cjPOyf4k+RApI4xWTDfN1nPWjVLWSTvN/2IYypYHwVuCslaVTCyarOdLZQ112nYHNqo
 KLUiDNb+W+NO20hTIbUEb4hVDoy8Euw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-iZWWOus3MJivRWFoBeGULA-1; Thu, 24 Sep 2020 20:05:10 -0400
X-MC-Unique: iZWWOus3MJivRWFoBeGULA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA3088015A5;
 Fri, 25 Sep 2020 00:05:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5A8E5C1C7;
 Fri, 25 Sep 2020 00:05:08 +0000 (UTC)
Date: Thu, 24 Sep 2020 20:05:07 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 03/16] qapi/expr.py: constrain incoming expression types
Message-ID: <20200925000507.GE347918@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-4-jsnow@redhat.com>
 <20200923194224.GD3312949@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200923194224.GD3312949@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 03:42:24PM -0400, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:13:00PM -0400, John Snow wrote:
> > mypy does not know the types of values stored in Dicts that masquerade
> > as objects. Help the type checker out by constraining the type.
> >=20
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/expr.py | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> > index 1872a8a3cc..f6b55a87c1 100644
> > --- a/scripts/qapi/expr.py
> > +++ b/scripts/qapi/expr.py
> > @@ -15,9 +15,17 @@
> >  # See the COPYING file in the top-level directory.
> > =20
> >  import re
> > +from typing import MutableMapping, Optional
> > =20
> >  from .common import c_name
> >  from .error import QAPISemError
> > +from .parser import QAPIDoc
> > +from .source import QAPISourceInfo
> > +
> > +
> > +# Expressions in their raw form are JSON-like structures with arbitrar=
y forms.
> > +# Minimally, their top-level form must be a mapping of strings to valu=
es.
> > +Expression =3D MutableMapping[str, object]
> > =20
> > =20
> >  # Names must be letters, numbers, -, and _.  They must start with lett=
er,
> > @@ -280,9 +288,20 @@ def check_event(expr, info):
> > =20
> >  def check_exprs(exprs):
> >      for expr_elem in exprs:
> > -        expr =3D expr_elem['expr']
> > -        info =3D expr_elem['info']
> > -        doc =3D expr_elem.get('doc')
> > +        # Expression
> > +        assert isinstance(expr_elem['expr'], dict)
> > +        expr: Expression =3D expr_elem['expr']
> > +        for key in expr.keys():
> > +            assert isinstance(key, str)
>=20
> mypy doesn't seem to require the key type asserts, on my testing.
>

Do you mean that mypy actually takes notice of the type assert?  And
includes that as source of information for the type check or am I
misinterpreting you?

BTW, what I understood from this assert is that a more specific
type than the MutableMapping is desirable here.  Did I get that
right John?

- Cleber.

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tNDAACgkQZX6NM6Xy
CfNrJxAAvqhsqFyfK5t/MbTw/g/Gq+MmTrSQI7y12E2oO9Uh5+9MkVcKQTldMgI9
wMEWmB6w4y1BuxpVELuqGotyiYa+CFAllJMQWzvHFLyl0LH3U4E2u7h/7cCBKCgy
BBIDDjnM2uS3u8Jjh24qXXKKmPpN86Y1dyiNnisoc6TO22XRWU3DPa+iXVqHr0ki
HclVRzPSHR1YKTpsq0MEnESsGPUv/wskOWh2ozWQK+bqXmEln0dpxztWN3ogGlrd
6BIIdRqLUCmGb83P8DJnh9Jj0wjiWtmac8CokkLfv+0WRTmF8epxIeYVWPfYwfWx
d7PzbpdOdG9NU/PMF5wqS3r/WHZfVdGJyCgu/2L5//xHf2hnntBSAdsZkxXWBnOv
uj1qHAiZztIXIiGZtbeG07Ul3kP00PI1PtlgJr7GiAuPu8edjEvL9WLjQMLBf0mX
oaOmkrFLqLOwax5imoY7Oc93jexoFCVm1U5su+gqsV3RYLnZdnSUWhkfg01E4Pqv
8qLzADEF/MYK0JC+6Avrl68z0JA1cxfJBYLx73JEJcM9Qj5Oey159IuJmot9ahea
ScMcjlZh/ZGXtb6HdNdssLOE2g7aZjXWUzrN7v9uxmCZkr+RxPo6Hf/yUGj5Ln5/
Pv5BD45X///pc7Eds+OnOvF0QxUh+4lRRpUY/IrrTrrzPnXQFFA=
=Wfpa
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--


