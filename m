Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C621C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAA524677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8Qp/qLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAA524677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaCK-0006Og-AF
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBaBO-00051m-HB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBaBN-0002Tx-IC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBaBN-0002St-Dv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583828649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnhJs1Qv5CJ2LifBUYIlnTyitzEv0YQIGzR5BcCJIhw=;
 b=e8Qp/qLgumo6llwOcKwvJ/FwwvtzOA3kYVR64VzFhInNx9sbI0HFMg8dCtWxBqXxdPjcJx
 3CRuzlbZhVcmqas7INPhyqZcMrQ6a7i9euBW7+kfgJcFexzs5h+k/TPK8mt/Fk2mLLEuWJ
 biR2B7t5Xffn353ak2GKl+R+t6HK5NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-ML854L6eOFWeCGX5_YsnRQ-1; Tue, 10 Mar 2020 04:24:06 -0400
X-MC-Unique: ML854L6eOFWeCGX5_YsnRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA3F18C8C01;
 Tue, 10 Mar 2020 08:24:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C962060BF3;
 Tue, 10 Mar 2020 08:24:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1F0A49D1F; Tue, 10 Mar 2020 09:24:02 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] usb/hcd-ehci: Remove redundant statements
Date: Tue, 10 Mar 2020 09:24:02 +0100
Message-Id: <20200310082402.22839-3-kraxel@redhat.com>
In-Reply-To: <20200310082402.22839-1-kraxel@redhat.com>
References: <20200310082402.22839-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

The "again" assignment is meaningless before g_assert_not_reached.
In addition, the break statements no longer needs to be after
g_assert_not_reached.

Clang static code analyzer show warning:
hw/usb/hcd-ehci.c:2108:13: warning: Value stored to 'again' is never read
            again =3D -1;
            ^       ~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200226084647.20636-13-kuhn.chenqun@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 56ab2f457f4c..29d49c2d7e68 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1301,7 +1301,6 @@ static void ehci_execute_complete(EHCIQueue *q)
         /* should not be triggerable */
         fprintf(stderr, "USB invalid response %d\n", p->packet.status);
         g_assert_not_reached();
-        break;
     }
=20
     /* TODO check 4.12 for splits */
@@ -2105,9 +2104,7 @@ static void ehci_advance_state(EHCIState *ehci, int a=
sync)
=20
         default:
             fprintf(stderr, "Bad state!\n");
-            again =3D -1;
             g_assert_not_reached();
-            break;
         }
=20
         if (again < 0 || itd_count > 16) {
--=20
2.18.2


