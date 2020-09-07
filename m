Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E7EC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7542145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQGkVH/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7542145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNAz-0008Ir-VC
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNA6-0006zG-4y
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNA4-0006Yp-Gl
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:45 -0400
Received: by mail-pf1-x441.google.com with SMTP id k15so9075675pfc.12
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QPausshj3ZNkBQJCNUTx4EMdHd3D/97lV817rLbvoFk=;
 b=OQGkVH/7Bqso913pf2wWr2CqPmcy6YDHWMVy74rfZ3Dk6d1Jr+B1svQWHh8WNzr1g4
 o0Il4IephQlQk69ebygh1m1nZjgEhq+QKo1Xr9TVrgH9nTupdtV4+Y9CPrcUGAAQ15fY
 Gn8O8SSdlGilhExgBs1L/OwuTsTz5WcBMEkeBB6A67YxtXUi2qeT+6R3eN4SPj27bJBx
 0f1EkhtCn5JO24kBrRyK+7hI73C15FJuafDgE8Y/8xcxQ4+WrfCwM4uzU5zKsJI/nZpt
 OuTeSykoZn1uz2LgxVPlPBFOF5MdbG007GK/+ZYqbLpFf9/YoBlzzaYOtnwzJGe/T10y
 uppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QPausshj3ZNkBQJCNUTx4EMdHd3D/97lV817rLbvoFk=;
 b=f1Y+p2oQj3oJa18u9o56KMEPy9qeiiaYJm4up/ErrqmpvBkuX2Vge5F9Z3q/MctvFV
 rjJH97mkYRC6ASHyGxbYgEGEiLzHcBLcN68Ji3xDViQJaVZpO4VICZ/RuJwmU2xv8n7I
 ffOIVV29Magg/4AdY43GURwGbs8gocT5ZXXNvX+Y1QDq3mwnj+J2kIXXnUe8B0UK1pBO
 OLhA0JZY5k0fYgkWe2qJeWLSykWnzRyJH6QiCsHnbS2MLy123gy5Rikv9TtCIdbCAtnc
 K8MVp/Hor2RtrlRU++l8AfApySEo3LbHcJvyjAE9VqeV2rnkVz0C8JHmZ6VhUpu/NYeG
 hJKw==
X-Gm-Message-State: AOAM530WRWbJ0nOZk/DCK+nMfMzbFFhRLWxn2mwx+/5rhFekoMXRCHFq
 GR11lEJLfxs/w+0Cq7k5bZjWkG4Dt3D0HGQG
X-Google-Smtp-Source: ABdhPJybQe3QUBHFZP+o0o+QFkflTeN5Th89Y9iNTaP2RqvUQeH/MSxyyLH3u27TB3qNChQf63fw4A==
X-Received: by 2002:a63:5b64:: with SMTP id l36mr1885842pgm.413.1599508242788; 
 Mon, 07 Sep 2020 12:50:42 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id ev19sm4818990pjb.42.2020.09.07.12.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 12:50:42 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] vmstate: Trying fixes test-vmstate.c
Date: Tue,  8 Sep 2020 03:50:22 +0800
Message-Id: <20200907195025.2308-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200907195025.2308-1-luoyonggang@gmail.com>
References: <20200907195025.2308-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmstate should be valid on win32

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-vmstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f8de709a0b..4c453575bb 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -34,7 +34,6 @@
 #include "qemu/module.h"
 #include "io/channel-file.h"
 
-static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
 
@@ -1487,6 +1486,7 @@ static void test_tmp_struct(void)
 
 int main(int argc, char **argv)
 {
+    g_autofree char* temp_file = g_strdup_printf("%s/vmst.test.XXXXXX", g_get_tmp_dir());
     temp_fd = mkstemp(temp_file);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.28.0.windows.1


