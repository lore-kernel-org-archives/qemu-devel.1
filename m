Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19910C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B50206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="S60Fuyug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B50206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspjr-0002LS-4n
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1jspj6-0001ub-7t
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:41:44 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com
 ([40.107.92.131]:39584 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1jspj4-0001bR-3t
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:41:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rne0PJe3JovzYQ68jp+64vpkn57Vej7fMvFhXD+PIeMBaEvh29c5gwopVlR+/vBfBEgZEY/FTvHUTpNJIY6tCTvamK0vzPutlsdgTRwElJnitc0QqybZrw2g3I9QFlYkHJE/SkQCqaztXfD8O3DNNIcKPibTzYs9EWl0AqrB+pgC7Yc0Vokxxos60eXVDoKSfcdF/7HDSl3qqtZaVcItA/ze5e5OQGG2owCv/u0QHmJQ1YgyZtlEFku7rsSQo3h7+b4F/Td1pwTZLMTuircP8/yiB+7kilTkN3ES6Br4GGTeromSTgjp0iTNK2A4ARC0piX1fFGQF+ME3RNyJGa5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPIDLzlmtOMC8OIHYkFs+dw4pLNtmVjjucHaWPhtQr8=;
 b=hEh4Vrg0cAKGkiou4mBjiZAMBucfrYt2XHDeam/5PpPydny8N/1RJsThqRPyu4WJYEz7gWJrm4BYkrWU3cobJ1RMzAUtJPMM2yTxWCKqqVdxVq/FWnbNMr0Gv5Wt1WH7FD/DoU/Z/8qM/IWsHkRUL/9ymA7ybITdwzbgNQVJsAhVaOqETT5/UwIlLD7ORtAuFFvqEbpIBIvdJw7h5g16i/BkpQlN6z3+qtCDJsohFQsvD3tCtxtkzTnatmXNwftrGvdhhgICXhDm6uNq7MhA7b7+AS2WwbgJ03y/Uc2ZiJxpyM+mZtZ59RMu9DCQa6YZr7cAdj1cuPM9IqfAc6XDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPIDLzlmtOMC8OIHYkFs+dw4pLNtmVjjucHaWPhtQr8=;
 b=S60Fuyug5zvH+57GTewV0KVNvK43D47P8nLOWVRH1RlXXpoKBKP/x26w+BIm4PciwUQMi4vXwi0vr6nBoq3J3RERrzNOQMWPvFca7+MBJKpka1OjleFtyLuFA5XwnfUo9C9vUF5R0SlGO4cNl5fql6SlBLemxc1oFd03TSM5308=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from SN6PR01MB4304.prod.exchangelabs.com (2603:10b6:805:a6::23) by
 SN6PR01MB3823.prod.exchangelabs.com (2603:10b6:805:19::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.28; Tue, 7 Jul 2020 15:26:36 +0000
Received: from SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::3daa:94bb:9223:161f]) by SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::3daa:94bb:9223:161f%5]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 15:26:36 +0000
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH] target/arm: Don't do raw writes for PMINTENCLR
Date: Tue,  7 Jul 2020 11:26:16 -0400
Message-Id: <20200707152616.1917154-1-aaron@os.amperecomputing.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:910:16::31) To SN6PR01MB4304.prod.exchangelabs.com
 (2603:10b6:805:a6::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from strawberry.amperecomputing.com (68.73.113.219) by
 CY4PR1201CA0021.namprd12.prod.outlook.com (2603:10b6:910:16::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Tue, 7 Jul 2020 15:26:35 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.73.113.219]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d97f1ce-1080-486f-8057-08d8228a22b5
X-MS-TrafficTypeDiagnostic: SN6PR01MB3823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR01MB38230AD340B058443987F2D28A660@SN6PR01MB3823.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGIZeyqNH8HqPPe1CNsCabgVC5YoKra2/JYOkAcAiA/BGzIlxstrAcCwWuRuKgqpMfWULC8KICZ4AzvrB45K5Up2M61okZCl1vFGQ4zbsk6+VlCV/5L/YvmBvPflc1GuyFjTIUO7pyXoLx0/irSoDlY2tDtbIPDbh6WZOzhO/R8hLcQDx4GJpE2UgSD6i9775FBuQB9phS8TY0VxAdQtzjtP5xT0K1v6NsBdhKB0Eq3w2M/sOw3BYdY737z5b2xdrjKsm3M3Kr7YfhLt9a6MgkotjdxygsjMDI+gWIe6U8IGmkyIB6cdSrEYAnXXhdfO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR01MB4304.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(396003)(136003)(376002)(346002)(6916009)(4326008)(2906002)(52116002)(186003)(107886003)(16526019)(26005)(66946007)(6512007)(83380400001)(8676002)(66556008)(8936002)(1076003)(66476007)(478600001)(5660300002)(6506007)(86362001)(956004)(2616005)(6486002)(6666004)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wmST5L2bwO5rI50dZUsKHS1jjmW4XsICVU5W8ANZy0NOftCt2HmLZWQNpXa4aOL99/ZUTIu5KrasPwjubTrxCpqHq2oA1HrYwmZbyk3RC5rq0G++w0m7Jk65Wq7kAUCy4FGznwNC60Kxwzes/cjL/tIrvQ3ra2zkfr7oo0WWQyMJiodZu10eYfnUw7Tsi+DN4ixG30nXNRqC7cuHR+f7qImyRTNp0SdjOAF/jslWQRSA/5RJ3ibTigf87lOj3F5W/V3kvfH9uQoXze2VHZGfMAtW9XnPxlJzOKsP5EmLF4rnvgihOVk7lvGOtvCgkUYYDOW0wxbMp1UL57dnSy7LSmH2kFuZLm+ir1Nx2pytdOFfkuBSnGHX6QAkv4UaTGnSQ+W+UluVY01xxBClJMLVeRsBuBLZVUkl+M/s0mibHs0fbZaYdq/2vs1NXSXWdbdFdYAQHsTv2DvglrSBCsLHB8KWws6wXWM7tRTgJi1//yM=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d97f1ce-1080-486f-8057-08d8228a22b5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4304.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 15:26:35.8815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ya/N2xodcBUYHXPgsgKMqrLjiJg1A+Ko0GZhLrWEOJgoF8iAPMSQzEggUgIXzI8PgmgZo4v1VJNHgYIcRSFYUOGowiK6tMB23vIfNUS6dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB3823
Received-SPF: pass client-ip=40.107.92.131;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 11:41:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Raw writes to this register when in KVM mode can cause interrupts to be
raised (even when the PMU is disabled). Because the underlying state is
already aliased to PMINTENSET (which already provides raw write
functions), we can safely disable raw accesses to PMINTENCLR entirely.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc9c29f998..c69a2baf1d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2269,13 +2269,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .resetvalue = 0x0 },
     { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
-      .type = ARM_CP_ALIAS | ARM_CP_IO,
+      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
       .writefn = pmintenclr_write, },
     { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
-      .type = ARM_CP_ALIAS | ARM_CP_IO,
+      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
       .writefn = pmintenclr_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
-- 
2.17.1


