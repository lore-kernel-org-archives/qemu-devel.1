Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA78BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B198D20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LdRUGXa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B198D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSsa-0006BI-W7
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSps-0002cE-TC; Thu, 25 Jun 2020 10:26:40 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:41601 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joSpr-0005wS-0R; Thu, 25 Jun 2020 10:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTClRV7IxQJgPXzRJdWSJjQqdymxW2dLcgTHdwEU21+pLbetF6Mj2X/c3JJPqHF8+h2SvlTgYeHrZiI7Qmi38kZQDtHJ6fICM3Z+51XOKR02FClREx8/TfHXm89uVcztzgEk/zeZf6gUdkOUz94VpTPofhhVuFIMzmYJgw1iMo8Itu15ENYnsdnru3F5uci2L/njsq4um6k8UhLxSVJXT6ED68FbIVI2rFnTVAkgDi6P3ElVY5tHdv5JmsuvrkryzHfbitf8BA8cZ+op8V7Z1TpHwqedRbFD7r++2NnJFwE6YUImUnziysT+/BAfAWqTFYr4EgCxVh9q9naj1kuygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbq74YhTjFQoZvt1OvZXCNsEXGF68Q9mmhsiDql408k=;
 b=GkglmXQ8lQPAnooPlx4D4ztaukJDm7Hz6k6PXtrr7+6Ia8YVGFbWbVqr4aviknd1iWwbsr704iGm3+fH7OON8zldAfeR61kJWwSwLabLtUcZtH52yHzkTMdIW3RiDmc3pQcpUTEnciZXfoXZmNjI089/XLn/6EhYHRLq9EkmhwqUaSbK9HCDw1tz+y1+YsR1Zi2qkpkzIKv3BIHdci0dCbS2P1ELCc6WWnx4tL2lALLet3vM+jdHhL2saxI4CP5zdqEiiB1q0FayHOdhdbYycEpVwarLR3DKwZh10L55HDFzD0KO6igWj5Wd8Qkq4xBZ1eNhqMXM5Fwpk+2nT3Jf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbq74YhTjFQoZvt1OvZXCNsEXGF68Q9mmhsiDql408k=;
 b=LdRUGXa85Kdd5GvbNxQnmGRRDI+yBDIxOfGFial1p4cClEMPaTAHc+klhqWTKFFpUoOBhvSfTrtmswaqXMbr4d5hGxAJMDjIXJfFWO3KNqDjaT+on9VUlhrg7HLXkEx+BjIX3VmPZlAxH5iL7gNqV6P8Cfxp5G+6rHnAtsly52Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB2100.eurprd08.prod.outlook.com (2603:10a6:203:50::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 14:26:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 14:26:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/4] iotests: QemuIoInteractive: use qemu_io_args_no_fmt
Date: Thu, 25 Jun 2020 17:25:37 +0300
Message-Id: <20200625142540.24589-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200625142540.24589-1-vsementsov@virtuozzo.com>
References: <20200625142540.24589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:208:136::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 AM0PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 14:26:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 306f7d73-5e64-4efb-292f-08d81913c341
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB210031BD085AC27E385FA501C1920@AM5PR0801MB2100.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWB8Zct0s+HvJ5lcvfzDgTEk2UIHjyZ9FAoVuOJJbMvBs7GxNI8RrUoNuN3VhRvGH9njk7yEobPWqnKJwtZly/4hM7G8H+nHMNGEiJrGeiwcTZ0DgGn0y1WY+/BJ/dmb/VfE2ULpX+xj4ZC58jkXiyWucdjvl4bSMZkUvX7lh/3+IXNurq3ELFjeS/ynD17+78uE/AGAq5m2ezw+MQuxhMQW4YM5YBaELoCrO8ra2nb0xTOOetCDwNWprLXFmZS3n+8KkZm5tdrKVRb34xY58JVN1om3c8y8yMotclVnP4FepoQENAC6j4tSBEcnnh40x4UcCN7gIkNiglhWrbT2aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(346002)(39840400004)(396003)(136003)(376002)(366004)(52116002)(5660300002)(4744005)(6506007)(2616005)(86362001)(956004)(316002)(36756003)(6512007)(1076003)(6916009)(8936002)(4326008)(107886003)(8676002)(66556008)(66946007)(66476007)(478600001)(186003)(6486002)(2906002)(83380400001)(16526019)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: g5zN6xJzJg2q2E0Ih9SaSjCT/mf7KQkSf4BS1tTIlQnSrRNqbyTSlxzs3v6begfdaG+2pRrOCviw1Z9EDbseBrYuwHWsndurztUi+osWUK6rAtd6lcPu2w5CTLO7cVEkn3olGF75+NA1+sPbuvbqAQp3BL4t/u93w1LlCPF5Yai+W+LZuvdM+IviPZ8rFpZd8V/rokVx4goth4s8B5FefENK4wrG6GFG3Y5mvVaqbxU8i1tNvkL+c7seUvBe/S34d7Og0dIMKHHcHez0HG+SEsLi742xPWOGTXw+/7CmxF09WdtPqEKb0q0+tWUZbkQTDv5PWGzrde/sn/2dtqndNFbDpUPmZ5R2uLFY5iIg+KVxy8cIhjCti420JaPvqNaA7UbNZUFV9nuvU3L6dzbRRU/WlLenYYvHo2MKhJ5jYO9voVYTbXukulOuBGlf4DVXZpaIrTyF3MFzfiKahztdmxxU4Datxo0MiCGo2v0IZm0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306f7d73-5e64-4efb-292f-08d81913c341
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 14:26:34.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl6Bga6XWaiwOguULLNoF7VMwwhRR7IUF2arawILL2yv6AA/H9OljhAH/JphOi4/VtVo3CfQGsf0twl37tf1md91qz7QJ5aW11jWwvT57T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2100
Received-SPF: pass client-ip=40.107.6.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:26:34
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
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All users of QemuIoInteractive provides -f argument, so it's incorrect
to use qemu_io_args, which contains -f too. Let's use
qemu_io_args_no_fmt, which also makes possible to use --image-opts with
QemuIoInteractive in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5ea4c4df8b..efe9958f5e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -211,7 +211,7 @@ def get_virtio_scsi_device():
 
 class QemuIoInteractive:
     def __init__(self, *args):
-        self.args = qemu_io_args + list(args)
+        self.args = qemu_io_args_no_fmt + list(args)
         self._p = subprocess.Popen(self.args, stdin=subprocess.PIPE,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT,
-- 
2.21.0


