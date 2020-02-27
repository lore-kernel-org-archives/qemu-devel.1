Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD7C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1391520801
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="LvPTWZb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1391520801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79eW-0006Kp-6e
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 22:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j79dZ-0004xx-OE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j79dY-0002uY-L0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:57 -0500
Received: from mail-bn7nam10on2112.outbound.protection.outlook.com
 ([40.107.92.112]:31328 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j79dY-0002rw-Gp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:14:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krPhgQpz0iGARP2GVU4KOc9Ubc1iPYNmXCRUH3RTyTkUXv1ncVU+wfOvyXLknpwgWN5S0dHMeSTREp/s6xqfsDW2rYAFxjQPvtgXQv65W/D1qQ5v+aabw7nnai1fX9phkCZoKJFdjwm2GsaIZlXJYID4URWsBr3O1rKuS2Uwh30H/7SW8V0VGk1ApERMHNZEVzez+wcoOHHRPrPfFsgL2jzjiJtvNG5rlS7bNO1IAnSRJRbjm50qrXlW1vEhXnw6R6rCNFqBAxbjWbIPWblTH0QeeRLRAVut4isbHNw8m17PlofClILWUWfZ+09psxj4F04wL7Rm5lLCaaAkBSEGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxzNN2xXvG2FQf9mW+UxiAeVO/Axf4ad+0W3USzwUpI=;
 b=gln6OjUUjI1zQ3A+vl6F1MN82bZsXXDFe3WSL87r7sFevdcxd/7pWujy0Itp1on/e8u+VdUpx7wuX9fAbdrDNITxLuOrHryQ9iZq/mtRgMTBU3yl6Sai8OHjDTekHrqr9cV7234VMg/w69MVPYUapNY69A/e+cUh82dVpVmVDTJQ2zwQdgetjXqFxHzFMw8XfB9T/b0Z5ctkAQF/MyUnBAvJI6Q5de+Po5o0HWWNi3h6+8sX5YHnUGJy8Gldx1k0LV2D7Mzp/Vy3U+HyC/2beKKt3mvEhH1hq3iDZm4s5YbF3s7Wh7sL/wR9WR7+qgEZKxeQoSbhCpoJyBYSRq7aZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxzNN2xXvG2FQf9mW+UxiAeVO/Axf4ad+0W3USzwUpI=;
 b=LvPTWZb5e/imy7wUre2F66WlGP0ZFKSql3tMhNs8NcgqAGJSMpc8uYZWa4mbUInZBIio17hktfWJ4PzD8W5vLxuLV37319xxtZbTrzDV7SwV6Fi5HdrPYIOC3dvoYZ4snSOwXNbSZBum/C2EUUBR8rzy7DMmTjdxsAWrkebqFAc=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3582.namprd03.prod.outlook.com (2603:10b6:805:41::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 03:14:55 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 03:14:55 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] fuzz: fix style/typos in linker-script comments
Date: Wed, 26 Feb 2020 22:14:38 -0500
Message-ID: <20200227031439.31386-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227031439.31386-1-alxndr@bu.edu>
References: <20200227031439.31386-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:2d::33) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 03:14:54 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63eddf82-7190-403a-0fd2-08d7bb3337c6
X-MS-TrafficTypeDiagnostic: SN6PR03MB3582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35823336726DFAB4F6C5A97BBAEB0@SN6PR03MB3582.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(52116002)(7696005)(8936002)(86362001)(6486002)(6666004)(66556008)(478600001)(4326008)(66946007)(36756003)(66476007)(81166006)(81156014)(6916009)(2906002)(8676002)(786003)(316002)(956004)(2616005)(5660300002)(16526019)(1076003)(54906003)(26005)(186003)(75432002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3582;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLs28qoiZuXp8KBzInO3lWfCETjRI0chGcL0Oq0SVMGb3rzS0ai0wmPV5AMaJhXpcsjoVe9qManSJ1Mbt3SnkOVAhHglNqE37mohh/z1ioDC3D0iL8H8YZhFrpLamzi28LNLLpDlixc0ZJwlhoCyI6Vcy648IooN/aLugynwlncBbBqUVvokg2r6fSAFYYw+j/AsheBijhYhDtmWF4cyXWIv5E09NPVm3glm0/3GPYWG8fgDNC4exSelqqSOFaMHj2+V7/ILpRfq1lPs8BB9YysiDh2hHlMci4+hbSx9Tw6EDM/C6hl2CfbN/0b3MwyTLI+o5bhTcJ07i7IbMTCMgAqj0St54AtLZWNZzyHbuNxh40coRXjhNDH5+ae8O/vU5obXOZeROpVUmCC4bvRhaR6/iMTtuqJeiRIQGltfbrunXSJ9DGR4Vj0D5BV1cz6b
X-MS-Exchange-AntiSpam-MessageData: 1/rEoc6NslU5LzqKWhg3NW5LLgxFCLGYBU1wahgV8Or4mDlvE0V/ltpK4jtqHNjpD5c6r8u18VK9z5XBqMFp9gJS2EJ7FwdA0upg6MuA13u47bPAO89xcsP+QBZ0vWzen3Xb5OlKmSnrahfxfzaSvg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eddf82-7190-403a-0fd2-08d7bb3337c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 03:14:55.1346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uWtNMXZv+h5EkUe+ZRj3gFvYMKSZaIq5hBDU3s3TkyXhtKitZN7j/zXBeN3xyN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3582
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.112
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qtest/fuzz/fork_fuzz.ld | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
index b23a59f194..e086bba873 100644
--- a/tests/qtest/fuzz/fork_fuzz.ld
+++ b/tests/qtest/fuzz/fork_fuzz.ld
@@ -1,7 +1,8 @@
-/* We adjust linker script modification to place all of the stuff that nee=
ds to
- * persist across fuzzing runs into a contiguous seciton of memory. Then, =
it is
+/*
+ * We adjust linker script modification to place all of the stuff that nee=
ds to
+ * persist across fuzzing runs into a contiguous section of memory. Then, =
it is
  * easy to re-map the counter-related memory as shared.
-*/
+ */
=20
 SECTIONS
 {
@@ -17,7 +18,8 @@ SECTIONS
   }
   .data.fuzz_ordered :
   {
-      /* Coverage counters. They're not necessary for fuzzing, but are use=
ful
+      /*
+       * Coverage counters. They're not necessary for fuzzing, but are use=
ful
        * for analyzing the fuzzing performance
        */
       __start___llvm_prf_cnts =3D .;
@@ -32,6 +34,8 @@ SECTIONS
       __FUZZ_COUNTERS_END =3D .;
   }
 }
-/* Dont overwrite the SECTIONS in the default linker script. Instead inser=
t the
- * above into the default script */
+/*
+ * Don't overwrite the SECTIONS in the default linker script. Instead inse=
rt the
+ * above into the default script
+ */
 INSERT AFTER .data;
--=20
2.25.0


