Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D2C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4587E214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4587E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWvU-0002Yo-P5
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAWew-0003Pk-De
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAWev-0007I9-AW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAWev-0007Hf-5L
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77E2E300CB2B;
 Wed, 18 Sep 2019 09:54:00 +0000 (UTC)
Received: from localhost (unknown [10.36.118.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08B551001B30;
 Wed, 18 Sep 2019 09:53:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 10:53:35 +0100
Message-Id: <20190918095335.7646-4-stefanha@redhat.com>
In-Reply-To: <20190918095335.7646-1-stefanha@redhat.com>
References: <20190918095335.7646-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 18 Sep 2019 09:54:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/3] audio: fix ALSA period-length typo in
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
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: f0b3d811529 ("audio: -audiodev command line option: documentation"=
)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 6d7fe57dd4..0f79c70c37 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -445,7 +445,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
 #ifdef CONFIG_AUDIO_ALSA
     "-audiodev alsa,id=3Did[,prop[=3Dvalue][,...]]\n"
     "                in|out.dev=3D name of the audio device to use\n"
-    "                in|out.period-len=3D length of period in microsecon=
ds\n"
+    "                in|out.period-length=3D length of period in microse=
conds\n"
     "                in|out.try-poll=3D attempt to use poll mode\n"
     "                threshold=3D threshold (in microseconds) when playb=
ack starts\n"
 #endif
@@ -546,7 +546,7 @@ ALSA specific options are:
 Specify the ALSA @var{device} to use for input and/or output.  Default
 is @code{default}.
=20
-@item in|out.period-len=3D@var{usecs}
+@item in|out.period-length=3D@var{usecs}
 Sets the period length in microseconds.
=20
 @item in|out.try-poll=3Don|off
--=20
2.21.0


