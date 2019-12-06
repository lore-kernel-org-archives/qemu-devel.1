Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6B8C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D9B206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVO+Nums"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D9B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHMq-0007zP-Li
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idGgU-0004dE-0A
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idGgR-0004K7-6K
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:42:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idGgO-0004FW-UH
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575650539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4QGPSZ/B6TzVKwVMxkQqB/fk+DVNUKRRUL+Cb9NeOg4=;
 b=eVO+NumsM/3lbzaS2hvtR8gcZA4nfWyVTYJu10oO0UygO218JV0xD6N2+RuwDwCLJP3PRf
 Kw6IOUfukucYDye8i/ElPaQuTssHY3tDp4zmZDFgR+pcTgi/wbEAaoFD1O/VWCZUnXd3Fl
 sl4M+/n8P+YZbczli5iM8nG6tUIuCs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-3j-N2RgbOq2OLx8qbvu8xA-1; Fri, 06 Dec 2019 11:42:16 -0500
X-MC-Unique: 3j-N2RgbOq2OLx8qbvu8xA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5601005502;
 Fri,  6 Dec 2019 16:42:15 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA3EB60166;
 Fri,  6 Dec 2019 16:42:06 +0000 (UTC)
Date: Fri, 6 Dec 2019 11:42:04 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 0/2] tests/acceptance: Add boot vmlinux test
Message-ID: <20191206164204.GB23522@dhcp-17-72.bos.redhat.com>
References: <20191206140012.15517-1-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206140012.15517-1-wainersm@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 wrampazz@redhat.com, philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 09:00:10AM -0500, Wainer dos Santos Moschetta wrote=
:
> This series add a new acceptance test: boot an uncompressed
> Linux kernel built with CONFIG_PVH, so checking the PVH
> capability introduced in QEMU 4.0 works.
>=20
> The test implementation depends on [1] which is likely released
> on next Avocado. So that will need a version 2 of this
> series to bump Avocado version.
>

Right, the Avocado bits have been merged, so unless a major reversal
comes (not expected at all), it will be on Avocado 74.0.

> Also I want to use this as an example of a scenario that test
> assets could be better managed. As you see on patch 01 the
> kernel is built at test time on localhost. While Avocado provides
> an API to easily fetch and build it, the whole process takes
> reasonable time - besides the fact that localhost must have
> all build dependencies installed. How could it be done better?
>

This is clearly not a "kernel build" test, so we should avoid building
the kernel as part of the "PVH boot" test.  The problem you expose
here is a very real, and each possible solution has its own problems,
unfortunately.

The best solution IMO would be to find a "well known" distribution of
such a kernel.  Maybe something maintained by the Xen project or one
of its commercial products?

The second best solution is to have a helper script (using the Avocado
utils API is fine) that will build a kernel and create/populate the
test's data directory (tests/acceptance/pvh.py.data/) with a vmlinux.
The test can cancel itself if it doesn't find a kernel there.

The third best solution IMO is for this test to require a parameter
telling where the CONFIG_PVH enabled vmlinux kernel image is.

Also notice that, with a custom built kernel image (a different one
for each user), the result of the test as a general indicator to the
QEMU codebase diminishes quite a bit.

> Nonetheless I argue in favor of merging this as is, and
> gradually implement corrections to improve the tests assets
> management. Also if eventually the test is proven to unacceptable
> slow down the Travis CI then I can add a guard to skip it.
>

I'm pretty sure that building the kernel will cause a major slow down
of the Travis CI results for the "acceptance" block (and thus for the
overall results).  But, it may also time it out (there's a 50 minutes
deadline).

I hope this brings some ideas, and thanks for coming up with
interesting problems! :)

- Cleber.

> [1] https://github.com/avocado-framework/avocado/pull/3389
>=20
> Wainer dos Santos Moschetta (2):
>   tests/acceptance: Add PVH boot test
>   .travis.yml: Add kernel build deps for acceptance tests
>=20
>  .travis.yml             |  2 ++
>  tests/acceptance/pvh.py | 48 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 tests/acceptance/pvh.py
>=20
> --=20
> 2.21.0
>=20

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qhNkACgkQZX6NM6Xy
CfNRpw/+I+ErYvf5xwumQBWpLg3BhLNcUhVP/rJ/VFjc2de4yxQ5/8ZMEfrpyHZ7
Ou3dkTIFRRScY7Np+wqXbnI24lCLbXRrSgX2ZRLHIdRApHpbgzCJrnYSyP1VJdJN
QLUvS0Wtk5w1ZTIibyOMOTizlDTc4ijmsGxCyhyV1b4vnJBPplxfZ+gTTCG81bZw
jqTdmogClZFkEWMsMO48FLZWvlt2hczTl2MkTEZvsE3BG8JFMiZtklYFq00nDMuM
Zc5cyUv3+V2d3duZYDLsox2h/OEM48XUG7AusTGQkVH5i5I2laphSe9UO8Nx+MtS
o5JOUrALXStoyk6rSlXyQS433GF8YTDDX0mbEKH0uh6fZz/SJcQzsYLAYZ9pSjkv
QM4i0WgrtTFrVxxPvY8qFdnL0OjY8kgyIv/8/RHmeol89jlq8OejfqncWwFTuVOr
+T2UW+7I0h8Lei3+Mkid2yoqT3KLKo/OBsLqpJJjHLKCKrUHPK0v1aOi5hzS6S7K
OKjrBnyuXKPmy+LiwmN/duI9454WRmRID5+UJM10FSwrSmrGMnK4a8FHl11KXUf7
F1OcwDHZ9LfDN56y8WEP7w3pKjOZLIYlUkYG8INDll+tKYVYqSHV+xHqCctaAFvH
uVrTzSjt66oCn4/m/gwTD9zO4erI3Mn3/XQ9rRrzpGIfdDuXIV4=
=qVh6
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--


