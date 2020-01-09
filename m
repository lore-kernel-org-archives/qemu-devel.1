Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93576C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4C820673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXiwOobR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4C820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVCn-0005DW-IE
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ipVC6-0004Bt-QM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ipVC5-0006Ne-IB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:37:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ipVC5-0006Kz-CA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578566256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz3V6GPkOd/TM8+8UbksdokcQJFlvScWAfjd9vMDEBE=;
 b=LXiwOobREb39V3+L2hxogs40DUDIjfM7P9DXNv4AsE8XvJzTU0ToQqiNMuFJzXT+xaCAo6
 TfuCfY1qeUHEAb78V1qBYoQW7/6ZYyTQk7IkbkzfyvYvG3koHJzgZ3jVu5+w0qRqoXHa7w
 bkf1/rhvrYh/a9y7W6eqVMRqj7hJi28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-gna8fdNrObS-sxG5U9b90w-1; Thu, 09 Jan 2020 05:37:33 -0500
X-MC-Unique: gna8fdNrObS-sxG5U9b90w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 635BB10054E3;
 Thu,  9 Jan 2020 10:37:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3A9F5C21A;
 Thu,  9 Jan 2020 10:37:31 +0000 (UTC)
Date: Thu, 9 Jan 2020 10:37:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] luks: add qemu-img measure support
Message-ID: <20200109103730.GC508720@stefanha-x1.localdomain>
References: <20200108112220.499180-1-stefanha@redhat.com>
 <157848576808.3775.16003679946263305504@37313f22b938>
MIME-Version: 1.0
In-Reply-To: <157848576808.3775.16003679946263305504@37313f22b938>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 04:16:09AM -0800, no-reply@patchew.org wrote:
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #! /bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-mingw@fedora J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   CC      io/channel-websock.o
>   CC      io/channel-util.o
> /tmp/qemu-test/src/block/crypto.c: In function 'block_crypto_measure':
> /tmp/qemu-test/src/block/crypto.c:573:60: error: passing argument 3 of 'b=
lock_crypto_calculate_payload_offset' from incompatible pointer type [-Werr=
or=3Dincompatible-pointer-types]
>      if (!block_crypto_calculate_payload_offset(opts, NULL, &luks_payload=
_size,
>                                                             ^~~~~~~~~~~~~=
~~~~~
> /tmp/qemu-test/src/block/crypto.c:211:52: note: expected 'size_t *' {aka =
'unsigned int *'} but argument is of type 'uint64_t *' {aka 'long long unsi=
gned int *'}
>                                             size_t *len,
>                                             ~~~~~~~~^~~

Will fix in v2.

Stefan

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4XAmoACgkQnKSrs4Gr
c8g5XggAwix7g4OXNLN17GjOJwLdu/jCnH5EQaWwW0mNCv/Pllssub/NjNpShfja
jIzPwNuBDqw9bEx3fIQSjimWV9VKZ5uuRVQF66mnsv9jRIFC4NVbc5r8PiDIHFuV
wkuoHF0QZxlMOZKGukRdepNtVAslbc/nrhCAPHsC1p2t7ZbiDC1YMGXvRs/kKhgZ
PCxO0fOF19P5qsfu918ZhGwBWzgQuPT3RXOUU8HxwOdDVZJQ0W5CJY/4jp6tU6X4
n9J3ubPas4l4gS/Mq/79XarRePUGTt5fF2iGi2NXVYgOaj2HsOu0PZ7tLoGOqr41
3Mro0UQ2IzaZAUzheRg+xOjnHyCzIg==
=KjZE
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--


