Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013C6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47052173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0UAcBCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47052173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwV9N-0005HI-V6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV44-0006Jb-Iw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV43-0007wB-Gz
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:16 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV43-0007uX-7h
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:15 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t2so17092568wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dErvkepkYgUBIWRCc2un1YcfpszwmABIk9M1+FNSCyQ=;
 b=b0UAcBCKuQUQPye+XxgYPImD3EoDZagWNc1LbEySVdZbdDxej3DzJ93Q+HVbSZ0d4s
 L1hhw+PpjH9KLxH9A4AiekMB798H9I65Ms5MJwyLor9YDACRXC7/MxtEDI+nWykB2LFO
 v3+ydt2s0SgIGB2j3/c9PFFKSPaNtfBG6HatIw1uXa9/4x9ST7VALQYNivH1hjGR1ItN
 aq5kYJvb92OE86aySQv3JTbguMOCcR5Wtk7xAp0TElMdc+hSzFTD+LzfIqyiKM7BmI2s
 nKwKQEdMz+c9KAzPYgVTFB228QPU/VXy3C4Ll6vkMtWJOvo9DaCiFklbXIPHJK+MTUBm
 9AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dErvkepkYgUBIWRCc2un1YcfpszwmABIk9M1+FNSCyQ=;
 b=VcBatMjt5D5uupsUCm1pT0tfQF1ClKigtC6L6GHOVCx1LZeCpjTOQZpU8vhTNjxEcq
 +sXKlIAh36zXV47KwPscufo+alrNCwAQ+U98fkghiPeJJptBrdAa0DfzD2+Y91pYVE22
 maUjjOjmsPc+uKW5qDvtn59z89YesZ8hympuJEYj0RtBKl1AiAKhXnLtwnT2VE+HkkKq
 keasvYXe1/gG+fMRHptkQPhOC9Ry+6RjAg9pg9uoFiwphHpctfT+LbL2qkOv4hshbabF
 afspAyaJgPmYGd4BZ6sJPfXoOTanpREqOk4BJwi2qhgAXDlKvMNDF66SfZhMwfhiRwQG
 SgvQ==
X-Gm-Message-State: APjAAAVJSA7BSrKgKjE8YVid7v04d7AARxIw0uuSHPqjcdJEetoVh/wk
 C5BDVpC/1tw0WeXiEM4KYl0+IHl0
X-Google-Smtp-Source: APXvYqy5yEAVWFpwQbhe0kmXFctPtqp5j86+ifP4xHUofV8GrJUb8W6uDxdAs6x1VCz1q2EMcF/Zpw==
X-Received: by 2002:adf:f244:: with SMTP id b4mr28607741wrp.88.1580234054138; 
 Tue, 28 Jan 2020 09:54:14 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 010/142] meson: enable pie
Date: Tue, 28 Jan 2020 18:51:30 +0100
Message-Id: <20200128175342.9066-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index b4f36820da..a9ab67bf26 100755
--- a/configure
+++ b/configure
@@ -2103,7 +2103,6 @@ EOF
 
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-    LDFLAGS="-pie $LDFLAGS"
     pie="yes"
     if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
       LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
@@ -8125,6 +8124,7 @@ NINJA=$PWD/ninjatool $python $meson setup \
 	--localstatedir "$local_statedir" \
 	$(test "$strip_opt" = yes && echo --strip) \
 	--buildtype $(if test "$debug" = yes; then echo debug; else echo debugoptimized; fi) \
+        -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         $cross_arg \
 	"$PWD" "$source_path"
 
-- 
2.21.0



