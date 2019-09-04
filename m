Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC7C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2B72087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2B72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5aQL-0007WE-Vg
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 14:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5aOC-0006BE-R8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5aOB-0005Mr-RC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5aOB-0005Mc-L3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01E018A1C8F
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 18:52:19 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 898E16060D;
 Wed,  4 Sep 2019 18:52:18 +0000 (UTC)
Date: Wed, 4 Sep 2019 19:52:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190904185217.GG26826@stefanha-x1.localdomain>
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <20190904130047.25808-5-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 04 Sep 2019 18:52:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests: Remove unnecessary
 global_qtest references
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


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 03:00:45PM +0200, Thomas Huth wrote:
> We are going to remove global_qtest from the main libqtest library
> soon, so tests that do not urgently need global_qtest anymore
> should be cleaned from the unnecessary references.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/ahci-test.c        | 1 -
>  tests/bios-tables-test.c | 1 -
>  tests/ivshmem-test.c     | 3 ---
>  tests/rtas-test.c        | 1 -
>  4 files changed, 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wB+EACgkQnKSrs4Gr
c8gVogf8CJllj7vQZTLmy/RfSoBBnRM3DbYDV8Qj3gptnX7vmgN7ovYYiLsNdlPB
Ot47fcLIebMENv1IitXjkRwIsYapof6S6cX3l2mo33uF77lTpi1BZFT+JnhZXxOt
yan6vQVkCf4de/aYErT6Ga+8ZJ0Qt6kK/IAt5b9s1RJ/C3HdnRfKX+9yqjmWb5a9
acFhzc7lUc4KFTiNogrk3Phbf71TLSCWGJEbnLfmkm3H5Gr8dbToYl/pX97I5Pys
HkG9azUCsr1/aoOlS6vXiC+2Mp0GVkFg1baobMjFhuevEMl2+WIAXB9fAWTUeOoh
nW7XuHBxSueZAY1VmeglkgsTBEyHsw==
=1Rx4
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--

