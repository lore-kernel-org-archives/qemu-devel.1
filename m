Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE1C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9F721835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIVUBNUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9F721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLCS-00086P-EE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inLAd-0006YP-NQ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inLAc-0000Jz-Gr
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45917
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inLAc-0000HM-7b
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578051069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNUR7H64mBN6GmV1tXx5tdldT0kBLDh5ar9SsjUmucA=;
 b=KIVUBNUpNzNCcA0iTx5l8qO9YWe0RrTw+SqN4jYQv3Qdei83bLBoVJGV3wrsEXdxwN0CIv
 udtDcMiTRjXpX45mOXnnDqzz5x5yXzDufPIDux3FgGk6QO3z5fw2pFRA3VqFMkyZG8QSZc
 vc4ZQ1s4KMEHt2PqlIKAJufivZedkhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-z-Cc1xGeNsmcRrt5HMQ5gw-1; Fri, 03 Jan 2020 06:31:05 -0500
X-MC-Unique: z-Cc1xGeNsmcRrt5HMQ5gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84328107ACC7;
 Fri,  3 Jan 2020 11:31:04 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DA0C5C28C;
 Fri,  3 Jan 2020 11:31:01 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:30:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 20/21] fuzz: add virtio-scsi fuzz target
Message-ID: <20200103113059.GO130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-21-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-21-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CbqR2XcyIs6OSP+I"
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CbqR2XcyIs6OSP+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:53PM +0000, Oleinik, Alexander wrote:
> The virtio-scsi fuzz target sets up and fuzzes the available virtio-scsi
> queues. After an element is placed on a queue, the fuzzer can select
> whether to perform a kick, or continue adding elements.
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/fuzz/Makefile.include   |   1 +
>  tests/fuzz/virtio_scsi_fuzz.c | 200 ++++++++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+)
>  create mode 100644 tests/fuzz/virtio_scsi_fuzz.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CbqR2XcyIs6OSP+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PJfMACgkQnKSrs4Gr
c8ja8ggAmdo2n5JoDZYx66d3LHVvdLDXsfzmK03rLfLtrAfqsgjuyj/XewDT7ITI
UTraU4q3SDhwgXCjrPZBDnnw1O5GD6OzbrZzDiSRe5bad5Q1PNKqkR4onZl3dHzB
XdkFXMn+azWrtHLVrugeiPdMtDm/bUmEcaPpragrHXCfDCmyeK59DVLfiyf7IlbM
g/YLxkAzGsvZrS4hnnFwiJo9Y2P4bYrj6SFX2mtB/0v8bUPe4fsk182BYjIsB4cf
KnRN31jVSC0jzRh85rJt9ukSzpJC1xMAeE135gTPLAZsqxWdj8KRJ3+Caeq3PwO+
NT1DI+cRKL2ze9RmhF+OmapdG2ksrg==
=1nLi
-----END PGP SIGNATURE-----

--CbqR2XcyIs6OSP+I--


