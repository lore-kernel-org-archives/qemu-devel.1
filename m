Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E0C31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586282183E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYAOQmay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586282183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbwqK-0002R4-UI
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmg-0000WU-O6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmf-0004IH-O6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hbwmd-0004Aw-PO
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id c66so3986662wmf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bLutnU/dkTXvJoiW5spoJToFM65YGUTnPwiUoNTJhIg=;
 b=uYAOQmayP9gskY4eyV9vuYglowPT/SLAH2JizBZ5vxTL6QYgXz2fZ6zF1sNKbHMaJQ
 mDijknCFByVxMl+CwqZEOBGvDU6KRRK4QY7/qg0mWX40O5a8ldx7vrBX4x4TKi05sG6Z
 SAbwwH5ELq9s4JjK7Gu6t6RykhJbtHArmIiOr4e5WraILdqfiIjd/gMcmuljy9jNP00+
 R3oTXbmVqWhSDwo14ma7N9jRT5YtAxub1Q0zzXx5uurxg4JYOgkmoMw1101UgnGPx7yI
 5T4f+hY4o9SGvdZnTA4ETVjFFzmrF+/33nqCfRkWZRhKBR30fI8YvhoOk9AVwcJLjFKD
 o3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bLutnU/dkTXvJoiW5spoJToFM65YGUTnPwiUoNTJhIg=;
 b=C9NofMYaj0nJRDdkbfysZC5Ovxi4i6jLrnxaBGFbE/la2DYu+JMkZEfb99r891kJ+a
 pI0Yk3MTjd5AVrfzzv/U0jjkQFnFcZprHNWJChRkDvU7xpkkUaJTNrAhAzKbF5puB8dg
 JEL3YGPL/3/+e4R5rotTwR4dDhWhNomrXrFSiHcVwDgIFR5f42oc6CoOyiKR+ibbZd3G
 L78VNOeRHxOYqwLGHoDdd+ALCXIET0Gp61/F8KWtmAX0sH7uSOikSwR5/yKoSidMFMJf
 kPlnX6vA+1U/JUL227+1YmetFB1TCSv+9zcFAnClzD76GrvW2/XTpn/Caw5NRYxkSm8v
 Sixg==
X-Gm-Message-State: APjAAAX1gMiuw3tt7zMyI4l8+h4cxwwBbjZM7l4Qs1DSwHGs7cHEjIB+
 na0EghTKDUlk2ALz1mn22kLaG8Sx
X-Google-Smtp-Source: APXvYqwdaIXDIBheJjiutUHDc7mPJVLxj8xPFIrYQjdURZHxjyKfMFCJkihMNBMcoelekAYc/VBZUg==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr10071538wma.100.1560559380520; 
 Fri, 14 Jun 2019 17:43:00 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1da0:213e:1763:a1a8])
 by smtp.gmail.com with ESMTPSA id m21sm3774234wmc.1.2019.06.14.17.42.59
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 17:42:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 02:42:54 +0200
Message-Id: <20190615004256.16367-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190615004256.16367-1-pbonzini@redhat.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PATCH 5/7] vmstate: Add support for kernel integer
 types
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
Cc: liran.alon@oracle.com, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/migration/vmstate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9224370ed5..a85424fb04 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -797,6 +797,15 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
 
+#define VMSTATE_U8_V(_f, _s, _v)                                   \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint8, __u8)
+#define VMSTATE_U16_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16, __u16)
+#define VMSTATE_U32_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32, __u32)
+#define VMSTATE_U64_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, __u64)
+
 #define VMSTATE_BOOL(_f, _s)                                          \
     VMSTATE_BOOL_V(_f, _s, 0)
 
@@ -818,6 +827,15 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
+#define VMSTATE_U8(_f, _s)                                         \
+    VMSTATE_U8_V(_f, _s, 0)
+#define VMSTATE_U16(_f, _s)                                        \
+    VMSTATE_U16_V(_f, _s, 0)
+#define VMSTATE_U32(_f, _s)                                        \
+    VMSTATE_U32_V(_f, _s, 0)
+#define VMSTATE_U64(_f, _s)                                        \
+    VMSTATE_U64_V(_f, _s, 0)
+
 #define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        \
     VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
                         vmstate_info_uint8_equal, uint8_t, _err_hint)
-- 
2.21.0



