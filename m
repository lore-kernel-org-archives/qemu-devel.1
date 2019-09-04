Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB6C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0432087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0432087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5aTr-0002kt-Gd
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 14:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5aOK-0006Da-Br
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5aOI-0005QG-6X
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5aOH-0005Pi-LC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B57552A09DB
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 18:52:24 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48BEB5C22C;
 Wed,  4 Sep 2019 18:52:24 +0000 (UTC)
Date: Wed, 4 Sep 2019 19:52:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190904185223.GH26826@stefanha-x1.localdomain>
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
In-Reply-To: <20190904130047.25808-4-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 04 Sep 2019 18:52:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/6] tests/libqos: Replace clock_step
 with qtest_clock_step in virtio code
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 03:00:44PM +0200, Thomas Huth wrote:
> Library functions should not rely on functions that require global_qtest
> (since they might get used in tests that deal with multiple states).
> Commit 1999a70a05ad603d ("Make generic virtio code independent from
> global_qtest") already tried to clean the libqos virtio code, but I
> missed to replace the clock_step() function. Thus change it now to
> qtest_clock_step() instead.
> The logic of the qvirtio_wait_config_isr() function is now pushed
> to the virtio-mmio.c and virtio-pci.c files instead, since we can
> get the QTestState here easily.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqos/virtio-mmio.c | 14 +++++++++++++-
>  tests/libqos/virtio-pci.c  | 14 +++++++++++++-
>  tests/libqos/virtio.c      | 20 ++++++--------------
>  tests/libqos/virtio.h      |  6 +++---
>  tests/virtio-blk-test.c    |  3 ++-
>  5 files changed, 37 insertions(+), 20 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wB+cACgkQnKSrs4Gr
c8gC9AgAhrNXi1JCNh4f4ioP5tPZyHNdLJIPL8wM6UVGqHsripQYyiUOy9rsD4lb
e6LReHYbgxS0Aj4xxTPw8DpeoXaHu3dLLrmVFJoMRYgDsOD9V/OfzFzvMWge7MLk
DSjLHa6BCp9TvpKXcGvRM9Ykly56mxngVro4HC/YCcHpN1FF+4l93cQ1SOe5sUYa
YElrDaukkPxDKbHCG1nC6+Xd15hLOHB9jXhskFwj3tFICoLdgs6z+xqz+qCZeKPz
09Djv/tgJ0IeTmRCzpba8V1mpiCaeudR97VFr29g3htdFCRJKucFdLxl8esRPZZ1
z0Z0DypCpWqwY1t5Nf3u5ySOdJaN8g==
=5LCp
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--

