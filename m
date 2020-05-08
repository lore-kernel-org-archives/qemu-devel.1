Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7AAC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7C524970
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="2O6v3ziH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7C524970
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2lA-0000qI-Nu
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Wz-0007Tq-Vf
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Wy-0003Zt-4z
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9so1740661wrt.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bKbcDZF4VvCdwc1Z3LgA0n0/o1l3SD8mbWQhoT1XpcI=;
 b=2O6v3ziHVNSlz5hskCELkYEU3KISPyKL5+5XeWc5/9h9taj0hvfcubXPOikV1RCsXh
 Qydzp7+AH09RZ541OgAUcG33N/ToTtuggRsg0niG9UFk73bb9k/NgmL3VNFWG0QK4qx4
 nRSctY9XqNwf9ssZSDMmE+MhNrzmCY8HuxeroGKF8vApkPr6uzMLuggYQEF9dQw4CFeT
 7B0s7B8HyJCfpLeNIj+isYWYo+mK5zUKoDcBRpGnXHmqf28gIENw9sW4GtT80LQ4vISb
 iiw/mCrLg9qBmMWg0niUUqEDdEJ1YWf2tbdFtFxtLoTm6u7pMeZbGLTM2oD7T+GtoOHt
 1JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bKbcDZF4VvCdwc1Z3LgA0n0/o1l3SD8mbWQhoT1XpcI=;
 b=EJAnEIlQTwPTcsHvS30RsLqK8mfCAzvQVH1tOWM0QrHZxnJZ/VI7k6HfCQHZaEb956
 LIOg1m7hdNTozimn7jlGv9r2mmeEtk+9feyzcdw8ic5F3XdaOti2+26zcRUclH0vZaut
 4vW2MmpxaxvafA3JsraoWdccwtuHgDHewVRa8HgIVuv1r6FRefJstVamXEVDsOZ2Gqoa
 z79l24ZN2B4X3F2ENTuGI37rbBt+XGMMwytxjC6I7B/8qmBDnGcusdja1sKyXDFKzkNk
 IRW8LcjyJ8jpPCpXAgPZXejkImwvnhE01qbBh3LMv3Bc+Wad4cjn2UwNZT80mO2BL0BE
 C6aA==
X-Gm-Message-State: AGi0PuYRV2OS8RvPNUbN5gtWQZtR3Z7rKsFybZiKb5XI0whvRQNJvLJ1
 tLsFhVWJZs5V11VufMfXNOz2Pfl7qeSw0w==
X-Google-Smtp-Source: APiQypJwBTG/q5IZmjupnfUpJdBZJRqwefjBgSfDuCPt0givpX0ht33oBb4ujyGd9rH+LreGaQ6Lwg==
X-Received: by 2002:adf:ea0d:: with SMTP id q13mr2784353wrm.211.1588942506647; 
 Fri, 08 May 2020 05:55:06 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-19-16.red.bezeqint.net.
 [79.183.19.16])
 by smtp.gmail.com with ESMTPSA id a8sm2852375wrg.85.2020.05.08.05.55.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 May 2020 05:55:06 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH 5/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
Date: Fri,  8 May 2020 15:54:50 +0300
Message-Id: <20200508125452.7802-6-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508125452.7802-1-yuri.benditovich@daynix.com>
References: <20200508125452.7802-1-yuri.benditovich@daynix.com>
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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


