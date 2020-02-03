Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C2C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E682920721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E682920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyc2O-0007Rj-5M
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1iyc1g-00069L-Ik
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LYan@suse.com>) id 1iyc1f-0004x8-IG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:44:32 -0500
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:59448)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <LYan@suse.com>)
 id 1iyc1Y-0004sd-J2; Mon, 03 Feb 2020 08:44:24 -0500
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY
 m4a0072g.houston.softwaregrp.com WITH ESMTP; 
 Mon,  3 Feb 2020 13:42:55 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 3 Feb 2020 13:43:05 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 3 Feb 2020 13:43:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeLGZH65Fq+FDv+nSilVSzaaaOaPmuWR6HNMyx2fE2oLapvIJD2kGOf7Cfu4vzW9E/S7yXfhCc+6n1zgng7h3oJAXC1zMrquBi7KvqmrZSYum+oAlhQEQBtM82Jka+5xXPEdr15kSqJzfI2QugyKoIcDG5PX+3gni6nSKDezYYxxTMycpglDFpHSjcP6JAlcrIcI6Eh2Tz3qCpc+AT6oEucpz0n+R36Iyj9Zxh8fROtTOUGpcFYcO5zeYNJz+PVwglHw1HTvsID/2JDWRlNGRtEc38M1ouiIVT7DrrLiNyA37sDqktwhFCzi/QZbxhcJur7M+OLbsqVwN4o96FjEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKeA6PrE6qdosN8awR6fawlD7jpcvjHWgfjOzOZJdr8=;
 b=U8jLNTCuu1BCdRpUFISRPOfIqd4jr1b630LSfwKXxd5IREGgbIf1BOSv3wjvocpjqk9KTFHOrEouLcTnTHhwffIv9LOUhMVxOyAJnXmKjJasiXKJC3IrrRaZzJ8bgsPC40DOAJfDojnt8MXEJ0luOJBL57/fGVsSUWt0Dd9/pDHbdP6j0Ls5qHEPh250knsZRky3TD4jqa7d9Ob9MMeD4EN8TWnz8FxuWIi4UQwzKAKzA6o/or+7hGOCFxssJweBmMsY5TCORAp/Oa7ogGJv5sv6GHZhE9JXgPu0q5RU0rtzCCfYWhkCb7kbsbMmZig9tF8dbvOmxk3OsH5oilnNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=LYan@suse.com; 
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2983.namprd18.prod.outlook.com (20.179.58.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 13:43:03 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::70c4:1802:725e:e829%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 13:43:03 +0000
From: Liang Yan <lyan@suse.com>
To: <peter.maydell@linaro.org>, <drjones@redhat.com>, <qemu-arm@nongnu.org>
Subject: [PATCH v4] target/arm/monitor: query-cpu-model-expansion crashed qemu
 when using machine type none
Date: Mon, 3 Feb 2020 08:42:51 -0500
Message-ID: <20200203134251.12986-1-lyan@suse.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0036.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::49) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
MIME-Version: 1.0
Received: from leonstudio.lan (2605:a000:160e:228::5ca) by
 MN2PR15CA0036.namprd15.prod.outlook.com (2603:10b6:208:1b4::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend
 Transport; Mon, 3 Feb 2020 13:43:02 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [2605:a000:160e:228::5ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e369d23-7325-485b-3c41-08d7a8aefe07
X-MS-TrafficTypeDiagnostic: BYAPR18MB2983:
X-Microsoft-Antispam-PRVS: <BYAPR18MB29836F51F8F2D2FD970F4E14BF000@BYAPR18MB2983.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(189003)(6486002)(52116002)(6512007)(2616005)(316002)(478600001)(1076003)(36756003)(8936002)(8886007)(8676002)(81166006)(81156014)(6506007)(86362001)(6666004)(66556008)(66476007)(16526019)(5660300002)(186003)(4326008)(66946007)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR18MB2983;
 H:BYAPR18MB2888.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/GaQA8WiTyqQhDDk3mA3FbXHQLIoFqzmVXacjpDQMoyiwTq6Dy8C0wKfveEFOdyoxIBxNydFqBl4uPdnIDcxFVvLfRribz6LFRCMDdzKEjKyzUrRWnpDOmRsZr0m4GYufK+cP3l5LtWQQ+grihEXbmI/6NbkQxbw9izUrSDkKd4ctkZRQwns8SBwWGbxdF51BBT8lZ/Y7gagrUMXlIgjj36qZ/gDpIpfYB5qC89QwPnxggEWgreL2CMkuARHdNHRZ6GQkmyNnXN9ZAWl7ZEsm746uL6AuPHlgj9bGO+hhvKsi7rtKugpiWh7cIUJZlYHWkDQEf1a2rJVKjrNtA+ySGeStIGd+hs2tnY1q9xQ93/JTWZVPlSsuaG1uZ/fIqfEcFNIWbDscoSs0dF/XqJNH297LWKOijQQJUP5zNUZa6TDDc7UH2VIN2UkjUlOfUi
X-MS-Exchange-AntiSpam-MessageData: /IlYZ3fdPnWb5wVNw7LRbd6bjmehu23e+cFwHUVAz7zpOkcPyfEsQKbJTaTC4kYPY5k6aTIXRidMmQ+noAMNDV80cGWyb1q19zHwcd+XPEdaSUV00Uq7ZJ3ixJMQKllDlNotivQxmZCrQDUzmQILwLYZpBpo3UXxLO4gKmvFF2g=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e369d23-7325-485b-3c41-08d7a8aefe07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 13:43:03.7526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atWIldCYMQM0pooAC1p8PaKjqxIecaSL4gaL4IeEqtcSBxngF71wf9X3WJp7eGdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2983
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.2.130
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e19afd566781 mentioned that target-arm only supports queryable
cpu models 'max', 'host', and the current type when KVM is in use.
The logic works well until using machine type none.

For machine type none, cpu_type will be null if cpu option is not
set by command line, strlen(cpu_type) will terminate process.
So We add a check above it.

This won't affect i386 and s390x since they do not use current_cpu.

Signed-off-by: Liang Yan <lyan@suse.com>
---
 v4: change code style based on the review from Andrew Jones
 v3: change git commit message
 v2: fix code style issue
---
 target/arm/monitor.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 9725dfff16..c2dc7908de 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -137,17 +137,20 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
     }
=20
     if (kvm_enabled()) {
-        const char *cpu_type =3D current_machine->cpu_type;
-        int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
         bool supported =3D false;
=20
         if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
             /* These are kvmarm's recommended cpu types */
             supported =3D true;
-        } else if (strlen(model->name) =3D=3D len &&
-                   !strncmp(model->name, cpu_type, len)) {
-            /* KVM is enabled and we're using this type, so it works. */
-            supported =3D true;
+        } else if (current_machine->cpu_type) {
+            const char *cpu_type =3D current_machine->cpu_type;
+            int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
+
+            if (strlen(model->name) =3D=3D len &&
+                !strncmp(model->name, cpu_type, len)) {
+                /* KVM is enabled and we're using this type, so it works. =
*/
+                supported =3D true;
+            }
         }
         if (!supported) {
             error_setg(errp, "We cannot guarantee the CPU type '%s' works =
"
--=20
2.25.0


