Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BABC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C5921924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C5921924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtLq-0005ce-Qx
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtK1-0003Nw-LC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtK0-0007n5-M4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtK0-0007mt-GJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCBBD8553A;
 Thu, 19 Sep 2019 10:05:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22D0860872;
 Thu, 19 Sep 2019 10:05:52 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:05:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919100551.GF3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-3-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-3-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 19 Sep 2019 10:05:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 02/22] libqos: Rename i2c_send and
 i2c_recv
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:29PM +0000, Oleinik, Alexander wrote:
> The names i2c_send and i2c_recv collide with functions defined in
> hw/i2c/core.c. This causes an error when linking against libqos and
> softmmu simultaneously (for example when using qtest inproc). Rename the
> libqos functions to avoid this.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/libqos/i2c-imx.c  |  8 ++++----
>  tests/libqos/i2c-omap.c |  8 ++++----
>  tests/libqos/i2c.c      | 10 +++++-----
>  tests/libqos/i2c.h      |  4 ++--
>  tests/pca9552-test.c    | 10 +++++-----
>  5 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DUv8ACgkQnKSrs4Gr
c8iAwAf+In0zmwdMhTTS2ld7a5upVvVbVoWEYYbz3ihn48Z6zVsNBSK1P7iX9deM
2s2o6bGOXISuhOqZfN1M4jjFOYC42hUXZAcpBlBuqb6x0B1RgIfLS7Q1PbsyE7rh
1AJkD96bcSYMTUTzw2MvAE9V3JS+5ToflUeX85iLIVEFqSTVyfu05Axjg8Q2opYk
EMoOpaaB0p8gZ0Ou00JSmzY/kYH5Ib+jFVue/CeB01jAHHkx260b0jLwwAbE8ov+
DfQUCUDfS4v0IA5slhbAgTg4Uc98UDzGPpeMj1WFMeLAglXqL4CYSie65CioBie+
XRVq11OiyxWFGZdy/aAGgDdpWOoftw==
=92gj
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--

