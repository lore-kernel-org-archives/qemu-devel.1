Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84172C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5849D2339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5849D2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GOA-00044C-Pk
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwT-0004HH-E4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwQ-0001G4-8o
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwP-00017U-OP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 707853082E72;
 Tue,  3 Sep 2019 21:02:05 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01CFD19D70;
 Tue,  3 Sep 2019 21:02:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:49 -0300
Message-Id: <20190903210201.14627-2-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 03 Sep 2019 21:02:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 01/13] includes: remove stale [smp|max]_cpus
 externs
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Commit a5e0b3311 removed these in favour of querying machine
properties. Remove the extern declarations as well.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190711130546.18578-1-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Like Xu <like.xu@linux.intel.com>
Fixes: a5e0b331193a ("vl.c: Replace smp global variables with smp machine=
 properties")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/sysemu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index d2c38f611a..44f18eb739 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -42,8 +42,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int smp_cpus;
-extern unsigned int max_cpus;
 extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_quit;
--=20
2.21.0


