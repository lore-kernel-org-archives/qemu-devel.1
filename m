Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2330C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB0C22464
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="any1S+c0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB0C22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igzrF-0005qV-Ku
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1igzqX-0005K1-Gv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1igzqU-0008G5-Ki
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:32:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1igzqU-0008CA-Gt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576539129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfXBNyvZEtLPawukhi/mDsYeJ9xMR5ygs2sazn2M7nQ=;
 b=any1S+c0NF3O10b2FyydnzIkXAfbBLJ2Z8qkLlPG/aNBJJ+NxjqlYhMuKs3AC8bc/OegT1
 D9LxvTPr3WXdDIHd4l8Iw2BqF0W+ug6gshxEwgOVWvhcN+1coLOa1wqJRMtJ1cKXgtwDu8
 ByCKPer36tSk8GxTXt/jOEaZtCCXUuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-JOWjyZJdOe6PsI597puHCA-1; Mon, 16 Dec 2019 18:32:05 -0500
X-MC-Unique: JOWjyZJdOe6PsI597puHCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C9AB800053;
 Mon, 16 Dec 2019 23:32:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D856C620A6;
 Mon, 16 Dec 2019 23:31:21 +0000 (UTC)
Date: Mon, 16 Dec 2019 18:31:12 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v4 2/5] python/qemu: accel: Add list_accel() method
Message-ID: <20191216233112.GA18357@localhost.localdomain>
References: <20191216191438.93418-1-wainersm@redhat.com>
 <20191216191438.93418-3-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191216191438.93418-3-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, ehabkost@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 04:14:35PM -0300, Wainer dos Santos Moschetta wrote=
:
> Since commit cbe6d6365a48 the command `qemu -accel help` returns
> the list of accelerators enabled in the QEMU binary. This adds
> the list_accel() method which return that same list.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl34E74ACgkQZX6NM6Xy
CfPfrA//ScpCBA91OwW+Gs/kACr5C9UjcS5sasMCmfk9s8NirY2vhmCwufASdDr0
lC7d/CbZidgy8jSpaQthX8SdNnK+Yn5WzlFlOc3ISEMWBOd/S8CSXSMlI7s/9Dud
Q81wAXT/ILW6azcrxIinDPf5NfkrXfiIt+19An8m6foAak9SbFQWePLNwV9gtzXX
94MU5AOpZ0jdR2zD7saWHps1X1tdWG7Gs7S3kn/ljoj47std+POYGSOU1BhlG7rL
gBrSXEbuvj1KLTZw64P4utclih7QvZQku6YbGAaDRNYR6xj2GOMXsspFdQZ6gtKw
NhA3ZbG7gZMUV5CnN8Tl/G9xeTaypkK0LwxAysb5C8q9zmeURr8Q2a9cSEEO3vlV
ZhHBnUoTrz5STSpuWsfXBXojaaNiznhNgdwder4HP/fmPrUVYVdmC3Y1cJvOhBAV
H4nnQraOtYLZxkTlEt0I4vfbj5lhUxKhwFORgE5TFgM2+uO8rcJ95Z+jpr3ssDdf
droNZw1zfckNLfUNHzGuNR8cCrXaW2ZuIkIJG+12kgu+NyGVGo91ki0nnQp73zN2
LmisnbfkWePpk7ajYmoVKGTlzyzEfLAjS54DHwYqGfOMqukuf0SlOCcXsOAFV+VP
a4Crw2MnzLtCl/rjVPtvTJ4+CX9DO36cREGzzVTL+AYPIzoKqFs=
=N1zt
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--


