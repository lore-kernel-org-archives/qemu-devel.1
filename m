Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F3A21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL+zlvkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F3A21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufKb-0004wH-TP
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuct6-0007iC-S8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuct4-0006sa-J2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuct4-0006sV-Ft
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jg3TFcOdp/VojYYyJF7Z3OkvAG5voPI06xlV+CkuWU=;
 b=JL+zlvkJBoALhUnxXVl22iWYYrIrqQCQUDxieK4+ldgd6sUnXqU7jOyL1usIABKgwT7xuy
 G0yPaer0+dFTGDcZSYLSwK9rjj0L1+fpW5w6+hS3RqQImjUoh0njAGX6y495FPhQYh24Hd
 5uSMXUjneTDhjtlT0PSuKzGyLu6ev84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-bv_6PkVbMq-qrX34f9HTyQ-1; Thu, 23 Jan 2020 08:51:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09BCA18C43C1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:08 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 063471CB;
 Thu, 23 Jan 2020 13:51:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/59] hw/timer/aspeed_timer: Add a fall through comment
Date: Thu, 23 Jan 2020 14:49:58 +0100
Message-Id: <1579787449-27599-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bv_6PkVbMq-qrX34f9HTyQ-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=3D2:

  hw/timer/aspeed_timer.c: In function =E2=80=98aspeed_timer_set_value=E2=
=80=99:
  hw/timer/aspeed_timer.c:283:24: error: this statement may fall through [-=
Werror=3Dimplicit-fallthrough=3D]
    283 |         if (old_reload || !t->reload) {
        |             ~~~~~~~~~~~^~~~~~~~~~~~~
  hw/timer/aspeed_timer.c:287:5: note: here
    287 |     case TIMER_REG_STATUS:
        |     ^~~~
  cc1: all warnings being treated as errors

Add the missing fall through comment.

Fixes: 1403f364472
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191218192526.13845-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/aspeed_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index a8c38cc..c91f184 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -283,7 +283,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState=
 *s, int timer, int reg,
         if (old_reload || !t->reload) {
             break;
         }
-
+        /* fall through to re-enable */
     case TIMER_REG_STATUS:
         if (timer_enabled(t)) {
             uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
--=20
1.8.3.1



