Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E277BC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722D8206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5X36a9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722D8206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLEgd-0001Qd-Hs
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 20:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLEfY-0000zL-Lw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLEfX-0004sL-2A
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600905565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5fPlkLx6EmVMzXwhtB8IDCIXfOtdcK95qoIFIAA0Uw=;
 b=J5X36a9Gon9WDOMnqJwRlGhyfbyw/peVyDSjaSRLFe8IBxwWkIu28keWllkFaJEQHz9d6m
 eM5aHnBnUR/HSKnkvKJ4ycXlS1l9818gzdXmgQOZZqWBh1Q+yigL3Rci19hom1//AavUyN
 aj1NMpbleyXxAcTOI8dVISbilEiYVeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-70XBJbtxOuCBO1wdk68dyg-1; Wed, 23 Sep 2020 19:59:20 -0400
X-MC-Unique: 70XBJbtxOuCBO1wdk68dyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5E61801AF7;
 Wed, 23 Sep 2020 23:59:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D32A81974D;
 Wed, 23 Sep 2020 23:59:18 +0000 (UTC)
Date: Wed, 23 Sep 2020 19:59:17 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 26/38] qapi/gen.py: Enable checking with mypy
Message-ID: <20200923235917.GA191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-27-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-27-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TuBLotoxjxNtqonL"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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

--TuBLotoxjxNtqonL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:49PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/mypy.ini | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> index 43c8bd1973..dbfeda748c 100644
> --- a/scripts/qapi/mypy.ini
> +++ b/scripts/qapi/mypy.ini
> @@ -19,11 +19,6 @@ disallow_untyped_defs =3D False
>  disallow_incomplete_defs =3D False
>  check_untyped_defs =3D False
> =20
> -[mypy-qapi.gen]
> -disallow_untyped_defs =3D False
> -disallow_incomplete_defs =3D False
> -check_untyped_defs =3D False
> -
>  [mypy-qapi.introspect]
>  disallow_untyped_defs =3D False
>  disallow_incomplete_defs =3D False
> --=20
> 2.26.2
>=20

Like I mentioned before, I'd squash this together with the actual
changes that enable this increased coverage.

Anyway,

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--TuBLotoxjxNtqonL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9r4VIACgkQZX6NM6Xy
CfNrUw//WGWuVk4omq8L+PiAOVPVHqxWMGJQq+ecxMePJnjjpRG4XWLJ9nQzG38a
PT5XijZ6XMWt4dG/niqPCNYCeZcb5aSs0vSW46uW8BDRi4YLyRQ0azWyQ5gfbkwN
3F34tQql1vo9PqDY9D6tqDYLNX+FeLEp2ngLWvq/vwvtVv9Q1qOUZg01Tk6Q/Gty
2Wk1qMFBJQF3T4JkEqOEwac3leRSoiMmM1UA6lgpPOe0g52lszoNQLvbZ8Wh3lPC
UTrm8SquYDmTaAWcY3AtLvEvTziVYSZlILVC0u9wCI2MTjpSiDYWKZVRWfP4XiMk
MR1wcmptcTW9oIDelAy8onBqT1Vt+N3mGqgqAghc5C7TtbjlERJv98t+7HxE+DCq
iv5PVmWzfWuWOtR9C8vUpN+tJxb0RRoR/vZxWKNKMfqblZLSvFZv1nN8sP2nV7Vd
fJlDHnJfgAQzMcHUoVPW0HwgKdi3Haq1+lA5U3kU9WozB+wwjrpqPpZfQtwyVvx1
JJxxcx4ZmJcjqfpC/nGkrUg9dL1p7cAT1w/MHShjaGZLIilkktNwKBiFJ8ACpN5L
IUfu+RTd4Ehpm15R7WRu1mfUOpKzLtCkF91Z7gjE7+eHIF/4BYYceB9/fkdq5MbB
+9r39CrKzGh1b3IehklcHDYTGmFDz7Yq7V+p190HJyHjbCE+w20=
=FsJe
-----END PGP SIGNATURE-----

--TuBLotoxjxNtqonL--


