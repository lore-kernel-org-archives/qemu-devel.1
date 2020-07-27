Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C518206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoV9N6lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C518206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BDN-0003V9-KY
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B99-0007rv-Qc; Mon, 27 Jul 2020 17:58:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B98-0004LH-8c; Mon, 27 Jul 2020 17:58:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id r2so11236799wrs.8;
 Mon, 27 Jul 2020 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TXJ4qVIr+/EEDMVg8MI9Tdsi5K/g1R0LNvzFvLMTjsg=;
 b=LoV9N6lRbqWkxZYPpTG5rJk+yuSUEPwij9p8OzuIKNh7TK1njNLkA8qKjRvWahlW4G
 D66gp4j4lABN75So0IvvcXfD/QOKR5OiDPqRfh8sKoeD8P1kVGN2DydXnybcw9wB7JrC
 7mDKtSMf76icj3cy3ERM1IUmNQGZrGbFCwZ75ocoU5FqBHaTjD/cbfDzgZ+cMVHwl7UH
 +s6AYhUEyoxYCmFfCIQo1xIctewKOivvHpx32eWKf4waJeN12GXqPhy1lKbVdX4j297J
 z1uUL62EFOgKnmCILPW/tSEOB3hNwgGR/k2tilJWlL7wviLMbDC98xzj1C3jv09gna9C
 37uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TXJ4qVIr+/EEDMVg8MI9Tdsi5K/g1R0LNvzFvLMTjsg=;
 b=fAAUYCzAULP5VqaI0fOgKjOeMzaCxyZolTGfbHReZUxIXGyryIjp/UliSy0SWE13I1
 EMThviKw57dhG/6balAl3LgKpK6eyF9JMHc28Sa3v8nLD4GzbyAgyTi89x9sS3LzxS/7
 fVXL/HFx/UtQBURSQlCw+Sxs7AqP+2FmOGTTa/65ajcwznRp/CYw1NOBnGtWusmU314C
 iWFRp6EXfEJ2smdDumYbATwhdD2YzIuJOcbfg4chKNZJ4B/Iqol6o+n6kzyWXDWSQHeJ
 +3fT11qAfeY5Hr39eBuH5/7LKKfuQxk9uIfs09vl6s0p5vW9CyBFlMjjJBGKgiAJSKiB
 gaOg==
X-Gm-Message-State: AOAM533jr06qVxhSOWFiY+vBJjivPZRTE8NKPUtCyIMFn+j2aabNA6Rs
 7jwdOLWiN26EIDkkzhCRbn41DbfA1xc=
X-Google-Smtp-Source: ABdhPJzCMPVhhnKdq1MA2DUfhEY3qAQ2DOjs/BJcpQrgQWrCCLK/DcYLGj3vCDh9Ofi2OhaD4A2k+A==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr20988152wru.47.1595887135886; 
 Mon, 27 Jul 2020 14:58:55 -0700 (PDT)
Received: from localhost.localdomain (109-186-134-209.bb.netvision.net.il.
 [109.186.134.209])
 by smtp.gmail.com with ESMTPSA id p14sm14492940wrx.90.2020.07.27.14.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 14:58:55 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 3/4] iotests: Add more qemu_img helpers
Date: Tue, 28 Jul 2020 00:58:45 +0300
Message-Id: <20200727215846.395443-4-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200727215846.395443-1-nsoffer@redhat.com>
References: <20200727215846.395443-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 2 helpers for measuring and checking images:
- qemu_img_measure()
- qemu_img_check()

Both use --output-json and parse the returned json to make easy to use
in other tests. I'm going to use them in a new test, and I hope they
will be useful in may other tests.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/iotests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8f79668435..717b5b652c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -141,6 +141,12 @@ def qemu_img_create(*args):
 
     return qemu_img(*args)
 
+def qemu_img_measure(*args):
+    return json.loads(qemu_img_pipe("measure", "--output", "json", *args))
+
+def qemu_img_check(*args):
+    return json.loads(qemu_img_pipe("check", "--output", "json", *args))
+
 def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit code'''
     exitcode = subprocess.call(qemu_img_args + list(args))
-- 
2.25.4


