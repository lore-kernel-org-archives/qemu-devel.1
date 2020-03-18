Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C45C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70882076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="iVi20NzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70882076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUrO-0007Ow-Su
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUno-0003Dp-H3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUnm-0004j6-Fq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jEUnm-0004db-9p
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id w10so459067wrm.4
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iSTHopC4uU4kCN0tyvTPrIHil1hTQrwxVdvmrqy4gWI=;
 b=iVi20NzLZuFLq14Y4QKwctB5HM/MiBsnCU+HI+sDEqncEk2nN6/In3kXqGHXC+4Xa7
 ad89QvTDKdpAh7CJbDkGfmbCzxEMI+LlqfXWBq0sjAY3J2rrkv82w9dcKnyzKhjyGjMu
 ciUGBF6J2o2aOxUpz8017tYcBfdrAToJIWdDg8HF7/gSZPrEmFnoPRctEQPEoTY7qg/2
 Ml1SItowVAtyxyz2fkzFISl1wEs6sV1KyR12tHXNhRxb0o6W3NORvJIJryu+rNxqV6AN
 57s1OxSiqMQC114fu7OxOhyvkYFnO7ZJltUewYGjNeeUd1Ldvlkv5gy+haUFTi9pt2HC
 Boew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iSTHopC4uU4kCN0tyvTPrIHil1hTQrwxVdvmrqy4gWI=;
 b=HJPzUsYS06qku408t+4WF6/Hv3G0Hkt0qSKjICDWS3myf7kdG+qNqRE7liTlzni5TD
 VSfX7PQyMq819yPCDXksTz/bKbH1bq6V+RgzqD47qBeEB9jQffU5lPygBqAA1O3aqZvB
 dmcPNeripUQGh3xUYZcMrbXO+NUYFla8ridAk2bv7ppBDirrqTwUiSkua2kcDo9DY0Og
 tdyYrnKgfKI5MbK5elw3OZea7fxH86iWcwSOAMn2JtaQs80U7Y6BbNGwQL2x+52PSkAO
 Fue5VsIZ1DUoG8elKgh4SHlUOqpMzzp8skNAdNEZGbZE/lxstgsa5Z/QiQgMowqbFnZx
 fHfA==
X-Gm-Message-State: ANhLgQ3AfwqPo/pSm9gUi2XMOF7mOdxWPG5pNHDl2GbTrVECHErhsxFX
 /RvcaMMyAFVCAkGtzEzJ0WPP0fmAqXt2mA==
X-Google-Smtp-Source: ADFU+vtWtAAYpwPWG8NLxGEOhQ0Rb8TFwwrJkAsNnPmkcMelNuqS9jyM06A472DUutmncSNMhfPXBg==
X-Received: by 2002:adf:eac7:: with SMTP id o7mr4739785wrn.292.1584522949109; 
 Wed, 18 Mar 2020 02:15:49 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id z22sm3062342wmi.1.2020.03.18.02.15.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Mar 2020 02:15:48 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v5 6/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
Date: Wed, 18 Mar 2020 11:15:24 +0200
Message-Id: <20200318091525.27044-7-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318091525.27044-1-yuri.benditovich@daynix.com>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is
16-bit field.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 30667631bc..baaefb6b9b 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
+#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
+    .info       = &(_info),                                          \
+    .size       = sizeof(_type),                                     \
+    .flags      = VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
+    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
+}
+
 #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-- 
2.17.1


