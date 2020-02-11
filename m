Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8AFC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF7C20842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVV4/xX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF7C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aSv-0001sX-BY
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1j1aQ5-0007uy-0D
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1j1aQ3-0006FF-Cz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:38:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1j1aQ3-0006Cm-93
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581446278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1FIkEpSl8qkDbHz+wUVRnPVG2Mdsen+3/qcU+l5bVnQ=;
 b=JVV4/xX3DLZ8Nong22WTAWMyKhXPDa1EeLMo33OXQBge/0rTUq2pSigt2KxaXyzKLKSxP7
 uxkNIltGTAVISj8+FhFBE3ccV3z/y5CPG15l4lvL8E6yAvE50/67HXCvc6yQf4TXZGiamL
 kddvBYrcCq53fgYtQh+Vytl990RhmZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-ZDF3vHx-OcqPjI_JhZZ_BA-1; Tue, 11 Feb 2020 13:37:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F94D13EA
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 18:37:48 +0000 (UTC)
Received: from kinshicho.usersys.redhat.com (unknown [10.43.2.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A33090069;
 Tue, 11 Feb 2020 18:37:47 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qapi: Expand documentation for LostTickPolicy
Date: Tue, 11 Feb 2020 19:37:44 +0100
Message-Id: <20200211183744.210298-1-abologna@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZDF3vHx-OcqPjI_JhZZ_BA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Andrew Jones <drjones@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current documentation is fairly terse and not easy to decode
for someone who's not intimately familiar with the inner workings
of timer devices. Expand on it by providing a somewhat verbose
description of what behavior each policy will result in, as seen
from both the guest OS and host point of view.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
---
This information is reported pretty much word by word in

  https://libvirt.org/formatdomain.html#elementsTime

so I'm hoping I can get the QEMU documentation updated and then just
merge back the changes.

 qapi/misc.json | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 33b94e3589..cd7445d29f 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -163,17 +163,29 @@
 ##
 # @LostTickPolicy:
 #
-# Policy for handling lost ticks in timer devices.
-#
-# @discard: throw away the missed tick(s) and continue with future injecti=
on
-#           normally.  Guest time may be delayed, unless the OS has explic=
it
-#           handling of lost ticks
-#
-# @delay: continue to deliver ticks at the normal rate.  Guest time will b=
e
-#         delayed due to the late tick
-#
-# @slew: deliver ticks at a higher rate to catch up with the missed tick. =
The
-#        guest time should not be delayed once catchup is complete.
+# Policy for handling lost ticks in timer devices.  Ticks end up getting
+# lost when, for example, the guest is paused.
+#
+# @discard: throw away the missed ticks and continue with future injection
+#           normally.  The guest OS will see the timer jump ahead by a
+#           potentially quite significant amount all at once, as if the
+#           intervening chunk of time had simply not existed; needless to
+#           say, such a sudden jump can easily confuse a guest OS which is
+#           not specifically prepared to deal with it.  Assuming the guest
+#           OS can deal correctly with the time jump, the time in the gues=
t
+#           and in the host should now match.
+#
+# @delay: continue to deliver ticks at the normal rate.  The guest OS will
+#         not notice anything is amiss, as from its point of view time wil=
l
+#         have continued to flow normally.  The time in the guest should n=
ow
+#         be behind the time in the host by exactly the amount of time dur=
ing
+#         which ticks have been missed.
+#
+# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
+#        The guest OS will not notice anything is amiss, as from its point
+#        of view time will have continued to flow normally.  Once the time=
r
+#        has managed to catch up with all the missing ticks, the time in
+#        the guest and in the host should match.
 #
 # Since: 2.0
 ##
--=20
2.24.1


