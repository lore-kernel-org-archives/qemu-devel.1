Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC88C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEA62074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UHp1avCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEA62074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8f6-0002xV-Qi
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bO-0004V5-QT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bO-0005oB-Ek
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:42 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bL-0005iG-9J; Thu, 30 Apr 2020 08:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcVBqWBgKx1kKZ9q/i+u75LPfO6Y6QCxIJ+smHxNAGT+ab2s+pvMUjQP+b3LdaTxuwOXTh5NDjyWOXj4Ed90GDDFYE26FNX6T+gIW94PBp3kSj25bFd0NoeHxw23/fcHts0V0HOsPtSrjT4OGksVL1B1e/mS9Am2GT0v2iK4VOE2KHaQbnLDEjHbIbotpIr3Pn2nvasDBDwJ/b/xg73tb7TInSqo+t0YzaAjCkFdhvdtBkCj6efElspabSXF20HCrenT/ZwIhTFbwJyhoWahNoqC9XcFKuGkNNP7Vv3Hi+eaLOy/3poMNtrgJRmrPZIPe8AHtUqbX9UAn//zH5Nlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bR2QPM17XxKEHDo4lxodtrQF4XZ1UmEb+Yg0/M5ojg=;
 b=Vi0VOWF3NXugP8nXh/r4hSMb41We33br/bqdlU2iDxQah0zeh6b55haBAWyRUDMjsmgy2crUlipl9aI0+EpqqWdHVHpgWkvPqKkT1/KUJ09Sk2GM+fbwh5CFTxLUlnSOsLa0WBEkkRfpxoU483FJOsc6wYwFDDw0nCnuVvne0y8/8v1jBKjDKCq5mlfKaXvmiL3JDVkP/4VpabuiL6OvcF+v3eV6KjwI8LRVflNdFpxr6cl6R5irIPwIZgPX0F4+02hzPiWtJm8L3kX99yZnnQA9Q0AelH7B9kcSHGhagjWnAcMTaIjbBZVc4qjlTSZlrXqMrEChq+1tGKyT8EzuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bR2QPM17XxKEHDo4lxodtrQF4XZ1UmEb+Yg0/M5ojg=;
 b=UHp1avCjO6SWtx4eo8cWcXqJIy8/l4vqJeqj9CwzpI64e4hIeBHep8ALZUANyQPRqUcHJ+31B5kAyOlQI4J3VSoOpOiww0VEBj4lgnYHNTMHlAkoahcAZes0R8EHPFR34vqwAAq9QeULzrZ3ecYGxu0NsLi60ayTmnUtsFslabg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 7/8] iotests/109: mark required formats as required to support
 whitelisting
Date: Thu, 30 Apr 2020 15:47:12 +0300
Message-Id: <20200430124713.3067-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430124713.3067-1-vsementsov@virtuozzo.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd072172-c9f1-49e5-61ba-08d7ed04a77d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB547828B42529DFBC1245F707C1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zmqf0R5d17pi+e0vBmR9DVxs/Wp7g4H8ctCGxf5Gs24OsF1UNpO3Vk8VM/24t6iuNo0UBLmXZQ+ljOwTLbIOB8EH/rGa25mvLPt/2UaXP8qbZ2jPTaGJpSPgoOe6wUUTuygAhU2iIygWlNYD+QzSLx+PsfEDe1nfzP5Gz8xZkVBqBZiM30BChNh0ss5YlNSMaycKhdlK/0QHZQFgKSVxdHO9WpCvPdnR9ggS4lv5ezAM74d4QYxU/qap/TXfbRJlvL72bcZc5+8xDUWVVyI/1kRepybUL4KBbQMT21AlVQfI/4WG4Z49bh76Hzzj12sI2XL5jgmUT8H2PgcuGZDQK6YzcIUSugFmQHa6hoEzHLTyd872YfW4z7D+zKcId2NmPhHM2DoDwneA1NxP32rl1YzZFjRrJKL8NY6oSGX5X8L3ceev4WG9I2hNAvgNT4B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(4744005)(6916009)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: c6Az8Q4npnoJy5tkN7iRewm2EZvN+iELuijaK+6hWfoUF5XPyICkRoTU+vJkd7dwF4xAIBQgeKK8LMFSAh9gUqeYIxIILM020fJFZTitvapRo1flsknS1fKHe2H7uJ56ZSpV873WH9z+UI24Suee5K+zo0mr9B2b/lhBh3admpI3cGi58D7/AduTrtYTcT7eRYvHmXVK/n6ztQC/qzcEXbeiC4UtZjSdvgDCsiHIsrbrvqYFSiLFciUJCmGC76ia7FVaqPIfB5mA5AwMj9Xvdu3HaF7DpLvHYCnvQ/nNFksnhY6+SvBeKk0PPEQ7qA9REUvnaU+17BYoQOZJBE2efpkietG0OTXIHP+QIz8DGY+gVeqG/mkorWKeu3TvnoF8d8YZFIvIG91VQzxpoiIZKzFqrB1xWRQPyUp/OS1lEDRvYx2I1sKdhvhnX6Nc1CIlHS4x/RNSuHpAeTHCzfSZjcAhvnsUQThAVSlJCddfcsrLs/wfOX8Ye7N9s0SjKA2ougp3hHqd9YA1wLzLgomRYLCxld3LQfm6B8N5Op9vFq/4n5FduD8jBhY4C+V19pppiWh+JvCDRJk9I79tdHEj5rgSI2eC5qJRiuqRy6Axg80vU7vLbIVqSz4uRWBWQF6fkqWElA/ZGP66unhiaZqsIdtAHk4PndvzLNFbOna8nQHc0pgkmp6Nx8UI1Szh898PF1h+O2iuLhH/PHm7X9he7Z7c5YSzu57A2S6gDAlc8jM4qMtd+Lgf77o54azXD7Z/qhvtJ36aD9R1h6BISJYWCKK51XRKN4o4PfVfQgjg8tM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd072172-c9f1-49e5-61ba-08d7ed04a77d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:34.4417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxhzQ1n50ig32EfSzU98Px58oInyEZGRT8A2XIFEHGy4bGA8uaOzjCf20+zuqJoXEk4Lu5nwnt6+jguKKXYVnMoo7pM7CM6gE8S/7J9vZ4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.137
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
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/109 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index a51dd84b3d..5bc2e9b001 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
+_require_drivers qcow qcow2 qed vdi vmdk vpc
 
 qemu_comm_method=qmp
 
-- 
2.21.0


