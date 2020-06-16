Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B06C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976F2208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsudBc9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976F2208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCrn-00055K-Pr
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQO-0003Ee-5F; Tue, 16 Jun 2020 10:18:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQM-0006uw-JB; Tue, 16 Jun 2020 10:18:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id j189so19335790oih.10;
 Tue, 16 Jun 2020 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U7J2TqZ1ks8KNH7mIqSpb6zD0BiSTiY4lPX/uz7chis=;
 b=LsudBc9irn12ll41uXuWAfo+MOHKdy5VJgTNuXGo7I9aj1VBx74Ot75xvrLZIydr2g
 v4nLwd90MsuF0XTOl5Cwbudyy6Oz09Fdhl0xYdTvsoJSTjFpRFIoTvEq+L1LxtBl0EoZ
 kDybpw1pJdJFsXO+ZZ4T/a6fmTZ5VUDwuCVxgmHVBBdVg7diqo+rHNiJ3XX5m4O/LJ0g
 z5pgQbFbQtXsTH/htaTpfbZnW0fp/95q1O9ZSdTzIo+IitmyWVLSRf6MVnEK89zhR5s7
 /QWIBP41/B2++1vxllA9XLDAKD9hQxzhL1CsejreHgWViht4UOQHWnTc3xc2bl2TVrw7
 dukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U7J2TqZ1ks8KNH7mIqSpb6zD0BiSTiY4lPX/uz7chis=;
 b=nOD9PfhD/tOaQABGbp1zzCs0o6v9/eRnRmTclSMAx4AUXfoGK1lA9i1KQ9paG7yBVM
 CeFFpjG8MNpkm9I/ecA3HxhiIOHag1/ZYR3zUv8eg4zfDIZVLqiHjWmNy10pCUuwbGkh
 2o7vx+V7RQuJ4uJkU+9WwPnUXDpgyd7lvNMVKSIFb5cDX6bB5cMHiHd3gf0RM0rjC93v
 G+E+yjkRD75V2W9m8AliePxHAWm4GpigE8KzywtHsQZI1ENulEcA8gsHyow4jQE2EavP
 FQswHXTA3t/TSSkjtHKgjXsK0KdA1m5HtRMI2nA2RaeA2GYFAXrpYXaWS5Y/r/zX3hn3
 53zA==
X-Gm-Message-State: AOAM533nxAV0yFXsWJKyPqBGkZ9yLcgBXsjDXdfdgFHaLzSXX89GVHtg
 MurAYk9+C8e6y7IG2qCdt4qJaMKf
X-Google-Smtp-Source: ABdhPJzx/fWZpwsFoWHuJuIXAHDmV8uOqg6JcpZDnUy2K/AzBn9aajdchNTjFX1UOPANstr3M6z2ag==
X-Received: by 2002:aca:1b13:: with SMTP id b19mr3649055oib.132.1592317128547; 
 Tue, 16 Jun 2020 07:18:48 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m18sm4155574ooe.12.2020.06.16.07.18.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:46 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/78] scsi/qemu-pr-helper: Fix out-of-bounds access to
 trnptid_list[]
Date: Tue, 16 Jun 2020 09:15:20 -0500
Message-Id: <20200616141547.24664-52-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christophe de Dinechin <dinechin@redhat.com>

Compile error reported by gcc 10.0.1:

scsi/qemu-pr-helper.c: In function ‘multipath_pr_out’:
scsi/qemu-pr-helper.c:523:32: error: array subscript <unknown> is outside array bounds of ‘struct transportid *[0]’ [-Werror=array-bounds]
  523 |             paramp.trnptid_list[paramp.num_transportid++] = id;
      |             ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from scsi/qemu-pr-helper.c:36:
/usr/include/mpath_persist.h:168:22: note: while referencing ‘trnptid_list’
  168 |  struct transportid *trnptid_list[];
      |                      ^~~~~~~~~~~~
scsi/qemu-pr-helper.c:424:35: note: defined here ‘paramp’
  424 |     struct prout_param_descriptor paramp;
      |                                   ^~~~~~

This highlights an actual implementation issue in function multipath_pr_out.
The variable paramp is declared with type `struct prout_param_descriptor`,
which is a struct terminated by an empty array in mpath_persist.h:

        struct transportid *trnptid_list[];

That empty array was filled with code that looked like that:

        trnptid_list[paramp.descr.num_transportid++] = id;

This is an actual out-of-bounds access.

The fix is to malloc `paramp`.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4ce1e15fbc7266a108a7c77a3962644b3935346e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 scsi/qemu-pr-helper.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index debb18f4aa..38c273de19 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -421,10 +421,13 @@ static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
     int rq_servact = cdb[1];
     int rq_scope = cdb[2] >> 4;
     int rq_type = cdb[2] & 0xf;
-    struct prout_param_descriptor paramp;
+    g_autofree struct prout_param_descriptor *paramp = NULL;
     char transportids[PR_HELPER_DATA_SIZE];
     int r;
 
+    paramp = g_malloc0(sizeof(struct prout_param_descriptor)
+                       + sizeof(struct transportid *) * MPATH_MX_TIDS);
+
     if (sz < PR_OUT_FIXED_PARAM_SIZE) {
         /* Illegal request, Parameter list length error.  This isn't fatal;
          * we have read the data, send an error without closing the socket.
@@ -454,10 +457,9 @@ static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
      * used by libmpathpersist (which, of course, will immediately
      * do the opposite).
      */
-    memset(&paramp, 0, sizeof(paramp));
-    memcpy(&paramp.key, &param[0], 8);
-    memcpy(&paramp.sa_key, &param[8], 8);
-    paramp.sa_flags = param[20];
+    memcpy(&paramp->key, &param[0], 8);
+    memcpy(&paramp->sa_key, &param[8], 8);
+    paramp->sa_flags = param[20];
     if (sz > PR_OUT_FIXED_PARAM_SIZE) {
         size_t transportid_len;
         int i, j;
@@ -520,12 +522,13 @@ static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
                 return CHECK_CONDITION;
             }
 
-            paramp.trnptid_list[paramp.num_transportid++] = id;
+            assert(paramp->num_transportid < MPATH_MX_TIDS);
+            paramp->trnptid_list[paramp->num_transportid++] = id;
         }
     }
 
     r = mpath_persistent_reserve_out(fd, rq_servact, rq_scope, rq_type,
-                                     &paramp, noisy, verbose);
+                                     paramp, noisy, verbose);
     return mpath_reconstruct_sense(fd, r, sense);
 }
 #endif
-- 
2.17.1


