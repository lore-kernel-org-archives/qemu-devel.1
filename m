Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D59C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2572137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhYBy/Kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2572137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4Hl-0000eB-0R
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL4GI-0008JY-9Z
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL4GF-0008F1-QT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600865559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MY2L6MP8h2q22ZuivqcxPNYJ2lDv9AmRsIXOer2O21A=;
 b=VhYBy/KxQm+hfpwqP5pUYMnqArZiw02HDaA7Z6knuQICB/HHIz6YllbPKq7UL8SZWTnGH5
 86B31wapzcdVhnH6TapmoaP15mz1VuKcUuGrw9szuOMKRCMD1yS83qmYrTGLiQyuWVqRBJ
 zKQQBe1Du+kqi/0hCfwQE/qhdtfcHkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-DByW4y0CPR-MYmsZLXnN_w-1; Wed, 23 Sep 2020 08:52:36 -0400
X-MC-Unique: DByW4y0CPR-MYmsZLXnN_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1B91084C80;
 Wed, 23 Sep 2020 12:52:35 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A9E160BEC;
 Wed, 23 Sep 2020 12:52:35 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:52:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] fdmon-poll: reset npfd when upgrading to
 fdmon-epoll
Message-ID: <20200923125234.GI51019@stefanha-x1.localdomain>
References: <20200915120339.702938-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200915120339.702938-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 01:03:37PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Rebased onto qemu.git/master for meson
>=20
> Fix an assertion failure when aio_poll() is called in a aio_disable_exter=
nal()
> region. The failure happens when fdmon-poll is first upgraded to fdmon-ep=
oll
> and then downgraded again due to aio_disable_external().
>=20
> Stefan Hajnoczi (2):
>   fdmon-poll: reset npfd when upgrading to fdmon-epoll
>   tests: add test-fdmon-epoll
>=20
>  MAINTAINERS              |  1 +
>  tests/test-fdmon-epoll.c | 73 ++++++++++++++++++++++++++++++++++++++++
>  util/fdmon-poll.c        |  1 +
>  tests/meson.build        |  3 ++
>  4 files changed, 78 insertions(+)
>  create mode 100644 tests/test-fdmon-epoll.c
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rRRIACgkQnKSrs4Gr
c8jJVwf/efEr5Iir3o22Wu1gXwSQs3e8nF9XOj9p6WishaO4ExQCmRFvh3TNQt4C
XmTHml+P7XfrnTxC2CCcbJcSlBPDHGdmqZ3Gz+I5WEI8jZE/bkExz1jX/9b6Jrp6
p3eOWNvZ14tfP3gURlREJNE63H/EmWK3CZ/yiTHwF2Fq1zMEhpl5co2Nxi7KiKCP
HVgCJ3ggPsFAQ2sy3nFBqCc5Zj4mWJKLXpznkFipqs0RUtrys/IUAH/S/2aSKjI4
g8bzxCtVOOan0amQwK4y9Shiag7XHhnyS+zAcignc/GUETBQWiH4F9QQayhNnDZr
32oqKQTADGs3V7bIOczH0RlADH42dQ==
=D5w8
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--


