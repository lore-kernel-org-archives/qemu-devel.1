Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1933BC352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D560A20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNVUDmXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D560A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Odg-0008P1-2G
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2Oba-0004dD-He
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObZ-000732-EA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:14 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObZ-00071t-81
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id n10so6978807wrm.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/GXo767UdRFEyYDVqlkyBO/vQxNmKoLjr1aO6Lp1dSk=;
 b=SNVUDmXLeWx/ExjMctr3wCst0bLflOLN1++mOAWbwIEWiLK7AdAhEnU0ymZHkCDrI1
 6S4OjSN3O+fKKYksSFXBbqW7DMO6/L8AFlBx7AuueUQNEKRBFhU/w6Kj8oy9pzeJ8dYZ
 jfaLZ9OuE/HUbcTrjjDheww6xITVvi8HETzdS2O8jEB003NZq01R9/xm8uVJJkT2OhND
 3WLQmPLF2WCcHIOdUqarNloVg/K2lcf/k7d2ViYy3hHiNtn0dHIkz50DK8dUVl7GDGu4
 N01C6rFPXxKaMCfFK3TYe+HIiG8cCs67+u5jGNWNO/BpJi20HPTNZhV+0CWW+jDFAhE9
 0lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/GXo767UdRFEyYDVqlkyBO/vQxNmKoLjr1aO6Lp1dSk=;
 b=hSvlnFtG/6KjXbVdMvTm/opzSmdgGF+zQIHIdP09ZfaVPz39IbQ++BHrzCJNNcAUqH
 GhyR/b1cJ4oMvBBi/b3qw81kDnTQ9J9ubMqVKWQet49V3yebZVpqr/BFuhWrYEHOLIUP
 ClbWxlrrjzFb6jBMh94M67FuJfvM1Q4ISsl6uCV9BsEruwZywQNn3Z7eJTI/rCd5hUkn
 R6TmD701ryrWiGBD+NR6l1FHFw8Hh9Un1XLnzU8021Ad+wclqNAv0Xu87lgOakBmcPfK
 /N/UWS9U4V98eWf/YBWmaWttveOHl7IBjhwSkXPnzrB9YgNp4VCLBTDde8TUfujoFvpc
 II8w==
X-Gm-Message-State: APjAAAUAeIM7TvJ2ZGjA/hI3R3BaeZE47kVVY2X2+kYQg4fTkzWpuBPh
 maxQC7t7r4Tr+rAYr+ZxV+c=
X-Google-Smtp-Source: APXvYqxZCHTcECigzvU8RazFsk8YtTr1gWYMURQgj+9RoZbeBYgExNu4B6ujtzQD5P6vVISJ4n6Erw==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr62122wru.57.1581639192269;
 Thu, 13 Feb 2020 16:13:12 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm4679230wrx.87.2020.02.13.16.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 16:13:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 5/5] hw/display/artist: Remove dead code (CID 1419388 &
 1419389)
Date: Fri, 14 Feb 2020 01:13:02 +0100
Message-Id: <20200214001303.12873-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214001303.12873-1-f4bug@amsat.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity reports:

  *** CID 1419388:  Control flow issues  (DEADCODE)
  /hw/display/artist.c: 739 in draw_line_xy()
  733         if (endy < 0) {
  734             endy = 0;
  735         }
  736
  737
  738         if (endx < 0) {
  >>>     CID 1419388:  Control flow issues  (DEADCODE)
  >>>     Execution cannot reach this statement: "return;".
  739             return;
  740         }
  741
  742         if (endy < 0) {
  743             return;
  744         }

  *** CID 1419389:  Control flow issues  (DEADCODE)
  /hw/display/artist.c: 743 in draw_line_xy()
  737
  738         if (endx < 0) {
  739             return;
  740         }
  741
  742         if (endy < 0) {
  >>>     CID 1419389:  Control flow issues  (DEADCODE)
  >>>     Execution cannot reach this statement: "return;".
  743             return;
  744         }
  745
  746         trace_artist_draw_line(startx, starty, endx, endy);
  747         draw_line(s, startx, starty, endx, endy, false, -1, -1);
  748     }

Fixes: Covertiy CID 1419388 and 1419389 (commit 4765384ce33)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 5492079116..753dbb9a77 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -690,59 +690,50 @@ static void draw_line_size(ARTISTState *s, bool update_start)
 static void draw_line_xy(ARTISTState *s, bool update_start)
 {
 
     int startx = artist_get_x(s->vram_start);
     int starty = artist_get_y(s->vram_start);
     int sizex = artist_get_x(s->blockmove_size);
     int sizey = artist_get_y(s->blockmove_size);
     int linexy = s->line_xy >> 16;
     int endx, endy;
 
     endx = startx;
     endy = starty;
 
     if (sizex > 0) {
         endx = startx + linexy;
     }
 
     if (sizex < 0) {
         endx = startx;
         startx -= linexy;
     }
 
     if (sizey > 0) {
         endy = starty + linexy;
     }
 
     if (sizey < 0) {
         endy = starty;
         starty -= linexy;
     }
 
     if (startx < 0) {
         startx = 0;
     }
 
     if (endx < 0) {
         endx = 0;
     }
 
     if (starty < 0) {
         starty = 0;
     }
 
     if (endy < 0) {
         endy = 0;
     }
 
-
-    if (endx < 0) {
-        return;
-    }
-
-    if (endy < 0) {
-        return;
-    }
-
     draw_line(s, startx, starty, endx, endy, false, -1, -1);
 }
 
-- 
2.21.1


