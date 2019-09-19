Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6070C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C24D218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C24D218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwb2-0004pn-4y
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAwAX-0007hG-OA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAwAW-00060o-Fo
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:08:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAwAW-00060K-AG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:08:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5ACC6898106;
 Thu, 19 Sep 2019 13:08:19 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 289F25C1D4;
 Thu, 19 Sep 2019 13:08:11 +0000 (UTC)
Date: Thu, 19 Sep 2019 14:08:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919130810.GS3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-21-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/KohU7xR/z4Rz7fl"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-21-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 19 Sep 2019 13:08:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 20/22] fuzz: add i440fx fuzz targets
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


--/KohU7xR/z4Rz7fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2019 at 11:19:47PM +0000, Oleinik, Alexander wrote:
> +static void i440fx_fuzz_qtest(QTestState *s,
> +        const unsigned char *Data, size_t Size) {
> +
> +    typedef struct QTestFuzzAction {
> +        uint8_t id;
> +        uint8_t addr;
> +        uint32_t value;
> +    } QTestFuzzAction;

I'm concerned about padding within the struct and struct alignment
causing us to skip some bytes in Data[].  Also, on some architectures
unaligned memory accesses are unsupported so memcpy() is safer than
casting a pointer directly into Data[].

The question is whether skipping bytes in Data[] matters.
Feedback-directed fuzzing should realize that certain offsets in Data[]
are unused and do not affect the input space.  Still, I think we should
arrange things so that every bit in Data[] matters as much as possible.

The struct can be arranged to avoid struct field padding:

  uint32_t value;
  uint8_t id;
  uint8_t addr;

> +    QTestFuzzAction *a = (QTestFuzzAction *)Data;
> +    while (Size >= sizeof(QTestFuzzAction)) {

To avoid struct alignment issues:

  QTestFuzzAction a;
  while (Size >= sizeof(a)) {
      memcpy(&a, Data, sizeof(a));
      ...
      Data += sizeof(a);
  }

> +        uint16_t addr = a->addr % 2 ? 0xcf8 : 0xcfc;

Please define constants for these magic numbers (e.g.
I440FX_PCI_HOST_BRIDGE_CFG, I440FX_PCI_HOST_BRIDGE_DATA).

> +        switch (a->id) {

How about:

  switch (a->id % ACTION_MAX) {

This way we always exercise a useful code path instead of just skipping
the input.

--/KohU7xR/z4Rz7fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DfboACgkQnKSrs4Gr
c8ihMgf+JXb7cKluUZGmNjU9Vm2A/2xVAQGI+X52hcOsR7Jt4fhIF5Ann9o8yZYJ
+tqd/xEGjDSaBUSyXd4XT3LgolGX10L8lOrL+6tpVu3sC8adlqveYpe7DsZ1ucZH
F9utiQtAHLpFHOzTDXZOXH7yBEs90oVVUhdCneOd/m9jUWvNMJ+4I5rTeQVhGEzZ
RLgbZPxg9f/12B6HpBfTPUYrx8Hz7O3wJbr1qhBBDk6hCImpHWDkJbz2sWDSZ+sI
sKj8jOw5gTcTl2n8OuLJu7ESG2KJ7WGIbDD3IsiV7kcYI/Mlr0/YtOn+d54BpYA/
xzRkd6PJxyJ/w64RgzYyL/8XbmxyJw==
=CK/n
-----END PGP SIGNATURE-----

--/KohU7xR/z4Rz7fl--

