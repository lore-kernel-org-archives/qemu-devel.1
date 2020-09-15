Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FD6C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25BC20756
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sih/DL6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25BC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIALy-0007nX-O6
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rB-0001PE-0c; Tue, 15 Sep 2020 08:14:49 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9r9-0008GF-8i; Tue, 15 Sep 2020 08:14:44 -0400
Received: by mail-pf1-x442.google.com with SMTP id k15so1797059pfc.12;
 Tue, 15 Sep 2020 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cB+r+dkpxaxYLpmfHgr9Ib2dc/r134/ZQOU509IQ9fY=;
 b=sih/DL6pPq1DTQOvqIRMfLfFN1vftgjqX/sVsKe6z15+Ebk1S5Hknon8SQfjrBRzt/
 4VG0x5XO5Y7if9wFH8AA4K2N8FgSSRTBz78wu2COpjuZ03SYwHN5JJyaJ/mdWwd7jkID
 66iM8YKPXikBkbL2smi0QpRY0EsLXj20WLh2vKNXkla4ku0NMLn0mRQchbS5sO8UTl0k
 SxoFQeVCHBKVkMM7oALRrU+EmpCHcMcsJoruU/27gXxRIBaqKbFGx6oZrTAS3Vdp/2CX
 3jtacGPJtFZWaRsihPciWZGThoTETRMp2tC972hjPvMGqGBC9FGcdr5+tz7r6Xs48/e3
 DGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cB+r+dkpxaxYLpmfHgr9Ib2dc/r134/ZQOU509IQ9fY=;
 b=b7stpMZjcDXR79h/fQ3KOSroCCVP48awXaTOUAkTXCf+9eITUfVrq1eDUe+Olo0bGO
 9WojG6mS4Rn7b1gtAwOAq5DIvYwKbLe0Ny7HZEwPpMdjnvF3pHaS8lbC9MY3LtpWYNgl
 QiKMbzuS65+pzoMiW9ZwqwmyEc7vY2+yiGERI1Sg2RQLK4DPzvlCgriMyG3//kj2kiZK
 zvB6+vjNwz3ThjPcrXRicYk75tLtivNKDkIyuHRfpu5ELS+juJmW8lj89P6rJx/oCiu+
 DIapt8/n8pQKMukcfriI6Nlucub8reAJ2cUBnwXpK58NlX/vOfmDGG54kuM85Zemy1Af
 cEKg==
X-Gm-Message-State: AOAM530LWDr+sfHXj3v16KtdrZPQP+/BD4fmJzAuvn4Zan1eHjpNERJ1
 VyzLY6bo7unSz+ZZ6HMi5UWfeQBeOg4KYYTe+BY=
X-Google-Smtp-Source: ABdhPJzjDHQU9QmUNa6pDcxha5MBLoGGfmaAOwJNnrI2HILNyn33TMyCBUR/fDVkOupZIAy4MfLmCw==
X-Received: by 2002:a65:410c:: with SMTP id w12mr3892003pgp.411.1600172081027; 
 Tue, 15 Sep 2020 05:14:41 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 14/26] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Tue, 15 Sep 2020 20:13:06 +0800
Message-Id: <20200915121318.247-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmstate are valid on win32, just need generate tmp path properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-vmstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 1c763015d0..ac38bfcfe8 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -34,7 +34,6 @@
 #include "qemu/module.h"
 #include "io/channel-file.h"
 
-static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
 
@@ -1484,6 +1483,8 @@ static void test_tmp_struct(void)
 
 int main(int argc, char **argv)
 {
+    g_autofree char *temp_file = g_strdup_printf(
+        "%s/vmst.test.XXXXXX", g_get_tmp_dir());
     temp_fd = mkstemp(temp_file);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.28.0.windows.1


