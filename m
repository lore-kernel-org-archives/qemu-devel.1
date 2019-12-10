Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10980C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1051206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="SBztUmyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1051206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ien44-0004Kq-Lu
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 16:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1ien33-0003W1-2T
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1ien32-0003Gj-2V
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:28:00 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:40732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1ien31-0003GK-OC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:28:00 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
 by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xBALRqHK034520; Tue, 10 Dec 2019 13:27:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=6GsKZpqfka3A+OxOXeH8855iOsd4LpeIZDU83F4Xx6s=;
 b=SBztUmyBhi3jeCkVfOmz48BuTnmDtZ0p0KccJyLOGZ2c12l5FDKihqQI55jwSHCn94+W
 zVrRHXfLMjxGtdrlvstsBc3yiKacbnbHMzUY2DHD4RvrTNEfWVvs8DEN6KB3eUfsht/6
 319zEoirVtbyh5k2AYej3jIgLc0jiF7PTsujh2TOb61SVCafxJevVbeKcoIHFp9xKNV8
 buu3FEnVvT5QKu/4+CHpFxBf24p19LBrWxdxmGY921AQC7Mu0Gtglarue44aDRMhNYAs
 srF1Bx6XLYrwEEBfqGaZmOu5dYoEiylf05glM8Ct8xgr5D98SCdEtQDugEta8S/XegOj Nw== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com
 [17.179.226.135])
 by nwk-aaemail-lapp03.apple.com with ESMTP id 2wrw6nq2k7-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 10 Dec 2019 13:27:58 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q2B001OMFMIUS10@mr2-mtap-s03.rno.apple.com>; Tue,
 10 Dec 2019 13:27:54 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q2B00H00EX18400@nwk-mmpp-sz11.apple.com>; Tue,
 10 Dec 2019 13:27:54 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 
X-Va-E-CD: 
X-Va-R-CD: 
X-Va-CD: 0
X-Va-ID: 7bee5336-b37a-48a4-aff7-e75debc474af
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: aaf2a305c88af01e6cd9a69980cd574b
X-V-R-CD: 0b94a6ef19bda2ba098ac0d7c55b3d68
X-V-CD: 0
X-V-ID: 5187c103-5e22-4f8d-aae8-6bbe84e762cd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-10_07:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.192]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q2B005WJFMITK00@nwk-mmpp-sz11.apple.com>; Tue,
 10 Dec 2019 13:27:54 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH v2 0/1] Fix bochs memory leak
Date: Tue, 10 Dec 2019 13:27:53 -0800
Message-id: <cover.1576013209.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-10_07:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.68
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

v2: Add missing signed-off-by line.

Cameron Esfahani (1):
  display/bochs-display: fix memory leak

 hw/display/bochs-display.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.24.0


