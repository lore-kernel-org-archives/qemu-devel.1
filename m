Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E15C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21F32184D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eaigalh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21F32184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmWa-0001gX-S8
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV6-0007uC-NW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmUz-00084k-0i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:44 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:18917 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTmSj-0007bZ-NR; Wed, 29 Apr 2020 09:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7b1PQpLVDVNxDvupAHPS5NcBocpBDGVunJU+lhSZ/RUGmn/EC3p9Bo2XFEG66l1sfIhlaCkQASW09VxzWEUjbGOHycJmx5AYw5NlGSKUUeM/+ZHwkh95KS0Krn0iBDYjZ6kF2tsHpNlf80ELTa86hFUAHVOvu7oSFIK807QEQFaFBmVWChL2RYqL01cGjww+aT5+Wp/QRbkns86fHd8BWtMi2KWhm7pA7KZDuIO+GSj6lZpzU5TvHjscfGZascI/UMtjUEed+r9yb19XE08DL7UUUG6AElEpldv2Ig6e+wSFt9/pPUxz2kkKUHDRqYLrLuAYQrU9T50LWQ04rW5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdIOkltzmHITcP6ikgzz6PbLppZ+M7n7jTnh6uSYsU4=;
 b=b4PJTOU0YO789qWnkF95jm48qKje2MkeuQKPYKX6HUzcwbw046v3HofR/NyT/tKU0ouIRpNE1u+IcID9pe1aFpLj+1wL8UVhSMq0W5Dh6/6N8y8QM293pSxqprOnu6wBf6AzYn7YfePfjZG9jxGxyPJKVO6UL2fvkVKyMwd+NwbmSyNCsVwhlQhxgnF2tN6zIN+heMU6llmtAMO/aBbYYqZPNO62RVYSfQFzt5qCfWbdtXIiDGwfK3+Ga04caiIcL6jv/AvYXPU+MgY4ZRaLvDF8CBqxR+l+/oUQamQJ0iU2K2Va2TDETk7Tg1a2CnldzmPZLUer+xOTVLm1TZhvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdIOkltzmHITcP6ikgzz6PbLppZ+M7n7jTnh6uSYsU4=;
 b=eaigalh2p+lSaJrD5P8vWy9KPoQIO8h7V7q7Iuo4ZrU4Y2V7mbZ0Fkjs5jjGV71kCa+43JXutkl9675WnD/I+bM9bJYiE6IKYBkWPx9wmQLBS3xe5v7iEDXQPk4+14vFfcgBhhLseQ0ZA/n4gSG6drCNgvXGKlPTouWd85mSmBw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 13:09:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 13:09:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 0/5] block-copy: use aio-task-pool
Date: Wed, 29 Apr 2020 16:08:42 +0300
Message-Id: <20200429130847.28124-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:208:122::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.184) by
 AM0PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:208:122::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 29 Apr 2020 13:09:13 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85ddf3fa-98ef-49dd-9e9a-08d7ec3e83c8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446E8296E437A1AF173C515C1AD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(16526019)(2616005)(107886003)(6512007)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(52116002)(5660300002)(186003)(6506007)(26005)(4326008)(956004)(1076003)(69590400007)(478600001)(4744005)(6666004)(86362001)(2906002)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9MjOaNx9HJul7c2N/rfEXHbiciT/5q+dlj5/mCeoucAGcW964IExzIJ+1Y9/5ANDBdF4ixnFWA3YeaTe+MQZaX+zcjrs+xxHDRryvjDPPr1va6LqjA7rP2gk8zZvsPLEvpltj19NtzEoVVDJRVPdJfxwCWiCXG8JqDSmffH3Nq6q8lrPBdLr1ghIwtc5BWak8S3U/tYTHx0RZfuhWKif5l5x6nSZ6vcdX2FRssp+vYTmGd0FjRPTDkOnX/qymAjBKkz7W0QJAUSRKCPi8VrvwjvSWUU8ndYju7qshbhI730xtnU8t9ojySZf0XebOcSCfB1G/yHFefc9C2RVr1rTCf26UWTT99PtZ51W3xGAHCqMa/r/YXtHTWGffX39MQez7QdpG9VMPWB2Ha8b52Ja66e9+J1Kjn0DZZolylTmQzaZyExI33WO9foXqAkCqcSdVoXT11UAqoegxjq9AJTB6/3jpnZnJCs44Adjad5JtQeb6J6W+RYkifZyTSOJfvk
X-MS-Exchange-AntiSpam-MessageData: ZPk6UZwSsk6/5LmTEPLGEvs/PyRpmghfYRgyxFB4n+BXUTZBC7T3AI1JIncnwG2QTI+RMkFr226ckWlAAG2JkxzwGwxvMd/eSxK/p7VAWkS0TYOOI7Rjk+6A6S5keambh6kNubby4duiQkyM3+KkXkWck+MWacsUuTcS2X3ipaW5kHb7N0sbRtQ34k88UWaVvQJjHu/aduo+77VsnTY/SYVfLsdq1f3TFh0qwiclAeqhfrJRzhy89K4Iev7KWWAN45eznzixKRQnfPTXWsIpjcuC9BLeXspF71bqfoNHhVOJIirA3d14h/ppL0M38PD7R62sJmMNeyKbFEd6EyzPp3PTrSGGRsqY6A4nl3RbJHeh9blcK80FibkjXxaXQmezUA5eAKuPSCXmTiv53S+OmH2KjgFsHPwuZQsRbaim+Rh8CMNetu659r+0fp+Qz8/+JtdppdmvrLF2dmHt/ffUaT4DtUJ/K/TZri5V/WYdF/MrUMC5kZ8m/ET8QwwQ+l8YUs3J1XmJAJTFazLHIuca8R7N1fFjggzJIzqRAnkrofRP/5y+ZJg6moTlik2sRHXB2/wl4qFKLK0aA+WSwdCp2AR0FCJMq/zNJx/yvFNqBM8u18UPMUQ845HEY7pfGi74iVCbp79S0GQGHh0PMQjKYnChLBoA0N9c8b1sDGBQBW8cizQZzyV165VoTnYuAT6d0Ylt2LdXGTx40EPmqtNJ4o7zM1tkFeritCcs955b3Fs1wE5Pa/EjNJh4UqrA+G3i79kJtN244S93hQbWFFdPf4pXpwI5osurKEgUgVGKflM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ddf3fa-98ef-49dd-9e9a-08d7ec3e83c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 13:09:14.1156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIKTQRf448LL38BK79aC8RqDlw37qpEMLuHJUcVEXn1Bx0Jfd5YcaP2OAmoQGMV7HAX3a8r9NY4wKoF+AMXMuG6EMe+7B1mOB4DHKSOr65A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.8.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 09:09:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.118
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

v4
01: add Max's r-b
04: move variable definition to the top of the block, add Max's r-b
05: - change error-codes in block_copy_task_run(), document them
      and be more accurate about error code in block_copy_dirty_clusters().
    - s/g_free(aio)/aio_task_pool_free(aio)/

==

This is the next step of improving block-copy: use aio task pool.

Async copying loop has better performance than linear, which is shown
in original series (was
"[RFC 00/24] backup performance: block_status + async".

Vladimir Sementsov-Ogievskiy (5):
  block/block-copy: rename in-flight requests to tasks
  block/block-copy: alloc task on each iteration
  block/block-copy: add state pointer to BlockCopyTask
  block/block-copy: refactor task creation
  block/block-copy: use aio-task-pool API

 block/block-copy.c | 279 +++++++++++++++++++++++++++++++--------------
 1 file changed, 194 insertions(+), 85 deletions(-)

-- 
2.21.0


