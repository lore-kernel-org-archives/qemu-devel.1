Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDBC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DAE2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0+kzdn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DAE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufRR-0002wY-Gt
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPZ-0000DA-QW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPY-0002pS-My
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPY-0002ov-CC; Mon, 05 Aug 2019 12:00:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id p184so39868568pfp.7;
 Mon, 05 Aug 2019 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=mAXOsVeY+WH0KY8xBsARzSnd6O65X/IHsyEOSBOVcT8=;
 b=H0+kzdn2ynOr4mdwDqm1T+8aiSxGAO/m69ecswYtEGzDvz31/PV652wNaMbYGvDlFX
 7ho9kERGAMF2D8ylS1u+CCNrNA08HPL/8a8FMcMMW+Z4fSTl2qWmGO0bzQAi/wcVo3qP
 Rbozt3Sptg8+bO8jxFNPIuuCQNai4ZhZvhB4VTFzQyP9jixXn7WwsE+IBH2tdxy9R9e9
 SHL8DesEOOE7wf6XeFWgXiqMztgrB4iv8iG2dnEQaEw9ejROB8hp5BM0WFKDGiqLHWyi
 EF9eoOY+tUxePzFWHiefsGSzDvve5mBNGKiFrjCQ/I24DxdHRe9AxfbZNEQQzVIvyc7i
 ykFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=mAXOsVeY+WH0KY8xBsARzSnd6O65X/IHsyEOSBOVcT8=;
 b=WNdyEzh/Jl6reZ1Fa0Mpo2wA6m9rX4iFNKjhZapZjoyJn6Hkgkx+lWrc02JnpDShC/
 ISq3KmUQtm9mE6cntB6bZnJQ8apGg6Z6f8zm9rqaksPkao8RPxJC1iSeCFFo2MO003Nk
 vlTwmBOz1LfNgcL6df/H2soWBRnbpN7dqj6aGCzGajOBCwpPbNcYIXNXf235OnvzLj5V
 hobMGDnRxmeGmMzJCDO+C+d+J0sKl9wifYIgK6+orCopEvJXFjocARSHrolU84dcASFD
 IkDUXwvGxfeF0UkHIdmxU6P4bu6gn2FNs1yTZZ1YdOkfqU+lLxNa5ZQdsvg8yPxNV45i
 iJmA==
X-Gm-Message-State: APjAAAX57hsfkM0VgTrYq97VHPBIm97E5FGGthCZ28AZOSQiElB/I9+k
 z87qPPe1pxmdNkxi+szTPNg=
X-Google-Smtp-Source: APXvYqw690F4kOZkqOpEIydqp4AdUSm2FzWYY96abRvPoE5oTnrCEd25NBduP6fo7AZ+zv+D0r7m0g==
X-Received: by 2002:a62:8643:: with SMTP id x64mr75949694pfd.7.1565020835697; 
 Mon, 05 Aug 2019 09:00:35 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.34
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:02 -0700
Message-Id: <1565020823-24223-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 07/28] riscv: sifive_u: Set the minimum number
 of cpus to 2
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not useful if we only have one management CPU.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 08d406f..206eccc 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -428,6 +428,8 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
      * management CPU.
      */
     mc->max_cpus = 5;
+    /* It is not useful if we only have one management CPU */
+    mc->min_cpus = 2;
 }
 
 DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
-- 
2.7.4


