Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59F12070E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ZE/ooTqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59F12070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw753-0000hD-6X
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jw748-00087T-DG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:49:00 -0400
Received: from mail-bn8nam11on2123.outbound.protection.outlook.com
 ([40.107.236.123]:10337 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jw746-0002Vf-1m
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:48:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IX+FH6EdKYJ4AaM1vEkktZ0Hf2Y+JokBiErLxpjx7C96bkbpiHHXd9AKUO3DClYumxt/whdXKsEcwiYvmLW8J5C0MAsDzfrQfNkt8r4eEqsxxKpvvtslX+VR453gIEPgexl+/0d4O1zQz54tccAeYoP1w3u/+RslqxHAQ4yHLKNyZw0YTNg3TV456IkfKJEsu9uH2jupndgOHmt91ugxgy6ZEtm2C4bXQMJCWdXEegbzKRMSZGhusMjuHk5rw8e+mtQA3j74v1R7sF+ejDueXhr1fgPGoM3XDHHdSkQuaRlpiNbtyniwdi6sLBQ8r4EXo8pw8niOyv+B+Kqj+R4mPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JgZKmvmNEff+wbwhwknP6IKH69FSqDXhfaDkjgLG7Q=;
 b=mVzt2O9eqAL61W5m/SaFqlQG6wGcxqZ+IfNxFBFbgyxfV43sECz/Dchu6PIsVYh5JZcRfifXwQ9+zVnmLPmvnaY5phrn77xkWz/KHgHp4pbC3aw3mWmUnj+wgbsBIUCJxhnPttsqXoJ2nt/wH6RD1NrR0dj0b34vkTZHo8GY10Plies9dqD6cKSY2tZ/GyrHNmSFt2szTDzf+76e8tuN0owl+E9oq7cxj3jCtKXTdb+vCR5o/z9YZ79CIZD246EB/vWwhxCCBr9EB/4QmhXQcc2XkuTb72kIIyvDKkGIeeNsVvs4eMco7oRshjJno3bSuJbbIaqDvsWnJxnSuhuSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JgZKmvmNEff+wbwhwknP6IKH69FSqDXhfaDkjgLG7Q=;
 b=ZE/ooTqcWymxwGcBeR/iEF0U3MvBPAzSMkLqE3M/o5PBzxpK8YLcKpxUZM8DpbZmVuwK8j9TtFX9Elt9lGbPKgicwelWlB99WiH/VqDeVk78Yc6UmBDFKQ1r3IYcUBqatJTe5syVbVJz1iLYWyVdlCxuyVA1t9qszaZT+BkroEk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2207.namprd03.prod.outlook.com (2603:10b6:804:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Thu, 16 Jul
 2020 16:33:52 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 16:33:52 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] gitlab-ci.yml: Add oss-fuzz build tests
Date: Thu, 16 Jul 2020 12:33:30 -0400
Message-Id: <20200716163330.29141-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:208:134::41) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:208:134::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Thu, 16 Jul 2020 16:33:51 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d13df35c-0684-4c5a-cc23-08d829a60674
X-MS-TrafficTypeDiagnostic: SN2PR03MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB22074C30684E9E39AB1D7781BA7F0@SN2PR03MB2207.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7hQnLvFVUGgtFjpG6mO9ctumASyhK4gezEcTuUsgY7UK05Wzkk3QA8uzuHnoO6beV57+aYS+OiuILafJABlM8/42z901es5lL1ovzNspO6s71gOlZEQhrsJi5kuOJGYFY95QAd6A+IB8h8zMBGR1Lt25lc2++tvs7EJv6oe2bNbnnNPqUllzhp0yy5jZv4LnASwhP2B1asLSBpxkEK1UE2O8W7sncLXMX7mNOrQosjyordWHvqYY27KgiiX3IT8ycnz2A6+iFJIioSsNTcNYEOOyHGwIsetB5T7u1XA+3pRo5hfXfo2BGm/mdRL0JTsm7BOnT325L8v6tZnUZ0LRB7KKFS6PItas1S+lmmpY0d1CQDWuM87wmedAo5IxB9HtiLNkyNWdJQit4Xx3AQeEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(6666004)(83380400001)(26005)(36756003)(8936002)(52116002)(6486002)(75432002)(7696005)(86362001)(8676002)(5660300002)(2616005)(6916009)(1076003)(16526019)(956004)(4326008)(2906002)(786003)(186003)(478600001)(316002)(54906003)(66476007)(966005)(66556008)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: y1NI00K5PUX8QXjFSmT1AmO79v8zkgw4g8zZbjSFhKiiQ6zdwg6oO78mlGlflgtGMM4TQeJLghLWp/MCKwMqAeDtYpkww5GUjoht54Yz1wSqOZqhosQwURPhov7N97gd6qyFoMZfuNrl1vTsxvKSkRquaUkGQXvfijdLNVXXPrQHym+RpbeZfbZcDpu5JHXfTY8l/SEdsF9NijUlZrCUtC5NmpbWYMeyjdHNPtlC97t34N9Vjet9mnq7XQdPzIG0KKHFpG5H1JhJgi0G4BEJV/3caKI1xghUsm4SKbUTKFcm90V4CBzi3TQB4tuVoGOkurraWdI0L70M14DcD6WydG56HyVVRB2qplsHavLiINSJvwcib4j9Mqvfli1j7UGXmlsN63+/0z9Es0FnwHcKULXJSAocxdQOHc5fp7XbGb3irK6OG9jF6hNzvkhp2AfcVs681u0Nx7UErb5LvfU10d+ZwmEBkO63+sc4AqNwm3Y=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d13df35c-0684-4c5a-cc23-08d829a60674
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:33:52.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhaIEDKS0tTBbg05ee7rHP970ZyjjhjwlrlBXZoTmIszG6U4VULAbjcZfZ3e2PJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2207
Received-SPF: pass client-ip=40.107.236.123; envelope-from=alxndr@bu.edu;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 12:48:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, darren.kenny@oracle.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tries to build and run the fuzzers with the same build-script used
by oss-fuzz. This doesn't guarantee that the builds on oss-fuzz will
also succeed, since oss-fuzz provides its own compiler and fuzzer vars,
but it can catch changes that are not compatible with the the
./scripts/oss-fuzz/build.sh script.
The strange way of finding fuzzer binaries stems from the method used by
oss-fuzz:
https://github.com/google/oss-fuzz/blob/master/infra/base-images/base-runner/targets_list

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---

Similar to Thomas' patch:

> Note: This patch needs two other patches merged first to work correctly:

> - 'fuzz: Expect the cmdline in a freeable GString' from Alexander

> - 'qom: Plug memory leak in "info qom-tree"' from Markus

Otherwise the test will fail due to detected memory leaks.

Fair warning: I haven't been able to trigger this new job yet. I tried
to run the pipeline with these changes on my forked repo on gitlab, but
did not reach the build-oss-fuzz. I think this is due to some failures
in the Containers-layer-2 stage:

...
Error response from daemon: manifest for
registry.gitlab.com/a1xndr/qemu/qemu/debian-all-test-cross:latest not
found: manifest unknown: manifest unknown
#2 [internal] load .dockerignore
#2 transferring context:
#2 transferring context: 2B 0.1s done
#2 DONE 0.1s
#1 [internal] load build definition from tmpg8j4xoop.docker
#1 transferring dockerfile: 2.21kB 0.1s done
#1 DONE 0.2s
#3 [internal] load metadata for docker.io/qemu/debian10:latest
#3 ERROR: pull access denied, repository does not exist or may require
authorization: server message: insufficient_scope: authorization failed
#4 [1/3] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require
authorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/3] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed
to load cache key: pull access denied, repository does not exist or may
require authorization: server message: insufficient_scope: authorization
failed
...

 .gitlab-ci.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e96f8794b9..a50df420c9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -182,6 +182,20 @@ build-fuzzer:
             || exit 1 ;
       done
 
+build-oss-fuzz:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: fedora
+  script:
+    - OUT_DIR="./build" CC=clang-9 CXX=clang++-9 CFLAGS="-fsanitize=address"
+      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" CFL
+      ./scripts/oss-fuzz/build.sh
+    - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f); do
+        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
+        echo Testing ${fuzzer} ... ;
+        "${fuzzer}" -runs=1000 || exit 1 ;
+      done
+
 build-tci:
   <<: *native_build_job_definition
   variables:
-- 
2.26.2


