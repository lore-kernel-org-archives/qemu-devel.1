Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA50ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BEF20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BEF20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPNB-00071c-SK
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1iKOXR-0004qu-70
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1iKOXP-00085m-1J
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1iKOXO-00083U-SG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 853DEA3CD88
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 15:15:00 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-69.pek2.redhat.com
 [10.72.12.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6A2A19C58;
 Tue, 15 Oct 2019 15:14:56 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-options.hx: Update for reboot-timeout parameter
Date: Tue, 15 Oct 2019 23:14:51 +0800
Message-Id: <20191015151451.727323-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 15 Oct 2019 15:15:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-Mailman-Approved-At: Tue, 15 Oct 2019 12:04:23 -0400
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
Cc: philmd@redhat.com, Han Han <hhan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since ee5d0f89d, -1 is not valid for the value of reboot-timeout. Update
that in qemu-options doc.

Signed-off-by: Han Han <hhan@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 793d70ff..6b92a916 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -327,8 +327,8 @@ format(true color). The resolution should be supporte=
d by the SVGA mode, so
 the recommended is 320x240, 640x480, 800x640.
=20
 A timeout could be passed to bios, guest will pause for @var{rb_timeout}=
 ms
-when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will n=
ot
-reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
+when boot failed, then reboot. If @option{reboot-timeout} is not set,
+guest will not reboot by default. Currently Seabios for X86
 system support it.
=20
 Do strict boot via @option{strict=3Don} as far as firmware/BIOS
--=20
2.23.0


