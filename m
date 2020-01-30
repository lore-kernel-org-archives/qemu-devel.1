Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC02C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE1B206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5Zi+C+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE1B206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixB3T-0002mi-Vk
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixB2d-00025Y-FI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixB2c-0003Cc-Gc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:43:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixB2c-0003CN-Cp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580395414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SzupXpFysLrmF431On+RBvhWCdpkT/ooGQP0KAtGRNc=;
 b=D5Zi+C+Rdh0nQfWXom2maTqfOMTLkF1OgkFIjrp5lU8zeg9l+xFLTS0HqgxWNSpW08g+gE
 tJKz66gzGQWtw+/r1UHY4QsPewKMqi0Tyrlhj5aw6nFz0cC3Jc0ZboQjlqhADydO86GxQS
 zW2cZ8xrOt0jpR4ARw6TSynMutt8QYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-sqDf06PrO-GDCN948eCldQ-1; Thu, 30 Jan 2020 09:43:30 -0500
X-MC-Unique: sqDf06PrO-GDCN948eCldQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33FB3107ACC5;
 Thu, 30 Jan 2020 14:43:29 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A8B777949;
 Thu, 30 Jan 2020 14:43:26 +0000 (UTC)
Date: Thu, 30 Jan 2020 14:43:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 19/21] fuzz: add virtio-net fuzz target
Message-ID: <20200130144325.GD180311@stefanha-x1.localdomain>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-20-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200129053357.27454-20-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
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

--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 05:34:27AM +0000, Bulekov, Alexander wrote:
> The virtio-net fuzz target feeds inputs to all three virtio-net
> virtqueues, and uses forking to avoid leaking state between fuzz runs.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/Makefile.include  |   1 +
>  tests/qtest/fuzz/virtio_net_fuzz.c | 195 +++++++++++++++++++++++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 tests/qtest/fuzz/virtio_net_fuzz.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4y640ACgkQnKSrs4Gr
c8iDIwf6A+LB272MxcNQ5F7Epu9OH63ymfVLa+B6pUquX4z5Kp1eoiAx+++AlO0D
xMnxr72U/v5lvQxEAlcsovYRmpGo6Iqh5zebHOUNPQ9PyJPTQJ2JojiJQLCkt4J4
ksa5a2EMODeupo932u6mjVfHimv//aD/xBllTYpUrIvtlFg3gP/IanJ6CFO2TKks
rdhg+GCcfaLJJbKk+676ed21w6JS4b9+I1OGvOF/zF493sCfw3akDzs7FW1J+Ibq
cMr6dD2P6jNHugE25QplSXO7nZMzFf3rS4glPTX0Aa9dszGZdwMa++8w54TEdjr5
NZv84gdGtDxUrUEeuWPEmZ3raIuLNA==
=n5d1
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--


