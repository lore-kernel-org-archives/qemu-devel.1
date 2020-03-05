Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D9AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49609207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="QA28sQsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49609207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9x3P-0005sD-Gw
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 15:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tobias.koch@nonterra.com>) id 1j9x2f-0005Rx-Kh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tobias.koch@nonterra.com>) id 1j9x2e-00082D-FY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:24:25 -0500
Received: from mail-db8eur05on2048.outbound.protection.outlook.com
 ([40.107.20.48]:6099 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tobias.koch@nonterra.com>)
 id 1j9x2e-0007vA-3r
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:24:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVkoBH7b7ARGRVa8K31O5YLNuQdDephFL0GDeKDi3c8tQc3AsWRTyYjCdcXnhEtVq2p4bTNhCP05MKNaFo7QRUK2q0+TjiqB0e737e8mLRWgVWEBxtHWqxNRABRUjwRGfPPbZrpe73HUMyiLclaRGsWfU4qbX/1v6P17OhXGU8gj0fUNyilbIcGHY2MwKyyoCjO9pC+zTckhDr/kYmyi5Z2v+o9DAT2tY+Yimzc3e73XcYDzrFxql3Ee+RJMGL1NKfT0kdS6C1zcLxPXT5P97FdNMMAYb83eM3iHXMA+XknRI8N5ps562lVyko0t7ARZYaTjK9+V50H8w/FFWOkPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCPLk3+MHLS7s6/voCDvCwEloF7cTxVnnCwfhx/zzTY=;
 b=kf2JbMH0OzXL5SvxyZ3MFIFXucN5KqKqO4LHmNbmyzB4//sOy7FQy1+NLR4+51l8aYs/N6BOGc4oGK/Dd0zbZ+Thjv2BzD0c77dZnDAO+LP9y6VDEYJcjks+DHKSD25+VckaTbFheSHWs1byGfKIbkTyRygq2P9Fntg83S5Ez7YfgfbFrFdrjpbnvS2L4UWfYmzb5Qkw++st+1Zk3Vw8JnA84xbIUanO7FTqcTBFiPZfYVH5mPtVCDbQGEw5R58Ud7XPGOwC/WcjKuvlCXEISs/3Yd+mOqybjTe+DitT7fKjocGVQKX5hI13Zmqzpy45oAlcvEmWjRIXeG0nc89SFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCPLk3+MHLS7s6/voCDvCwEloF7cTxVnnCwfhx/zzTY=;
 b=QA28sQsD9DpsGk0YZlheZ3TI9m7hBR6C0pifXrqtQPGb8eVmZFG0ogWooBamk3momg7n1WkoaHOt1A4aYaeWQhu3UWN6WiH4DJdhO3KPBcppDUq1MEty9S8lwqa5aMq8NSPK296WyzNiWHosFcHda6P8mWf5KaJTn8YZODwkWKU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tobias.koch@nonterra.com; 
Received: from AM0PR08MB4273.eurprd08.prod.outlook.com (20.179.35.80) by
 AM0PR08MB3266.eurprd08.prod.outlook.com (52.134.126.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Thu, 5 Mar 2020 20:24:21 +0000
Received: from AM0PR08MB4273.eurprd08.prod.outlook.com
 ([fe80::7163:372d:fd4c:812a]) by AM0PR08MB4273.eurprd08.prod.outlook.com
 ([fe80::7163:372d:fd4c:812a%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 20:24:21 +0000
From: Tobias Koch <tobias.koch@nonterra.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: do prlimit selectively
Date: Thu,  5 Mar 2020 21:24:00 +0100
Message-ID: <20200305202400.27574-1-tobias.koch@nonterra.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::28) To AM0PR08MB4273.eurprd08.prod.outlook.com
 (2603:10a6:208:144::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from build.nonterra.com (46.4.103.172) by
 AM0PR01CA0123.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 20:24:20 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [46.4.103.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73700134-baa9-4024-426b-08d7c1433005
X-MS-TrafficTypeDiagnostic: AM0PR08MB3266:
X-Microsoft-Antispam-PRVS: <AM0PR08MB326621794111B41D20046BD089E20@AM0PR08MB3266.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39830400003)(376002)(346002)(136003)(199004)(189003)(81166006)(52116002)(8676002)(4744005)(1076003)(66946007)(81156014)(86362001)(2906002)(4326008)(66556008)(66476007)(6916009)(8936002)(508600001)(5660300002)(7696005)(16526019)(55236004)(316002)(36756003)(26005)(6666004)(6486002)(186003)(956004)(2616005)(44832011)(41780200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR08MB3266;
 H:AM0PR08MB4273.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nonterra.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3mVDRF17XetqBkp+ZHntqnioDIyLO/+Nv0HxrHvfaDtWB73b5/Bv4kZ/4K9E/faMSSt7ALpitw/kxFclD1hOba09ixh1AOfsWavVna476KYoOCH/CG5rK+ScHqRqYGhfSsvLjohrIFVRGU0GzyYi24SakJQ9ufkkHL/5qxXT5CgmiEnxcyI+mLkVEXIW0qeCMHtgLxMpyDdV3XPDkQvGOKLZW0XTVgF07Jbwmz5JhEeHuG2XoHD0aJayWKr/UOVGY0LebSshYNKzF0lt2Qa22p5NUJ70RSQAK+8YnvV0VgeA7/F05V6YxTryEwrkMHIHD8rCZ+C7V0BHnSz0Q+RIwE431JZ/ZnbhI3SEyQqVYoM/z+aLIku7sMw6jE9zPfPXDihVRsbyD0x7Uzc2RrzsWp+5fbT4dKmvdf+z0k9K3tBNKWCQjHuf9B1P6wgqCnAz0uJqdUBnMSO7G82H04pLLcVSrLVY/dPrZXbehkVUhpxIykNoxyx5qoXmBf8k5l9
X-MS-Exchange-AntiSpam-MessageData: pwB1v6L1b73si9p7cbQKp56+OCdmRRmuHAaBRmIv5iLYk4LR/9aCKeMJeYP6D3tG4t2tHNsteGnf6cxEln3IyKdf7e62KQh6Q0TfIllmFdISMpCitz/4mFL85mekyqUCOkJdbWsXetTqTPf6zXjZSA==
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73700134-baa9-4024-426b-08d7c1433005
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 20:24:21.5951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vBWfyQX5FEPtUThPqppwfCtFp2D7voR31yCNXlNjAPqC5NDca4pynb//9KYM5i6c/GuTSzoP29yRZsD0S84gpnYH6iW3D7WS40ITKkl0bY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3266
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.48
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Analogous to what commit 5dfa88f7 did for setrlimit, this commit
selectively ignores limits for memory-related resources in prlimit64
calls. This is to prevent too restrictive limits from causing QEMU
itself to malfunction.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
---
 linux-user/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d10807..4f2f9eb12b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11871,7 +11871,10 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
         struct target_rlimit64 *target_rnew, *target_rold;
         struct host_rlimit64 rnew, rold, *rnewp =3D 0;
         int resource =3D target_to_host_resource(arg2);
-        if (arg3) {
+
+        if (arg3 && (resource !=3D RLIMIT_AS &&
+                     resource !=3D RLIMIT_DATA &&
+                     resource !=3D RLIMIT_STACK)) {
             if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
                 return -TARGET_EFAULT;
             }
--=20
2.20.1


