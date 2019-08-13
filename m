Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5727DC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6F3205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6F3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53151 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYJG-0002h6-DI
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hxYHt-0001NL-2x
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hxYHs-0003lO-0V
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hxYHp-0003jY-CN; Tue, 13 Aug 2019 11:00:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9887DC04959E;
 Tue, 13 Aug 2019 15:00:32 +0000 (UTC)
Received: from localhost (ovpn-117-191.ams2.redhat.com [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2548526FDB;
 Tue, 13 Aug 2019 15:00:31 +0000 (UTC)
Date: Tue, 13 Aug 2019 16:00:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190813150031.GA32090@stefanha-x1.localdomain>
References: <20190813093047.27948-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20190813093047.27948-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 13 Aug 2019 15:00:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] First batch of global_qtest-removement
 patches for QEMU 4.2
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 John Snow <jsnow@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 11:30:41AM +0200, Thomas Huth wrote:
> While global_qtest and its wrapper functions work fine for tests that only
> run one instance of QEMU, using the global_qtest variable in our qtests is
> very problematic for tests that use multiple test states (e.g. migration
> tests). Thus the core libqtest and libqos library functions should not
> depend on global_qtest or functions that rely on this variable.
>=20
> This patch series gets rid of these dependencies in most of the libqtest
> and libqos code.
>=20
> Thomas Huth (6):
>   tests/libqos: Make generic virtio code independent from global_qtest
>   tests/libqos: Make virtio-pci code independent from global_qtest
>   tests/libqtest: Remove unused function hmp()
>   tests/libqtest: Clean up qtest_cb_for_every_machine() wrt global_qtest
>   tests/libqtest: Make qtest_qmp_device_add/del independent from
>     global_qtest
>   tests/libqtest: Make qmp_assert_success() independent from
>     global_qtest
>=20
>  tests/cpu-plug-test.c      |  15 ++--
>  tests/e1000e-test.c        |   2 +-
>  tests/ivshmem-test.c       |   2 +-
>  tests/libqos/usb.c         |   6 +-
>  tests/libqos/usb.h         |   2 +-
>  tests/libqos/virtio-pci.c  |   8 +-
>  tests/libqos/virtio.c      |  74 +++++++++---------
>  tests/libqos/virtio.h      |  27 ++++---
>  tests/libqtest.c           |  37 ++++-----
>  tests/libqtest.h           |  24 +++---
>  tests/usb-hcd-ohci-test.c  |   2 +-
>  tests/usb-hcd-uhci-test.c  |   8 +-
>  tests/usb-hcd-xhci-test.c  |  22 +++---
>  tests/virtio-9p-test.c     |  16 ++--
>  tests/virtio-blk-test.c    | 153 +++++++++++++++++++------------------
>  tests/virtio-ccw-test.c    |  18 +++--
>  tests/virtio-net-test.c    |  35 +++++----
>  tests/virtio-rng-test.c    |   2 +-
>  tests/virtio-scsi-test.c   |  22 +++---
>  tests/virtio-serial-test.c |   4 +-
>  20 files changed, 251 insertions(+), 228 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1S0I4ACgkQnKSrs4Gr
c8iEEQf/dwciyL4R9i55AdTx/h8W02EcBIqs4ov5KIwhqCKR035n8uT3yqXYKHco
BeSPmF3H6wqnWyloAmMGTBPWYZ13/apbPQDHK2igbbUBzbiiFgbNqGObKqk46sCV
gnOfwNUGEcACYmh63f1XU4I/SwTgJRIt3dYU6zT24S9vyDt3T3qLUAXRAGuG0QFc
rMIUyMg9LC61fCF0Kv5tPu4iPHJPWcd9J3bksuWkkHaBXo93mR/GU0x57bdLqnsk
JoF3WOy0CouY1s+j/3ioLFqO8g6UvrakhfetoIa6/rzawbmQT9EdLd43tiluHN65
vxIfxe1vBdJ7ZAePjrI/o/e4Nm0Q3Q==
=f7v/
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

