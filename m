Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58857C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A3D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyLzMWZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A3D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMo1-00055b-BD
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iwMnS-0004gz-J0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iwMnR-0000Hd-8X
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:04:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49001
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iwMnR-0000G4-4H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580202272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nYdlZWvMf7IGLKDxPew9VET4UdmMwDfKIQUNcfzO6I=;
 b=MyLzMWZ7YokYrbH9bvsjPzU4NfJtmwdsHCjPfmYHHupj6nEC4rGCxPQ5tjXzYQghAHVh2a
 D1q2xZfcpxkSiFt1NjoBeE33IsPpRjQAOITroqJiE8S9mSPo3H2gCN/wo0PWdkMbifCc5s
 isgI5FFoAeiMw2lU2ZqRAb4Zro7ZRSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-k21A7FN5OjuKHhF0Ql4iiQ-1; Tue, 28 Jan 2020 04:04:30 -0500
X-MC-Unique: k21A7FN5OjuKHhF0Ql4iiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A38B107ACC4;
 Tue, 28 Jan 2020 09:04:29 +0000 (UTC)
Received: from localhost (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B019F5D9C9;
 Tue, 28 Jan 2020 09:04:28 +0000 (UTC)
Date: Tue, 28 Jan 2020 10:04:27 +0100
From: Sergio Lopez <slp@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH 4/4] Add the NVMM acceleration enlightenments
Message-ID: <20200128090427.5bjvj4jx5sdvr4cr@dritchie>
References: <20200107125401.18126-1-n54@gmx.com>
 <20200107125401.18126-5-n54@gmx.com>
MIME-Version: 1.0
In-Reply-To: <20200107125401.18126-5-n54@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tvsq3yg3x5ek4w7d"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 Maxime Villard <max@m00nbsd.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tvsq3yg3x5ek4w7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 01:54:01PM +0100, Kamil Rytarowski wrote:
> From: Maxime Villard <max@m00nbsd.net>
>=20
> Implements the NVMM accelerator cpu enlightenments to actually use the nv=
mm-all
> accelerator on NetBSD platforms.
>=20
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  cpus.c                    | 58 +++++++++++++++++++++++++++++++++++++++
>  include/sysemu/hw_accel.h | 14 ++++++++++
>  target/i386/helper.c      |  2 +-
>  3 files changed, 73 insertions(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--tvsq3yg3x5ek4w7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4v+RoACgkQ9GknjS8M
AjUN7hAApfq62ZM9CqngbpuYAHM5VAxwQ2Zl1mt4EhXBtPpYEUjNHCBLfw2/vsYe
35xdkVlOIPKwAX3frMKPScq2PM8dbnS3RuQb/uXGPqDshwcq9ceL625FvKwhn8Fs
k5bbaQDUH+0fzuKzX65nXcNTlUexYYNx6P3oBMG6s/k9/xceLPrKv8Bt8yB/53WY
/OlHyUMpmee5an7qby5aauR7dB47u2Gnv7E4XrM50jMpyuL9ZNUxGepuq1pTMJvG
lMoN5J1RQ6hxyak9XvxhVULXR0IBB7vDAKZn1pLSruI86kKp6W1THJhvwPl7Wt2I
ndl9yst+A8gfg4Z+TEyCaErUdU79oVHe6wBYyBzTwLFT2ii3uVPTyFL+9sCCpEr5
Icv1QTmHr7GEIN+U3JSai9I6H1kuYIm1pKnkbuQOeqAVsHPBQz2KiQphMP+ws+FJ
tRTBQaTowTByjOjtvir1oFujCHKqw97txxiNh31xj5eguQoheI1A5OMnkUDWCW+q
iECT8vLB3i2l3t4c8Z77sbOnlflrNjBe/XQlQ8p0cv9dJkXkwp61OBhG5K6jh76u
OUCj6d7Y8Uzq3z+NAT0cM9GiU7mvO1Chflf/RSJ1Zw3gY9lmA+kF+z+swEbbLiVF
2ZSaNBaW7FHjrCia0xUjOgyn8OmsWvjEAoG+VncYENn7vTjWCJ4=
=shl5
-----END PGP SIGNATURE-----

--tvsq3yg3x5ek4w7d--


