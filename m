Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE79C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 16:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FC720735
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dft7cX2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FC720735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4fF-0000Zo-8Z
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 12:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC4dm-0006B4-RI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC4dl-0000W9-Nw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:55:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC4dl-0000Vp-KY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583945729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NQF34+AMeK7cntfhdCGMsjWhHXma/jCSq+tuBM98zew=;
 b=Dft7cX2WQR6yMrfB6lSYEpSUTMbkmaEbiTIEO6R73LAY45Wqtxm76/USOpaMv/y9qTHA4t
 Bt2hur73nRvfPcv817ZjL3sUvbTHDmRn2DFGJA1qnqewuPyUtHhCJAZtnMAoUkbUSaG86X
 CbuEtNp1XZlFZI9C1lg77ePBPgWbu0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-fDgjPgxmMVuZwbtD9kZBew-1; Wed, 11 Mar 2020 12:55:23 -0400
X-MC-Unique: fDgjPgxmMVuZwbtD9kZBew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12EFAA0CC0;
 Wed, 11 Mar 2020 16:55:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80E5E8F37B;
 Wed, 11 Mar 2020 16:55:21 +0000 (UTC)
Date: Wed, 11 Mar 2020 16:55:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] Block patches
Message-ID: <20200311165520.GB281087@stefanha-x1.localdomain>
References: <20200311124045.277969-1-stefanha@redhat.com>
 <158393470453.5248.14269785570464192054@39012742ff91>
MIME-Version: 1.0
In-Reply-To: <158393470453.5248.14269785570464192054@39012742ff91>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, peter.maydell@linaro.org, qemu-block@nongnu.org,
 mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 06:51:46AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200311124045.277969-1-stefanha@re=
dhat.com/
...
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/9 Checking commit 86ac8a79649d (qemu/queue.h: clear linked list pointer=
s on remove)
> ERROR: do not use assignment in if condition
> #66: FILE: include/qemu/queue.h:314:
> +    if (((head)->sqh_first =3D elm->field.sqe_next) =3D=3D NULL)        =
      \
>=20
> total: 1 errors, 0 warnings, 59 lines checked

This is for consistency with the rest of queue.h, which comes from BSD
and does not follow QEMU coding style.

Stefan

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5pF/gACgkQnKSrs4Gr
c8gf/gf9Hao9Hc0cJHC+1cyvHw4bTh68/Yp/58+zg09ucY/o2wiZRi2Mh0ncrMkK
WaXGKlmEZZGMyAgBfolWGtgFuXMfkDxl99kvyVtqH/RdSrKx5bltsbNvqCi8PsLq
sclsmhwWy5WC1pgaIAeiiRb4v74RHyRt9D6DoVhuMWtIdQ7icRMx8iU5W1ivC2cs
pCwWWv/Zw3PB3BytYASYtg2LxDFCw3UxIRj4KQtsJEWzm+YDqk0pGVwNRE5q/6hD
wIzfnoyv6BpMHGWxkzbAjifj44GHKt1NOC+jjnJ0Jrrt0NRq2FtlZUQ3HcN2ON0h
kbsBDQwB6uGGl1djcvRWzOvCTTkr7w==
=Cv+9
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--


