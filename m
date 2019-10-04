Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C66AC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7658921D81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7658921D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNAk-0000Sh-JS
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iGN8a-00072b-U7
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iGN8Z-0007tF-SD
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iGN8Z-0007sj-My
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:56:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09332309B142
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 12:56:46 +0000 (UTC)
Received: from localhost (unknown [10.36.118.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 211B910013A7;
 Fri,  4 Oct 2019 12:56:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Subject: [PATCH] audio: add -audiodev pa,in|out.latency= to documentation
Date: Fri,  4 Oct 2019 13:56:41 +0100
Message-Id: <20191004125641.24383-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 04 Oct 2019 12:56:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "latency" parameter wasn't covered by the documentation.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Hi Gerd,
You asked me to resend this patch because there was a conflict.  I have
rebased it onto qemu.git/master (4f59102571fc).

 qemu-options.hx | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6ac5..5c27c57273 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -470,6 +470,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]\n"
     "                server=3D PulseAudio server address\n"
     "                in|out.name=3D source/sink device name\n"
+    "                in|out.latency=3D desired latency in microseconds\n=
"
 #endif
 #ifdef CONFIG_AUDIO_SDL
     "-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]\n"
@@ -630,6 +631,10 @@ Sets the PulseAudio @var{server} to connect to.
 @item in|out.name=3D@var{sink}
 Use the specified source/sink for recording/playback.
=20
+@item in|out.latency=3D@var{usecs}
+Desired latency in microseconds.  The PulseAudio server will try to hono=
r this
+value but actual latencies may be lower or higher.
+
 @end table
=20
 @item -audiodev sdl,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
--=20
2.21.0


