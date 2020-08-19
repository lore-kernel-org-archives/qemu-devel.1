Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3952C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1502076E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMwyvQzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1502076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PZl-0005XR-M6
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PYm-00048T-1m
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:59:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PYj-0005Ak-EV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597849164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lP2fwmTL9XePyRW/WO2Laagp6h4OpRJNwEw1rzTcLkY=;
 b=WMwyvQzc55U9t9xm1hspRzqvJuFiFC5ayzpIuv6A0yv8vcoQCiNI6DR3F1Y+umIHQxXWRY
 9FU+wWbGHOx+dpCMuHlk3wojwq0xNt5qv14nsdktjIZVJcV4ho5ZCawZtpItpkRXq6STPO
 41iIsRK9AYXPwUmrA2hSOApiaiT0tcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-IheVSGKGOUGWqNZcq4oZyw-1; Wed, 19 Aug 2020 10:59:21 -0400
X-MC-Unique: IheVSGKGOUGWqNZcq4oZyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 970891015DCE;
 Wed, 19 Aug 2020 14:59:20 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E54310013C2;
 Wed, 19 Aug 2020 14:59:19 +0000 (UTC)
Date: Wed, 19 Aug 2020 15:59:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 01/12] block: simplify comment to BDRV_REQ_SERIALISING
Message-ID: <20200819145918.GI366841@stefanha-x1.localdomain>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200817091553.283155-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 12:15:42PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 1. BDRV_REQ_NO_SERIALISING doesn't exist already, don't mention it.
>=20
> 2. We are going to add one more user of BDRV_REQ_SERIALISING, so
>    comment about backup becomes a bit confusing here. The use case in
>    backup is documented in block/backup.c, so let's just drop
>    duplication here.
>=20
> 3. The fact that BDRV_REQ_SERIALISING is only for write requests is
>    omitted. Add a note.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block.h | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89PkYACgkQnKSrs4Gr
c8ha1gf8DvqbPZL7THys+dueez9Usu/DlTkw1PuRR4SxbKud5y/+A9FwA6pQr63U
J2vjs/xXjkyPYl3EnXGgW2s3v/c6Rb/Qj4zBZRt1w+A0gIUi8H/pKZy1X6JrhOv1
jBPwq/aCd55uDFvr3Sg4/WXlgtOExu/Sde4W7G3ZaPgckA7kBCpx71O2cqg2yLKV
j/lfyWYxy1vZ/OSAcLJVkzLudp3Qw562PxYq6F0EZVPkTNoU3ZapF4kNDeg9i5Bp
9fBPteo8qvSjzMXl+mDVSUIyGn+wROVP08kHbK/uLRy1MNyzlVqDRhO5wo9+avQu
yJZQ1m7Kg1JRcanUUkj3gKcuvVRexQ==
=7i4M
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--


