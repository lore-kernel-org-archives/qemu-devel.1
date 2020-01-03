Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF6C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF16A21835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMC+3AaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF16A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLDe-0000as-FN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inLAu-0006kd-1n
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inLAt-0001DW-1b
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inLAs-0001AM-PA
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578051086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B7jtugvlEWHjqiKZZsaXRYaTEOvnYuAQztRESpkR3M=;
 b=ZMC+3AaJ8OEofgWr/L0foza/ZpdhBJdsdpUe+iGBrdMEj0dnfZCkg5dG5zApsAAAhAOovm
 zrqNRELTgoVQwhfXheQgU9hdIPCMQOWFXkCewswCIJ3fmkDpMIrPFa+i72J9tJsl6Ej1QP
 C3HsVtVdWF5EoEs4zu6KXH6bviCI7I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-80wLxfpHMc29LyRDI68BFA-1; Fri, 03 Jan 2020 06:31:22 -0500
X-MC-Unique: 80wLxfpHMc29LyRDI68BFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82CEA1801249;
 Fri,  3 Jan 2020 11:31:21 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 659C37BFA3;
 Fri,  3 Jan 2020 11:31:17 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:31:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 21/21] fuzz: add documentation to docs/devel/
Message-ID: <20200103113115.GP130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-22-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-22-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BnCwdHgQ2ZomtW9r"
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

--BnCwdHgQ2ZomtW9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2019 at 09:34:54PM +0000, Oleinik, Alexander wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  docs/devel/fuzzing.txt | 119 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 docs/devel/fuzzing.txt

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BnCwdHgQ2ZomtW9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PJgMACgkQnKSrs4Gr
c8iJ/wgAk/RvopoV70hxJB17rTL/pabWq+MMAlkFDGy0xqZ0F7rAO+pGu7LGBKDj
uaKsW0BIS0EO49h01tUPfCvddvVJsIXast7vQnpVHc1srjHfw/0Y7xG9Dmbs4cWN
heBE5O5BL3kwYkiHbpOh0dz/Ek0E6rJ0NPg3hOxAxxcpH/xvWJ7gPA43A5dic9xu
yWTA22RPkpduSemZOa2LSDRDkeW9reypcvbex5/yYvtT/9aVnde+TeJn/3dESNAG
/8AocYDpg75u9ri8eRV0ZT8QbYjy9ysdGD/cdR9InCv91iMhvBptp5LRylOr+p3R
0WhQ9svfg3ebHOgBq0gqPiQVSsoSFQ==
=+7nS
-----END PGP SIGNATURE-----

--BnCwdHgQ2ZomtW9r--


