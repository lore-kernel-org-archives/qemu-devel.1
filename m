Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A153C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA30B217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkonhpLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA30B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Elt-0005vG-08
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2ElF-0005RQ-9K
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2ElD-0007Z5-Uk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:42:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42225
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2ElD-0007Yh-QL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581601351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xdPKQfrZ1RBDe4hqhlglMERfhsJPUIIP0SAu6YT/YJA=;
 b=GkonhpLXl99TwyJFxdbV8fAoqBSZ2mVrGvth0/p4xB0AkkiJCP5QVy8nb6HPhhfYy+9+UH
 LszQxnvcT52pbuPjM8QG3t0YxSP5lBhKF/W1jIlNqXOpB3ufUq9sUErr2pVW4UHXY+NuLv
 s/VNQGqpiOyL/uChYhNlUg32T6/xMBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Waoq8wDlOuWrOgDAuZ8ZMQ-1; Thu, 13 Feb 2020 08:42:29 -0500
X-MC-Unique: Waoq8wDlOuWrOgDAuZ8ZMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBAB3107ACC4;
 Thu, 13 Feb 2020 13:42:27 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B5A09008B;
 Thu, 13 Feb 2020 13:42:24 +0000 (UTC)
Date: Thu, 13 Feb 2020 13:42:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v9 22/23] fuzz: add virtio-scsi fuzz target
Message-ID: <20200213134223.GE544499@stefanha-x1.localdomain>
References: <20200211203510.3534-1-alxndr@bu.edu>
 <20200211203510.3534-23-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200211203510.3534-23-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, darren.kenny@oracle.com, bsd@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2020 at 03:35:09PM -0500, Alexander Bulekov wrote:
> diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> new file mode 100644
> index 0000000000..f62f512a26
> --- /dev/null
> +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> @@ -0,0 +1,214 @@
> +/*
> + * virtio-serial Fuzzing Target
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

virtio-net?

> +static void register_virtio_scsi_fuzz_targets(void)
> +{
> +    fuzz_add_qos_target(&(FuzzTarget){
> +                .name = "virtio-scsi-fuzz",
> +                .description = "Fuzz the virtio-net virtual queues, forking"

s/net/scsi/

> +                                "for each fuzz run",
> +                .pre_vm_init = &counter_shm_init,
> +                .pre_fuzz = &virtio_scsi_pre_fuzz,
> +                .fuzz = virtio_scsi_fork_fuzz,},
> +                "virtio-scsi",
> +                &(QOSGraphTestOptions){.before = virtio_scsi_test_setup}
> +                );
> +
> +    fuzz_add_qos_target(&(FuzzTarget){
> +                .name = "virtio-scsi-flags-fuzz",
> +                .description = "Fuzz the virtio-net virtual queues, forking"

s/net/scsi/

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5FUj8ACgkQnKSrs4Gr
c8ix3gf+McQkkr7MrMnPmSpjSBo4tOpdjV2ErMC0TJ/ErfcBLaozrDb6Jj9kWQGA
TCoekFbaNKIjcH8cJxGHa2+tV79QWrICyGdz2UpL1SQGxxNST6HfUQUzzZNhb+ao
/4tGJQR6jznu81BxfRKueyUFtgI1xd/l0l/4YjYQS85CKoFisM0pWBawPBqkYxQC
mIa+74sYd0YqBjwEHclZm2rVvMif2VKWxj83j5rgj1eZy1dbSrFopf/xJHFRaXxG
C45d7tHiyNdiUjtYVjyi4iurMsXPMugrz1ofk7JhynaMYLDn2XUbYEX0e/FFfsc6
bi8dhuOosKiQTNCUIaI4KQK8vfGOVg==
=FTT0
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--


