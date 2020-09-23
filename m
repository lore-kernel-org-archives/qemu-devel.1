Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D924FC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9AC20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0uAugsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9AC20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLD9s-0000Lb-8O
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 18:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLD8j-0008Fu-M5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLD8h-00031z-Pk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600899686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2RpIWhQpqJc2soO2H4yxHK21Ja3uZCmQgbiNMjukV8=;
 b=F0uAugsfymj+4LDa+nUwdFpd8LOb9VnMREnqcBkS6a3tntzZvdVyZiO+ag9Ujx3FNCg7qi
 nqkjI5OLNmwSp0zR6odR3iNLQHo3ZHVWcAUPDcT4Is5qiQO+FjbbfXL2KUCqgGWsheFx5W
 EKYhposAayALJqipyCKF0RMMtadqW9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-okXbFX97NNKHP50VplnmEg-1; Wed, 23 Sep 2020 18:21:22 -0400
X-MC-Unique: okXbFX97NNKHP50VplnmEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96CAF801AF7;
 Wed, 23 Sep 2020 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF6C719728;
 Wed, 23 Sep 2020 22:21:20 +0000 (UTC)
Date: Wed, 23 Sep 2020 18:21:18 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 21/38] qapi/commands.py: enable checking with mypy
Message-ID: <20200923222118.GU191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-22-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-22-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NHfequSh1hmJPP0s"
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

--NHfequSh1hmJPP0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:44PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/mypy.ini | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> index b668776d94..9da1dccef4 100644
> --- a/scripts/qapi/mypy.ini
> +++ b/scripts/qapi/mypy.ini
> @@ -4,11 +4,6 @@ strict_optional =3D False
>  disallow_untyped_calls =3D False
>  python_version =3D 3.6
> =20
> -[mypy-qapi.commands]
> -disallow_untyped_defs =3D False
> -disallow_incomplete_defs =3D False
> -check_untyped_defs =3D False
> -
>  [mypy-qapi.doc]
>  disallow_subclassing_any =3D False
>  disallow_untyped_defs =3D False
> --=20
> 2.26.2
>=20

IMO, this increase of strictness for "commands" would make more sense
to be squashed together with the previous changes on "commands.py".
Not only here, but for the other patches for the other modules too.

Anyway,

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--NHfequSh1hmJPP0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ryl4ACgkQZX6NM6Xy
CfPqMA//ZKZWtUDHn0GgZK7qXZTc/0WfwADrvjlgRNqoSXKdPSX+6tQMQhOCH7Av
2dTv2PAN8UlrokfSXp/JnS5bv0cnM/7gYKZg/VQ5UJF7NmTsDI9fkquw4eMmWuQF
zrcSK9WqBcUSeyugohdAGxWx1awD2549tJRok/CWbBFADSU+6F2T37a9Efmw3EAF
gEavSKkIQFD0c6eouH03lLbxKjEKUOvN13AfAZsH7MrfNIrqmIDOtYj/lkvjkBqM
gx5aAI4YVSwd5+PCLgVFW8Nu78i94dbxODPMV2Shd749h+wu6PTTv5y5SPoTmoAO
bwJB8GJ92rEnjPZwFimY8h2Q+2iY6EIVdTnLbLu351WJutrW82OBhrT58GNsGpWT
LBQaE9IWJMAIydOyCF/ZCTXvqATEMb7ZZx1zl0i4t3EVmFAjS2ZR/WqmSHn57G3I
o/jyQihpKpDWVNQ+eMkIj9CiazLYz0GoZyTFtQ9zjUwOs6JUyTMNbrEzUdnKtPiO
g8pSHUeNj5Ho+bg4spyXNtAbhR4ekCNIvsinSvd5sDcDKXK1ibY3GioZ7eQQFvyW
3ZegctMSTZmcQjq9COSl+GbmylOinmdv4cGtdutx4Y/O2TvcC1tydO0zCL0ZWhdj
wUsav5McITsGcOEzj89U33cih9GrQB6X5j3QsXQ09zq9hl7Za1A=
=7W2C
-----END PGP SIGNATURE-----

--NHfequSh1hmJPP0s--


