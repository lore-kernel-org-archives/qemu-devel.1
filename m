Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C4C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 09:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F12B21974
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 09:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PPSLr+Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F12B21974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQ6jg-0005SY-Aa
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 05:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jQ6iu-0004xE-BJ
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jQ6it-0000Fn-3t
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:58:47 -0400
Received: from mail-eopbgr680067.outbound.protection.outlook.com
 ([40.107.68.67]:12773 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jQ6is-000063-MQ
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikvxfmmvnRbGF1sJUInU2tT5hDAAVBW5D5GSPh7R18JWK+YTwjrPTzRwo5GTpnT2GuhwuKtetUJ2wm0JoM95j7o4+W7svs0MLNTdK2fg3MjXcwedq8GhbpOfCOx4hECiA9IQUa8UcldL5JMKP6ISQOCIu61wBRfcIYLZbsKPGGCsXwiFVxJzGOjxlETryuhAIalRDEuQYWYenYURIEBkWXaLoUve07Bzii/IUbRhydicTaJAn3Qrxm+GESptfREhbdv0Ris84x2Pzu1CW4qgVFRdk3Ncf4RsX7pDL9xZpmii9jKeFPZEkTU7Af2Lr2LMS3T5ETNzgIh4zdwjhktXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2g7JA+hVDuKyeqoWGcCVzJ5BqNNZwdwcJeSrejD++Y=;
 b=j2QiavJrKic+5ZhjfNHos6Klmw6QooDiHYHPwgu6Kc4vhlp16AEKCaDOQ3VTckSvlxHiQFTNHUGaMytgeLPc2EyP3DHSHp7YnHz1op2sgraKIT7lv+KnGm8tfwOXPvdVSaQs7s4FBU5IW4+SxEE/y8GLNsh9oidg4IIvpNVwYYmicdr2uELhHtOqotQ8P+vC9qw4b8MjTZuxfvL21JeCOjc/LwV8Ql+IdZB+R0qoZg6Pgz7mx62Cmz5uG1QA4tS9pIbzUjDuzk06bApM+rA8kHwaeitt9j83TPk+sSQYSKBLiLg6U5QTk9e18rTUwK6HtaCZzus5UGg4gFsEAp6hqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2g7JA+hVDuKyeqoWGcCVzJ5BqNNZwdwcJeSrejD++Y=;
 b=PPSLr+Z5yQfnFWrg0+Lc30EfxnjMpjmDbH1Idjg4be4ldYwDbzrRu1ZjkimI8Tqn9sq7NavYBix1wfgmqkeRi09KmHK3FN2HvDw1mJAUWk1j3PAAkL27FyDVwAoWlmKBsQsAx1MmIrhhRZS6yBw2FdLgnXMSwPyYTB9cv0YxBEY=
Received: from BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47)
 by DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Sun, 19 Apr
 2020 09:58:43 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::90) by BL0PR02CA0034.outlook.office365.com
 (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Sun, 19 Apr 2020 09:58:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Sun, 19 Apr 2020 09:58:42
 +0000
Received: from [149.199.38.66] (port=55609 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jQ6hv-0006hm-N4; Sun, 19 Apr 2020 02:57:47 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jQ6io-0001b6-BX; Sun, 19 Apr 2020 02:58:42 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03J9wfKH027686; 
 Sun, 19 Apr 2020 02:58:41 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jQ6in-0001b0-9i; Sun, 19 Apr 2020 02:58:41 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 8910C13C0A82; Sun, 19 Apr 2020 15:21:41 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2] chardev/char-socket: Properly make qio connections non
 blocking
Date: Sun, 19 Apr 2020 15:21:40 +0530
Message-Id: <1587289900-29485-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39850400004)(46966005)(42186006)(316002)(2906002)(478600001)(81156014)(8676002)(8936002)(2616005)(336012)(110136005)(426003)(5660300002)(186003)(81166007)(26005)(107886003)(4326008)(70586007)(356005)(6266002)(70206006)(36756003)(47076004)(82740400003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb92eb52-db84-41a6-ba5e-08d7e4483e2c
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3356011B444F3C807B257FAACAD70@DM5PR02MB3356.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 0378F1E47A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZtXLSHWwan00xtGkFZ2/PbtPIHDeIDExT/z+SXkoBkchf36wYgugREsWFlKdu1hPbUk1Qcfkz/TinRMOVba0QvcY/5H5uvVE/IxDYI+hoIMk1Gk+2Jpd1qWgxmrHxpipehsDlzN3ekcMmEHMFFfmGLSHuN3QRKQ0n7fkNzIW29qcRfgn5+116Zp5W4J0FBKs6gJIeVak/yGCHEy5oq1HgbTBXH7xt1u08I8H4OZsiX53t7xQQ/5kF1fvEXSgg/nSnpAxsZzYO3g40KfoJ7heOCup++KwMzkm8XFv7ALVyfApvZNvDvriFViH+sTKvoOm3VK7nRGV1BKvS8KHN3b2TuqET9v/eKHgauyM8Sgqjm4FFtPzPnhqp2R5KUMkpbtkag0lpGERvs7hB9L0qOtzITT3Cx82o+Hq2Qa9FYS0+wkNRrEGY+NxDfdlPKF7unepuks4ZGAf+WF9lO64nrC7YMk+umObTrZ02F67Sc0Lyk/ePa1PBiH5PPiYNeT4dWv3Ih/eoMmVTtlYCivyooJx6w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2020 09:58:42.8021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb92eb52-db84-41a6-ba5e-08d7e4483e2c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3356
Received-SPF: pass client-ip=40.107.68.67; envelope-from=saipava@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.67
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, edgari@xilinx.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In tcp_chr_sync_read function, there is a possibility of socket
disconnection during blocking read, then tcp_chr_hup function would clean up
the qio channel pointers(i.e ioc, sioc).

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
Changes for V2:
	Place the guard around 'qio_channel_set_blocking' call to check connection status
	This fix is simpler than v1 and explains better about the issue.

 chardev/char-socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38..e56b2f0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -549,7 +549,9 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 
     qio_channel_set_blocking(s->ioc, true, NULL);
     size = tcp_chr_recv(chr, (void *) buf, len);
-    qio_channel_set_blocking(s->ioc, false, NULL);
+    if (s->state != TCP_CHARDEV_STATE_DISCONNECTED) {
+        qio_channel_set_blocking(s->ioc, false, NULL);
+    }
     if (size == 0) {
         /* connection closed */
         tcp_chr_disconnect(chr);
-- 
2.7.4


