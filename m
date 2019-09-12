Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4E2C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F402081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F402081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Rdj-00073H-QJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 12:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i8Rc1-0005yt-Lf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i8Rby-0007l9-QM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:06:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i8Rby-0007kX-5Y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B4E4309BDAA;
 Thu, 12 Sep 2019 16:06:20 +0000 (UTC)
Received: from localhost (ovpn-116-134.ams2.redhat.com [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF7BB5C28F;
 Thu, 12 Sep 2019 16:06:19 +0000 (UTC)
Date: Thu, 12 Sep 2019 18:06:09 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190912160609.GO23174@stefanha-x1.localdomain>
References: <20190910090310.14032-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
Content-Disposition: inline
In-Reply-To: <20190910090310.14032-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 12 Sep 2019 16:06:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/ioc.c: try to reassure Coverity about
 qemu_iovec_init_extended
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--p/1JFEOz/hVXxMAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 12:03:10PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Make it more obvious, that filling qiov corresponds to qiov allocation,
> which in turn corresponds to total_niov calculation, based on mid_niov
> (not mid_len). Still add an assertion to show that there should be no
> difference.
>=20
> Reported-by: Coverity (CID 1405302)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  util/iov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16bPAACgkQnKSrs4Gr
c8gzrgf/U/gflo7VQq0x/WwnDB8t9nYL0PkSoRQgDSq8oYgN+QJ1xZ5+Cuvf6/r9
lcmh97Lzj+mdGiX1Ed3pydcewmqZ9FS7EtAUaqsYXpGlDegZ34TBnv78Vs2UjGqc
s/p3VIn4gDWC4OEIzWWn6J4xXtzMHV1PS5tCMg0/l8ijPw8C/RSGaIK77g0I/rkZ
hxVrsq+qWlESRvfVLGgmCZYS4oAHKpM9KFzz4caiysHeHFAvnDEpeytzMjh2a+ho
koHW9uMqdFphigMUEU4xbOBjbKjlq16r/HSjaqKcYtsdUrqqoi+QCTNd4mawdRId
qQ2Kd8KYpV7a11kz+V/PxhQ0NeCv6A==
=z8p7
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--

