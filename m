Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54328C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 23:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA23206E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 23:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Y2X9ZNqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA23206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzqTD-0002YY-BX
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 19:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzqS8-0001j9-NM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 19:53:12 -0400
Received: from mail-eopbgr140134.outbound.protection.outlook.com
 ([40.107.14.134]:43294 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzqS6-0003jM-Vy
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 19:53:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWFYIQ0uLqDFlXvIQhcc70ZWGkTZZgWs6HS+reqyhirm3U7BpVhShH2QWyJZBqOizUBs75Lzqk3wlq0+gsdr1MjZ3YXCrc4o2VPuWixaU5ivomitYXyNdH0JMiepo4rXBJfjYr2HFzP5xXoztB5HYgBounMX+XJ+TBOnyrJg8HwCC+MHJ5etrn42R0Par53z3t13BLPidnEtyF9JEyZF1wLTqK/skk7JwCjLJr+F1XO6PoK3xlKP0aW/yIelW9zJZLPH3Re40efbLNnvkMipgrf0JwaqxozCFqjbDytDAsPENMfRbtlOrf1k5vZSxiY9ImURlhEEytQlEu9OnyjioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huC1qUZU5o0XWV9l9RuIhZZu4c8vwp+fARCCrDjsUrA=;
 b=mH7+maNCpMvfukdVbIgUD2qtn0O4MUn49auTC9n0Qo+GNfhbeswbNidiMfISlK81hlYACMl8JuOjlOlDMcsUyh/zxqEQD06pAgkBKR/Wx7Mb3dw932GnfJcksXGW2tvvQoasYsGcb/M9xwC8A9pbq0513Yf9PvKX8Z4UW4FgMmoesGJ9pOFXRqerjl5VgsHY2gPvGuYz6fXKSyooYE7HDTmn0RW8NYYfALtzTQ7Q9YbDodSp8xRVQVlJCAMMuM+qR+Andmf4d8wSuFHGV9w189QV5gyXdZpm8bbchKbeY7lat7b+zeZIraTfrToi8d2/2u/bogD4jhNW/lwGqMC34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huC1qUZU5o0XWV9l9RuIhZZu4c8vwp+fARCCrDjsUrA=;
 b=Y2X9ZNqzmUrKfnbedxJpqgMxZY4gUSl9eUtOM+7ou055F61ieYPiR3BwrAdpqMp/MHz+qnlSrgugpP1bKDp4CiDd+mtqpiNInpBqK40cpObMiP4swsnwlJDMP+IMIUnsLfq1kTL6/rFBkgbtzIvxV84+fIAZBSSh+fVA/wRM2YA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB2925.eurprd03.prod.outlook.com (2603:10a6:802:2e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Sun, 26 Jul
 2020 23:52:36 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3216.033; Sun, 26 Jul 2020
 23:52:36 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] linux-user: Introducing functionality for two time64
 syscalls
Date: Mon, 27 Jul 2020 01:52:19 +0200
Message-Id: <20200726235221.337529-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Sun, 26 Jul 2020 23:52:35 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a49a6643-c922-4085-2ff8-08d831bef8dc
X-MS-TrafficTypeDiagnostic: VI1PR03MB2925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB29250B80E5D2CFD0954994A1EB750@VI1PR03MB2925.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjfECs45BixD6hbZ99V/6TSFIsE9vvnIViT5etW92cduNi5hG8nGoZnJrc61+ZBX56xPqAz3VnnWeXG0OGNF+vw6KBstZvyK7cBNnDFdYGBCDCDSeT78eCpAZ5Nz9tXXs++Yln5diIxsnPqzz0nyEu3VHqRjURdqVSeC2JGDvhCcavVhiiN/i/amo7JhZv8rxyou6jYk8Gsl3XrYh4juoHTPz8p9+ascxf9bAPvmyEk6ItueiBrwpEZGtPsMytxwim7DOV/1QmDrn8XLUgh/MSZzcAj2pi3VMrV20Alqr+SRtvybsaRvNR7gHAE3uPzNgA3skmSJGer7a5dPGJ7pOJg722Uekc0J9joWaTyQPhxQkx8nf54VQw5M46jZVgwy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(366004)(136003)(396003)(346002)(1076003)(83380400001)(69590400007)(2616005)(956004)(316002)(2906002)(4744005)(54906003)(6486002)(36756003)(16526019)(4326008)(6512007)(107886003)(66556008)(66476007)(186003)(6916009)(66946007)(26005)(508600001)(6506007)(86362001)(6666004)(8676002)(52116002)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: F6uoiLGs02LmA+D1YJbf+iBZYlhMdxe7WaWw8qhzT8+8bIuNvujFc8TSP2pCvDJTKQ9GEzNkQhZjvzu6qT7cWhkj5XYiQQZgzxYnXUOF8oECI3nHQ8ttoqTaz5eiH1SHtDq0Qad/K8yifO24e6SulqJCL9bIA0rqkPhAof2mWAEtcorySCzeAI02F9ltwe4tRl6Hbhdubeoc4UouvK8MycKykwQxPWlWEV76h13xaF1FDq7/ex+yKj0L8CYi85JJZ/lbocJDidEMTS5/XK/ZGi36HbIshUZ1LE5ClLoqa618QOwncyTXUS+W9AsFYLr3nmdfzlZrL0eeAp4O+JfpQ6eqa5c08VZ7TH29EkifLvJgVTapi7kJyY7s4JcS9Yd+6QoOH7qo/NtRvB+IGvKeLQ2Q+6aLeGXVq+C/+JvLign1Z+0Hhv7ZpGuT9Vyra9+YVOKVHVTUX8Kg36t8wOgBeXM5W7X1ujhpAL1el3eUsI8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49a6643-c922-4085-2ff8-08d831bef8dc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2020 23:52:36.5000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x+1O+4CAsA1S5odO+tRviVYF0pfxAnnKhTbKWPxlqr/vdfe2Fg+a8mJJkebQw+KimMcKtCWItZc/fhp/l8Vbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB2925
Received-SPF: pass client-ip=40.107.14.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 19:53:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This two patch series introduces functionality for two year
2038 safe syscalls.

The first patch introduces a little correction for already
implemented normal (32-bit) variants of implemented syscalls.

The second patch introduces the implementation of the
syscalls.

Testing method:

    The implementation of the implemented syscalls was tested
    using recently added time64 test in the LTP test suite.

Filip Bozuta (2):
  linux-user: Fix 'mq_timedsend()' and 'mq_timedreceive()'
  linux-user: Add support for 'mq_timedsend_time64()' and
    'mq_timedreceive_time64()'

 linux-user/syscall.c | 74 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 7 deletions(-)

-- 
2.25.1


