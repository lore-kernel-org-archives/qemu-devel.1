Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505ACC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBE220835
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1oeMYc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBE220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidez-0001Tm-BM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jidTz-00022O-PU
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:35:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jidTy-0007Qn-RG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591706157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u15FCO2WNMuJNEoIbMKeZZKEjmpe932ErT4s57ea/3U=;
 b=F1oeMYc6LViC8iiVkWZWmUx//Hx5oaee6Sy2GZUN75OVOiX9qOFADFypuebUQ1QrLsKH2e
 IM1MxIY3CnhOezUShpoHjMqjf2IrpkHN+nhqaxpuxJ8YNDaIJu4HRscQEuVuzT618w/lKc
 MUtmL0r2U5Ev5gMcgTLqC1Tvzhg2Qs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-sGXVy6KbOraWGa-WAsXQow-1; Tue, 09 Jun 2020 08:35:55 -0400
X-MC-Unique: sGXVy6KbOraWGa-WAsXQow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DE611009600;
 Tue,  9 Jun 2020 12:35:54 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 365915D9C9;
 Tue,  9 Jun 2020 12:35:51 +0000 (UTC)
Date: Tue, 9 Jun 2020 13:35:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/qtest: Fix LGPL information in the file headers
Message-ID: <20200609123549.GE92564@stefanha-x1.localdomain>
References: <20200605100645.6506-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200605100645.6506-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 12:06:45PM +0200, Thomas Huth wrote:
> It's either "GNU *Library* General Public License version 2" or "GNU
> Lesser General Public License version *2.1*", but there was no "version
> 2.0" of the "Lesser" license. So assume that version 2.1 is meant here.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/e1000e-test.c                        | 2 +-
>  tests/qtest/fuzz/qos_fuzz.c                      | 2 +-
>  tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c | 2 +-
>  tests/qtest/libqos/arm-imx25-pdk-machine.c       | 2 +-
>  tests/qtest/libqos/arm-n800-machine.c            | 2 +-
>  tests/qtest/libqos/arm-raspi2-machine.c          | 2 +-
>  tests/qtest/libqos/arm-sabrelite-machine.c       | 2 +-
>  tests/qtest/libqos/arm-smdkc210-machine.c        | 2 +-
>  tests/qtest/libqos/arm-virt-machine.c            | 2 +-
>  tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c  | 2 +-
>  tests/qtest/libqos/e1000e.c                      | 2 +-
>  tests/qtest/libqos/e1000e.h                      | 2 +-
>  tests/qtest/libqos/ppc64_pseries-machine.c       | 2 +-
>  tests/qtest/libqos/qgraph.c                      | 2 +-
>  tests/qtest/libqos/qgraph.h                      | 2 +-
>  tests/qtest/libqos/qgraph_internal.h             | 2 +-
>  tests/qtest/libqos/qos_external.c                | 2 +-
>  tests/qtest/libqos/qos_external.h                | 2 +-
>  tests/qtest/libqos/sdhci.c                       | 2 +-
>  tests/qtest/libqos/sdhci.h                       | 2 +-
>  tests/qtest/libqos/virtio-9p.c                   | 2 +-
>  tests/qtest/libqos/virtio-9p.h                   | 2 +-
>  tests/qtest/libqos/virtio-balloon.c              | 2 +-
>  tests/qtest/libqos/virtio-balloon.h              | 2 +-
>  tests/qtest/libqos/virtio-blk.c                  | 2 +-
>  tests/qtest/libqos/virtio-blk.h                  | 2 +-
>  tests/qtest/libqos/virtio-net.c                  | 2 +-
>  tests/qtest/libqos/virtio-net.h                  | 2 +-
>  tests/qtest/libqos/virtio-rng.c                  | 2 +-
>  tests/qtest/libqos/virtio-rng.h                  | 2 +-
>  tests/qtest/libqos/virtio-scsi.c                 | 2 +-
>  tests/qtest/libqos/virtio-scsi.h                 | 2 +-
>  tests/qtest/libqos/virtio-serial.c               | 2 +-
>  tests/qtest/libqos/virtio-serial.h               | 2 +-
>  tests/qtest/libqos/x86_64_pc-machine.c           | 2 +-
>  tests/qtest/qos-test.c                           | 2 +-
>  36 files changed, 36 insertions(+), 36 deletions(-)

For anything I touched:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7fgiUACgkQnKSrs4Gr
c8ghDgf/YToM+sDBF1+ETSZjj0Rmi2YDZgogciJOYkaLqfFz/+xLJFHVcwSSR0F0
YoXCW5VqLw7UpjoMgSLrsOD1JhtMIKPC/EZYw7G+hxvV27H7izf3wMEE3viL+Exj
W+ca4LPkWDuPeE2l/z117m8WZ8dh/G5IGWFtek/09R3vZM244AE+nuEq95I7qNHA
ErAORu2x+gByECLkJ0CmmpBTkulswZU1tQlhd7MWAFFXGA8kENRJuAOKMMW0xGsK
Ru0W5cT0BVyCKFO7aE3ZLT8nMaAFzF1lE2+rKUosLjVVuBNGmHJ2UgpafMRgnWl5
mgmjAb6iZ0Kn9dMHYLX31Qn6W8fXxQ==
=cVSb
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--


