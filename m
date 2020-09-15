Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C512BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182B320809
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dsJvoxX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEAc-0000U4-8N
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4F-0000BH-3k; Tue, 15 Sep 2020 12:44:31 -0400
Received: from mail-eopbgr70092.outbound.protection.outlook.com
 ([40.107.7.92]:52206 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4B-0007gp-NN; Tue, 15 Sep 2020 12:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZqYC9mwrrtw18FdLTwH53Rj2Zg9qzPh8Taif4dhtWweR/rx7czJF3jBwpVpjEVRKA2qJ+gTKs6PvPJdaczeT7kg6pcluKyXgmXeDf/BBZj6rS9CsSxqmPMNlMtejV0RhM2IiDKpKFiWNpOuQmNmJH7NzhWWBVkYHCeU10WUhA+HqP8jm8ZH2Pt+0TsrA9ZJH9IaaHlFwCVQavUfZ1IZrpziBARimdMhrVLVdbCG9zw4axf0ncmZxMknjKyd7Q6M3SOzsDA2r7w8X2fPXjrBiOHNTmAFufZ+fL7SQzqtWUULrFtrYcgRBLYfehTP+SWIN+Oj0tBJkPmvqi/4nzTxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys8fFbttnwyIjCF4dw/YrF9RVnjboJGLOOtAi3r3Zp0=;
 b=c51GYL1mElZ0TmXh/tJrmlJyqk+y6NbpoA3Kxde991m+G9TiTiUPH1CuKFW0t0bAmv5A91t0SoZQnPLI1GDMvSmEmVy8p0h3k+76UnWusYwKRoEbABOmk9pWNOmKD9u5fCPk0U1tRUyMhJ5vIAxdUSU9Bx4uiVHteXwixiadHJDjGorzlZmaucIVdr5G26oJUpI+jEstpCF5JnT6XAGdolgkKFM+lTDAp7ZvBYKSISUFqp//YaeNhJy08Nhv3XtwRrjJjV3OUc53kqBtjkUD0J0Nb/2IB5PbxuLRQoF/YJFJMU+bF/gUF2tS9DZud4ZhmaLJvje1xGEQCq84rptsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys8fFbttnwyIjCF4dw/YrF9RVnjboJGLOOtAi3r3Zp0=;
 b=dsJvoxX6hx9vyaocGfV4CfBCgEXQal2IEf0tOj5rXSBou4qG21KsvIa/7yboiZscDUy6kl3T+Ph3KxIO9aSM5vt87eJTgt4AqrRK7PX5RGsiGwiXfypFuax/R6QMaKNVEM7Ras0/4p11Vqa26t0hJP3baLmjq1IATAL/7odPw5c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 16:44:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 16:44:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com
Subject: [PATCH v8 0/7] coroutines: generate wrapper code
Date: Tue, 15 Sep 2020 19:44:04 +0300
Message-Id: <20200915164411.20590-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 16:44:22 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5405a8f-bf31-408b-5ba0-08d859969979
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB16522C15B1B287CB2BF1FF52C1200@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNq/LDBNpywrEGtEY+A8NcifafJLAyifHtO+9TFxR2fQ3DMwQJz0rCTf0y9BUSP3JuoV/Gm+EJwiJ6XAb1hno5bXbEqxK6Peic4uLd31eyzS9A9NiDUW10ceE3TmD9+v2mvErV52XyFebmZLjyHfI9aWHujnxdOuHEgD+aZW6eC3m6vPlKUQWHzZZI6kGHOiWh5JmDZp4XcIBqyu9Msw8ocVvrW+cyLP5Fuu8K85QMdVXSA+LbBKM/Vw0gwHW+r/hJkwyttrDjCy/Vpm/SPnTKlMTBZnIyC4vFD6Kpz8tG50P6ozuAHRk6t/zd0iCusRgA6tc5nX0lR13S+Gha8qOcXoXuaTJRYFLAFHULOk2pRs9EcISLGHq1r+R0bhM09n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(6916009)(6512007)(2906002)(83380400001)(36756003)(478600001)(1076003)(6486002)(86362001)(2616005)(956004)(8676002)(316002)(186003)(16526019)(5660300002)(66946007)(6666004)(52116002)(66476007)(8936002)(26005)(66556008)(6506007)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TxNPqCDN9/xVwa+SJz1j1I+xs8M8ceTuTpWOEk8RrrcPceNMWcFjHkPFryTkxv3PopS0xyMwpOT/5AW2in5q+KArob+ZYQ2EuBHE/f8cbDxVbLvv8wFefoZuFnnL0tFt5srFQPP7vXPRHmq2fo5HtZoIAS7CaEY0hqHDYqwV+RPCCx9+WKfcZlrb7hBpXfPP/HM0TU6ylGB0rn2YcOaVU6h5kpg3WtpnnXPkNjlO8ymUKAzotUbdJahMre7uNFXqqE053UVNMRjVsmkxXKBletSHjiSQogYH7CglXov9e7svFgdm6sd244yvHTcEwlN5fLfKAvpqxlr/1MaslWBS59ckxbhZMWPJ2+A7d/vH5FdUVh41Rg3mxoLNGOrLZV/JLq5dYORIIOnRWiSfidVwFTJQH2pf7ouwrvkb1XBVehJMOwRkCQPi/x7e/t52CbWbu/YEEKRVlFBshgT9/jUyZAAJHDAgZWlqMDagRMgHxXiu0nt6JxX+tbWT1tWv1TnrQTCuoyoABbfGb6KiduExYzLf1Ba0xDff5/TZFdTTb/Jrfbm78ndJjO4beTfVVPmtewyhhMaTuIvLcwqSPWfQZfw2cUy4BXioV5pAGVX3eD/EB98YxNbm7G3Wpwa6enuOtTa+9T4kDAL8L3x0S2LWlw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5405a8f-bf31-408b-5ba0-08d859969979
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 16:44:22.9720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOAIAsRmyCw9ym8bkqNw6YbcOeSFgFAn2sSg2/mxoCWNGKPl6P7BVb1eolftKHVyGLE3zIw7caQEcsGT+QN01C66qd0rU3H4RFydj37aQyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.7.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 12:44:24
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

Hi all!

The aim of the series is to reduce code-duplication and writing
parameters structure-packing by hand around coroutine function wrappers.

Benefits:
 - no code duplication
 - less indirection

v8:
04: - rebase on meson build
        - script interface is changed to satisfy meson custom_target
    - rename script s/coroutine-wrapper.py/block-coroutine-wrapper.py/
    - add docs/devel/block-coroutine-wrapper.rst

Vladimir Sementsov-Ogievskiy (7):
  block: return error-code from bdrv_invalidate_cache
  block/io: refactor coroutine wrappers
  block: declare some coroutine functions in block/coroutines.h
  scripts: add block-coroutine-wrapper.py
  block: generate coroutine-wrapper code
  block: drop bdrv_prwv
  block/io: refactor save/load vmstate

 docs/devel/block-coroutine-wrapper.rst |  54 ++++
 block/block-gen.h                      |  49 ++++
 block/coroutines.h                     |  65 +++++
 include/block/block.h                  |  34 ++-
 block.c                                |  97 ++-----
 block/io.c                             | 336 ++++---------------------
 tests/test-bdrv-drain.c                |   2 +-
 block/meson.build                      |   8 +
 scripts/block-coroutine-wrapper.py     | 187 ++++++++++++++
 9 files changed, 451 insertions(+), 381 deletions(-)
 create mode 100644 docs/devel/block-coroutine-wrapper.rst
 create mode 100644 block/block-gen.h
 create mode 100644 block/coroutines.h
 create mode 100755 scripts/block-coroutine-wrapper.py

-- 
2.21.3


