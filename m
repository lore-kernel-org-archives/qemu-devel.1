Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4CB204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmnbZgNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4CB204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddL0-0001Yz-6d
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJd-0006Uc-NN; Tue, 26 May 2020 13:24:37 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJc-0004Me-5k; Tue, 26 May 2020 13:24:36 -0400
Received: by mail-ej1-x641.google.com with SMTP id se13so24653336ejb.9;
 Tue, 26 May 2020 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=clSLccSzglOurDqEG6EK2JpNgA9cL9mA+gQPjD7iYns=;
 b=RmnbZgNlrcoWUtQIG08Ub5IjrH76xxjEuapuyXwynsEuTaRnqAjXnZKzCMBVo2ydl0
 3EGwHgbj0du4z4cGghu7ew5WomFU/oMW0dziJECEVYxNOzU1hzmuXj+mrEoCOKinjHYp
 o7Oa0IQGU+whhCosyGiqJjGvd5GwVR72DhcOLPOvlw5SWwGJ/0v5AiNdx66a57y/dE+4
 FlhW/nscpDuRzc7Ml4u8xQ+0vriqkC/1I+zwknaxgx30F4kycW3buJzpL1qc2WpZvDKI
 Rbfg1Yf7DEYHuUCMl7rQHdSIgPDIb9GkeeuMO9hcB7Gb6uPlDhzOhvg+hMSGb3fl58hC
 IE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=clSLccSzglOurDqEG6EK2JpNgA9cL9mA+gQPjD7iYns=;
 b=I+A95N4SdI3QCdKf/58zlFAAyhhEL+l+IZI1rHMDBG+lCq35BtuOhdM9AeuSG0iHBF
 LqgrmQyFY2P3dkbg1F5/YQqMkPyI6ZXIN6v/k/GQHY2WjyWPYniwgLH0SaYjyXSaAOp5
 aSoikPUxAO1kn9lnV76kEZwNsnGPAZ2mgYlJJElrm75Rci72z7lCSLpuL9ijSU1LbkMs
 qwbDuVt9FLiJhelWmru6HgGc+yfl39WXjJXxayBnY7I0GFPDASQQfTRvkGxq6aO2bOeT
 aScIw00agVw/6RcxmU9NYFqSYCmj6oHli/XmdUGAWgD9fCFUDXbg93osLfRyQEeb6Uo/
 sGRg==
X-Gm-Message-State: AOAM533aPVu8impyvR7GmEV6PODkbl+dP9JmI9xvcnjgi19IoXTBUD2l
 VFcxeSFyJ/rnAaLD+Y29RfYyES08HdQ=
X-Google-Smtp-Source: ABdhPJzI4iBhXst+c05iEuJsMCNjVkGbMkb5AduQO+mCmSc/126RcNhWtPHu+TyxxGGpgd/+tBziDw==
X-Received: by 2002:a17:906:1d55:: with SMTP id
 o21mr1987258ejh.491.1590513873390; 
 Tue, 26 May 2020 10:24:33 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] sysemu/tcg: Only declare tcg_allowed when TCG is
 available
Date: Tue, 26 May 2020 19:24:22 +0200
Message-Id: <20200526172427.17460-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When TCG is not available, the tcg_allowed variable does not exist.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/sysemu/tcg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sysemu/tcg.h b/include/sysemu/tcg.h
index 7d116d2e80..d9d3ca8559 100644
--- a/include/sysemu/tcg.h
+++ b/include/sysemu/tcg.h
@@ -8,9 +8,9 @@
 #ifndef SYSEMU_TCG_H
 #define SYSEMU_TCG_H
 
-extern bool tcg_allowed;
 void tcg_exec_init(unsigned long tb_size);
 #ifdef CONFIG_TCG
+extern bool tcg_allowed;
 #define tcg_enabled() (tcg_allowed)
 #else
 #define tcg_enabled() 0
-- 
2.21.3


