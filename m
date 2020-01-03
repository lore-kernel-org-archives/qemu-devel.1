Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1110FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D244B21835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqj8KXs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D244B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inL9C-0005om-Un
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inL8Z-0005QH-Sa
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inL8Y-0000pl-FH
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:29:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inL8Y-0000mG-64
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578050941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBLTwuOiJi+P5uJNVRiAH+tHmhWJkOJiYkCUWso8wx8=;
 b=fqj8KXs6zjy+Z80pS2kW3FFUA6jae9Abwwq94qvc0g1JN8ARUW+UfBQhV4PaoGt4DrjnXC
 u5mQEdZ+sR8Tu84EpPrwcfMfCeTKBWPHy+5sGw2KmmixVQm9bJbQtyS6N8k4V63K+UkIAN
 yTVHyV6rm+8ebHmUWnGbtxSIzluNpqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-Za25GqGRO9-OTGHCTXG_eg-1; Fri, 03 Jan 2020 06:28:57 -0500
X-MC-Unique: Za25GqGRO9-OTGHCTXG_eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6841100550E;
 Fri,  3 Jan 2020 11:28:56 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF9855C28C;
 Fri,  3 Jan 2020 11:28:53 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:28:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 17/21] fuzz: add support for qos-assisted fuzz targets
Message-ID: <20200103112851.GM130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-18-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-18-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2019 at 09:34:51PM +0000, Oleinik, Alexander wrote:
> diff --git a/tests/fuzz/qos_fuzz.c b/tests/fuzz/qos_fuzz.c
> new file mode 100644
> index 0000000000..da76e28ca3
> --- /dev/null
> +++ b/tests/fuzz/qos_fuzz.c
> @@ -0,0 +1,232 @@
> +/*
> + * QOS-assisted fuzzing helpers
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "exec/memory.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/main-loop.h"
> +
> +#include <wordexp.h>

Is this header used in this source file?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PJXMACgkQnKSrs4Gr
c8j+Dgf/ZnDPSju8Tk9KUQRvlzWjHmv27jd5gn64eC6orP13E7JUq3VflC0kISme
NxOfrqoo49U6WhnsV/iTOWLVorwc7Vh2HvuoZetigC6v/SO0NCDdB6RSZ7las5p9
FdWMC5ERAJwUgcUJR5qN/XT/TZp9dBEdPMy+Yq22O323ClV5JJCd6cp3kp2v4slr
a46vBUW9e9nbAMU++1b8IQMOWGYfzrP4xLFPQeURzRDdzs3EfkkuOaMt//rCOlXR
gUUJcVCL5RRwTTdQ3RAzy0U5G9kaYEZYc701lpw3Owk8QG1pbFeot9a9U0sKnI6l
4f1UjxTbokRh3Lz2qaqTycWP300wyA==
=ILDf
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--


