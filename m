Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34441C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15492073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ssFX0rSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15492073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnWI-0003XC-1t
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSa-0006Le-Px
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSa-0007Rk-35
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:48 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:57857 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSR-0006mI-IU; Tue, 21 Apr 2020 03:36:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAo1AWj2bosC8BE00iMGXyXwaXCxRpwEp2dcuUtSLX1jgvxnb4xgbbYD3Lm/OExcP4KfYZZEd6Cz1lpavUkhQ9iV5ngvrUCH7QsqNgG4DOMKBuIFzVuZiexmFw/Xb1c/OXA+EKCD7eSCgwuSJ+zUINbvJZZhURJv7Q/5C+kaFJE1Ekl8nAPKUBgsl9vgwjNz5I27hyRgWkpDSFTvYWdmAkoldm0PzvQvyE/frKOBI6NyOwjGIrAPK3BKf5dJTujCRif/WYTkypN7TAbX3HiHztGrJF3piXALIdblvvMPwoij1JQifP2IOq7zzXZXxVhf0nbFthwbdx+7aXJtYpY1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhqoLgLntbFdPl2tDNcEP6HSUAVCetnUY636mQj5qD4=;
 b=CJAUhv+PVpRrafekzXomc4JlOJ2hLh3OvdbZ+vvw2SMntvDYPua2WYjp/RFmPj4EIcKP3zbZDUECnT54/ZKVjutfjxSq/FL9XebAf3EjtLkiuiGe/pcr8esW+gByMvfI8rCtr58Sw7n/2Z5O3jW/raJM2e5MR7HyBuhgZ4aDsk7Fyl9PdSQuTyyIiA3RfmCVPAIM07FOLqAjnTFdcvISy6Zijqeo21QqpEqiovBkZ9BGM9Jl4QDajGXYZjQDhgtbiaUN5qBsCFF1afBo7zXHGmA7OQvGcb7YTZeE6fVYXu5flt46qRnfPzBAZqxMpkIcNYPF7FLmx0VWkSMEg+uYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhqoLgLntbFdPl2tDNcEP6HSUAVCetnUY636mQj5qD4=;
 b=ssFX0rSrlG9PKz7fEQit2By7nXkuMBiwDYKdWO/XWpYsdimmPlxg8X33DV+OgWab1/cC31fr0Q/x6HHg7DLjjVfUl+erWTzXifNIoQm2tGZMpFpyyOvmC/86WD3sSe0WejgXh4Yx1nHaJ4AJ34f/k1HfB81FOZXoe7Kf8Yqv6dQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 04/10] iotests/check: move QEMU_VXHS_PROG to common.rc
Date: Tue, 21 Apr 2020 10:35:55 +0300
Message-Id: <20200421073601.28710-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200421073601.28710-1-vsementsov@virtuozzo.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.142) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1821e25-30fa-4c8c-b37b-08d7e5c6b877
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5397C1BBD27DC4AED4B439B7C1D50@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(376002)(39840400004)(136003)(366004)(36756003)(1076003)(6916009)(5660300002)(6666004)(6512007)(186003)(4326008)(316002)(2616005)(956004)(16526019)(69590400007)(66556008)(66476007)(66946007)(26005)(2906002)(8936002)(8676002)(81156014)(6506007)(6486002)(478600001)(86362001)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DywKfYRd3YnGdxtW07Z7q9Y65edsWiwypAceXpcpl6PQU3wVGVi7obQX/v2JMykycH8NIzES/2vlWe+MJofi+DPXJZi0skYz1hdYHQou9x8jgbl0WHbu5JKfB/l4k0u8E//c7LtxLYNfVQgb6YIa7po2+LUPxdghSLmC2iPCql0XyOKlJGz4pJNtmSDWp02UoTa/+cRSXE2lZp8jJZoUiwkkRdaTRSlFmKnWoshXCdASsRgdRNXJDz1AxuAX+DwVvngN3wJYpERunhzMwTT6Al51XWxJMdfhzDl1sg0F68KXKQOtsqg1mAiaAmiwUfM1XEKtS0x2I7rZgzCZoQZmZYHDSe9Rld5NdmdAEu9NBMP1WS5NgAnSG1e7C+9yZv8kT1pMc045+xflmiLScdPUtM5DfELtnAliZC0D4f1KMO3s1kfZl3DPXaqM5rLnbitTxZdwEEYeR+VR9YRHU/sL8dfpt4jsahYgGkHA6HjKc9byQZ5ZoELvveL4oz2+EBz4
X-MS-Exchange-AntiSpam-MessageData: /niYW65sC/4DK0yJ1PVZQVqG845LrWk9dJFff2H0Rn4Vlvj8eMl3YL5iWFLFKxkJVgk7dj7QY3fRMveHhT3HRQSQ/FAyjW3rMG20GFMYBr5jSO4gsxoMg8wbrvWI/gwBff0Jb2IVETNEidpsV4IwLw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1821e25-30fa-4c8c-b37b-08d7e5c6b877
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:35.9393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKsaLYsNats96tuklv+KeJutbNTIib06jwsuWzFZGxVuJCd+wQPADcc1OyjeH+pjUwcCi2+U6jq2MWCKrAr7A16kQq2f0nROq2xYhNOxOBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.93
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU_VXHS_PROG is used only in common.rc. So, move it to common.rc,
simplifying a bit further conversion of check into python

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/check     | 15 ---------------
 tests/qemu-iotests/common.rc | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f7a2d3d6c3..03016e1e91 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -103,17 +103,6 @@ SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
 EOF
 }
 
-# $1 = prog to look for
-set_prog_path()
-{
-    p=$(command -v $1 2> /dev/null)
-    if [ -n "$p" -a -x "$p" ]; then
-        type -p "$p"
-    else
-        return 1
-    fi
-}
-
 if [ -z "$TEST_DIR" ]; then
         TEST_DIR=$PWD/scratch
 fi
@@ -643,10 +632,6 @@ if [ -z $QEMU_NBD_PROG ]; then
 fi
 export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
 
-if [ -z "$QEMU_VXHS_PROG" ]; then
-    export QEMU_VXHS_PROG="$(set_prog_path qnio_server)"
-fi
-
 if [ -x "$build_iotests/socket_scm_helper" ]
 then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index bf3b9fdea0..aaab17c718 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -109,6 +109,16 @@ peek_file_raw()
     dd if="$1" bs=1 skip="$2" count="$3" status=none
 }
 
+# $1 = prog to look for
+set_prog_path()
+{
+    p=$(command -v $1 2> /dev/null)
+    if [ -n "$p" -a -x "$p" ]; then
+        type -p "$p"
+    else
+        return 1
+    fi
+}
 
 if ! . ./common.config
     then
@@ -116,6 +126,10 @@ if ! . ./common.config
     exit 1
 fi
 
+if [ -z "$QEMU_VXHS_PROG" ]; then
+    QEMU_VXHS_PROG="$(set_prog_path qnio_server)"
+fi
+
 # Set the variables to the empty string to turn Valgrind off
 # for specific processes, e.g.
 # $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015
-- 
2.21.0


