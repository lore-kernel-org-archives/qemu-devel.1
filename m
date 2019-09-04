Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2385AC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0A62087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0A62087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5aUo-0003pX-6U
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 14:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5aOs-0006o6-8t
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5aOr-0005mH-3m
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:53:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5aOq-0005m5-UC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:53:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42D076412F
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 18:53:00 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA8731000343;
 Wed,  4 Sep 2019 18:52:59 +0000 (UTC)
Date: Wed, 4 Sep 2019 19:52:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190904185258.GK26826@stefanha-x1.localdomain>
References: <20190904130047.25808-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline
In-Reply-To: <20190904130047.25808-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 04 Sep 2019 18:53:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Make the core libqtest library
 independe from global_qtest
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


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 03:00:41PM +0200, Thomas Huth wrote:
> global_qtest and the related wrapper functions often caused trouble in
> the past - if they are used somewhere in the libqtest or libqos library
> code, it's hard to write tests that properly track multiple test states
> (like migration tests).
>=20
> This patch series finally gets rid of the remaining global_qtest
> dependencies in the core libqtest code. The first patches are used to
> clean up some files that should not use global_qtest anymore, then the
> wrapper functions and the global_qtest definition get moved to a separate
> header file called libqtest-single.h - which then should only be used in
> tests that track only a single test state.
>=20
> v2:
>  - Do not add parameter to qvirtio_wait_config_isr(), but push the logic
>    into virtio-mmio.c and virtio-pci.c instead since we have access to
>    the test state here (as suggested by Laurent).

Looks good overall.  I posted one comment on a patch.

Stefan

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wCAoACgkQnKSrs4Gr
c8hYMgf/YcyEhesvvTau85qVP1LXgA1tBHd+rtzyK0T3w8FZkJpFXaeuwp4FvkQh
IkVsVVmstc9Eq5MVq3dB3syJe9AcrmR/uhYIxzhGQBnYncdQxB4Y0SD2J86XLzaE
BbzEhPPSJs//YEfkCj1Nzh0LEa2xUtb10dIKbXU8jVefb4l4zZYgB6YJoMmbcoQd
qHoRCjRVykpXJ8cTXFXweJjFYRmIdcTdSkF8q03OBSci2iQJ81KVemqpITP9JqcQ
2DcpIOx7DSwEfNFbPnYLCE8aUWhrYzAkeaZPH3bNCLY3mbfDyhJLQORSb0RDXCSo
cX+ZQHkk0xHy23wKd9t3qcROnr35Vg==
=vJWo
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--

