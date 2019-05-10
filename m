Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA29AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA322175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA322175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP2xo-0005BN-TE
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:41:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP2wB-0003iN-Fp
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP2wA-0004hA-KI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP2w8-0004cy-JF; Fri, 10 May 2019 06:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5BC585376;
	Fri, 10 May 2019 10:39:31 +0000 (UTC)
Received: from localhost (ovpn-117-147.ams2.redhat.com [10.36.117.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59073646BB;
	Fri, 10 May 2019 10:39:31 +0000 (UTC)
Date: Fri, 10 May 2019 11:39:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190510103930.GF22311@stefanha-x1.localdomain>
References: <20190508143209.24350-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <20190508143209.24350-1-thuth@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 10 May 2019 10:39:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests: qpci_unplug_acpi_device_test()
 should not rely on global_qtest
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
	Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 04:32:09PM +0200, Thomas Huth wrote:
> libqos functions should not use functions that require global_qtest to
> be set, since such library functions could also be used by tests that
> deal with multiple test states. Add a parameter to this function to
> explicitly specify the test state.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/e1000e-test.c     |  4 +++-
>  tests/ivshmem-test.c    |  9 ++++++---
>  tests/libqos/pci-pc.c   | 10 +++++-----
>  tests/libqos/pci.h      |  2 +-
>  tests/virtio-blk-test.c |  3 ++-
>  tests/virtio-net-test.c |  4 +++-
>  tests/virtio-rng-test.c |  5 ++++-
>  7 files changed, 24 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzVVOIACgkQnKSrs4Gr
c8ibqQgAmCAI8rCRIAZKrJ3gLIecctoGLQDH93FaZZ05mZsehXGkFa/1sLxJmvPI
W6OX9bHh0bQOv+PVd2SwmjinVBHSV2QX8L03yqNMPhcUrh1gU9M3dp3gZFUm5v5F
AnNig6CUxIY2MnX2Jn5H3lN2ApqcKXxjaVBWxT2rGQvxkFmCh6E3HdzEkQ5eC5FT
7o83FA5dSU8oRaroEw+pWwRvUONezCkWwP9sxx17+6xTA4D1hOlDs+XlfOZiN7ul
oq/dMdbtwQ/ggK3e7Z3fNVu9YGrYoRmACYEDa4d0Ae5/NZR/LqI+61GbwbthZPgd
1MxLHWcoWL/u5heLpZxIANYrY+xQRg==
=oZIy
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--

