Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FF5C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D16A20673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D16A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCeDE-0005M3-3d
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iCeB6-0003Z8-2R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iCeB4-0000qc-Un
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iCeB4-0000q8-PC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1BD921DC5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70C7B19C58;
 Tue, 24 Sep 2019 06:19:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 910459D70; Tue, 24 Sep 2019 08:19:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] audio: fix ALSA period-length typo in documentation
Date: Tue, 24 Sep 2019 08:19:37 +0200
Message-Id: <20190924061951.27916-3-kraxel@redhat.com>
In-Reply-To: <20190924061951.27916-1-kraxel@redhat.com>
References: <20190924061951.27916-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 24 Sep 2019 06:19:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Fixes: f0b3d811529 ("audio: -audiodev command line option: documentation")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190918095335.7646-4-stefanha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 569958fc0c77..565d7af8c208 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -445,7 +445,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
 #ifdef CONFIG_AUDIO_ALSA
     "-audiodev alsa,id=id[,prop[=value][,...]]\n"
     "                in|out.dev= name of the audio device to use\n"
-    "                in|out.period-len= length of period in microseconds\n"
+    "                in|out.period-length= length of period in microseconds\n"
     "                in|out.try-poll= attempt to use poll mode\n"
     "                threshold= threshold (in microseconds) when playback starts\n"
 #endif
@@ -545,7 +545,7 @@ ALSA specific options are:
 Specify the ALSA @var{device} to use for input and/or output.  Default
 is @code{default}.
 
-@item in|out.period-len=@var{usecs}
+@item in|out.period-length=@var{usecs}
 Sets the period length in microseconds.
 
 @item in|out.try-poll=on|off
-- 
2.18.1


