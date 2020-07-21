Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBB620714
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4LHRAdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBB620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnhD-0000H0-M9
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxngD-0007of-4l
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:31:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxngB-0007cR-M8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595320274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FqIur+bhWDpB9k2YSIprQuyz1unA10WOpf+JK8wf1gU=;
 b=f4LHRAdhheMN5GPbrsfbhHdlf80mDlKHR8f8SVGvSXs+SudZJhsq4ZjqrOUe6L5O7DcNwt
 gweqPaKRjnNS/ioXdR94NMGwzVLYIkVhOA1hSJ+W1oMac8AgBAeBh94vMOo/qlVQjrKT+U
 Wocs7hwtjCpwNbAGUGGMXLtj0osmNW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-_MyNeJeVM9mnyEuvYHsnqA-1; Tue, 21 Jul 2020 04:31:11 -0400
X-MC-Unique: _MyNeJeVM9mnyEuvYHsnqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB70C8015FB;
 Tue, 21 Jul 2020 08:31:10 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60B677853E;
 Tue, 21 Jul 2020 08:31:07 +0000 (UTC)
Date: Tue, 21 Jul 2020 09:31:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Extend the device fuzzing section
Message-ID: <20200721083106.GC144170@stefanha-x1.localdomain>
References: <20200721053926.17197-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200721053926.17197-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 07:39:26AM +0200, Thomas Huth wrote:
> The file docs/devel/fuzzing.txt should be in this section, too, and add
> myself as a reviewer (since I often take the fuzzer patches through the
> qtest-next tree, I should be notified on patches, too).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Wp8oACgkQnKSrs4Gr
c8jcKAf/VHcbCQKQLuVj8hYlG/j4VPNAlm2HehmQKyJpLSAhxacQhOXtBk9FLlGi
cKKlujbq+WMhzLDJlqcZdKD3yNEF+PdeVsYTgJ2LiEeP453v2WwOj7a44n+RtZzO
upIiznzjsMecCLi233uKcl8Zw+3RL6zDdLPZGHDL8Qt9EsSNI6defnfq0y8EQ64T
4K3dOGbyeCe3EUaBQEwXBsPnvCKSa1CmzWkeHEJp3OPrGjNFkD/9s4XcTIIB3Bqb
pL8aZIpo+J31sI09TQbZ2dQ7f1ocHHMbbFDAXJUQGiET86OTJvPrceshU7VU0+mO
pnkLPcl/B/PhdK6H5O+8NtNNsIKTqQ==
=Z6Zt
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--


