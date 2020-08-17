Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A857CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743A92072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fi6f16LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743A92072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bVR-000645-Oj
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFr-0007sQ-F2; Mon, 17 Aug 2020 05:16:35 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com
 ([40.107.14.127]:35534 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFo-000882-7V; Mon, 17 Aug 2020 05:16:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnetS6IqkNKjMQxZuR5gfmOh2P6/ovQmDonqf7KgNlzr8wdVvVQ/a89ZPgkJ9GXlXpxbDN8TB5uo2BgbZ50RcTMg/dCNACqtl5yOSCVQRg2sc6nMqCcIA8iAvqXELtuy2potId3ki3emJAzjiymwf6kPbviRE6WtCxLnsr2jwz+Cj+Z9xzE2oFIrXNbvuoTIMsZltbKwZXZrbCtgbQe3ZpY+fqd8G6U5gewYCaEuJs9vktsMmC416s3/bVe6Toa2pTdfprinGUpEp/gaByEbaeXTpTUIQnvd4bSw8ERCWTLOeY4kjplO3WSF5JaMrP9d61cWjOn9C9jH3XR6NBSlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bSewKwR/qJKi8k6AuIIWLyv+oN8eJ5a/HOfOESNKN8=;
 b=T7qGzh0MT1EvzMQG+Jr3MW52T7niMxsRVpQYtPhRvYA2SAFxfDj7cPQzeh1gDQJqPgPKJaFkzLII8wDPMgAsbOXT+mbasQZgEMY0O2l6pYIPGLXvSpzS7Fkp3/DyDirLZj1YkNAQGEjK9JrqepHbEGcdF0caB4uoPH7wPs2yFbMVM3V4l24D9sngPTd5o+PClWDBTEYebdPO/6djDgEUQkUN9u0p+FJ4KIj6ZjXwwv/j3KMZrzDLG3AwW3IKieDi4p4thEzTEAGTC1n4/yso8jETKp0xroSrZwxkULmpEYij8wVLqXHKouI9aNdK2W2O90ych2aOWNRsU9d7khGyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bSewKwR/qJKi8k6AuIIWLyv+oN8eJ5a/HOfOESNKN8=;
 b=fi6f16LBAqwNBmCmhOhZkW+52qIJn9ArzTSBndv505kNIeepsBZqNAGoNAzksGhfx+ss2H5ZCpDh3/YH9n6hGpQBaqdNLaR2aETPEl/iDxhDSdOWLtb+d6/BG5OjIp+AlNj5471o2tosXdrTiM5DUU45pPfTcIUyl2ncBZI0RVk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/12] iotests.py: add filter_img_check
Date: Mon, 17 Aug 2020 12:15:50 +0300
Message-Id: <20200817091553.283155-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:10 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0424e49-6224-4b7c-a507-08d8428e2ea8
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852D6675A1F124C5FC498E4C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwYGtTR9VKtxMPKm3jD+cspMRt7wHfG7tVoGvQebNGnsE/nqH0Z+v00rIV+TI0Wq82OTBWrLQ+XjqbZoG5q+KkGdLp6yFH9LO/LTvqgwFm+mT2EZrHfsJXHTzSaHEjOUcZ389w6mL+s7Akc1fTuM4vOYQ7Wm2lW/EpP+MHll9vOlE2i6UzCH65J25fWMEwfvFCNi+E2TFFUcE/pc9pkILYiA5zIrSWnS6bZ4kSYjFDFOhSNQx/vVH1ADyRe8UCa4o3hEgYmWtTPNL38wOhLiOFgEbzF2sVZRiEXi+i0jyGdnQ1/GlFfYFnzkuK8lDlfKrMlbXpMlxq6pk4TFKDdGng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(4744005)(2616005)(66556008)(66476007)(6666004)(66946007)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8K6nbw4dnJEjJe+6mtB93uwl84TNzdxzp0ouNnwYaAtnAoL1MPxqkqzMFqil8v2ZUT9bUY641EXSAsmW3VOy05DIxqoSYgqiQ9xpTjd2QdJWT9cOXEaLBf+0U/Op9Bry8u+Ida0s4W4x8q+mKrqdcAbJHnNbbw34r76THpOWKTAdIe5itWjPiy03VpcNhtVODkC/QJA4n+tXDYvHmSRRVsUTHFA7bYFn4iqiWSi0jRWt0tp3LjUJkYY/n0Fo9P4nIAI6fu5HXqzjP94Oy533+W9J3D4gJIyVpPkGT2+B3gLFTP2aocdMIiuEnjcx8ZeJzJM5oQhtaWqMiSXS1g94H2ZN3cUii4+ARonun/0mEIzhOzCpWVez3YUr5cATkBw98GIUoVWwe/LRRrNy8SJqyyXBNdfOKwrJpQTsA6ZAZdaRuYrYJy1FPXMOXFqSRjawcmyDRWDgEbHQYrOylRpWe6vk2AuiAB847nvEIRoFFZC3dLHWODzsmXPZvmkW4Mp0yBt02WTkTisFafyeXFj30yVoxCHQG0+yrssiSGqW6y+BdphQVZ9Wec0lovwfjin9vNrT79TpY98fagZlIWn14MQjvZ3wPRg7fquTCL77icOa5+rT4jB/O/hVcADan/ycB7L0J4iNVvyZUmZoOP9X+Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0424e49-6224-4b7c-a507-08d8428e2ea8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:10.9723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRqDnYh9LzmmbA2ODagbyBBMFLF0XzxIMa28vlTHONC0npGw3rgad77zrEZtytbJr4DvMHWAo8VeDVxZ4Yc7EWR8Q5ALK0VXCYS8AilUdCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.14.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add analog of bash _filter_qemu_img_check to python framework.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 369e9918b4..ef3da4ee61 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -402,6 +402,10 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
+def filter_img_check(msg):
+    msg = re.sub(r'.*allocated.*fragmented.*compressed clusters', '', msg)
+    return re.sub(r'Image end offset: [0-9]+', '', msg).strip()
+
 def filter_imgfmt(msg):
     return msg.replace(imgfmt, 'IMGFMT')
 
-- 
2.18.0


