Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1781C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5B12467A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwNRXU/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5B12467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZHm-0002vQ-L5
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlP-00026d-V2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlO-0001z3-08
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlN-0001up-Po
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:33 -0500
Received: by mail-wm1-x344.google.com with SMTP id a6so2849893wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cVToSW6TMNFqd0X+S+JCU3eMMpDIGt+aFLZBZLF0usM=;
 b=KwNRXU/ATEmLzdWyYC1fIwVCxWh75FqK8jppUoM1xFUTIJt01IpslbP0AL13qjSpWP
 WDQxa991leFD7qbZlsgqIBIcR+3Jf3R9gcfs1tvCFMuws6+scxHN+U9yKUYzJBBzg/IP
 sZqKHZaLbe+mzwDHeB517rq4vdU8/pM3jliTpUwcti9SJLfbGbhuBRU6tOE3JGj9veGZ
 u91e3rNyAdU3KlZs5alKAo3omHC/UdcxVXIGtcwg+ClPYX+1HUzEHp4l4qL2WO2tkB2q
 18B9W82SwJvPsu1+eoH+qXyTsYsT/ItUQuVywo+eyVwVTzKrzyEdwpCxICHc7vtKHCCd
 bMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cVToSW6TMNFqd0X+S+JCU3eMMpDIGt+aFLZBZLF0usM=;
 b=n+YqL/1uMM4Ry+5oD27au9XHzsCF3KA+q9iY1K0BC8PySZuljmXUD9ncqn+egb8I79
 bTQsQA+GS02HLxmuznp/EYZ2ySjjr/1G/yyt23509ytmffWxC+dDchlYBoHpTsBm3D+H
 q72fxcgiJrITx9BtyDCWsh9uoyDftNbwdTdvlJbGkUUuNPK5WNE0CrJ8fyEQL33BqJ93
 fd70L3ETWhAJLJoaFaapi6fyGobhlL3VYZ2Tp8n4Vc75kbMLLWVZnwfXiqy0+z+Z6QJ9
 md1zbn6Pljm1MAAmkURpGvLGw7MF/dwYlS/pzgQyjIcQNniznTn/tg8mSBBDIh7v+mdM
 qSBg==
X-Gm-Message-State: APjAAAXFdZc3AiTACkvNSXuneERjGR+RbHeOzIZqdspwaCVq9609WR0f
 fBcOvs65lxz3k/q1Gno54NAoP+m4
X-Google-Smtp-Source: APXvYqzJt7/H6n9vp5Ukn95X7148QkuBhqOrkB3KerMpeaWtRlEHufWoPQ0gYw5Xh/E6hc7GPZs5TQ==
X-Received: by 2002:a05:600c:2481:: with SMTP id
 1mr4945734wms.120.1582631552585; 
 Tue, 25 Feb 2020 03:52:32 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 093/136] exec: Let address_space_unmap() use a boolean
 'is_write' argument
Date: Tue, 25 Feb 2020 12:50:23 +0100
Message-Id: <1582631466-13880-93-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c                | 4 ++--
 include/exec/memory.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index 58664ac..239239d 100644
--- a/exec.c
+++ b/exec.c
@@ -3598,11 +3598,11 @@ void *address_space_map(AddressSpace *as,
 }
 
 /* Unmaps a memory region previously mapped by address_space_map().
- * Will also mark the memory as dirty if is_write == 1.  access_len gives
+ * Will also mark the memory as dirty if is_write is true.  access_len gives
  * the amount of memory that was actually read or written by the caller.
  */
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
-                         int is_write, hwaddr access_len)
+                         bool is_write, hwaddr access_len)
 {
     if (buffer != bounce.buffer) {
         MemoryRegion *mr;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index afee185..1614d9a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2329,7 +2329,7 @@ void *address_space_map(AddressSpace *as, hwaddr addr,
  * @is_write: indicates the transfer direction
  */
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
-                         int is_write, hwaddr access_len);
+                         bool is_write, hwaddr access_len);
 
 
 /* Internal functions, part of the implementation of address_space_read.  */
-- 
1.8.3.1



