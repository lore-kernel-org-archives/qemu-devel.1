Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE78C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728292070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtAp3EiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728292070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07Cv-00050a-KC
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07C9-0004CE-GA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:45:49 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07C7-0006Bk-Vd
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:45:49 -0400
Received: by mail-ej1-x644.google.com with SMTP id g7so9655511ejw.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OGCemuoCnniJTddIL0pVvSa/2sbZNppcufLQWxfQwd8=;
 b=dtAp3EiHMN1+5Ntxbtup7mh1PjUBCnBQGqqiNkEu7U7708w4hudOrN+OKDcTq/+PLu
 1jkVGlkc/i+0OQ8qqrPteURDUMh36F2x0pfeRQ7B7G5edKhzqV5qPLjJny6uzzFjpB0B
 XI6JvtWtf7pF3xpvAEp/qyKv76w0pil4VcYX7kYp4NILJIO1YH9lAtscJK00JKQJr00i
 oPGpsIFIYKPZwRKflVr+njxae8K7XmhRCGXtOCliVgmWR9K9B77oBKzB2oFWcM/+07YX
 FQGREsAzYpJgalY3pBsWcFmuyPRRg39/XdxKu5d6ytGPUZlkRTGr1/QU2gjjlx/m3raP
 Qjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=OGCemuoCnniJTddIL0pVvSa/2sbZNppcufLQWxfQwd8=;
 b=spML7meMbmniWHnx8ZtfhkQCU+eSKJtfkdE2yh2ApaYiOuH1BGdca7m3z8OsmWpeNU
 38AhMjdpLY1KVN756S7khhvy1/KOAeYN2aAti+CdZ/u8Jdm96g2vHpsb5NtSVYcz4/9V
 Hg+tjWMgJTk8OLH7pVWLzKmx955SyVL5q5rMl3ZPfISPJgRlJzK3mgNU8uaqO0Zr3LyI
 Mb/dwBJ6SXpsHE/AlNpZ40KOWnOJ0cKP4T1E+O47hjZ342N21H0e93lgdoDTGzqH+8fn
 OH+NKarX2qBqwxcMOx3rNEx3BZiS5EJVPbMMvNFWaI/+F3+xs82aFbpnoaE18EgUSW11
 VkQA==
X-Gm-Message-State: AOAM531irfW8s7g+WZ6X9DlS1JwXH2jSY/47w8St9bT6F1hhuPzURGB+
 1Ke099I4pndSxXa4aC8Bhn/wYplz
X-Google-Smtp-Source: ABdhPJztc8CmgW3k40JQJ9gKBv96ZMPEtOQES9Gd1vxnaGaSr+y1N5ZpHjHzJUr9vAXLx+Ws8D+Ncg==
X-Received: by 2002:a17:906:f181:: with SMTP id
 gs1mr22913793ejb.293.1595871945798; 
 Mon, 27 Jul 2020 10:45:45 -0700 (PDT)
Received: from x1w.redhat.com (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id e10sm6679406edu.51.2020.07.27.10.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 10:45:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] memory: Display bigger regions first in 'info mtree'
 output
Date: Mon, 27 Jul 2020 19:45:43 +0200
Message-Id: <20200727174543.4219-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When different regions have the same address, we currently
sort them by the priority. Also sort them by the region
size.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 softmmu/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987518..c28dcaf4d6 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -2960,7 +2960,8 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
             if (new_ml->mr->addr < ml->mr->addr ||
                 (new_ml->mr->addr == ml->mr->addr &&
-                 new_ml->mr->priority > ml->mr->priority)) {
+                 (MR_SIZE(new_ml->mr->size) > MR_SIZE(ml->mr->size) ||
+                  new_ml->mr->priority > ml->mr->priority))) {
                 QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
                 new_ml = NULL;
                 break;
-- 
2.21.3


