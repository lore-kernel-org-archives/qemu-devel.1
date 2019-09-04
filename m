Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A8C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDA42087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDA42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5aQV-0007cb-6V
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 14:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5aOO-0006Fs-Vb
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5aOO-0005X9-34
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5aOM-0005Sc-Am
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:52:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EFA310C6961
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 18:52:29 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 353055D6D0;
 Wed,  4 Sep 2019 18:52:29 +0000 (UTC)
Date: Wed, 4 Sep 2019 19:52:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190904185228.GI26826@stefanha-x1.localdomain>
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline
In-Reply-To: <20190904130047.25808-2-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 04 Sep 2019 18:52:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/6] tests/migration: Do not use
 functions anymore that rely on global_qtest
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


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 03:00:42PM +0200, Thomas Huth wrote:
> The migration tests deal with multiple test states, so we really should
> not use functions here that rely on the single global_qtest variable.
> Switch from qtest_start() to qtest_init() to make sure that global_qtest
> is not set anymore. This also revealed a regression in the migrate()
> function: It has once been converted to use the qtest_qmp() function,
> but commit b5bbd3f315d686bd511 ("Clean up string interpolation into QMP,
> part 2") accidentally reverted it back to qmp().
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/migration-test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wB+wACgkQnKSrs4Gr
c8hangf/fBnTgagIX9v9MdqkLhfKxx3JEVlMvwHQMZbKe/SsFL99C2xbF0wUJYxE
ge0zZBpqe09ucTpxAhUXM8dn4ybGuPO0atgiEj2kTkeU9SDqUi1C+9OV9VEaTUvl
yOryL7AJ8vsWYD4EQRzndSieOWKW10BGn5sfgyyZVDJ6hCBqhHCtadoddkortGoJ
sWvgd7b8oTVdFg6zKZgKoxKKs2QC4UUGO+RKcUtAxtIEq8mVlHg+caGLtsDfIS67
Iue/ebsPkc1Pfe17KoBvu4Y8FJKkvyUp3J0O1vlQ5MUWshwKnb5qAT8A5h+r7qTg
5gu80hbMMOzFuC1km8e8mupCjB5UHQ==
=nXFj
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--

