Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3883C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7083A206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUAL6xIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7083A206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOP38-0004X1-Bk
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyU-0000RO-Oj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyT-0003JO-6f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id y15so2574391wmi.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xXdgD+CX1xaJz1RLqkztVK48fKpoJNRH36Jn29j2m3Q=;
 b=MUAL6xIf8PviJhDBefAPrh7PcVnrrIOEO099O8FQoxcQFWYJP15tXvdIMXZ4IIPkMf
 zg4dj+M4JzmME6yx0nmb/62DaPJhI8CM6EmxF6806IyZ6mg/vPhVbBqCRcO1gHGz6dKV
 IbJ2/qUJ4dAXhiTz87R6NCtW1w6eibvsY+0hk2T8wxx83WrjznW16XBzq6zOdCtQ3FrT
 sjBMTLCBlhkDj9fabM+tTniRITJk/FuNEXGLfFNV6ZGiQ9SMtejqyRpa2Ah2RAk7uG+O
 U7mydm3W1I81+5gIpcPjeR4GIIt7iR6Dg7lElHCiD28l15dKtSL97qNCOEsfmDSnYwCX
 pdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xXdgD+CX1xaJz1RLqkztVK48fKpoJNRH36Jn29j2m3Q=;
 b=SAeL9jAHG+v+wB4yRLIhofDnidCddBtZJzyQ13OByVpGaN8kOAoerpcH1TgO0UI3QX
 HpgeTim9mINgHwQJtQVec0Gm4/4m1CvAAnqtSGrxJBr70PsGPpQ3uRoA4j62L8/L0RaM
 JCTL+5LTjfuEbohVuvZcQjk0o9nQocNZtY7/WRwpYwgKb30glp6WTF87YxYoB/Wr8aHu
 krYg/5Xy/vSkDVnQoo3P0yPF0jG8S+s7NGPt6DlC5jIWCgne090vm9ff2jfg63+EHJvH
 XmCrQiAmWxeKGMioUwjbamADyP91TujrtbvcU+j1O1tpE8Ee9GubhmIwZp04Wq70SkSf
 87yg==
X-Gm-Message-State: AOAM531cjQMP4gPLcwud2Euqr9h7BrgwhqSN0XlFUetoIGbaVfbU+Hqr
 gD9vB270kkVn7vgxdnFXM7McJ8Ut6iQ=
X-Google-Smtp-Source: ABdhPJwZIGQ7loiGEIqV6MjBkBBlJEQUsSH2w1n8BmoTx03WHcvUOW/SusLD/7zGLY/Qlox9/XKUnQ==
X-Received: by 2002:a1c:bbc6:: with SMTP id l189mr4315191wmf.52.1601660163638; 
 Fri, 02 Oct 2020 10:36:03 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/10] device_core: use drain_call_rcu in in qmp_device_add
Date: Fri,  2 Oct 2020 19:35:52 +0200
Message-Id: <20201002173558.232960-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Soon, a device removal might only happen on RCU callback execution.
This is okay for device-del which provides a DEVICE_DELETED event,
but not for the failure case of device-add.  To avoid changing
monitor semantics, just drain all pending RCU callbacks on error.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-4-mlevitsk@redhat.com>
[Don't use it in qmp_device_del. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qdev-monitor.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index e9b7228480..bcfb90a08f 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -803,6 +803,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         return;
     }
     dev = qdev_device_add(opts, errp);
+
+    /*
+     * Drain all pending RCU callbacks. This is done because
+     * some bus related operations can delay a device removal
+     * (in this case this can happen if device is added and then
+     * removed due to a configuration error)
+     * to a RCU callback, but user might expect that this interface
+     * will finish its job completely once qmp command returns result
+     * to the user
+     */
+    drain_call_rcu();
+
     if (!dev) {
         qemu_opts_del(opts);
         return;
-- 
2.26.2



