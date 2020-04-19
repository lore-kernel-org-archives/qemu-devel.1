Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8FC38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 09:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F7821473
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 09:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Z7oTGkBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F7821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQ6fg-0003nT-6U
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 05:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jQ6ey-0003O3-7G
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jQ6ew-0007hz-Fu
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:54:43 -0400
Received: from mail-eopbgr700041.outbound.protection.outlook.com
 ([40.107.70.41]:44481 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jQ6ev-0007fa-VM
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:54:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8pmFiLKmUVSjzlPamJxz1w2grfEP7/ReXcfq6AmYnclJZyeeIqEBKi77U2k8LrFXVEZGhyPRrWOHVNVPi3E1ZlPpwqJ9PlcFSJ5Gqec0YHwBwP001/sFk7oYPr24LpJaIBW5EGrOzXges1cDvEbGQkw0Jp3F5p/sJ8hkaluBXtGGAUDi+/E8kGWYXppv6MzhcL1ZfohOC6NBKNkzhF+NCjMQg8/DcmQ5a2X+ZN9gPc/qNc5P0GCmWs2c1MkBoX+pYI/jmt4XtZ95Rtyq8TedWMH4otg/yIcvc2RYR9UrJQLUhpm6xtKuvG5Tmzpon5QECeoIoeXG0LhnOl8q3JNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMiMQt0nRaDhrTrjM4h9/GK2+eX5jDdMi6kl/5v1OBg=;
 b=jAZZUr0pAwZQgl5Twn6iO2VslM+8jzwDmGCXdMGaPKh7dx7rsDG+cZScR2BsPTwKiVud/FK6KDxa9nEmlKkIW30DRDdlmoJ0JXRkf3qhhv+SRpdzk4l19EcAjTvoNzvjbTqJxJaBuV3HGYM4PPo/lNM0gxom4A7rZnqC/SfFGpBRn1gxvdHK3MNdyDnoy4a6p3z6ovbqXKuAWHBIUyyzQwEvkRplXW8nWZMhQ33qNtmx/Dlj6QQbMSUsFnUlHnaTJ90lLJDP3JVQef16o83GUMO5PgKxxQZ+zyXiYJTo4JTu7cRE/V7QevqE8pl77H9DxOFiUxgMhG/5jw0wWZ3j6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMiMQt0nRaDhrTrjM4h9/GK2+eX5jDdMi6kl/5v1OBg=;
 b=Z7oTGkBlpHx4Ixtw71tF2n2NNCoRh/Fmq2XGDvxhvf7GZSY59uIYSfZ2awfbRJ6d+D7tHwY2KZ1QQwFFqH8JZqMFXVzvbWObOQJYbHm+peLVcDM4B5G2L27cvPIsPnSqHxBi9swznL1XooQIe3bJYVSHxg4f6WlNHKBGp0bYNcg=
Received: from BL0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:2d::23)
 by BN6PR02MB2434.namprd02.prod.outlook.com (2603:10b6:404:53::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sun, 19 Apr
 2020 09:40:55 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2d:cafe::4f) by BL0PR03CA0010.outlook.office365.com
 (2603:10b6:208:2d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Sun, 19 Apr 2020 09:40:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Sun, 19 Apr 2020 09:40:53
 +0000
Received: from [149.199.38.66] (port=40411 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jQ6Qg-0006Nc-Bq; Sun, 19 Apr 2020 02:39:58 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jQ6RY-0006sU-VX; Sun, 19 Apr 2020 02:40:53 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03J9eps4022515; 
 Sun, 19 Apr 2020 02:40:52 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jQ6RX-0006sM-LO; Sun, 19 Apr 2020 02:40:51 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id E6C1713C1BB6; Sun, 19 Apr 2020 15:03:51 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [QEMU][PATCH v2] chardev/char-socket: Properly make qio connections
 non blocking
Date: Sun, 19 Apr 2020 15:03:44 +0530
Message-Id: <1587288824-17846-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(39850400004)(376002)(346002)(46966005)(2906002)(4326008)(5660300002)(478600001)(82740400003)(186003)(26005)(36756003)(356005)(81166007)(426003)(2616005)(336012)(6666004)(70206006)(70586007)(47076004)(110136005)(8936002)(81156014)(8676002)(107886003)(6266002)(316002)(42186006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d0d8ab-d949-4601-1a9b-08d7e445c0ce
X-MS-TrafficTypeDiagnostic: BN6PR02MB2434:|BN6PR02MB2434:|BN6PR02MB2434:|BN6PR02MB2434:
X-Microsoft-Antispam-PRVS: <BN6PR02MB243436B2F22196CCE99AFC72CAD70@BN6PR02MB2434.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 0378F1E47A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Il7eS0KRAiyR1tZGsXFmPXZ2+L7qzLJB9kmcEW6UEtHYKnh8kZikeEz7T8mUgMJ1QNdegbnBSkfMD1+wDlFwlC4N2g9UrQZ55cM8ZsvIS09/0VOy1Xp8tkGcxbuW1uTM5DODccqMvDqCE3LE459zAmUPPNdJHxKnVN2VrLN8W4c7PAiaoINxuUOBRJeFJnOxwAUEmfhTkcYe6ij32p82Augd8l6aa4pKbTkS5GHxVqK/UN6uHupjx6LoRj79aXldoQKvwMXDbxB7NgSHcs99HWJiNKOd6O7U0ZwDBcAkpgEqoGiUPNsiw3+8Dwi1bxzuNoU460KwFBRO/4AeTyuRkvbu242RcZWE2bn6sDW+tn5DLvHURSt+XiihMuoJkuAXCrQGO5uc3AQUDaxJcs7ukltqjQZlKBUNSUsTYUaNp5I2JjPIqKkQnrwepo7M9YBVLKiAGgL20rpN5V1RbLzqNmS6zemNyWbwfhNQ+nex2szZqJlaZeoR070KtGtYd8nK4KSBqoNf0EhzsgRcefoJwQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2020 09:40:53.4743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d0d8ab-d949-4601-1a9b-08d7e445c0ce
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2434
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: xilinx.com
Received-SPF: pass client-ip=40.107.70.41; envelope-from=saipava@xilinx.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.70.41
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
disconnection during read, then tcp_chr_hup function would clean up
the qio channel pointers(i.e ioc, sioc).

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
Changes for V2:
	Simply guard the  'qio_channel_set_blocking' call to check connection status.
	This is a simple fix than v1 and explains much better about the issue.

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


