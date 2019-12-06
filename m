Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899812173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gam2MXLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899812173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJXL-0004V3-LI
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idJVp-0003Vr-K0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idJVo-0008Vd-3w
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:43:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idJVn-0008Qr-SZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575661414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lwDPJdeVukC/Zy+MU39YGqgOXUqmL18SE/F5bkiXv58=;
 b=Gam2MXLDHKfUoeD1UuiNyoLlc4aHSxIPad8LCWWlR0eQTiAVsGrH67XXpiRJP4Ok2YiKHO
 jlK48/Ufuf+uba7k2pvh2jnPnT9DYul8z/kIxQa9OsaOsa/LBAsqV1vRENQnYRFxOX3yJM
 xRaQ+TdfbttUKzVawy2oi7qVtc4oO5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-a4bVArL7P4eJk67924P6AQ-1; Fri, 06 Dec 2019 14:43:33 -0500
X-MC-Unique: a4bVArL7P4eJk67924P6AQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921201005502;
 Fri,  6 Dec 2019 19:43:31 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBE341CB;
 Fri,  6 Dec 2019 19:43:27 +0000 (UTC)
Date: Fri, 6 Dec 2019 14:43:25 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0 v2 0/3] benchmark util
Message-ID: <20191206194325.GB6252@dhcp-17-72.bos.redhat.com>
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191126154848.193407-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
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
Cc: kwolf@redhat.com, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@gmail.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2019 at 06:48:45PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> Here is simple benchmarking utility, to generate performance
> comparison tables, like the following:
>=20
> ----------  -------------  -------------  -------------
>             backup-1       backup-2       mirror
> ssd -> ssd  0.43 +- 0.00   4.48 +- 0.06   4.38 +- 0.02
> ssd -> hdd  10.60 +- 0.08  10.69 +- 0.18  10.57 +- 0.05
> ssd -> nbd  33.81 +- 0.37  10.67 +- 0.17  10.07 +- 0.07
> ----------  -------------  -------------  -------------
>=20
> This is a v2, as v1 was inside
>  "[RFC 00/24] backup performance: block_status + async"
>=20
> I'll use this benchmark in other series, hope someone
> will like it.
>=20
> Vladimir Sementsov-Ogievskiy (3):
>   python: add simplebench.py
>   python: add qemu/bench_block_job.py
>   python: add example usage of simplebench
>=20
>  python/bench-example.py        |  80 +++++++++++++++++++++
>  python/qemu/bench_block_job.py | 115 +++++++++++++++++++++++++++++
>  python/simplebench.py          | 128 +++++++++++++++++++++++++++++++++
>  3 files changed, 323 insertions(+)
>  create mode 100644 python/bench-example.py
>  create mode 100755 python/qemu/bench_block_job.py
>  create mode 100644 python/simplebench.py
>=20
> --=20
> 2.18.0
>=20

Hi Vladimir,

This looks interesting.

Do you think the execution of "test cases" in an "environment" are a
generic enough concept that could be reused (or reuse other system)?
My point is that it'd be nice to do the same thing say for the
acceptance tests, or any tests for that matter.  For instance, for
known parameters, we could record what's the time difference between
booting a guest with q35 or pc machine types and virtio-block or
virtio-scsi devices.

BTW, This reminded me of a IOzone[1] test runner / results analyzer:

  https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master=
/io/disk/iozone.py

I'm also cc'ing Luk=C3=A1=C5=A1 Doktor, who has actively worked in somethin=
g
similar.

Cheers,
- Cleber.

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qr1sACgkQZX6NM6Xy
CfPCWhAAmOMKZLdDzT8pxFP1vcIetz9IuXySMO1ZNvyKMO/6eOVcxas/BGrhbagz
RA+Ig6H03mFi5GXGDpiEmJ+yfkGdtZxCMLa5Y3UFr1zUoEh0GN6oZ8tRwYg1uL4H
uu3RNNrXt1KUvIYF9tWypkj36zFqGIrRjmZXXKXFvooXic8z+oQZLk8ZLM2UNZUs
/pOTZNdLOhIL8UIeGR4s14qc8ELPbf6V2wQsjHkP0aLuepRMpSzdRdn/TCS33eIM
FFsXPA0MUhHnLcb40CX8EwxqVjIlEkUQEDozcKdgdXwMtxoI2So7HOhURwtfcgeV
3li6HYaj0f83fwtvphMYB2vAfOBiE3FxB+zPejiygXeWG/+uEHguUV/EquSXt4FF
Upb+V9KSRjyhWindhLRJrsDVaq/ssNRKC5Y24Ld6zAeHLsnQHapOram20ri+m/xi
yazLRwx0dgmxPKjixz/yb8pTgMA79IxNdRd+YBwqrLvAsNEYD9U9+wPY1S+D9z7P
cg7pMrFQMBsi98YjJuKABIBnqdSs9B9r2U0Wma1nRVLXoe6Hyn1MZxNVIYpNovJh
wJeGu/CYD7XfDVOi7UrgztJEWFrb5My4zqxZnvhIq0oeEzFlL6vi6UuYxS7mWMHW
1ODvHlxtfivTI2KcDe7jsadVye9jcSc/ZD4AsfjJBtXMXbdkKuI=
=XuKn
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--


