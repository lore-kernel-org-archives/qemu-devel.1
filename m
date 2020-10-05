Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCC72078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no1D1cIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCC72078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLtP-0007An-J1
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmv-0008EQ-B5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmt-0007Ky-GP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id z1so8471118wrt.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pa1mqceM/ZYvpPF7bcpg2S6znQSV1IB1IPFJZ/cyliY=;
 b=no1D1cIbVtmkyn2ef44Vs57olB+7a07sejBZlIF+Pl79YmeAuwAUCcuvakbsajyKf5
 13/vQ/YxaZidbe6OhjKkg3YjvK12D0C18ej7FE+nbiUu2ot5ROpUO23V7rgJLfiFXo6R
 nrlbwlsTVU2GrD/q+cDYlkEMwFMWZjspmE3M0oaGVu7TrsgicUJUV4WFTg/cmGV2VQ3k
 BkI9dk8okNF3fSFIif6mwgK6OUJOp6QA9wrschxn2UBxJbaFK/PJFkvHByNhKXRoHdCD
 lhzb505PvZkzn1k0nKEEJgdERUwbhQI5Q4ZsnshMLkpKdiG/yNoOP5+GlPa8r5QQ1m8F
 3XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Pa1mqceM/ZYvpPF7bcpg2S6znQSV1IB1IPFJZ/cyliY=;
 b=pxlL8Tdz/UEmANrScjJ/crG86dP+0Bvv83HHHqUJQ0xUj+OCrO1UOD6e8erxG/1PyC
 rRvg1sJ9NurwpMBVNm8gXRKUCjkIhOg2lUlMH3xdSyFor18E8NQAJ51mhqBPC7yUyE65
 MxSYPGXI7fJQP5rSMJEfz//xAWgrwReYp52w7xJ7QJIDmz2dpIrZz+jtFpfKoMEVcvde
 KK20thjAPBaj3jjkSl4CsdOsgPrV5z78AAvrrH2SI6DKL5I4JOGCX7wKpWNx+1quYDH0
 Qz0ai/BpCWepdwZxiMIsv2Lm7c/Ed4gAjbjn9GmbVCyx1L/zhyjuqNGshH9V1EWwIjbe
 PbuA==
X-Gm-Message-State: AOAM531ca7dDyFFEPpntjn+7RUJub8bFVvDUip7lfi4aDG4V09kU54kO
 wQY9A0wuEc1O0aijHRs0irHeQPvKKN0=
X-Google-Smtp-Source: ABdhPJxOCrKk6dmwku70g4jAH2VC3qCuoI9am8qYlpnUgrBvwbG7j+A1mROkh51mQxHo+E3BKlgKpA==
X-Received: by 2002:adf:b641:: with SMTP id i1mr4524372wre.376.1601886241783; 
 Mon, 05 Oct 2020 01:24:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:24:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] qapi/run-state.json: introduce memory failure event
Date: Mon,  5 Oct 2020 10:23:46 +0200
Message-Id: <20201005082349.354095-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhenwei pi <pizhenwei@bytedance.com>

Introduce memory failure events for hypervisor and guest. This lets
mft: Need exactly one file argument.  Try `mft --help' for more
information.

Suggested by Peter Maydell, rename events name&description to make
them architecture-neutral; and suggested by Paolo, add more info to
distinguish a mce is AR/AO, and if a previous MCE was still being
processed in the guest.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20200930100440.1060708-3-pizhenwei@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/run-state.json | 90 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 7cc9f96a5b..964c8ef391 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -475,3 +475,93 @@
            'psw-mask': 'uint64',
            'psw-addr': 'uint64',
            'reason': 'S390CrashReason' } }
+
+##
+# @MEMORY_FAILURE:
+#
+# Emitted when a memory failure occurs on host side.
+#
+# @recipient: recipient is defined as @MemoryFailureRecipient.
+#
+# @action: action that has been taken. action is defined as @MemoryFailureAction.
+#
+# @flags: flags for MemoryFailureAction. action is defined as @MemoryFailureFlags.
+#
+# Since: 5.2
+#
+# Example:
+#
+# <- { "event": "MEMORY_FAILURE",
+#      "data": { "recipient": "hypervisor",
+#                "action": "fatal",
+#                "flags": { 'action-required': false } }
+#
+##
+{ 'event': 'MEMORY_FAILURE',
+  'data': { 'recipient': 'MemoryFailureRecipient',
+            'action': 'MemoryFailureAction',
+            'flags': 'MemoryFailureFlags'} }
+
+##
+# @MemoryFailureRecipient:
+#
+# Hardware memory failure occurs, handled by recipient.
+#
+# @hypervisor: memory failure at QEMU process address space.
+#              (none guest memory, but used by QEMU itself).
+#
+# @guest: memory failure at guest memory,
+#
+# Since: 5.2
+#
+##
+{ 'enum': 'MemoryFailureRecipient',
+  'data': [ 'hypervisor',
+            'guest' ] }
+
+
+##
+# @MemoryFailureAction:
+#
+# Actions taken by QEMU in response to a hardware memory failure.
+#
+# @ignore: the memory failure could be ignored.  This will only be the case
+#          for action-optional failures.
+#
+# @inject: memory failure occurred in guest memory, the guest enabled MCE
+#          handling mechanism, and QEMU could inject the MCE into the guest
+#          successfully.
+#
+# @fatal: the failure is unrecoverable.  This occurs for action-required
+#         failures if the recipient is the hypervisor; QEMU will exit.
+#
+# @reset: the failure is unrecoverable but confined to the guest.  This
+#         occurs if the recipient is a guest guest which is not ready
+#         to handle memory failures.
+#
+# Since: 5.2
+#
+##
+{ 'enum': 'MemoryFailureAction',
+  'data': [ 'ignore',
+            'inject',
+            'fatal',
+            'reset' ] }
+
+##
+# @MemoryFailureFlags:
+#
+# Additional information on memory failures.
+#
+# @action-required: whether a memory failure event is action-required
+#                   or action-optional (e.g. a failure during memory scrub).
+#
+# @recursive: whether the failure occurred while the previous
+#             failure was still in progress.
+#
+# Since: 5.2
+#
+##
+{ 'struct': 'MemoryFailureFlags',
+  'data': { 'action-required': 'bool',
+            'recursive': 'bool'} }
-- 
2.26.2



