Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76197C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4021E20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+GypmTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4021E20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAaz-0001g5-Sn
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWK-0003fm-Dc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWJ-0004GV-5c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:08 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWI-0004Fw-Vx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:07 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a5so2310729wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3yhWA8yXlYsJVpooobRrkZ5hRD9Oh/35FTaEzQyVALk=;
 b=o+GypmTRf7QK5WHOcIUm34g5ke1D5ixjsIbuwOH6BhxATeHpUwEvKroFGxrKCN85Gl
 aIJJTpkV+XcCjU9WXA4PFigbDfWUmPzSEL92X/8qu5Rol/Th3Hl4dlXbMeCkvu70TbhJ
 6DsfR9wamSy82jmS2oE+XOJN2KHr1BZrTDPnHMKVA/nJEjfm/vYUhkFwQcYPskPbYZc4
 3fQ6gRkeFLrJutbTqqCVZFmB3dl8tBpQ5qWM0VyJzxWoLwzaMnzQKMYn3WDrblwEEnoy
 DsVQReGJdBItNPtNUzJ50VkPI0MD6IebVV2pDIF90TUnYjJvd9C4irpeIXuA/kwP5PZ5
 ufvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3yhWA8yXlYsJVpooobRrkZ5hRD9Oh/35FTaEzQyVALk=;
 b=jsxTdJRhGhExClRiGfr5XNeshR64f7ILyrLJAm4xJymHJK5yo6byci7ZmER7d1i2+F
 X8RCRosl0U7nRcPVKgFGgPWes1GuYiijsq3YssPd9zCuqhi1ngKzcrxto/og7/4XH5Uj
 5YKqZNCPEvd3uz1uKPKmuCShE0ei7cev5SUDXHvCOLIulilsjva30shAluH/6Ao9ynQZ
 nY6Resxk5Q5s8mmoym+OW4i3Zatn0p5QzMIlCYufVcxsXm/JcqpDDF0mMw5sAmNpakl/
 Ii5TZV0SZOUYXJTz6lBh+P7xgrlL1DwXF/gWKld/0osEKirplFSiZ2tj00hdTL3YNCfT
 0HQQ==
X-Gm-Message-State: APjAAAWua7BRJYgKBrBEso3/pNGpT0Ukl6UWDHTtdXopNU6jxNvs+H9J
 XlIIuSLDv99RZK6rRu0oFQqQfUa3
X-Google-Smtp-Source: APXvYqwpOLz/VNGF1tLzpzLCMjK3QWloyXaw38yEMgaVj9pj7kBSK3gl7eB/oCzjm3SrOJgo08ON4w==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196mr3617884wmd.106.1578486785837; 
 Wed, 08 Jan 2020 04:33:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/38] hw/usb/redirect: Do not link 'usb-redir' device when USB
 not enabled
Date: Wed,  8 Jan 2020 13:32:26 +0100
Message-Id: <1578486775-52247-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

The 'usb-redir' device requires the USB core code to work. Do not
link it when there is no USB support. This fixes:

  $ qemu-system-tricore -M tricore_testboard -device usb-redir
  qemu-system-tricore: -device usb-redir: No 'usb-bus' bus found for device 'usb-redir'

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/Makefile.objs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 0ab20f9..0052d49 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -39,9 +39,11 @@ common-obj-$(CONFIG_USB_STORAGE_MTP)  += dev-mtp.o
 endif
 
 # usb redirection
+ifeq ($(CONFIG_USB),y)
 common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
 redirect.o-cflags = $(USB_REDIR_CFLAGS)
 redirect.o-libs = $(USB_REDIR_LIBS)
+endif
 
 # usb pass-through
 ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
-- 
1.8.3.1



