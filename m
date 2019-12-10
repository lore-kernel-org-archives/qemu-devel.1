Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20714C00454
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0427205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="bx8I/XAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0427205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iempo-00060h-VH
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 16:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iempF-0005bS-0u
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iempE-0006Pg-6U
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:13:44 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:53132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iempD-0006OO-UV
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:13:44 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xBALCbIK020541; Tue, 10 Dec 2019 13:13:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=+pNRkQvJbqn9KmZim7KcIayufL8+oEs8YqwMXwHoh/0=;
 b=bx8I/XAKUSkLIKISeYr0yWBufWT2QDj3oeBwGt5fd7zHS9oJCxb44QBZPepy/RcyfNxP
 +27Fv+WTwPP3E8ReC3cwX0juArA4xszT53ie/LaO95fT5Oed8JeLyAiT/NTgM2ASQqxD
 a4Y+ZrbXj5zwmAv2Ek5MEZXyB7F1jQcvRm352zgDx6gTuaaBkcCyXkB6E2+/JWiI8bIf
 wbUn9VbefaKOptdNG9EXqIJtVL76t62cpcX8C3iOUCzjKL4ZRYrXMgujYv1aliKn3Sx5
 wk79/nBT/o/apcgD/UR4HSdliD5qkTPPRuD30uyyidcYJ5W+Ez+166sKx9/ROWElqLO4 /g== 
Received: from mr2-mtap-s01.rno.apple.com (mr2-mtap-s01.rno.apple.com
 [17.179.226.133])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 2wrbw4qp2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 10 Dec 2019 13:13:41 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by mr2-mtap-s01.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q2B00H0CEYS3E60@mr2-mtap-s01.rno.apple.com>; Tue,
 10 Dec 2019 13:13:41 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q2B00H00EX78K00@nwk-mmpp-sz11.apple.com>; Tue,
 10 Dec 2019 13:13:40 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 7e3d9f92e0ba29e36d3eb88004d05ba7
X-Va-R-CD: f8ba38d3adc84cb833913637bd96b881
X-Va-CD: 0
X-Va-ID: e1f9a61c-b041-4116-beaa-ddc4257f482d
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 7e3d9f92e0ba29e36d3eb88004d05ba7
X-V-R-CD: f8ba38d3adc84cb833913637bd96b881
X-V-CD: 0
X-V-ID: 9d8c6f1f-599b-41cd-b37c-66a17bd05110
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-10_07:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.192]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q2B0058KEYSTK00@nwk-mmpp-sz11.apple.com>; Tue,
 10 Dec 2019 13:13:40 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH v1 0/1] Fix bochs memory leak
Date: Tue, 10 Dec 2019 13:13:39 -0800
Message-id: <cover.1576012190.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-10_07:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.66
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Fix a small memory leak in the Bochs display driver.

Each frame would leak about 304 bytes.

Cameron Esfahani (1):
  display/bochs-display: fix memory leak

 hw/display/bochs-display.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.24.0


