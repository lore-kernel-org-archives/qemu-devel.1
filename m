Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F034C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1650620409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="XJ0ZG7jI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1650620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuMx-0005QR-9v
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jDtVB-0007gp-68
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jDtV9-0000DK-SG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:08 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:34122 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jDtV9-0008RS-Is
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:07 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id BED8540418;
 Mon, 16 Mar 2020 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1584379563; x=
 1586193964; bh=aTNGDJuYHGco724gdsuQJNuglR994JG7/z8mTvTwqcY=; b=X
 J0ZG7jItwpp8XMQMho745ro1lqGBXNSw8cUte9JOF3Y/c3e0BpYsztmlkzGEXMyE
 a1KzijMS4BwMLp+Bv9ScxJUPzYG8iM8Rg9IAwAAhzNp0OguKSDpP4CdPYMud98OA
 PSb/wGDHcPvOC1nCOK4b3XiRazEffsemNEK3LUIr7Q=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4CIFJfK45QP; Mon, 16 Mar 2020 20:26:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 72F0740416;
 Mon, 16 Mar 2020 20:26:01 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 16
 Mar 2020 20:26:01 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2] MAINTAINERS: Add an entry for the HVF accelerator
Date: Mon, 16 Mar 2020 20:18:27 +0300
Message-ID: <20200316171825.42544-1-r.bolshakov@yadro.com>
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
Cc: Patrick Colp <patrick.colp@oracle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Patrick Colp <patrick.colp@oracle.com>
Cc: Cameron Esfahani <dirty@apple.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Heiher <r@hev.cc>

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---

Changes since v1:
  Status is changed to Maintained instead of Supported.

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..8649ff9cda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -405,6 +405,13 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
=20
+X86 HVF CPUs
+M: Roman Bolshakov <r.bolshakov@yadro.com>
+S: Maintained
+F: accel/stubs/hvf-stub.c
+F: target/i386/hvf/
+F: include/sysemu/hvf.h
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
--=20
2.24.1


