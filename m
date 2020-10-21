Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A185C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2D82224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Rz/VEsZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2D82224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFow-0006dh-7s
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaT-0006KC-HJ; Wed, 21 Oct 2020 10:59:37 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaP-00085a-Vz; Wed, 21 Oct 2020 10:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH1Ah0DQgkY54V8axLt46CzxrHJzNtmKlurp/csRr7n4fl3eZhG60GfEVMQJPilAlCY7wI4gXPfa68lRSRQBhHZ51w5KfoCKgtc7Po2kNBSOkCmL/RDE0AgC/OO5qDn3xQWhSh6quhiMJHYiID07CvZDwMxdGpDEloeiBr9ZDP7G7MixZZOJNjbU9qhCPawWNRyzg4QEh2AH7J+nXz5n08bXpjTBuHN/0Xlf13r9z6K3B/YligqX4NkJkAkt/qOQrytMzsUR3EqFm9tGkVjBIdOaJ2BAzyxK1RCHCOAuNiGTwgLTLXnNdJe6ucwPtZZWlPfdqJLSOnTBNwWolDRZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR0ONDRoF+5EK3YWXkG8xZVzxx8Bn9qVxrPG41lbUIo=;
 b=SdygHUUlfgwzzM0GTGs18IGcG8d96sRuGjQTRp973dnUGMBFv4ffGFHbhJYbWwQ0Lp9naTlWUZsLxuwanm93pXsY9sssIkDgMfG3Sajd0FF+/w3cl8j9XYju2++XoooFyZbPiz+fgENf6eWzFZ0zQU5dmNnwJxZ/EHs53bYkKtPHEDDYhOaw5gmkHHmyf3KqU9KMY9COPf3wS4iS6RHJIkYV0yzQa621epdY9BB7ASWY7BakOIIhYScfl8ErwwSM35vUrDju+A+Ehf/kuFVSzolpvJWXrQ+9k1maervT/okBNY6RIEjwqu2gKj8zmg5HiNocLhIPomfJUB+jSu/w6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR0ONDRoF+5EK3YWXkG8xZVzxx8Bn9qVxrPG41lbUIo=;
 b=Rz/VEsZ3gC+IA2UbqHXDYsD1q+M5dq7R/IwIGEcm3kOVvt8bXkzD02CZDtTqgJ3nfe7iGQtR+6AurQQRFico77KLFBezt1IOll1z49ivmT9h+LEEDcfju4rj+n9iRJJBd817hGf/pYbssxuDabJseZMtw3OWLa/8KC3zDHhi8RY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 11/21] iotests.py: execute_setup_common(): add
 required_fmts argument
Date: Wed, 21 Oct 2020 17:58:49 +0300
Message-Id: <20201021145859.11201-12-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eee0852b-3f37-4d21-af35-08d875d1e4dc
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472375540202A94023A2E22C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaRd9JQqcVY9mCROnJ85r/yN/SkZMnMDpZqF/IGX3lFOtY5UKurTKeJ4x0x0sBZznFMZswCQ6+j7WKs6OH8j1xQ7ytQ7dwkhY7I9CXmIcK76Ez7797W1Znm4pZCeX5415B3rtxtzC87XsJxx7YWWkVYMzWJKwFYozktbI9Zn3f9oNKr7YQScyw9V0gf9LbjXR7CUIb5Ad8winX1+6E69Q/CiBNQ8neOHJt07EHKwFaDkV8ymA+Vtkx0wsF5NbK9lcGX3PHHwS0/GBg800RLKXfQ9ejVb+F7lFK9d00Epg0YwhxlqNBapyom4+NBi5THa3fi6A9lGtVCrUGoeXBKdWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fNaSr8K159Gujp6iOX2IXF5nbXqOvzbK8KydD+RvwMkRE0jIyfnvEcpJAJoYskLoHFvvZB/ACdqugJeKkHgjzv1FqVIZNbr4Zd3lik+f0d6bodmnorOR6OP6RtMmlmoNlzpztFuGD7l2YB+CMBIiutxXiXkXPtIHK2hb3ZrqUMiIM82d696li/H0YzcOFGgxghQKAy3SiVLz5HYxajA5CpCcS2Ha1LshrazqEl2N6tURLkFv0GUypiZf+8vNqZpXehWmyvM9FVTvS3Yp1wYbd5qtstoGk4ROcPGVBEyks7TjMniywczxUILl2hDGGcrmBzziwbtbHWAhy577nQn+RgKCoP3Q6YsdKeH7Ct/xXCDlEgjXhJyOWAy8Ea7IgSbX8B6T+XWsxqljFoj5Y/3loRreNSBw9G+3ufhr5pvJfpbb2IueNKeAjXYk2NTaulnuQXxUXkVDA8KAbPau/SOVKT2lGWhcn67UiJeHHcMPHXeefNn/dUxmDKSr4Pj8hf2GNeO7e+BpUTPzS4xWAIVUJB7Vm4skvm7eBaB/7vxVIKXBpyIqU5Q2YmSNDW06ymjDZ7jFhZplUFvDFfhQCxNNQvQMayQ4SKTnuTbUA8ulIndm1BE45Rag+GA1DynSmDx1ozgLW/gGdPvhF3RW/2zk/g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee0852b-3f37-4d21-af35-08d875d1e4dc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:22.2661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RkgVJjlHNmCKvgZwNk9O9WsRILBvAV6QBlmGfllnIiNJD3nstkSCateo3RoagY+jEDC0SizVKS3ysZUbaC+FXSvCDLW1qUN2UCcqu9CXbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a parameter to skip test if some needed additional formats are not
supported (for example filter drivers).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 0e3d1d0ba3..274396b14e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1109,6 +1109,11 @@ def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
 
+def _verify_formats(required_formats: Sequence[str] = ()) -> None:
+    usf_list = list(set(required_formats) - set(supported_formats()))
+    if usf_list:
+        notrun(f'formats {usf_list} are not whitelisted')
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
 
@@ -1266,7 +1271,8 @@ def execute_setup_common(supported_fmts: Sequence[str] = (),
                          supported_aio_modes: Sequence[str] = (),
                          unsupported_fmts: Sequence[str] = (),
                          supported_protocols: Sequence[str] = (),
-                         unsupported_protocols: Sequence[str] = ()) -> bool:
+                         unsupported_protocols: Sequence[str] = (),
+                         required_fmts: Sequence[str] = ()) -> bool:
     """
     Perform necessary setup for either script-style or unittest-style tests.
 
@@ -1292,6 +1298,7 @@ def execute_setup_common(supported_fmts: Sequence[str] = (),
     _verify_platform(supported=supported_platforms)
     _verify_cache_mode(supported_cache_modes)
     _verify_aio_mode(supported_aio_modes)
+    _verify_formats(required_fmts)
 
     return debug
 
-- 
2.21.3


