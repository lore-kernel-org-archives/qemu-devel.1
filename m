Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E379CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4C22087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enjAm0mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4C22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytzr-0001Ua-TS
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iytyE-0007jB-Eq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iytyD-0002ep-Fn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:54:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iytyD-0002dv-CD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580806448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6tQJYyYoXBbbTDwzrxl2/u15ybGKaHn5/Slk+lukc8=;
 b=enjAm0mFccsrSkmlQqmfpeW0uCM+0fhkVFzBY4Ej4Dvenr5rllIdAELAQ1WbEFgorWRoQl
 quD9jgGJI4HVc98e9HHlQDqjGe3odvixQnqP1H/dfVBxADh2nU6apog/C//CTI+6Zxc+iO
 A6fgiK1/Mr0+4PlBi1Pwvwuh9O0Bgqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-jW-6l_Z-P2KqMk1pUimDfA-1; Tue, 04 Feb 2020 03:54:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2DF1401;
 Tue,  4 Feb 2020 08:54:05 +0000 (UTC)
Received: from thuth.com (ovpn-116-39.ams2.redhat.com [10.36.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51AE98ECE2;
 Tue,  4 Feb 2020 08:54:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 14/14] configure: Fix typo of the have_afalg variable
Date: Tue,  4 Feb 2020 09:53:58 +0100
Message-Id: <20200204085358.17191-3-thuth@redhat.com>
In-Reply-To: <20200204085358.17191-1-thuth@redhat.com>
References: <20200204085358.17191-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jW-6l_Z-P2KqMk1pUimDfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable is called 'have_afalg' and not 'hava_afalg'.

Fixes: f0d92b56d88 ('introduce some common functions for af_alg backend')
Message-Id: <20200203160046.23194-1-thuth@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 5095f01728..115dc38085 100755
--- a/configure
+++ b/configure
@@ -5843,7 +5843,7 @@ fi
=20
 ##########################################
 # check for usable AF_ALG environment
-hava_afalg=3Dno
+have_afalg=3Dno
 cat > $TMPC << EOF
 #include <errno.h>
 #include <sys/types.h>
--=20
2.18.1


