Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17721C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C15206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="rmWwDTP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C15206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgY0-00022D-Hd
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAgMk-0005hb-DU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:27 -0400
Received: from mail-eopbgr60111.outbound.protection.outlook.com
 ([40.107.6.111]:2560 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAgMg-0004EC-Uz
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH3/H8hiQpnXVJgTW65wca7H/NeehAiMV5y2URaSdAYgz5viHvE/vdEWhM1YETFzukelFc1Q4+5qLTKueT69kmuIYrEwy8CysLSF9+Zq9ebTr6zrh6q4B7Tj/Jjxa6LMeGgf4prkkvy9P+szEeg0iZtbQs+cOBPlct3JVdJ8gibTFpqHsrKvndiQWOY+3DFqkR4uuZ985au+hmjWwsScPD8vDyxsk+jUYO+TMknrr49nI/IuzhC/6pLcUkmx54bet3DbcvXu0q26+bjnzqsjWCzJQOiEbZrAOtc3RmJWeqfD/rWFmOGz7BNkowsTOy682AZmzg7IJdqjKl7pJyb3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izouUSYC054Zn1AYVhTaLft6Ua2Yx8+292SR2HN88k=;
 b=MvvUHpR91d8nDsffd3Cc9T9VuXXLnIosm+zhboK7tdjbuZqRAzLYX3DIAzn9CkWi8EA7tdhiAsKRHSwV8k6cjx3EKWxBAZdNKh666ij0Uw1RhFaydLMK691jp6FknS5VOgAOBbCRwP6f7HyLwXEyc7axWkrR/N+40KH33MWMNc5LwSjPZGjB7AAEYRqUDj4nlEC1Mlu1qoEuJUu6hO7+gRuc/qKLAXubSQ1ysYxeLoaFESP672Jnovw1WpRzBNyZffib5GVhfA4vqEf2lIZPQmBJAhWyv5aMaMDQkAIrPplOezIvqKo9SDFAFXNFQTumhfxuomhDTZ5OWpQ542duHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0izouUSYC054Zn1AYVhTaLft6Ua2Yx8+292SR2HN88k=;
 b=rmWwDTP3uaELNsE0efZD/wbAC2v9u8u+yZPa8mlZUde/NYJivjUcBr/2pq/K6N1UFY+EiagtCvWgDUcsB3EttnY2BuKhI9XoS70V7egTrvab+ybZpkFaGuCMCiJgI/4MJmI+DiNkDGtWw/e+zESkVscpYUAg2lg6bGd9+AwyLtQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR0301MB2253.eurprd03.prod.outlook.com (2603:10a6:800:27::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 21:20:19 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Tue, 25 Aug 2020
 21:20:19 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] linux-user: Introducing support for 'recvmmsg_time64()'
Date: Tue, 25 Aug 2020 23:20:03 +0200
Message-Id: <20200825212005.35982-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::14) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.240) by
 ZR0P278CA0045.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 21:20:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 737b13d7-05c8-4d41-8eb2-08d8493cab1e
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0301MB2253F561E78F531A40374309EB570@VI1PR0301MB2253.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByOi/2eg9gGAel3pDSpetI7ebhfDbzfaCoXSnYs5aDBEgWcqyii94BMFBxtrE4ONuc42+2UOTRb82mhSBDIcCfI1w8DsZ/HVftWT907KqWsA9XTRCHcUXZXOPqKxyjpts5WFX9r/k9MUVopJb6RvaiLoDBmECFT46UWX6vRJjq1/3vbhm8cfvRoTZhayuGD+XSBB4knuNsSohSM1vFwVLPsKQQWKqVqUFdJg9pLI22LcWQ5ZoHMjsPBxsIU40V7GmyZ5fMN+Yr+/WFrPegRgJLABnCu/XV4AIC1qcpA0RsO/BqLULABpvRozp6fI/4mTluBtLhOc6oeiXWS4iAGS5nh8zaizqZgCKex6xXsXaNe7qq5KCTuM6940LNV1OJUx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(366004)(39830400003)(136003)(376002)(396003)(4744005)(66476007)(86362001)(16526019)(66556008)(107886003)(1076003)(8936002)(186003)(2616005)(956004)(6512007)(26005)(6916009)(5660300002)(83380400001)(4326008)(316002)(66946007)(52116002)(478600001)(6486002)(2906002)(54906003)(36756003)(6666004)(8676002)(6506007)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: b9NviBA5L8Dte7xJPez7jaTiTZwJEmz60Ock9cu8zTF1g1fsddssknwrobk7JXqYq8fyQi0h3hUhuGVPuuR6XnpT1Xxf0KBmRbSp8PgIlNPH2w77+g9ooJP/rI4oIrOhZ4LPYL3mChqrfXJIThCuQtcV6ArIk9ye37tSMxI4MrKclVqn8A+kPzbsBHzRB/Un/o7u4MJhrcq31ar21sJi7OQhR0axWL+hqYJ+v7LZyO+unANEquxRx4LTe98Hzr4HVGWBPkYjczQuIvawQ/Jy/RKBfXzi+NbQp3KsGrC8PLBzAaK0GR39R5fdchz3gtXtXjBtf1matSwnbAjDbRJ7Ge7KX2qHkWoRkTzHVEVtHvSuM7bVxbhnI3UZW0znFx7iQ3sqgCqyU8x+ynaNTiHad0yzqmtSggg1c6OQ6KotpM3QTGxsMl5mVDH+2t6vCWvixH87zFEp89X3d+sFbBwl9bsMCNxzerUVrfVjJAiCCZUR0XZlYkbO/JxmfQyizwsCflYo3x19XTqiIf+ob0SOidw86za85ebE+njbGRKSNK3txoROGRkOYy2i3McBInq8YZc9HpSICp0o3nDiaByj6SoH6t+PrsEtHbU5/YQWTiJBtsoP25WFUV70+a7KQd/LTdxtI9SBdtn7Jc9r1VFMSg==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737b13d7-05c8-4d41-8eb2-08d8493cab1e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 21:20:19.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MP+t0ctlbM+DeDz+zWdK1Fy5xYfNMTbG4fwpSiMWABfx0b3s9Fx4adIXSTimtoOO9umvym5z5jwqA3MMWfT3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2253
Received-SPF: pass client-ip=40.107.6.111;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 17:20:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch introduces functionality for 'recvmmsg_time64()' which
is a year 2038 safe variant of 'recvmmsg()'. This new time64 syscall
is introduced in series of two patches rather than in one patch
because a little modification was needed before the syscall could
be introduced properly.

The first patch in the series introduces a little fix in
the implementation of 'recvmmsg()' that introduces the timeout
argument which is of type 'struct timespec' for which the
separate time64 variant is added.

The second patch in the series introduces the implementation
of 'recvmmsg_time64()'.

Testing method:

    The implementation was tested using existing tests from
    the LTP test suite which was build inside a chroot.

Filip Bozuta (2):
  linux-user: Modify 'recvmmsg()' implementation
  linux-user: Add support for 'recvmmsg_time64()'

 linux-user/syscall.c | 56 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

-- 
2.25.1


