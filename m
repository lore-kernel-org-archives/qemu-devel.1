Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7783DC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEE92087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEE92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5aRA-0008Iw-Qr
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 14:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5aO6-00065F-5k
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5aO5-0005Jd-7H
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5aO4-0005JJ-VB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C0AB8980EF
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 18:52:12 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51105D6D0;
 Wed,  4 Sep 2019 18:52:11 +0000 (UTC)
Date: Wed, 4 Sep 2019 19:52:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190904185210.GF26826@stefanha-x1.localdomain>
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-7-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
In-Reply-To: <20190904130047.25808-7-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 04 Sep 2019 18:52:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 6/6] tests/libqtest: Use
 libqtest-single.h in tests that require global_qtest
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


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 03:00:47PM +0200, Thomas Huth wrote:
> Tests that require global_qtest or the related wrapper functions now
> use the libqtest-single.h header that is dedicated for everything
> related to global_qtest. The core libqtest.c and libqtest.h files are
> now completely indepedent from global_qtest, so that the core library
> is now not depending on a global state anymore.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/cpu-plug-test.c         | 2 +-
>  tests/display-vga-test.c      | 2 +-
>  tests/e1000e-test.c           | 2 +-
>  tests/fdc-test.c              | 2 +-
>  tests/i440fx-test.c           | 2 +-
>  tests/i82801b11-test.c        | 2 +-
>  tests/intel-hda-test.c        | 2 +-
>  tests/ioh3420-test.c          | 2 +-
>  tests/ipmi-kcs-test.c         | 3 +--
>  tests/libqtest-single.h       | 4 ++++
>  tests/libqtest.c              | 2 --
>  tests/libqtest.h              | 4 ----
>  tests/m25p80-test.c           | 2 +-
>  tests/qos-test.c              | 2 +-
>  tests/rtc-test.c              | 2 +-
>  tests/rtl8139-test.c          | 2 +-
>  tests/test-arm-mptimer.c      | 2 +-
>  tests/test-netfilter.c        | 2 +-
>  tests/test-x86-cpuid-compat.c | 2 +-
>  tests/tmp105-test.c           | 2 +-
>  tests/tpm-crb-test.c          | 2 +-
>  tests/tpm-tests.c             | 2 +-
>  tests/tpm-tis-test.c          | 2 +-
>  tests/usb-hcd-ohci-test.c     | 2 +-
>  tests/usb-hcd-uhci-test.c     | 2 +-
>  tests/usb-hcd-xhci-test.c     | 2 +-
>  tests/vhost-user-test.c       | 2 +-
>  tests/virtio-blk-test.c       | 2 +-
>  tests/virtio-ccw-test.c       | 2 +-
>  tests/virtio-net-test.c       | 2 +-
>  tests/virtio-scsi-test.c      | 2 +-
>  tests/virtio-serial-test.c    | 2 +-
>  32 files changed, 33 insertions(+), 36 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wB9oACgkQnKSrs4Gr
c8jwOQgAvlNY3hW5RnEyfmUFkKaamyO2FBl6XZED4oUU4WcmEPdNclgXVmK3PU26
ykZuULSPLK2bncpWRPSVNaROA41B3uxH5OhnBg2QFA7g65KaEP/HdL2Q9+vAXQt5
wsrNsK16/48OMrq4GI4rZVqhLkd/Mhs8SS0Gb+XAr1rZV28Jzmkummy/v2Wu2ih/
oyx8Vrb4vmtojyk2XL0MckZ4a5RO6I5s1kUBvbjBm17g5S76nVK6k1shGmumjxXZ
2U2bPqL7yJ6KkrMTOBGEFyWJ+w2mJ8YtFQ1SsmbRuQhfMP8/51WveS+64F5XlNRi
c3EO2iSCohFG14c9qwfQI84BX9zLyQ==
=Q2Jm
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--

