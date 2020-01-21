Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B71C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F9024125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj7cX100"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F9024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwdT-0003kx-0a
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1itwcX-0002bm-NY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1itwcU-0004Tf-3G
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:43:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1itwcT-0004TV-Vc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579624993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWct7Uk8tqbj99oOVIyOC//AXgfMOiuPMVrLwlQTX5I=;
 b=Aj7cX100nS7bQlJRkqexpyfFAmbkm2dJaH5nNFcyVqSOO5EQGcnKZqLclQBA05z9x6Ux8h
 zp6P64yI80YaF1UxRmbRpzwqNoIsIHGiK1KhRUJ1jsM/mqzB79Z3+iZ16yAh7IPiH31nhG
 eFetgkSbsibhDAxHvrN0pZKsF5vqYo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-BdzHuPfdNTitEAum3S_8nA-1; Tue, 21 Jan 2020 11:43:11 -0500
X-MC-Unique: BdzHuPfdNTitEAum3S_8nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9F4B1137866;
 Tue, 21 Jan 2020 16:43:10 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9580D85748;
 Tue, 21 Jan 2020 16:42:56 +0000 (UTC)
Date: Tue, 21 Jan 2020 16:42:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v7 18/20] fuzz: add virtio-net fuzz target
Message-ID: <20200121164255.GH641751@stefanha-x1.localdomain>
References: <20200120055410.22322-1-alxndr@bu.edu>
 <20200120055410.22322-26-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200120055410.22322-26-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 05:55:08AM +0000, Bulekov, Alexander wrote:
> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
> new file mode 100644
> index 0000000000..3b1b79fd93
> --- /dev/null
> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> @@ -0,0 +1,190 @@
> +/*
> + * virtio-net Fuzzing Target
> + *
> + * Copyright Red Hat Inc., 2019
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "tests/qtest/libqtest.h"
> +#include "tests/qtest/libqos/virtio-net.h"
> +#include "fuzz.h"
> +#include "fork_fuzz.h"
> +#include "qos_fuzz.h"
> +
> +#define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
> +#define QVIRTIO_RX_VQ 0
> +#define QVIRTIO_TX_VQ 1
> +#define QVIRTIO_CTRL_VQ 2
> +
> +#define VIRTIO_CONFIG_S_NEEDS_RESET 0x40

Please use #include "standard-headers/linux/virtio_config.h" instead of
duplicating this constant.

> +
> +static int *sv;

Please make this easier to understand:

  /* The -netdev socketpair fds */
  static int sockfds[2];

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4nKg8ACgkQnKSrs4Gr
c8iKywgAyHKoHi6RaQRtiR52cMk/N4M2fOcRZb4Kig7InJBMmoF2tiohbpAApjBS
fJ8DcZFPqz4iGUJEPBEe6QUMWpnhip/vqM1KMA24tbkk1gFTqLkZVjRQn0cESZjK
pG2UeH3MXOULdPYFG8FK9Nzh99tkX8wS2bmh11iv39ezLinJA8tiKycfjBpDONVw
9wAeancjy2+q/pui1u5y7lrDn5uAeEOMUW21JHs5S0vn31kGGm4eKRVqLtycoUbt
PGnyqJOVhOocHOLQBFTCzBdAekN9SSU9jYKjDs5SuUu8NAFYDlQy+GSpL8O9wkQk
n3k2nnAuuGSNac9DVEMQ9xYqtKLElg==
=90O8
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--


