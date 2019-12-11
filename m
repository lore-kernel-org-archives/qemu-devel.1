Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB93C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4696421556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oN8qPj0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4696421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2yk-0002Hc-Cn
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2ts-0005PV-Gx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tq-000391-NG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2tq-00037k-HE; Wed, 11 Dec 2019 09:23:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id b6so24267647wrq.0;
 Wed, 11 Dec 2019 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KTbcScOLjXllpK9umoeqVc/PDjmIqMW5fTameWTBrIo=;
 b=oN8qPj0jT+uo3AMAXS8VqupwT9RelTzEQBqYUNqK0iIKnznELXzRwmquB1uunWzg5g
 IsMBvDiPFXpLxyaqhRE/aMbHjLrIvb+14saNSGOeuuga3uNtM0tfYjPm452SA0+JASfS
 mP5ExkHo2pPLqmS2V156WMbX9Zf+VjTY/j+trOBrx17JkthX5sz8b5LpzoOpDSuT7U4k
 UP5QtJ1Z6XRLvJrAFJdO0HzMQ+dKAMB6Z9/qobqOsgK5XkBGx8h1niM31c99ZT8RrtNS
 nrtUQ9a3FN8JkUiGFI/6j3bUqk0fqcAly8Nk6i41oNO0/P0BSrvCdcS/N5XmKjl/OnIi
 D+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KTbcScOLjXllpK9umoeqVc/PDjmIqMW5fTameWTBrIo=;
 b=Ucu+ICvnl9pZnhOQ6H808sCBnoLjS+vGfZ8uvUW72KqSbfdOEFi4Sk+r6bja4l3SvI
 apy+e7W0W5X5g73R7t1DTgDn5pDA2I3N5HwXm7qIYWyjzfaz3U9khop2CqxXmVeqnnlr
 0oIFf+NdemB3wbnPGGGrFv6FJbTcbEBQl7fWUn56nkg1Y0SEXwAfi/etRwyPZNQ3ceZA
 vsp9M9onLY7Z69wRKQ5OGsikT/Y4CP3MEKdTSru4t2X45xh3q2xp4qVXJHQ+chOvElA9
 XitHlCc3vKnoxjY5RUR/ZfCuflc9h09IXFeFTrSFGyK1P2/WDm3W2/QMvPa6Wu4msl1B
 2Exg==
X-Gm-Message-State: APjAAAXSNtnAy6qbddzJdsAeZU9O93khNy2ko+HliNGjp+SDUdDh/50z
 q7GPXTFeCqPZ7Ng8Roq89T46mY5c
X-Google-Smtp-Source: APXvYqyJReA0qZLK4zO4VcBN0cU/v+F2bAwpe1awnganCfX8fr2Zi2UeuPOcHS90qWNi7if78+sPxg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr70174wrr.226.1576074213202;
 Wed, 11 Dec 2019 06:23:33 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g23sm2503783wmk.14.2019.12.11.06.23.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:23:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build-sys: do not include Windows SLIRP dependencies in $LIBS
Date: Wed, 11 Dec 2019 15:23:23 +0100
Message-Id: <1576074210-52834-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When including the internal SLIRP library, we should add all the libraries that
it needs for the build.  Right now they are all included by QEMU, but -liphlpapi
is not needed without slirp.  Move it from LIBS to slirp_libs.

Based on a patch by Marc-André Lureau.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 6099be1..d16dad2 100755
--- a/configure
+++ b/configure
@@ -926,7 +926,7 @@ if test "$mingw32" = "yes" ; then
   DSOSUF=".dll"
   # MinGW needs -mthreads for TLS and macro _MT.
   QEMU_CFLAGS="-mthreads $QEMU_CFLAGS"
-  LIBS="-lwinmm -lws2_32 -liphlpapi $LIBS"
+  LIBS="-lwinmm -lws2_32 $LIBS"
   write_c_skeleton;
   if compile_prog "" "-liberty" ; then
     LIBS="-liberty $LIBS"
@@ -6069,6 +6069,9 @@ case "$slirp" in
     mkdir -p slirp
     slirp_cflags="-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
     slirp_libs="-L\$(BUILD_DIR)/slirp -lslirp"
+    if test "$mingw32" = "yes" ; then
+      slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
+    fi
     ;;
 
   system)
-- 
1.8.3.1


