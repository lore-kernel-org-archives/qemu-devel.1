Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE925221FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RJbpfDM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE925221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNj3-00027d-4J
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNhk-0000JB-MU; Tue, 14 Jul 2020 12:22:52 -0400
Received: from mail-db8eur05on2116.outbound.protection.outlook.com
 ([40.107.20.116]:22897 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNhh-0002R9-Ax; Tue, 14 Jul 2020 12:22:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2VtDr2ukOYJCa7L/ACCe2MSjhjX6aulGxJ8F40TmZWfzIY6wlDrsyZFjNlp2oj+k0dXlALHPp7SeVUnoi6utxoGrP3e/+FDHrBEOv+R6gyRpUIFOGZWd8rTwEjcbLsiTCw2ATjddomeCguylyOu8Z/DwCCm/HIZMU+GnZeEJ+jcEByWyNoalWXPa2ePuu8u/B1Y68lZdVA1J8dv7Ffixhs+hC3gOAlLVMNFNz1kxLjdLkgZlb1J/pBH5e2hfFynqFXqG+1GBx5ZXRJ4mJNjOIMSw6UkKhm4L/5W7aL6A/jPx2v4hh/S11ontL00N5ZzfkfkrH7e5Uo4HYzltMAihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li6L8i6c58kAZeLEmnCo2oVl1HTRNQCwNF74/vT2TBw=;
 b=MHdJY8rU5CuhwEu4Qut5O9ur6eYhETtc9tYdVMfnhuCVo2A/DWoHrv/uERd/M/cNfqFyGOtvnxG4ihthtDquoXUrucdChw+jVKX0CbN9TD8dvpGUsA/PjlRNUdS1kwA6YBLGrbxBSv4fIXotu5RhlycgGLIEIf935Di1u//gk1R5xYYBjr8QsMblRJwPvKnqCzl9PHc6KprHlz3I4xBpLDwJ1Uf891MZ7o1VLauQcSWHpXQTD10VejwwR5IHKa0oP46+02GRwJ0ALmf5M/qhGM+FH5b/q7njk6+cbZhwRG4CpSFRfyxYr0VB5TqCNOtxpKvA/3m0ucWz6yOfSjx4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li6L8i6c58kAZeLEmnCo2oVl1HTRNQCwNF74/vT2TBw=;
 b=RJbpfDM/cbet5pzq2eeR1I5TFpcYBBuUN7Bd20TplDi2PppceGOpwBB81Ch7xKotG8tRCw5EZd9QOP2LXxYC6L9gUs9p1CcwthokN3e+TwbIeSCzYmU0js0IsyAsk6MtM9Gvf5C3Ns++isIYJGK6/Zerx32FXoQiKF48UO2JoLc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 16:22:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 16:22:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 for-5.1 0/2] Fix crash due to NBD export leak
Date: Tue, 14 Jul 2020 19:22:32 +0300
Message-Id: <20200714162234.13113-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.164) by
 AM4PR0101CA0075.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Tue, 14 Jul 2020 16:22:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9589bed0-4024-48c2-0a2d-08d82812249a
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2982BA24A821E79C9FE91E24C1610@AM6PR08MB2982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgOOnv8qwUFxnMcZYmKnqF2z+qR+6fF9dE3V5R6HIkF5zdYHiNxtpI99DYYr9zShOEdnOUGSDrX1meWuDSJwjPuV05Tu0sMt3Dgbqg84bbh5YRNqTUkrB9SUnj4vDu0F3yYmMOXfE293wQyUYCS76LvWl4hIXsu3M8wR6d6FxNn0bXIRzsEomOfHy2SlhirAA3VCzAyvYrAAToa5U5eABVffBYfyi1vePe73t4rHAOPeyUgr//hqCTF9uRAv76cN93p453sYiEGz6rTeR8WgLfqAm8fM8QHcqIyIn7fNCI3MPp5DazI7O8I3c2flQTIpOmQtmXhspd3Ms3KN0klmgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39840400004)(396003)(136003)(86362001)(6512007)(8676002)(6916009)(6486002)(5660300002)(66946007)(107886003)(8936002)(2906002)(6506007)(66476007)(36756003)(66556008)(26005)(956004)(186003)(52116002)(16526019)(478600001)(1076003)(6666004)(316002)(2616005)(4326008)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0n2dbxBrFtXWbO9hNIwwi/D2vi+2EpZCfVVQUvACfTra8juTlLqMJQm8vMoP8Vu5a7fcJmHKwfRZ5+0TCVvBDwcElVhOPk/xiA6vKpMMecW1nG7Ctnv5HdEHwpVZLpFpj7lWxz98F3LhxO3aFSfMwFS9X9N3BlrAdpZk4qDdgUvtl4jYZqEYqFhGEunrdSLK3TZwyijsh0xD4P9N0abUcgsY+zjj1AnL8WPoN7ac6FwLIb3TKxN9CyDJhhXQIOZFFMaRRblyiUn9pq+BPb5IDdha0c3585A+VK984p89mjeIlHEONTKu5GZTfHFqav5zzSMGU8wkLbSpak+6nUm4h0lDf0YbaXv4rX1uoJnxsIQ+o/DyZlEqECTuAcqNlby1eRlYxhPuEZ7f5logbZvNJhQJtuj+OTat+Nj1F5II1G9IyF8Wks9t5vx7Pj+Z32f0K8LqLIdEsH8ePRznMEAYDsCohRpZHuCZ+d378Of+s6waZvu2QIwtW3vKbEoPAu8U
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9589bed0-4024-48c2-0a2d-08d82812249a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 16:22:46.3354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsA895igr/J592GWslyLVYBHlrkO2vhVsPGFxQjk3+jtq9Y0jRpvDNepJOao4yJfsLVKIrkkrlnKy5HEemJm4o4nX7fTh+fiZz4PzX89Wz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Received-SPF: pass client-ip=40.107.20.116;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:22:47
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

We've faced crash bug, which is reproducing on master branch as well.
The case is described in 01, where fix is suggested.
New iotest in 02 crashes without that fix.

v3: resend for convenience, as all preparatory patches are merged.
01-02: add Eric's r-b and t-b marks

====

This is a crash-fix, so it would be good to fix in 5.1. Still neither
Eric nor I are sure in patch 01: is AIO_WAIT_WHILE used correctly?

====

Side note: this AIO_WAIT_WHILE may be long, if nbd reconnect is enabled
and connection failed recently. Still it's another story: I think we
actually should disable reconnect in bdrv_close, before drain.

Vladimir Sementsov-Ogievskiy (2):
  nbd: make nbd_export_close_all() synchronous
  iotests: test shutdown when bitmap is exported through NBD

 nbd/server.c               |  8 +++++
 tests/qemu-iotests/299     | 65 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/299.out | 10 ++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 tests/qemu-iotests/299
 create mode 100644 tests/qemu-iotests/299.out

-- 
2.21.0


