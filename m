Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548BAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD63204EF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcsQ7tF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD63204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiBzv-0007Vt-DN
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 03:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiBz9-0006zY-W9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24661
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiBz8-0004lX-BR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591600456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SMx5SpnyStznYe62dUidIf4jRnxg6ybMRVo0DpRP+yU=;
 b=CcsQ7tF8YwT1qn7AXrbYoBLw8KnmmbESjqqt2vPp6EkQC9cLMOKUnO/NqnuN0Xxp3Ilpjc
 FXsu/A8RtpIcMk2q6PWCNuBvtvLcjdf522nCvUqiurOemR4XBbp9QdPSjs63oKeJbeomlo
 MbvS5EWD2EQbkBP526tSPPfUiPqBUf8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-5qqY3Bg9OrimNNUVLle9BQ-1; Mon, 08 Jun 2020 03:14:13 -0400
X-MC-Unique: 5qqY3Bg9OrimNNUVLle9BQ-1
Received: by mail-wr1-f70.google.com with SMTP id w4so6791344wrl.13
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 00:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SMx5SpnyStznYe62dUidIf4jRnxg6ybMRVo0DpRP+yU=;
 b=PWUubziERUUSOmXcVyqyLNBhDrHzqzOePg7EczZ5mkOgc7VYfLdGA9QGm3vstSakp0
 w5K4m+4hg0dwQtOd2Zc6a0dNMiAN/AUHitbUbyOfeKQ7jAg8z0syXxtIFBzHFwxumK4k
 DYrgtb8VLguCamEi3k+7FCZ/81n8Kw9cLz6Z8tJG0ADaBqN2byslq+TzHIG+KZleG/hZ
 aA6chUSlr1CunmhtcpwRgNC/QKVwdcU/3sro5palpcFbc1daeFDmKP5sAde+vFUV4Due
 Aru3WFjwbib2gAavPcQkg4ehTfAFerT/QHNu7Ma9QjcrAhJVtOXRlaluzi7rlBIRXkeJ
 w4Aw==
X-Gm-Message-State: AOAM531J2Gzb4x6S3pIN8hUn4XFUbbTShFToUYs7Jm398CR2Rh4iaW/G
 ytLcW+Tso2dmoTJKEaHweE4W/2SAsygGcJ2xpDttyD4LEA9UydI2Secs7YEVDdG72GVcPBp9on1
 /I/hXOsYIYac1ga0=
X-Received: by 2002:adf:aad7:: with SMTP id i23mr22304144wrc.331.1591600452507; 
 Mon, 08 Jun 2020 00:14:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg5Jz7y3JYvwmiaJta9Zp1LkW9JbXgFnbaU+r1MEfh465XbMGkY/a5Sojc/ahcvizrU7Q2mw==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr22304113wrc.331.1591600452110; 
 Mon, 08 Jun 2020 00:14:12 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v19sm21109368wml.26.2020.06.08.00.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 00:14:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH] hw/openrisc/openrisc_sim: Add assertion to silent GCC warning
Date: Mon,  8 Jun 2020 09:14:09 +0200
Message-Id: <20200608071409.17024-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, 1874073@bugs.launchpad.net,
 Christophe de Dinechin <dinechin@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When compiling with GCC 10 (Fedora 32) using CFLAGS=-O2 we get:

    CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
  hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
  hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
        |                                  ~~~~~~~~^~~

While humans can tell smp_cpus will always be in the [1, 2] range,
(openrisc_sim_machine_init sets mc->max_cpus = 2), the compiler
can't.

Add an assertion to give the compiler a hint there's no use of
uninitialized data.

Buglink: https://bugs.launchpad.net/qemu/+bug/1874073
Reported-by: Martin Liška <mliska@suse.cz>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/openrisc/openrisc_sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index d08ce61811..02f5259e5e 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -134,6 +134,7 @@ static void openrisc_sim_init(MachineState *machine)
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    assert(smp_cpus >= 1 && smp_cpus <= 2);
     for (n = 0; n < smp_cpus; n++) {
         cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
         if (cpu == NULL) {
-- 
2.21.3


