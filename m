Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E528FC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A1320714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLg9vX/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A1320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v7v-0001GS-T8
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4w-0003Av-Ui
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4v-0001XS-Pv
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:34 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v4v-0001VW-Jn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:33 -0500
Received: by mail-wr1-x430.google.com with SMTP id g3so3174969wrs.12
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JT9C6l5cMam9Id8e97W1nQcd6eNpyd3ZDkBP7+S4YoY=;
 b=kLg9vX/ceW2zrRYHMBPJQ+F88tGJek7bOgDLHOVfBEfnyhiuhRJJJptq+NyUShj2mu
 TR4K54dYUOM5aqSSGmriAdosVdUlUMr9a4XZZTEl7PAciMUIk7EaaRx1NX6PnA4LShzg
 IBW7ETBzOQoZCMi1YSkP79u6znaUzIn8kpLGhstAKdK45J3r+TtH8TGiQYq/v2JjZ55k
 beUdsOZM8gUNG0VF034LMTgIuONKAkkcmwA2H7vFfv5obujXCGMVDe+0VmZBG8QSMFQ1
 4XHWM+g74VMCxGh0tE4dbfJFpFPQaQL0l5JYCqA7ZCybxRMKI8dfDMr6lxhR75qA7jU7
 ETnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JT9C6l5cMam9Id8e97W1nQcd6eNpyd3ZDkBP7+S4YoY=;
 b=ZW2kp4xkBOM/7aFyHCes7T9MPtmqOv4/fgnuvZr3cLFhUoV6Jf9CE8KAadGcXa+q6D
 tPs0NwFD29lEkDqcxaMgIkugehATcWqOi22nhq/6xpYiVpoNV+SbhEPHL+/uKDFQko/J
 zPMCILeqtcIx/tmaG+D6gSCtjWKXg7RNxCUzs6SWcOxAodT2sTlY/8IBWYWWA/35dK5P
 SAuBvCt6hB/g9Bs2TakG+Vn8RfCGvmLs2NcG+MUD+kIZpcjqH9Qzc21yi7N4hSuqRII1
 uF6CFvcdCyHd+pH3GzP6ugqXXcIBF/M2V754sTRpnKGgog+n2SElF/ShuxlM4tus8DXG
 F7IA==
X-Gm-Message-State: APjAAAWxLmcqxibfldWBBZhUU2wdVzujXaIgtoHdAuFnCR1M5xKA1h2c
 sFf4Xi2UE5bYVZerVv3DgLdTN0em
X-Google-Smtp-Source: APXvYqxyyAik/Ns4GkKTfUdfqSItmebsY6yELfJdH6bnYaGSr97vGniXdBcoHI75bE1Y48oFNM2hkA==
X-Received: by 2002:a5d:5188:: with SMTP id k8mr1161196wrv.151.1581525692348; 
 Wed, 12 Feb 2020 08:41:32 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] vl: Don't mismatch g_strsplit()/g_free()
Date: Wed, 12 Feb 2020 17:41:21 +0100
Message-Id: <20200212164129.6968-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

It's a mismatch between g_strsplit and g_free, it will cause a memory leak as follow:

[root@localhost]# ./aarch64-softmmu/qemu-system-aarch64 -accel help
Accelerators supported in QEMU binary:
tcg
kvm
=================================================================
==1207900==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 8 byte(s) in 2 object(s) allocated from:
    #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
    #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xfffd6ec724d7 in g_strndup (/lib64/libglib-2.0.so.0+0x724d7)
    #3 0xfffd6ec73d3f in g_strsplit (/lib64/libglib-2.0.so.0+0x73d3f)
    #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:3517
    #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
    #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0f53)

Direct leak of 2 byte(s) in 2 object(s) allocated from:
    #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
    #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xfffd6ec7243b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
    #3 0xfffd6ec73e6f in g_strsplit (/lib64/libglib-2.0.so.0+0x73e6f)
    #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:3517
    #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
    #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0f53)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200110091710.53424-2-pannengyuan@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 7dcb0879c4..c5beda7d48 100644
--- a/vl.c
+++ b/vl.c
@@ -3501,7 +3501,7 @@ int main(int argc, char **argv, char **envp)
                             gchar **optname = g_strsplit(typename,
                                                          ACCEL_CLASS_SUFFIX, 0);
                             printf("%s\n", optname[0]);
-                            g_free(optname);
+                            g_strfreev(optname);
                         }
                         g_free(typename);
                     }
-- 
2.21.0



