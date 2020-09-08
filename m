Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C54CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FB82068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkwaF10W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FB82068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFimn-0005vV-Ii
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihM-0003Cv-N9; Tue, 08 Sep 2020 14:50:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:38261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihL-0002o5-5R; Tue, 08 Sep 2020 14:50:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id l126so4695750pfd.5;
 Tue, 08 Sep 2020 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9VMmLATL4hLY9MeoSmcNwnDOjnsVNymdFAgQMcXeglM=;
 b=BkwaF10WtWNLIvDotjR89OlGaCOVDtQFKpTkNmbQpJKvxWwcZlCrjySkVQeR0qUbvI
 cvlddfIZ+A+1G6qlx4M39Aa59Pjf7IrZfjMKg5uRDJ3O+n5yDrktF4lf70DaIv/a30bc
 FF7pgxc69IZVhBsV/Umxe3m2nxjDgHcFjdtw7EnEr1+IjXsSSsIwAWck3GgJ2q1nFfF/
 FqL06kxBaxhdeaQXRKn0fpWgC0Vd1NDJ5PA++8qWojsj83wcYSCBdi9s00G6slO+YIJ8
 igrMDi6ESj6aLxxa3qEv3Lna5LElYtBLiPEo4mHJ6YDqq+QaRkg4exYX8CnGr0Xyk1ff
 PULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9VMmLATL4hLY9MeoSmcNwnDOjnsVNymdFAgQMcXeglM=;
 b=iH6RHkz4tzs+QOyPUSlpI+lfVsg5uPrBYopbg3xTnW1XKhS6HL2kE9Bn8fV4cZBDCB
 T3EA4BFMLTLrlXn33LQzahYRQ8iKUPri3jHwAsgzC6Ra59cAeioXyPlbDQoy7NZLmSfN
 HTcNN0Zlg0MRdno5XsAvkh4Y3WK8nREeXv/KBYzxGAFAJ5HygutgmkUKBBKx08mL3ZVm
 x/qbIUnTNPYoz0Jzo4PyhgcuZuVmSrwzvcPHAVPpXpV2G8rTfh3m/9lK30k9Wks56lz1
 AR67GIhDtlKQcVPvvJopPUAX1eaLA8FMxnQeYlgfAWPtgHrLVDogLeCC40eUFyNAm6OX
 LjJw==
X-Gm-Message-State: AOAM5311Sl5udUXkmXFjX09ueZVEYnjaX5jU8aunQV9esNKGF5YFiFRZ
 LjTSr2FKbiQQ+aB2XXygdgzH6GT0h3DYkUkL
X-Google-Smtp-Source: ABdhPJydiNBnDobzjuQQzwM/PEQxFF0DSS5gbQDObvm8D/Wpt3ZADQoUJqtKuJeLh4AT7NFzQ7+0kQ==
X-Received: by 2002:a63:5656:: with SMTP id g22mr137089pgm.44.1599591028864;
 Tue, 08 Sep 2020 11:50:28 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Wed,  9 Sep 2020 02:49:15 +0800
Message-Id: <20200908184918.1085-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42d.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmstate are valid on win32, just need generate tmp path properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


