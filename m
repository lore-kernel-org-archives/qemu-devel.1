Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 02:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7AB20760
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 02:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7AB20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWrvG-0003Zw-7L
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 22:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1kWruC-00036z-1f
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 22:06:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1kWruA-0005N6-GX
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 22:06:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 49C145C00AF;
 Sun, 25 Oct 2020 22:06:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 25 Oct 2020 22:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tBzRPD
 fx2arn5aR+mtf9eeYDogdV1jhAZLJysLcYba4=; b=dCbXL+VAnhQ2KNRnZW2200
 0L24I9S4pMWLzt4XadxZpe/xUpq9c/Pkq68L/OQDp/CgpSdOR0hlUmZrcG11JE54
 SwK5lmpCy1HiGOLh1cUht4Kqag1Qi1YdVP3CGq9nlkRITejxOPadCdRvPUSaKZT9
 RQph7pTa7Pd/J/X74LaXncQVYAiiAA/6wj8xbrs8p9ZmF3qSOL2UxD4yBSxW5FFg
 FRFgr6kTZI4SoM0LhxhFbuhY/cwRb9J67QOcr3JTzJFtjf8nI3iOPb8stoSFL+Hn
 x40lORl403MZZs2YHgBEfEC65cOpn0snpTt9v2QDKUDFAqDNK7L7RtgWO//tU02A
 ==
X-ME-Sender: <xms:LC-WX9R73loR-CnerLTLd2WVPUwFhZa0Kmkg50EWHdIYprouFUu2Qw>
 <xme:LC-WX2xNYdvz_hXRJWCV_f5S5wDAi675gdnbcNQQ3hvolbbmPQxNgZwQknWFQCaXP
 eNXxZ6nUGYSjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeehgdeggecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtohfgsehtkeertd
 ertdejnecuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgvtghk
 ihcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqe
 enucggtffrrghtthgvrhhnpeetgeetkeeukeffhfejueeludehtedtkeeuiedtgffgtdfh
 veefueeiiefhudehgeenucfkphepledurdeigedrudejtddrkeelnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhv
 ihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:LC-WXy1X7dLTbNFHbvY2QRUE7OFymlhd501jAgsM7IvD3Tj3fUGPhw>
 <xmx:LC-WX1D4v7OU7PG9UruzEezniZhmdzf-kWp9xy1zuowPWVbpDGPH4A>
 <xmx:LC-WX2he2Icdmm-SoH_VUzcOuuTBYVw4zUhvjWV4nadsiMVnXnLd0g>
 <xmx:LC-WXxsNiwO5hdr8NpPbe8hhOp9juu5ZC2iZRG_rN3tkttPuE-X8rw>
Received: from localhost.localdomain (unknown [91.64.170.89])
 by mail.messagingengine.com (Postfix) with ESMTPA id A1C553280064;
 Sun, 25 Oct 2020 22:06:35 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386/kvm: fix setting up nested_state for SVM
Date: Mon, 26 Oct 2020 03:06:22 +0100
Message-Id: <20201026020622.2890096-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=66.111.4.25;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=out1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 22:06:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nested_state->format needs to ne set appropriately for VMX/SVM,
otherwise KVM_SET_NESTED_STATE ioctl will fail.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 target/i386/kvm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index cf46259534..a002f0b4f1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1816,16 +1816,22 @@ int kvm_arch_init_vcpu(CPUState *cs)
         assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
 
         if (cpu_has_vmx(env) || cpu_has_svm(env)) {
-            struct kvm_vmx_nested_state_hdr *vmx_hdr;
-
             env->nested_state = g_malloc0(max_nested_state_len);
             env->nested_state->size = max_nested_state_len;
-            env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
 
             if (cpu_has_vmx(env)) {
-                    vmx_hdr = &env->nested_state->hdr.vmx;
-                    vmx_hdr->vmxon_pa = -1ull;
-                    vmx_hdr->vmcs12_pa = -1ull;
+                struct kvm_vmx_nested_state_hdr *vmx_hdr =
+                    &env->nested_state->hdr.vmx;
+
+                vmx_hdr->vmxon_pa = -1ull;
+                vmx_hdr->vmcs12_pa = -1ull;
+                env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
+            } else {
+                struct kvm_svm_nested_state_hdr *svm_hdr =
+                    &env->nested_state->hdr.svm;
+
+                svm_hdr->vmcb_pa = -1ull;
+                env->nested_state->format = KVM_STATE_NESTED_FORMAT_SVM;
             }
         }
     }
-- 
2.25.4


