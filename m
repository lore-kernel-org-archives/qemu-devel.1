Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA022C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DCD21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DCD21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsGx-0005wK-Rl
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvp-0005C9-LW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvk-0000JD-7d
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvj-0000Ho-0z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A48188383D
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 08:36:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBEEF1001B2C;
 Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A36921FCCE; Thu, 19 Sep 2019 10:36:30 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:29 +0200
Message-Id: <20190919083629.29998-27-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 19 Sep 2019 08:36:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 26/26] audio: fix ALSA period-length typo in
 documentation
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
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
index e9417e6561b8..877edc677160 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -446,7 +446,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
 #ifdef CONFIG_AUDIO_ALSA
     "-audiodev alsa,id=id[,prop[=value][,...]]\n"
     "                in|out.dev= name of the audio device to use\n"
-    "                in|out.period-len= length of period in microseconds\n"
+    "                in|out.period-length= length of period in microseconds\n"
     "                in|out.try-poll= attempt to use poll mode\n"
     "                threshold= threshold (in microseconds) when playback starts\n"
 #endif
@@ -552,7 +552,7 @@ ALSA specific options are:
 Specify the ALSA @var{device} to use for input and/or output.  Default
 is @code{default}.
 
-@item in|out.period-len=@var{usecs}
+@item in|out.period-length=@var{usecs}
 Sets the period length in microseconds.
 
 @item in|out.try-poll=on|off
-- 
2.18.1


