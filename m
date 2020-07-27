Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D117EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D10E2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UMe8HBvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D10E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08C0-0002Zx-RB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08AT-0001SS-Su; Mon, 27 Jul 2020 14:48:09 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:59123 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k08AR-0005W3-Qk; Mon, 27 Jul 2020 14:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXGnRiYtduRknu3suns+6hAhA7mj09dknA0sn/QKV1/Iytwx5W1fGeh6us1ds23/dvZ6yZNQRcks2s6aUHRSgiWaE1zhdZEaqbWdC1nKZTkqYcB2nS+zRnw9TChNmM56qEkZpcUUioVpBNSS1WBxWrsk3jaqmuXIBLLsTvZ28g+cksQVYHsMri3iVgbyQsBnvAqUWCWeu0LZTsXCT0ozPHYqq6eBqBgk7QENJJ4+ZXEY4fismLw+3b6sX5SGLAEC3VFaEw16QqOkruY+ywcc+LcqhCBsXl/vYN5z9CxebVTKOtjNP0MdRSfC4yZ3TfXuN9VYmvN9GbkBABeucYjUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZHNp9scQG8enfe4EYDbbciVYDeZnKYf1f25nbx8sT8=;
 b=ILO6NM3iZMz77Lc9R2I614bVzRC2ET/RsGRUjRYZuId6zEOc6JYxtHM4j8YErDEAkhBRZvKNiz+fKJcfavqQQf+ypfqnGQKMuPJyNFONwNcYy8T6X9CzN6SIQN9yZtDRNMm31SWtZCjmPpWVl2f5dxMK8ia0rL6E7CYNMrC09NqoIPdCzV9nIn1BfX10nM1hyot205GP7Ek3De3bS5OJs+VAxbe8ha8K7+65hhvaV10ZtCj6yBdeckbCgPFd89gpbccbJUzauv+JrU6x6HD7MqdQV9dqzz8aaCITeEiA2BIz9+ddpIX9PWdQ2zhGA8OTsgZd2Ci2fYbMbzJUfPZzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZHNp9scQG8enfe4EYDbbciVYDeZnKYf1f25nbx8sT8=;
 b=UMe8HBvgLAXIBQDMJepi06eTpnFoLZZs1rFCVDj0NHmoisPkVQI0jwH2BqXo0GhQmt44soMV3kh6xwwTW9ebMUWL4tpaCAlqIty2lbhlFKXsf6+RX/5sUYwtIDKWWvws7UEwXUbaethPl48SjsqnOzfQ3MBJTkNv9dmL3JA2goQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 18:48:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 18:48:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 for-5.1? 0/5] Fix nbd reconnect dead-locks
Date: Mon, 27 Jul 2020 21:47:46 +0300
Message-Id: <20200727184751.15704-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0701CA0033.eurprd07.prod.outlook.com
 (2603:10a6:200:42::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM4PR0701CA0033.eurprd07.prod.outlook.com (2603:10a6:200:42::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend
 Transport; Mon, 27 Jul 2020 18:48:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d97634-fd2e-40fa-d59b-08d8325d9881
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50793361C96D2ED67B3BB5CDC1720@AM6PR08MB5079.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOX6a8IE+gL2HBs2rlc54pc4Or0B2TDDB+oNvb5JifDjxYb1KRNScXZPmy1cCVsdS80xb5YWWrVE9toouoN8q9VYWpCoUdrO6eTFdxjIU/tSv7LMcCuBTh6vDtS4WIDAd8Q7x6GwWMyouKXSewKuHTKk2EFG149+6YVohPKPOzqpxlDpIWRpiHQYiBQjRh5cELo7vg0aVXk6kyYfo/emjx+EXausMA+xBagusbJglASwG07A8+xGcwrRWUy6/1LWXVMSlt3vb8oUGQpmutrafaC9+5vFHoS3g+kzsnzduqZtMZDziImQaeI0SwXoOPXnjqtAMFBekDSQ/6rGD16cOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(346002)(396003)(376002)(52116002)(478600001)(4326008)(6916009)(6486002)(956004)(16526019)(107886003)(8936002)(2616005)(186003)(8676002)(316002)(83380400001)(6506007)(6512007)(66556008)(66476007)(26005)(86362001)(1076003)(4744005)(5660300002)(66946007)(36756003)(2906002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9Hh8ee3PjWsVUXEHk2bQ4PBiz8314OT8Tsxr8F8mb1AVagvHOP2+GkE0xTSEPnvValL07PHmL6dua4R1ewEb9opr56B16HjEob0ZPanaRz2iSrCyNIEq9CvOjp+Rmb16moVYfBG8FcTkaYZfusOS+Qszk9bF+EmRSQRp6VvRIK1MCU4CMQhycaxyZkJqwisoXll6kSjxohVi18PcA35TU0+OuL3j75f3mZoPDLPuNw9qqLLeSeEZ9+5/x/OTgmCOkDazXOTyo8Q0pdTsMe13Slz7dWCsW53VG2MO28TFj0eoXCtHsvG8aw2lat9aKcnDLzpyCcO3n9rwIDGUTqnLchOkcBUnq79TDLilAscZZPxNSUSjebZhIVFc1GvDnKzl3mzrUkAtMcRdEWHvuvWiVZKsKYYaFZVIcrGo6MoCaigj+LQzhIhlb8P4QP26ELhBgVTTSjMyF3o0o56uXz1jrWqlroH2UQMguDWyqRoY8EZr4aHRKfif9MwHPDLk3xWh
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d97634-fd2e-40fa-d59b-08d8325d9881
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 18:48:04.6132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYKt3ryODtOZe7p+4aPuMM7k6QIYyw2W6xnjtcdvy9YpUPsQUiAWpPueqIi8mx/c0C00BPXXXQMHFqLC9QnWtMGxA5+h5yRFjoCmxSZg9v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5079
Received-SPF: pass client-ip=40.107.2.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 14:48:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

v2: it's a bit updated "[PATCH for-5.1? 0/3] Fix nbd reconnect dead-locks"
plus completely rewritten "[PATCH for-5.1? 0/4] non-blocking connect"
(which is now the only one patch 05)

01: new
02: rebased on 01, fix (add outer "if")
03-04: add Eric's r-b:
05: new

If 05 is too big for 5.1, it's OK to take only 01-04 or less, as well as
postponing everything to 5.2, as it's all not a degradation of 5.1
(it's a degradation of 4.2, together with the whole reconnect feature).

Vladimir Sementsov-Ogievskiy (5):
  block/nbd: split nbd_establish_connection out of nbd_client_connect
  block/nbd: allow drain during reconnect attempt
  block/nbd: on shutdown terminate connection attempt
  block/nbd: nbd_co_reconnect_loop(): don't sleep if drained
  block/nbd: use non-blocking connect: fix vm hang on connect()

 block/nbd.c        | 360 +++++++++++++++++++++++++++++++++++++++++----
 block/trace-events |   4 +-
 2 files changed, 331 insertions(+), 33 deletions(-)

-- 
2.21.0


