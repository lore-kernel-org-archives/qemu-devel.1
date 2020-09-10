Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D282C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE08207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWasbVzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE08207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMRF-0005cb-63
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPu-0003vy-5z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:56040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPs-00064g-E6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id a65so5589184wme.5
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1IVujaGcl6Gaeb44XvH6utm7tpVyG1R70wAp2OwcHKE=;
 b=QWasbVzqGjmIb6mcq+bDGufK48YF9mzK9gFFvYiuOwKW3ujXXBOxSjepx841Qn0ERZ
 /NGAAdiT9EehL8SBgR2liB8AV52gnqC3/b0Vv+VfzbECCV2Lo/ofYQloJ8m6vcQI+U9Y
 ofxnEZpU8pazgX1neTq+rl94WBAPCd0UKmVAeXO7/EgPhQINzsRmKBgdE8ge+vIfAQFb
 k5r8Ht59wagjlSEeHMrvmuvhSWcCz8BU2W7hrjbC4fDIIBPulkD7GtNlVwQ5mlQkrgCi
 YZeh+u59VRRmX2zC1bA83NsVvgp0LfVt8AS3pT125u9KFeArja8YDXvNzC8pxSA+YTqS
 NTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1IVujaGcl6Gaeb44XvH6utm7tpVyG1R70wAp2OwcHKE=;
 b=r/1sRu4DnLp+TLRfwwaLuKpzAnqf5EEuaaISpAfyZ2of5ZoakCsiCbm4WtwPtU44GN
 0uzNFxdJk6L2MGbW0q+/KWDCZaDyFgclSkGNDeymPzqPu8m9BYXk9AJi+6FzjAnntmDy
 IpEut5VmMl5nMADxRMm14QDa53rDyKGo5urG7iBslqg5JS7gDbX3HTRx6rRk82RQGrwD
 CEuxVHWn6l1CXQl6/36PdqEkbfs9wI/annnqy/H3cdc6pfe8w4llJeVCMVBAbTz4BInA
 BjP0uX7eN7t6Mp/17Lijdg5JuZEatp1aOedeAnQ9n9yyeKcdhuwjQOI2aOFKwp3/w8+S
 XZjA==
X-Gm-Message-State: AOAM533nmJypdCnqmd9pIFcjhxb6fXdGKdsg/t5qNfcHwo5I61p28RaW
 An1yOd+/DA8vf0vcHONJ3j82pw==
X-Google-Smtp-Source: ABdhPJz5W4oHB5KcDDy1IcOmfNtvhSdSRWZxgKzsC1XVyKTiKLqcHa2boLy1lCaKs9bqzPqy119f2A==
X-Received: by 2002:a1c:9a8d:: with SMTP id c135mr63339wme.58.1599743706263;
 Thu, 10 Sep 2020 06:15:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm9030393wrt.20.2020.09.10.06.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77C6B1FF87;
 Thu, 10 Sep 2020 14:15:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/10] CODING_STYLE.rst: flesh out our naming conventions.
Date: Thu, 10 Sep 2020 14:14:55 +0100
Message-Id: <20200910131504.11341-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mention a few of the more common naming conventions we follow in the
code base including common variable names and function prefix and
suffix examples.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200909112742.25730-2-alex.bennee@linaro.org>

diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
index 427699e0e42..8b13ef0669e 100644
--- a/CODING_STYLE.rst
+++ b/CODING_STYLE.rst
@@ -109,8 +109,41 @@ names are lower_case_with_underscores_ending_with_a_t, like the POSIX
 uint64_t and family.  Note that this last convention contradicts POSIX
 and is therefore likely to be changed.
 
-When wrapping standard library functions, use the prefix ``qemu_`` to alert
-readers that they are seeing a wrapped version; otherwise avoid this prefix.
+Variable Naming Conventions
+---------------------------
+
+A number of short naming conventions exist for variables that use
+common QEMU types. For example, the architecture independent CPUState
+is often held as a ``cs`` pointer variable, whereas the concrete
+CPUArchState is usually held in a pointer called ``env``.
+
+Likewise, in device emulation code the common DeviceState is usually
+called ``dev``.
+
+Function Naming Conventions
+---------------------------
+
+Wrapped version of standard library or GLib functions use a ``qemu_``
+prefix to alert readers that they are seeing a wrapped version, for
+example ``qemu_strtol`` or ``qemu_mutex_lock``.  Other utility functions
+that are widely called from across the codebase should not have any
+prefix, for example ``pstrcpy`` or bit manipulation functions such as
+``find_first_bit``.
+
+The ``qemu_`` prefix is also used for functions that modify global
+emulator state, for example ``qemu_add_vm_change_state_handler``.
+However, if there is an obvious subsystem-specific prefix it should be
+used instead.
+
+Public functions from a file or subsystem (declared in headers) tend
+to have a consistent prefix to show where they came from. For example,
+``tlb_`` for functions from ``cputlb.c`` or ``cpu_`` for functions
+from cpus.c.
+
+If there are two versions of a function to be called with or without a
+lock held, the function that expects the lock to be already held
+usually uses the suffix ``_locked``.
+
 
 Block structure
 ===============
-- 
2.20.1


