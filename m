Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5890C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7230021582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0faSzCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7230021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYRG-0006vG-3u
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY38-0006JN-Jj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY37-0000Yq-8F
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY36-0000VH-Rn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id f129so1610891wmf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S3pmMgcEmeHBtI4+AVbPDjiFOAavVsNacKUoCx6hTZI=;
 b=S0faSzCrrz5Wrn9iD03aP5O5HxAyfBRFtFZko6bx/Ix6vJow5wEdBg8kxjzRE3Wnim
 HwohNFi7h3J3joRstetjogFGJxNUrDIxw5kFJLUE3AN8g183oGaFWLWfsikvEGPBtcdf
 9Kh95ziGsZZx6Ac/tWDe0Meqhk7F2f7ru7uWvaJ4yM44f1XElQYbMpxheSE6lT1PcXeP
 jydlX9J5thtW61iiisE+nWKOHQknLqhRip+87L4cxmIlcr1zco9z252yxr2qffmeZj2d
 WCQwQp1+EDAyqctj9eSB0ccJFA8/Z+PwGNQPU2FSlee8WFRTvwzA8z3YjyYO4A3c/E4L
 U6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=S3pmMgcEmeHBtI4+AVbPDjiFOAavVsNacKUoCx6hTZI=;
 b=hCeU7c66AgmBaetlCGdU6XKSS2apWqtEHnGXqWLPe8cCt60MkLs0kB/M2N6lAxuWzo
 0rEOo/Y3RglCsa+G9hPlJ2zSahQb6vMV9Jbu5qEx0ciiIAXnzv/QuK4JjF3u/NmFtzLC
 VdtMEW8xnJ9Nur4/T1jUU0xCtlWO1ElxDZCbqUnx13yZgpicNWF6jkWN3QcbS78xDVgE
 1Tt/1jrkm/Vg4Qn45nArPhuamXbLQgrMzWyuGI88s+gUtJIKjLcMSSOqb7YfUAszh9ZO
 vEOqc4xn8izQiNtCTjSK7ikdsmEYWJRKE4PLeYQOi9OFuIt8ummw2zPH9GU1m2I++erG
 s1VA==
X-Gm-Message-State: APjAAAUYGeaPrtPwlvuiskdHMuT4bhkz4LoOk9oMLC+jSAQC9MBKfxf5
 dYw9NQ34B6xjd3tGLWeFQfa4Gp8C
X-Google-Smtp-Source: APXvYqzdLnUnWaYZsp/oZwhgry3e4iYvvb9r6dK9sodNHG+DxsvsmyuQDQQBoZq1e/shEzyNGlqj3w==
X-Received: by 2002:a1c:bbc3:: with SMTP id l186mr2866346wmf.101.1576670607463; 
 Wed, 18 Dec 2019 04:03:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/87] build-sys: build vhost-user-gpu only if CONFIG_TOOLS
Date: Wed, 18 Dec 2019 13:01:58 +0100
Message-Id: <1576670573-48048-33-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

vhost-user-gpu is always built and installed, but it is not part of the emulator
proper.  Cut it if --disable-tools is specified.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index a2acef3..bfd8ba3 100644
--- a/Makefile
+++ b/Makefile
@@ -321,14 +321,10 @@ HELPERS-y =
 
 HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
 
-ifdef CONFIG_LINUX
-ifdef CONFIG_VIRGL
-ifdef CONFIG_GBM
+ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
 HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
-endif
-endif
 
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
-- 
1.8.3.1



