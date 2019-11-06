Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE52C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DC62173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmJ/3jzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DC62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSHZB-0008Hu-T3
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 04:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSHYA-0007lK-Q4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSHY9-0002FB-D8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:24:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSHY9-0002Et-6x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573032264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7UmAtda7wHyR/lZkqt6PoHAFAJXG6HU+pdLp0tNC/0=;
 b=EmJ/3jzhbYVtuU2t5fHiIBhaydfU+DAMHTJNvASlfsVwLav+NQzFPRYeL4CASn69G9knYd
 rbwa/OU0IqiseLEgbl3gYRLbl/fOWeUNCPpzvYPlnKGC9lpvE1NTYrwFHAqGMw21738+pH
 SoGK9EbGPYrKx/lwRljdzKKyTkqL4Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-lEknen74PPejOlnTSqy2Zw-1; Wed, 06 Nov 2019 04:24:21 -0500
X-MC-Unique: lEknen74PPejOlnTSqy2Zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E47A21005502;
 Wed,  6 Nov 2019 09:24:19 +0000 (UTC)
Received: from localhost (ovpn-116-171.ams2.redhat.com [10.36.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8009F600C4;
 Wed,  6 Nov 2019 09:24:13 +0000 (UTC)
Date: Wed, 6 Nov 2019 10:24:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 4/4] iotests: add test for virtio-scsi and virtio-blk
 machine type settings
Message-ID: <20191106092412.GH189998@stefanha-x1.localdomain>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-5-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191105161105.19016-5-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2019 at 07:11:05PM +0300, Denis Plotnikov wrote:
> It tests proper queue size settings for all available machine types.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  tests/qemu-iotests/267     | 154 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/267.out |   1 +
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 156 insertions(+)
>  create mode 100755 tests/qemu-iotests/267
>  create mode 100644 tests/qemu-iotests/267.out

The qemu-iotests maintainers might prefer for this to be at the
top-level in tests/ since it's not really an iotest, but the code itself
looks fine to me:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3CkTwACgkQnKSrs4Gr
c8g54Qf7BhTfccX2URHI1uYm4FJIzQdLsaugmpx6rxTvIatOJP85EJ8K5avnJm7f
C99t4Uoj7cmLR3JjO8eNnJv5ZZwH16csCCnHvX7bxsWYbXiPkrxWxZLWufYTvXL+
Y9oB7GFDdB5Qg2z8Ei7SvmrF+KAbdLKOwsNSXkjSk5xHc3LH2ZRMBq8iZndWJpIr
NtJwcKt0FPmBHOjiOs5VzbsuKIiEE68Eg7pf0AkAA1LIbFebnmc5KfVnBrOWQAWj
FpurVPrM534WX8f3Tjhua6gOsZeyuijgdUEYRtOUpNcc0vHBZxlT9zgAM1qo+dv7
+Fxabn4lFAmOo74XB69iFvXTIJqujg==
=nmxm
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--


