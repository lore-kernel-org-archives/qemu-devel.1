Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AAC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18F3214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyTe9FTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18F3214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLDNt-0003lv-Mq
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 18:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDNF-0003Jx-UC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDND-0004a7-Ho
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600900586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wBIbgvyQnP/n/xY/eYmk66gIrD6/qCHuQSf5nV2i0ec=;
 b=KyTe9FTdu0nVDAFjCEsGSfcXbRHiZ/FvpiGgfnmhIshSooNTsirdSKMnBMPcaBb3z5cgoF
 x1d6Y85HdJ6JuxKJhionQoB+6/t2Fq41dKU7apilu2/9NrhJvYNnq9+UhUSZLCb1Rkz8+j
 Da4rKyEZd6CLt0XmPvEZDxBBe4t4w7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-ktknTW3aPp2Gtwa-mi_iOg-1; Wed, 23 Sep 2020 18:36:23 -0400
X-MC-Unique: ktknTW3aPp2Gtwa-mi_iOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54056800135;
 Wed, 23 Sep 2020 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8287160BF1;
 Wed, 23 Sep 2020 22:36:21 +0000 (UTC)
Date: Wed, 23 Sep 2020 18:36:19 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 22/38] qapi/source.py: add type hint annotations
Message-ID: <20200923223619.GV191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-23-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-23-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aKl9HDSa9q6Cj3fk"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--aKl9HDSa9q6Cj3fk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:45PM -0400, John Snow wrote:
> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/mypy.ini  |  5 -----
>  scripts/qapi/source.py | 31 ++++++++++++++++++-------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> index 9da1dccef4..43c8bd1973 100644
> --- a/scripts/qapi/mypy.ini
> +++ b/scripts/qapi/mypy.ini
> @@ -39,11 +39,6 @@ disallow_untyped_defs =3D False
>  disallow_incomplete_defs =3D False
>  check_untyped_defs =3D False
> =20
> -[mypy-qapi.source]
> -disallow_untyped_defs =3D False
> -disallow_incomplete_defs =3D False
> -check_untyped_defs =3D False
> -

This is what I meant in my comment in the previous patch.  It looks
like a mix of commit grannurality styles.  Not a blocker though.

>  [mypy-qapi.types]
>  disallow_untyped_defs =3D False
>  disallow_incomplete_defs =3D False
> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> index e97b9a8e15..1cc6a5b82d 100644
> --- a/scripts/qapi/source.py
> +++ b/scripts/qapi/source.py
> @@ -11,37 +11,42 @@
> =20
>  import copy
>  import sys
> +from typing import List, Optional, TypeVar
> =20
> =20
>  class QAPISchemaPragma:
> -    def __init__(self):
> +    def __init__(self) -> None:

I don't follow the reason for typing this...

>          # Are documentation comments required?
>          self.doc_required =3D False
>          # Whitelist of commands allowed to return a non-dictionary
> -        self.returns_whitelist =3D []
> +        self.returns_whitelist: List[str] =3D []
>          # Whitelist of entities allowed to violate case conventions
> -        self.name_case_whitelist =3D []
> +        self.name_case_whitelist: List[str] =3D []
> =20
> =20
>  class QAPISourceInfo:
> -    def __init__(self, fname, line, parent):
> +    T =3D TypeVar('T', bound=3D'QAPISourceInfo')
> +
> +    def __init__(self: T, fname: str, line: int, parent: Optional[T]):

And not this... to tune my review approach, should I assume that this
series intends to add complete type hints or not?

- Cleber.

--aKl9HDSa9q6Cj3fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rzeEACgkQZX6NM6Xy
CfO5NhAArxww6oa+vS3w4pXga4i4JXGkTMwQdSnIWzPbVwEeA/fO45oVuemBw84t
TsYPc1KHWN/JsV2SMXJLCQiHugVnyBr8hAoKLwCfWJqaWahyuFRSURRziteKUiaQ
p5vrrEfWKs5nED79u8HB9GLk8aAD663N7+Fd+DkaBLPA2W+OAI4R5dPr28bUSqfB
KNqW2NhAijNzhGEYWgShxiVD+NFJ7zV2kTfVzHgzbNt5hkgRBSDBFYvhZNxTs7bh
nsJ2ubuzdM445f49BLJIthYhKBvm5xSyO8Z1cPdduROmPssI/waD0HoXimIdXa3N
iM815RF98Pw2xH4bH1LYYP/+a0LYs7XtdKtQmvUN7nOaGjm4bKkfhuA2PgRtgTxY
Fw3npqJ63U8/mlsa45cAkT8DjjNQMaYtebRjevc3kvQ1eNYssXY62OE51WlUF9iN
hKFMIELGnf65gmYblUk+Ps8JMS/cubmM4jD8BucMGPm4IdNstfTdg04VQq9MiD1l
W3mOH+4/qJnOG8zMjpmdSj8LgIlJt94dcLXhHy5FBviLRuLBSviK2QF3LjFiJBUx
/2i727/Osk4LtBuHl/IuZK4jxhEfVdwu8T2OvKH4IZcvPIPWFv8g5DpMZkOERmeV
F3pgHsrGPfbcsGxC5Xq16YcYoL1Xb6Lk8d1r5IUgSImilNkNd1A=
=iThP
-----END PGP SIGNATURE-----

--aKl9HDSa9q6Cj3fk--


