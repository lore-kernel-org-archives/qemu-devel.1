Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA95C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A27B20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP3Qa8K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A27B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUpa-0003j1-8b
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwUn0-0001S4-Bs
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwUmy-0007ke-Os
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:36:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwUmy-0007jP-L0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580232995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94J3Gu+Nq5MMh7LjEwYzrnfvjXwKsX1znh/4qdDeOPQ=;
 b=HP3Qa8K3Byr1rhv5S/lOlMCzOEpXWpBvd9gZ+ErIUjGBL9aG0bHxFVm/i7daZwL/6KH96R
 g6GFsQhMpoAiH0mUgkjZaPEnZEbPsYOYTdH7j36htMZfv05AQDVTD7lCqb7x7njutonbkV
 YwEfbCHiCO+JXCLjNEtFrF1eKsPBqHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-0MnlGpQbN1mbk0IURr7Q9Q-1; Tue, 28 Jan 2020 12:36:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FB33100551C;
 Tue, 28 Jan 2020 17:36:29 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57A0889A62;
 Tue, 28 Jan 2020 17:36:22 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:36:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 08/13] iotests: filter few more luks specific create
 options
Message-ID: <20200128173619.GA1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-9-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114193350.10830-9-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0MnlGpQbN1mbk0IURr7Q9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 09:33:45PM +0200, Maxim Levitsky wrote:
> This allows more tests to be able to have same output on both qcow2 luks =
encrypted images
> and raw luks images
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/087.out       | 6 +++---
>  tests/qemu-iotests/134.out       | 2 +-
>  tests/qemu-iotests/158.out       | 4 ++--
>  tests/qemu-iotests/188.out       | 2 +-
>  tests/qemu-iotests/189.out       | 4 ++--
>  tests/qemu-iotests/198.out       | 4 ++--
>  tests/qemu-iotests/common.filter | 6 ++++--
>  7 files changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
> index 2d92ea847b..b61ba638af 100644
> --- a/tests/qemu-iotests/087.out
> +++ b/tests/qemu-iotests/087.out
> @@ -34,7 +34,7 @@ QMP_VERSION
1> =20
>  =3D=3D=3D Encrypted image QCow =3D=3D=3D
> =20
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don encrypt.key-secret=3Dsec0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don

I'm not convinced about this - it feels like this is throwing
away relevant info to be validated about the test scenario

Can you give more info about the scenario this benefits us in ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


