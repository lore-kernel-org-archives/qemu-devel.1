Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87541C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21ACF206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AdYyR47F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ACF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaOd-0004dA-BO
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN8-00020c-Ud; Wed, 01 Jul 2020 06:53:46 -0400
Received: from mail-eopbgr10106.outbound.protection.outlook.com
 ([40.107.1.106]:9187 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN7-0002Jl-B9; Wed, 01 Jul 2020 06:53:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8Bql5/4iQ6r+LWOA4iO0w+ro6MjVAt/kEUhoK/KmL9oONbZ12z3TiBsy2/VoQQr9lQGguDOo2EtUXqWjxZqTXcdXxDUO8OWzLgFhkldkrNjhdq7omQGNk7tTZLGumO2/TsTffl3WrZZNeMrD/3YMfW2CPgBArVIKWJ1FW90EqzQGC30RGAExtEG4Oe4bdwBtXiHZpM9RR2pLRAklqEvCwh57hWcHS5C5B5sIZ/EzFjLjUghKUOSh10RhwmCzn2scDpMICedMEI1dIdSBkMqNiJ6xpquADL3z7tBQGNWMPn1ZCoO6NB/On74uvWphV6rD4uhybkRNkXdXJSuTwij3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6G1dRBHL0pLEdzQ/5RUVCtUO777notCFjPwcfqsYyo=;
 b=IxTG3qTkeNbC4rT9Fw9hbxEUIX4sV4xUz2ZddPHfDvHMG/KtgabxRvFo6L0usIWrbXwVqezxK6FwKgKKmbvpozkKjPPP1dU1diShLM1bB6y2oTZw5H3BexvvXlC6zRUiFfJwpU+dli6k2ASpmlnupYjxJ0A0dxOobULkgkBKv3ZPwfuETldDwqgEwWdTNtPvI3AfFmG05mxPLuaXSFoQb/fw7aC12IrdGGz0KgCOmBtc7QGhm/MBOeG85+1ypSNAfMQB20sSXwT2vucTJxCYDEpQ2ZURIMTVZIclLqRzktIr4+uLK8yzRs0pxJN6F/FyIurKAUvlJ4uwFd+wyMm8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6G1dRBHL0pLEdzQ/5RUVCtUO777notCFjPwcfqsYyo=;
 b=AdYyR47F2jdozjTXjiumxiYE1kQfzO7xEsI5+OPWxgfrtTPa/+wZFOG3ZiVWUGzFzK2/pYtBL2goEPfGZekdsfksj7Sd+DBckhq+5SBffG9APzgkTmmGGeyAuTw+DKhoXO3sHy5qwBYvI3sBu/nmW+yxBo7WKld2Jx6rx9rozdY=
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
Subject: [PATCH v2 1/5] iotests: QemuIoInteractive: use qemu_io_args_no_fmt
Date: Wed,  1 Jul 2020 13:53:27 +0300
Message-Id: <20200701105331.121670-2-vsementsov@virtuozzo.com>
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
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 10:53:38 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d4e6549-91fb-48f3-a20f-08d81dad02db
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850291C4EFE8CF598D20966C16C0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPz+yvYR7HBBt+GpgHxau4RovWGBoKuU0c35+gGzls4KIkME2pjPZWBB34djGHyghwvBExzOLVeccTLYCN7IIYEMK2biQg1tqnWLenntEbvD/gK4etXkyU9DJbcGmSHy3AuQmEVbeIgXJoUFPTyEz0kOlMFr6fHHQQUxQ5zuKcsldISPd1a7OT5CDZLNRUALxi1GAcFZtUF3KUMzPm5hjy7CH+B8AjYcyIDOuRzK6aG37PWotEGFkByINaYeWBKZL8QiP5zYP2MDzQrSNCjbVPl2H9pfxsRFSE6r7GtvI024k6t7Ck9Y5o069+AoIl7Vy3XLk1hk+JhAdHuLiYLv8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(2906002)(83380400001)(956004)(316002)(2616005)(6512007)(6916009)(107886003)(6666004)(66946007)(66556008)(4326008)(5660300002)(66476007)(86362001)(4744005)(1076003)(478600001)(186003)(6506007)(36756003)(52116002)(8936002)(26005)(16526019)(6486002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hprFzC+PiB3y93Kbx66HoTjI34VF8rSDWXV91NJZu5Ijl2Wq81e0R2o6P8u7bAxVUOJ5tgF7CCF7fA7CeKE+c+1OPwLskSvzU/H/sFEjFmlevOzt5GXELl1rSKZy2fkO0lEa/UxFgGCjv4/QMFmUXO8uncOH13y+HC3IDCRgn4zRUvPK3OJFi6oR09Lzgh7Uh8mx8hotqpjok+7Tped0GD9TwuuAGsxLttQltfm01s2kduAP8RWz99k6saq16aANcrzb/XzBt/2piqp9bOrglLAJ+LFqKP3plqBLz+6WtrXWW4wQc1T/TvqMhESpsJ4yF6Rm8CZhbxR3rjeD/GnxpOjCpTFuiDSlYOrLYTgjvg05LJG8zIQSt1FqggG1YPcsMOcM+ddTCL0aXXorNtvgfRdfGPDYMv2/b1CCMxyXqJ/cf9+y/qchE8xNaZS3btfx40i2x1vZIGbouk26V9EYXol4Wy/3q+AZMzKxdTSLMyI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4e6549-91fb-48f3-a20f-08d81dad02db
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 10:53:38.9292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWfjh0QoAlFcruazSNwntKxM7IJJFbZ4fAGRIB9C6YCp/3h/YaJPD3YaBszkZygo8nSz+2lUkTORsmwH+KDWnLwnzI/CcjNpRLvxeXH+95o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.1.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:53:43
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

The only user (iotest 205) of QemuIoInteractive provides -f argument,
so it's a bit inefficient to use qemu_io_args, which contains -f too.
And we are going to add one more test, which wants to specify -f by
hand. Let's use qemu_io_args_no_fmt.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.18.0


