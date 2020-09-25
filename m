Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6082C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3520C2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlAxCIot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLc8D-0006Ag-8k
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbdw-00024T-QQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbdt-0000Yv-N3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:31:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KlbSagAU6+h/mKQslrnw8AEXM+WEO2y97b7b1fgJXbI=;
 b=ZlAxCIot1GzUhOYbjKrq6JS2r8H6EA7htMfCOC110Q++63A387KaJJb3Bo3yBZA5sIwlBI
 2m8h4Wwj7S2PxWB6nkbjkFXY7Nazajr7DcdAYNiuKsu0W+QfNz7L4kfeMWoOOprM6ZUVjp
 1B0e7XB09X4pZXh0LIdW8dcE4Pm4vww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-DZx66z2APPen-8Us4SMauQ-1; Thu, 24 Sep 2020 20:31:06 -0400
X-MC-Unique: DZx66z2APPen-8Us4SMauQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 889131009443;
 Fri, 25 Sep 2020 00:31:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEBFC60C15;
 Fri, 25 Sep 2020 00:31:04 +0000 (UTC)
Date: Thu, 24 Sep 2020 20:31:02 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/16] qapi/expr.py: Check type of 'data' member
Message-ID: <20200925003102.GI347918@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-7-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-7-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:03PM -0400, John Snow wrote:
> Iterating over the members of data isn't going to work if it's not some
> form of dict anyway, but for type safety, formalize it.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/expr.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 3f5af5f5e4..633f9b9172 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -247,6 +247,9 @@ def check_union(expr, info):
>              raise QAPISemError(info, "'discriminator' requires 'base'")
>          check_name_is_str(discriminator, info, "'discriminator'")
> =20
> +    if not isinstance(members, dict):
> +        raise QAPISemError(info, "'data' must be an object")
> +

Don't you mean "must be a dict" ?

>      for (key, value) in members.items():
>          source =3D "'data' member '%s'" % key
>          check_name_str(key, info, source)
> @@ -260,6 +263,10 @@ def check_alternate(expr, info):
> =20
>      if not members:
>          raise QAPISemError(info, "'data' must not be empty")
> +
> +    if not isinstance(members, dict):
> +        raise QAPISemError(info, "'data' must be an object")
> +

Same here?

- Cleber.

>      for (key, value) in members.items():
>          source =3D "'data' member '%s'" % key
>          check_name_str(key, info, source)
> --=20
> 2.26.2
>=20

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tOkQACgkQZX6NM6Xy
CfNy4Q//Zx/jsPrOKp/bYl3MqfTwuOMC/kTTaykgACWxodA5pLu1H5wVzhmrOjLf
KnGTWrPdjHeP486MxoZ2RRRGfleLyCzYHaKXdR1x+L75dBm1aWgmN93b5cwNyU7T
nO7f4lTHuPu2ULPVRGfgULN7yZXNB66f2KfvMCnQe+VTav7wOjOcYVmszYWZed1K
KyZF9HsGB8/wo1WzLhLca2btdoec71iNddCxc5uHDP8XNLFnQuj8vOiaebJBowKY
YE169CmPa3z/srT7GbZmtvDsLyuYJ7dasgptCcFCIgkil09GSL6TO5ENW3gi6yLc
9W6natuG4kPXV7S2Xv7vX77Dqvh5UMFmVFnFuVkR4t+CfbU5E5hN5j0MkXWjgmIW
zQu+wFcSxiKGrMBWFlfpKFGY6HPwRLsRWqGDJB80k8f55yNa3qeUmwUDQTa6Fshi
NuuCWl3/erSyAanuA5cp8KASAiQHawMCgUFD6gQRR9VQpf7w9yuFqApYX3e8ftPX
k1EX1EVucr4oSLfsxO0rhW4wQwKsGetDZhzMM6pKAUYIzlPEVZhpD4X0CjfZQk6O
9cYIboevA4HRPlxAE9Znij/HO+cCzh6HsfZqZJjkRTVa4/qh1RA2qZvDFyw8U30N
r7QoVJWkotjTtVc2BF0IvHrkhEHSO58hVHAQ4q0UAWwa+rWsYZQ=
=CuAp
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--


