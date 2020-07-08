Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430D5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0952E20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9+C1Eus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0952E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIYZ-0007ou-9G
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIH4-0003iM-NU
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:10:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIH3-0007qt-1h
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDfH0AX/DwK7ZPvF71x75ez1WGs/pKHu/0moSnyPVj0=;
 b=d9+C1EusEhXRbVbx9bB7IcX34B+qJt0YMUnlyOvuv1rIkPYBfmzzasVMZZi+nMxEHng6X6
 qxoEsGkJFhLGlx4fB+YFfizYtKhZec1pc61EHvoBkF0Gktt0xUhen4yV3bRup2HA/xaf3y
 jfXOtghLYZAjh8A8tHirlMT/e67yrhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-bGZb2fwBM2KkRmYhrdDfoA-1; Wed, 08 Jul 2020 08:09:43 -0400
X-MC-Unique: bGZb2fwBM2KkRmYhrdDfoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9965185B3AD;
 Wed,  8 Jul 2020 12:09:41 +0000 (UTC)
Received: from localhost (ovpn-115-17.ams2.redhat.com [10.36.115.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD9460C80;
 Wed,  8 Jul 2020 12:09:41 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:09:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 5/5] iotests: add 298 to test new preallocate filter driver
Message-ID: <20200708120940.GE459887@stefanha-x1.localdomain>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200620143649.225852-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 20, 2020 at 05:36:49PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/298     | 45 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/298.out |  5 +++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 51 insertions(+)
>  create mode 100644 tests/qemu-iotests/298
>  create mode 100644 tests/qemu-iotests/298.out

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Ft4QACgkQnKSrs4Gr
c8jwCQf+NqjKv/xfL23GmUVsrgS/FdAAEejXstmrJE9HeQkZYzabP0sDDwaYhuY2
J7VJ4xfAJuhxonwFJpLoSyF9nuu5F1tbwI/lMPYAmkbaBR4gDmgkJ3ikTEiXY6U/
VnWwuDuPra4b1TrC0BItcgxz8458SKNNjfpVJHG4BBboqh6eb+jf4SZtsSxUUzTk
ukgk6a5ThPXSH1zohrW69mVhlwoU8EdKLygRDBY7nprdXRSuUchGH379QXMbfe7R
yMpxaSHnW3O+l0TPCIt1BUFIaJtCQDVZaBV3o2+R966FgDE5Qv7MwYaJSEZvbxKj
foHrSBpQy83cbbV3i22vgqqtnu9szA==
=0NMl
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--


