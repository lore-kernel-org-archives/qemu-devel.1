Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F29C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D87A2137B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="UtvEQTcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D87A2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvnd-0006yo-7y
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jEvmg-0006Ww-2P
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jEvmb-00084A-6b
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:04:30 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:44506 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jEvma-0007oU-HJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:04:24 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 80B0741291;
 Thu, 19 Mar 2020 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1584626653; x=
 1586441054; bh=n7NJMoiwZil6Fow65ui7c9i4OczauW0K3VflSTp5bzQ=; b=U
 tvEQTcOT25/bzvbkqWQFF/yOa607ggX5oHM5EsUQgvdYDeKzTRRYJHrZCOUWsqRk
 gT0ZEY1j8xF9hJNHxEkvJhhDcz6vR83AuQgDU4YgXuyxPsDVkT5QdxVtgNQkv9ej
 LAoPJpC97YmqBd0EdHLSxttiFxAiLO9I553aj16D0c=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1gu_HvNc1fp; Thu, 19 Mar 2020 17:04:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 88CEF4126C;
 Thu, 19 Mar 2020 17:04:12 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 19
 Mar 2020 17:04:12 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3] MAINTAINERS: Add an entry for the HVF accelerator
Date: Thu, 19 Mar 2020 16:55:23 +0300
Message-ID: <20200319135520.80901-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Patrick Colp <patrick.colp@oracle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cameron signed up for taking HVF ownership.

Cc: Cameron Esfahani <dirty@apple.com>
Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Patrick Colp <patrick.colp@oracle.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Heiher <r@hev.cc>

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
Changes since v2:
  Removed myself from the list of maintainers, added Cameron from Apple.
  Status is changed to Supported again.
Changes since v1:
  Status is changed to Maintained instead of Supported.

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7364af0d8b..ab4dc2816c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -406,6 +406,13 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
=20
+X86 HVF CPUs
+M: Cameron Esfahani <dirty@apple.com>
+S: Supported
+F: accel/stubs/hvf-stub.c
+F: target/i386/hvf/
+F: include/sysemu/hvf.h
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
--=20
2.24.1


