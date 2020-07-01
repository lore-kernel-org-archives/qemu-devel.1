Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A121DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3D420775
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sey34xSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3D420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaOC-0003lC-NF
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN8-0001zR-Bv; Wed, 01 Jul 2020 06:53:46 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:2638 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN6-0002JK-QO; Wed, 01 Jul 2020 06:53:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3/Wr5W/xiTs8MxJDLNAseCoSrREsMfpbGd+WApCm+uP6IZAXC+RTBscTW+5zB2eCtrlqPu/AdvJrp2p/cMD2L5+d7Rf99E6R8g/Lx45qRRqFvKYqjQcm1uWRkj6/1gfHHz2w8BwALUnmMCbdip7W0++RId80/1eFviDzA8LPHjUipkLsAHWB0/iyLsgXRXr+537vZAt1AY67j2wp3DX2XVcqOFbmokOks68kaIaVLhwrGUbuCjgCoQufS9dqjdB8wKj8+m1YNVkGYu5Dd1GEgRO0rELdyaC1AiVTIQTcwd9FaAC2H6lk1nj8/KFSaerqxnCKbpbhNco/iZ/tO52kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYZsvrdBC7fM5IWsY1MIRuH8ZTl28pVdRfLQ3vO6S+4=;
 b=eoKs8fU+POQDzOzP2GvgBRGI3+G59Xw0mW/0ya1eaAZ4K7nlEaHikQ5foqHK8pN22pijU//SyPmdbiA8uiAk4K84y1eJRldSjr6TfFBJy8+AmRiM2EC1EbfrMxrQHL1tfaPFpJuAMHEb3k/RV/fOs0iyvUAWvsxD/rjXLSX3fKXtZy1r4jIl0oL2DmrFVzi9BX6pQu/YQ8wCDi4o5MtfqP5kIuQrdVBkCS/APtHn5fcNkqEkotngFnfLyeQJQYC/ZK3kUFYw69gCxdoFROXGQP81hy3dcTiLlib9YjcmFM5a7xMzgADRpPV9xHuLWo7oNLDltnSDndhPHWU7m2PwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYZsvrdBC7fM5IWsY1MIRuH8ZTl28pVdRfLQ3vO6S+4=;
 b=sey34xSB0NQovfX3cJhZ11S+bWv+kauoCNEZOBMJPQfgQAuHuiYFbgWklI6FiZEPgqwhsgw6uqP043LbmRHunGJnWRojqC4ZOuByLU+kahzEiPWEMiIZQjxA0jvhTcFOrcgqzPZvEu1seWrVsc5QqWqZui184CLJ11igXgETCaA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 10:53:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 10:53:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/5] iotests.py: QemuIoInteractive: print output on failure
Date: Wed,  1 Jul 2020 13:53:28 +0300
Message-Id: <20200701105331.121670-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701105331.121670-1-vsementsov@virtuozzo.com>
References: <20200701105331.121670-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.28) by
 AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 10:53:39 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4be2d367-387c-4877-0dc2-08d81dad0358
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48500A6F0680FD9E59F93EF6C16C0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfzA3gxuqG7NEwtTDCAdU4gS0u0XIRpMp3neaeEsOE+QQXuoiC6j98Yeso+QW1lcJMArpuQ8juppl/3rmOSgo2wJ6rzCn3cVRO7fknNQQ06L1O2mpzjJLpEWgy5dzr/Ii6Exp5y8ip4/V/47JY6WjtVzLMsBvP+o0G9hIF5ITpcJzuqY3HpM+3mkMWWaxk5gY6r2v+bxfGswUTTfwLe6eOD1FepJNHxt2IGk6qTZ4B4WmsvH8X8MDKG5UTZIC1rw1fSf2B7IUzy4hRw+/8ZcyyJ6asRsLc5VETs5yTEokz/jGhStOnM7Q2lJdnwZfzZythrrupHLa2ivPN5C5AGNqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(2906002)(83380400001)(956004)(316002)(2616005)(6512007)(6916009)(107886003)(6666004)(66946007)(66556008)(4326008)(5660300002)(66476007)(86362001)(4744005)(1076003)(478600001)(186003)(6506007)(36756003)(52116002)(8936002)(26005)(16526019)(6486002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TCQW1onjwgt9fuLXWm08n9WpFUs+HchjcZ1yiP8VyttGhg6B7v2UXZI0mtvI4gIAQGFBsu8MgNWpvJ8CBsf0nnd0OabYnHKIyIFD/cACo4eKmult4DQ/vGoJ4PJXM8Yymtj6bg3zNwnfOqTI7dQz/r+Gbj3/nAlDKr8ZItk3JxLJB788mwQUZPCbWxBr9gkR7EOdXJR3kIFi8s/adwb+74ALFGzkup/mL6O+oQD19o0XWfmRU3sQDYM55VE2bTuE7AOpy8qaNh7SoZ78jMn/kzPtBG8GjXQ6h5Za9lihvLZ6k73ofjjgjy1FOoKdfPVN10bxLHdGYqLYxJ7iActmgAxkZtumEl48Bztpzc0MLfOtejAyZP4tqrX9j+YKmZHYRv4h1Kz5J730pg/4i/mj5j4RjoNC9xpoWDxM4dqlYyHaJJYOP474RFbmk/XLbE0JtmVUQnBqxQCXVwncMRpADx7jDIFGk3TU2c7qbHTIrnA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be2d367-387c-4877-0dc2-08d81dad0358
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 10:53:39.7895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N23+KkAoFVxGv+HXbaInK9uxtBXZBNgQoWwE0sMfh5MeT/AOqYSVQJqYyodzQI9fSHVqJG2hTMn3X8W0XNeuweK+NfOPLCMtdf6M+OksgVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.1.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:53:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it simpler to debug when qemu-io fails due to wrong arguments or
environment.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index efe9958f5e..ac9d199a1e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -216,7 +216,13 @@ class QemuIoInteractive:
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT,
                                    universal_newlines=True)
-        assert self._p.stdout.read(9) == 'qemu-io> '
+        out = self._p.stdout.read(9)
+        if out != 'qemu-io> ':
+            # Most probably qemu-io just failed to start.
+            # Let's collect the whole output and exit.
+            out += self._p.stdout.read()
+            self._p.wait(timeout=1)
+            raise ValueError(out)
 
     def close(self):
         self._p.communicate('q\n')
-- 
2.18.0


