Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D04C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF43C23787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBWYpBEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF43C23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQBL-0000TZ-31
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLQ9e-00087H-IR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLQ9d-0002WD-1H
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600949716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfwJqohAOhJmkJlu+/cTjense/pDE/p2nZ4sHKPHKFs=;
 b=iBWYpBEBLgLCrZZQ5D0ctAzpHbIDs2rDUvi6G3lCz5PTvhTeVkEIOq6oALCbriCsAaDccu
 5gs6CORLZ4KKM/58jpP6sUQhim8K1I6ZsbzAbgApbuZUGBdRp42cjyZHP6Pw8VpBtkq4Kb
 mJ9lidtA1GTgXBds26s6I9CNEf2BXGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-TvvOZfHuM0SRT6JFvrxxVg-1; Thu, 24 Sep 2020 08:15:12 -0400
X-MC-Unique: TvvOZfHuM0SRT6JFvrxxVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF83581CAFB;
 Thu, 24 Sep 2020 12:15:10 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7531155785;
 Thu, 24 Sep 2020 12:15:10 +0000 (UTC)
Date: Thu, 24 Sep 2020 13:15:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 6/7] block: drop bdrv_prwv
Message-ID: <20200924121509.GY62770@stefanha-x1.localdomain>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-7-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/q/BUR4W+hUV5fU1"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/q/BUR4W+hUV5fU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:44:10PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Now that we are not maintaining boilerplate code for coroutine
> wrappers, there is no more sense in keeping the extra indirection layer
> of bdrv_prwv().  Let's drop it and instead generate pure bdrv_preadv()
> and bdrv_pwritev().
>=20
> Currently, bdrv_pwritev() and bdrv_preadv() are returning bytes on
> success, auto generated functions will instead return zero, as their
> _co_ prototype. Still, it's simple to make the conversion safe: the
> only external user of bdrv_pwritev() is test-bdrv-drain, and it is
> comfortable enough with bdrv_co_pwritev() instead. So prototypes are
> moved to local block/coroutines.h. Next, the only internal use is
> bdrv_pread() and bdrv_pwrite(), which are modified to return bytes on
> success.
>=20
> Of course, it would be great to convert bdrv_pread() and bdrv_pwrite()
> to return 0 on success. But this requires audit (and probably
> conversion) of all their users, let's leave it for another day
> refactoring.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/coroutines.h      | 10 ++++-----
>  include/block/block.h   |  2 --
>  block/io.c              | 49 ++++++++---------------------------------
>  tests/test-bdrv-drain.c |  2 +-
>  4 files changed, 15 insertions(+), 48 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/q/BUR4W+hUV5fU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sjc0ACgkQnKSrs4Gr
c8gDRAgAxO1bdxysdOYk1hQS4/fbghkNxThBAetPPVWFuo2ln3b+oi5uGON1tQ5d
IG0RUiDuxUdZxwKrJ9dQEq4+38jaV4ZTI+wC7j4sin+3CAGs+SOXByV8Ovw/uHq/
5WBZzkdwcE76sIxNPpWgVjsOzDFxZgeq1sdqYvDGTEXkInD3/8Gj5C/mR+SMrahI
JUHeA4XErqnnTqu1DuuRMuKC9gaNe1GVdNtqtvmTw3YUenza+u9dcKGL8Y9Y4dVL
ko8u1dZcGfI4lbZ2I/9ttalmXJcLyEWkjUB4AyTaGupktVNGOT5vnWMyp6GwtZUk
n4/5gGqbkWF2kMXMEsjXo/FFiW1s3w==
=IDBo
-----END PGP SIGNATURE-----

--/q/BUR4W+hUV5fU1--


