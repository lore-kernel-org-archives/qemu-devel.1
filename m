Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BEAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01F22075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fU8EOLZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01F22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTum-000757-0A
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTb7-0006Ze-0X
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTb6-0000P5-2S
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTb5-0000Nh-UY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3yi+86XKGWerRekgayIoQ0UIxyR9uQYIXSVaTtp5bc=;
 b=fU8EOLZ8W8JWOUaw1HA5XNlFj8NKposxyOf4sBQkPVEiowabg8hTO93sPQiwqij+I79Nm/
 Pk6rS8/ziv8wsXbLl2o8d8fixyZtnYv/Qr6nP+r1/nA2PWrF/bJDaJtjr7Om+5WnWXbZMs
 VNTtRx8zS65VOY70xPnGEFnfQj7R3kM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-uCWCR4z_Mei5AjSMZ-wKHA-1; Mon, 06 Jan 2020 09:43:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A551118E16;
 Mon,  6 Jan 2020 14:43:07 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98D706A83B;
 Mon,  6 Jan 2020 14:43:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/34] iotests: Inject space into -ocompat=0.10 in 051
Date: Mon,  6 Jan 2020 15:41:49 +0100
Message-Id: <20200106144206.698920-18-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uCWCR4z_Mei5AjSMZ-wKHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It did not matter before, but now that _make_test_img understands -o, we
should use it properly here.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20191107163708.833192-11-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/051 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index a13bce2fd0..d7294d80d9 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -158,7 +158,7 @@ echo
 echo =3D=3D=3D With version 2 images enabling lazy refcounts must fail =3D=
=3D=3D
 echo
=20
-_make_test_img -ocompat=3D0.10 $size
+_make_test_img -o compat=3D0.10 $size
=20
 run_qemu -drive file=3D"$TEST_IMG",format=3Dqcow2,lazy-refcounts=3Don
 run_qemu -drive file=3D"$TEST_IMG",format=3Dqcow2,lazy-refcounts=3Doff
--=20
2.24.1


