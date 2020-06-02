Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14184C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D329F2067B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZoi3Bja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9D1-0003OI-54
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97c-0003cY-32
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97b-0007dL-3d
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id r9so3410927wmh.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uvMYxLr0Nl/kQDg+PeIHS1bjqHOZjTucP3buAR3WOFI=;
 b=sZoi3Bja+i3ID+6DKXNmzxL80Rqrw5oDLfooP3kNM+VyxrF/x2LJcoh8tSkOc//IYY
 B6qIFvkVMEDyF6RwuM4zdwSoZ/9WnddA1cUBpTYm50RzbwWR0wbd3/LwqkDVb12zAWfd
 6kl51LgXKwX+0/XpDBuPBO41hzaRKl9nKCv253O6Qbf6yD3KdOJhgo3CbEIVrLGRR7B9
 HKFu6S3OFqH6wZ9VXeht6t0+tMFZVIdKgg8121wA412LaScpLdyx2XBBXMYp97S7YrI9
 lzD39hlRLLqmNhfnUjCZ1r6IsrIkarJXQLR/3pPWaw7bD7944usolRKgov+0JrxSutKS
 Tc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uvMYxLr0Nl/kQDg+PeIHS1bjqHOZjTucP3buAR3WOFI=;
 b=mjiC+2k7BRmG0Dycx907VE3jxMi3DUmfro4Hmhw5ntDY9xf9bUMaF74jhbvyS0Y53s
 cDNjeiYDNm1pwg4vl0DjmG0haX97zU+K+ImhPYBq2BptH61mHKbORxN3EFMLNIi+0oPD
 ha6M14O/daFKV4nTEOq5Fdera1R7icjy1+Htzz6i/lRHKJklaHZcApckCuoLVKfbYgVe
 5miA7RDkBfa4q+NaPKsqRCpCAHmFlD2PGziQCAlm6rpgnE/x2YAFQ8Aa9U+XoOwzC/dN
 Ta+20XiqsPjTOEWox7UVBEVKWobqh9LDlLmgNcfmMsUYeJXk2JyUvSXrgcSYJPvDN36r
 3GTw==
X-Gm-Message-State: AOAM533+fVF2YztASOJA3dXCboMvRsJ6aWu8iFvik8p8LFV+1TGr8xn1
 QvPkBkARSdob+IDcz8QRzCPmww==
X-Google-Smtp-Source: ABdhPJydLknq4NSSvfQ2Qi0ZW04oolrS5QPna+zl7sCqU/LUXRg5R7Bs6lvw/hkhvEjScPoeNOHgvg==
X-Received: by 2002:a7b:ce15:: with SMTP id m21mr4705152wmc.117.1591112793713; 
 Tue, 02 Jun 2020 08:46:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i3sm4366144wrm.83.2020.06.02.08.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:46:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABE0B1FF91;
 Tue,  2 Jun 2020 16:46:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/9] cputlb: ensure we re-fill the TLB if it has reset
Date: Tue,  2 Jun 2020 16:46:20 +0100
Message-Id: <20200602154624.4460-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602154624.4460-1-alex.bennee@linaro.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: robert.foley@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any write to a device might cause a re-arrangement of memory
triggering a TLB flush and potential re-size of the TLB invalidating
previous entries. This would cause users of qemu_plugin_get_hwaddr()
to see the warning:

  invalid use of qemu_plugin_get_hwaddr

because of the failed tlb_lookup which should always succeed. We catch
this case by checking to see if the list of entries has been cleared
and if so triggering a re-fill.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eb2cf9de5e6..b7d329f7155 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1091,6 +1091,20 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                                MMU_DATA_STORE, mmu_idx, iotlbentry->attrs, r,
                                retaddr);
     }
+
+    /*
+     * The memory_region_dispatch may have triggered a flush/resize
+     * so for plugins we need to ensure we have reset the tlb_entry
+     * so any later lookup is correct.
+     */
+#ifdef CONFIG_PLUGIN
+    if (env_tlb(env)->d[mmu_idx].n_used_entries == 0) {
+        int size = op & MO_SIZE;
+        tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE,
+                 mmu_idx, retaddr);
+    }
+#endif
+
     if (locked) {
         qemu_mutex_unlock_iothread();
     }
-- 
2.20.1


