Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA54C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A4206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY7zuboI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A4206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihf4i-0007TW-2n
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihexZ-00088s-2W
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihexV-0003sL-LV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihexV-0003pt-Eh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576697169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvKn3E3vtip/x6nya4V8EKu5DfUXiZ0uZoETj2uOGIA=;
 b=XY7zuboI4EDk1jbicx6fgWAMwqopGyBorE6PU7djruSg42ylBNsiV8o1xRDGeotdOLZz2p
 15TGVjZD0GMOPlPCPPCbgZPmTOiM7AgmRMX5GxWl5lQWSo4t0aTRZ3Kj9W47RGXRfL02zy
 0mfw+W6+kTgzY1KyHfnsN1Uf8Ljsjj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-0lMZT4nyOxiOKML3-m51UQ-1; Wed, 18 Dec 2019 14:26:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42AE212BA84;
 Wed, 18 Dec 2019 19:26:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C44D60C81;
 Wed, 18 Dec 2019 19:25:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] hw/timer/aspeed_timer: Add a fall through comment
Date: Wed, 18 Dec 2019 20:25:23 +0100
Message-Id: <20191218192526.13845-4-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-1-philmd@redhat.com>
References: <20191218192526.13845-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0lMZT4nyOxiOKML3-m51UQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
---
 hw/timer/aspeed_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index a8c38cc118..c91f18415c 100644
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
2.21.0


