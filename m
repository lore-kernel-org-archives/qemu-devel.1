Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA423C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754B221D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKPecddQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754B221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inJk9-0005Db-KH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 04:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inJj2-0004F7-L6
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inJj1-0006AN-M1
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:58:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inJj1-00067o-EM
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578045514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ApPvvk1yWuhSnB98XOrMRjx7I4EMfIx16NUWBTnePeM=;
 b=QKPecddQxIv8CDtSSeWRF+KWeGVT87lK6dmqANBq1f3NKYVK3Lz+R+SZ7xgV6FXgc+59VW
 gHIb8XLPWuX5PXP+fHeTVdyTRwcV0WcrmAE9hPzXcejjGQkE7wThv7yVTBgNat4DhNaX27
 V9+1ez5PL+C0IhUIzuwsz4kfv/dcTjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-bAZA1MjmNkOJfh4_ZznamA-1; Fri, 03 Jan 2020 04:58:33 -0500
X-MC-Unique: bAZA1MjmNkOJfh4_ZznamA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61E65DB31;
 Fri,  3 Jan 2020 09:58:31 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88BC91081333;
 Fri,  3 Jan 2020 09:58:28 +0000 (UTC)
Date: Fri, 3 Jan 2020 09:58:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 02/21] libqos: Rename i2c_send and i2c_recv
Message-ID: <20200103095826.GC130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-3-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-3-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:38PM +0000, Oleinik, Alexander wrote:
> The names i2c_send and i2c_recv collide with functions defined in
> hw/i2c/core.c. This causes an error when linking against libqos and
> softmmu simultaneously (for example when using qtest inproc). Rename the
> libqos functions to avoid this.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/libqos/i2c.c   | 10 +++++-----
>  tests/libqos/i2c.h   |  4 ++--
>  tests/pca9552-test.c | 10 +++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PEEIACgkQnKSrs4Gr
c8gCZQgApYfUwfxGsyQUSvfOHfs+1WoVN95UIRJk/MCHw5osHrJLOsxk3RUHPLza
tP8x9WgsGYs746ni0Ux1RaxHySowsQUXoAal6SS5K0FLkSeWSEX7EsImVJAtPBX2
g83FiXT+MYSZBDJL0ugBXVY1OxAJr9efuerRjgciBZOvnW1v+AFjD+coePB257G5
hlbxTt0qxE10ScC4uKm6Enu0DicWvQoqr06narl96Tg3MMNi9ufiA6FFGhRU7+lt
UUDOP44MLNJ0llip/Rmk/VMr1dzfXvwUGhCHJUsBgr5T11ISETx8qBjy5s4leXTI
oiwYQihIRg5CtrIxp7JSA8wBeUyHlw==
=cjU/
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--


