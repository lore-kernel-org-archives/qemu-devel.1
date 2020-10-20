Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDDAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAD12177B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXJEuhUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAD12177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUv3p-000278-Nl
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kUv0Y-0007ml-RY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:01:10 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kUv0W-0004rd-O5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:01:10 -0400
Received: by mail-pl1-x641.google.com with SMTP id w11so1331127pll.8
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eaYqmjcMx802IYh8As8yQQI4HZLzXd0/F879o5VXjTg=;
 b=tXJEuhUh/jBCkoIm18hk/J+QQErGA6dM6aodvpm5zAjpd0SMaC9cj5NzSsVeomWwdb
 uMISMjUWoDPDuNAFVKlYOEfjlphlNV77EnuuF/VObOBaIsCnq0kxkm1iqywQmpNaxH7s
 RakE6JuJh9Yeru7KCeiEDvMZlJ1ZHkPPdjt2auaANrVz8k8PotKbJibCkHe+VM/CQG/t
 YyalaEC9NvE8uiwSmit9I57v0mAWMyknlHFF5bNd9XGOeEJ/whGazNu0uiM/t4PgAyvK
 i+LjYHhxFKarkk6JTNrJKpMFGFJotDXrai7JIvgo6GXWnYfoAmY+DfG4gmom9gteZ5Xu
 uuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eaYqmjcMx802IYh8As8yQQI4HZLzXd0/F879o5VXjTg=;
 b=BaBcypKWiTjqilmdsbD9POXUHccHXr49mlSjE+NyxfJac8DFD1v2bwow/ZwvHloV7X
 Hh7l+Kk/KVPw074K99oNgRwc1gYdwo3caUCYwepE6CK+4VJApBpyXl5FkKporDtces7L
 enpRCjE0xqgrj7FlT8zfKc6JGJe6WWujw7NwjrKvVRRHxCr8IHlN3M/o93mYuGCUi42H
 0L7Rr43PZxoE64jgI8G6/tLTma6vzXGlRNZUVL+lGvD4Rsyc+xUwqES9W8wuHF43yGns
 Y4Eqd4VH/ul1vf89HZAgZkS7m6Au6CGeWV01m9xPtIhIwckx3xVW8HiUDVWN1FFCbmE1
 1fgg==
X-Gm-Message-State: AOAM530g7LMAQP1GicwJcApBi3uDFQHSzJM7G9pXWQZxqliu0WxNqzZH
 F8VC0y2KLWjfjCaqhpfnz/A/ZK/M9Q8=
X-Google-Smtp-Source: ABdhPJyrIZ0jrQpUiVQiMr6asT4wMDG/t4eFF26d8JnKNK5AR8/YFD8r+JrSG6otU6RLsyXjrWbfiQ==
X-Received: by 2002:a17:902:c24b:b029:d5:f14a:318d with SMTP id
 11-20020a170902c24bb02900d5f14a318dmr932875plg.4.1603213267195; 
 Tue, 20 Oct 2020 10:01:07 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.132])
 by smtp.googlemail.com with ESMTPSA id x29sm2766161pfp.152.2020.10.20.10.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:01:06 -0700 (PDT)
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: qemu-devel@nongnu.org,
	ameynarkhede03@gmail.com
Subject: [PATCH 1/2] linux-headers: Add support for reads in ioeventfd
Date: Tue, 20 Oct 2020 22:30:55 +0530
Message-Id: <20201020170056.433528-2-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020170056.433528-1-ameynarkhede03@gmail.com>
References: <20201020170056.433528-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces a new flag KVM_IOEVENTFD_FLAG_DATAREAD
in ioeventfd to enable receiving a notification when a
guest reads from registered PIO/MMIO address.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 linux-headers/linux/kvm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 43580c767c..3e71d15a53 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -695,6 +695,7 @@ struct kvm_guest_debug {
 
 enum {
 	kvm_ioeventfd_flag_nr_datamatch,
+	kvm_ioeventfd_flag_nr_dataread,
 	kvm_ioeventfd_flag_nr_pio,
 	kvm_ioeventfd_flag_nr_deassign,
 	kvm_ioeventfd_flag_nr_virtio_ccw_notify,
@@ -703,6 +704,7 @@ enum {
 };
 
 #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
+#define KVM_IOEVENTFD_FLAG_DATAREAD (1 << kvm_ioeventfd_flag_nr_dataread)
 #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
 #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
 #define KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY \
@@ -712,11 +714,12 @@ enum {
 
 struct kvm_ioeventfd {
 	__u64 datamatch;
+	__u64 dataread;
 	__u64 addr;        /* legal pio/mmio address */
 	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
 	__s32 fd;
 	__u32 flags;
-	__u8  pad[36];
+	__u8  pad[28];
 };
 
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
-- 
2.28.0


