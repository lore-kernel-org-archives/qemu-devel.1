Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60290C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3459F206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TeFBoJNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3459F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFnJ-0005c6-FZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtFmg-0005D0-KJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:31:10 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:33229 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtFmd-0003TB-9z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:31:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaVn1qPerBrQF3GSW3vFXOuq3gMSUmxsq38WHHp2ZpwtZVarTdHP1gyPinUXZ29Inh+TJlu6CSRt2yc+xpdxIDyfwSHhD5NosX0r2J0iwIEwAAXy/lrqK+8vOqEGVT30PTY/nwDqpnA7/qbmvhISqFRCfK9tjtn7O4nODoRnubNRujbozj5kTkLjatDDQrm0hLNFuJK6ndciv/2Z1mBAcXguiz6OLysb2H0SEdpj6HmB/Whyy+PcN87cEZFIm3hnE48eL9UVynyuRxGKRuV2zRI9oDmPk0+Mu65+ydlnBCuOO2UQtl/KSMMYP4zp+9Y1g37Z1TFarp8QlqcVmBY9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR0daKa29eUaIH7yu2YOHzp9BZH+ZpqaUqeZconu/Kk=;
 b=VuPCyNEQMW3BBVTIsVnrlt99QcU93j2vkPMqzK8BJ0bx2zGs2ywkeh2zy+nwjch2gyTecYQKXsN262C6k1Buj10msFfTLHkxtI3VaYRoN2Ng2a4dEed0G2LD80DOJQuWNfQQDY2rGBfwR4Tns2vSLndLDjfy3Uc2Yd7AaVfIcYsHMpjoKrsAvR8vh4LyAzX7gqa8PoDSXcszYgpA6gFbpkNpXEI0qGR1RYEAwZYIeNZfqgGiiEralBW/wLa8jWwlBzMHN2z+LZfBHs3tbqnxCbDHxw3JxkvBUnNlWznrFbSf4UGENpcJHCLHuh1ycGWS7ynWMwvPPEFlr+X5/2ANPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR0daKa29eUaIH7yu2YOHzp9BZH+ZpqaUqeZconu/Kk=;
 b=TeFBoJNr74XCdlDosjINY1/Waog1UdYL5899uF35z3aS+l4Df+AfmFXGrioFfd0u9W1nyp9NTfJb7R0LZAtrnrZrqZdSFiGz0ZhUZQ88kH5sYGKMwyDfcrAhQRpTjY7+wpDS2gowZATVbOGRXZXfcHi42Fo71ppMhI5HN9OPEww=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 19:16:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 19:15:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] keepalive default
Date: Wed,  8 Jul 2020 22:15:37 +0300
Message-Id: <20200708191540.28455-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:208:55::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.17) by
 AM0PR04CA0123.eurprd04.prod.outlook.com (2603:10a6:208:55::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 19:15:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92c05d76-2256-4350-2624-08d82373569a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB40701D5BAF5494FDEF06F571C1670@AM6PR08MB4070.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3ZEB9XcBTXstgmnBJ2qolWm4DB4AldsWyjaBiUMYcxweYhITiIj2WsTuF8TEnezkwiDNg26bb9VDoRAsVts9PEXZ/X2ZcsUZpVFUjEvMiCXS/X9hoD5KVMD5JxlYgpNSBddBsDnDUHgi5FX+cNX8UhJYE7vGDaDpIgNJ6WQyh6B5Byq/5bML6Rn3GSsY98v6WgTZEYE8bc2oW0JMpCcOBQ6qNpn130vhLRv14cMobB920TVTf/myjWlL/+DwN8xmA8S0kzncyS184dmePATSweXMOXMG5R/t2BehXr2UiNqs7qQIbYbaTvCDG0TNJzFzn9zjkQqYfdzheHLis8TWdg9EVqZGinEQZcIGBAcjrG3BOSRLis9+nzINye3DcNV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39850400004)(366004)(376002)(346002)(186003)(16526019)(86362001)(1076003)(6506007)(956004)(69590400007)(4744005)(26005)(6666004)(6486002)(5660300002)(316002)(52116002)(66476007)(66556008)(478600001)(4326008)(66946007)(8676002)(36756003)(8936002)(6512007)(2616005)(83380400001)(2906002)(6916009)(107886003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rAEhItFEd8Bm4Mtd5e+H8FvGfjliG93Igs8YCWMwrkrtqAH9ORJOfXPDY1jPBDToXx807KAkBEYOtK13O4km5/yRwwhmaoEuhXqKjEmau6vkhaTdU0vyn6Y+DW0zJBOxCbj1eX+5/3TF1ZTZp1s6FctlfJ96426/FI4HRBk0VkJOelyoNTPiPXX4zIDqsoY8lJwZP5Sdsu/LSNoxAHBNvD+KocTs48Zmz7b4KXyVCi2T23pnselyCBYn4y/yxl6Xus3EaLQEybA2jYuNRH2q4IldQaFpEiKlqmFXNnEcx9WdtYY35+IbG1T5MMpdTpYmcs2pGu7XRgzWoVGWDQ+Rh0D4pvfwWKBbOR6LzemT6g+szE0K1lIyNZox64ikd+Rt3AjukPY/aVdW90yxjSSsiE7kfe2p26MpDhE011pY4ev/SBV4GApyLlKqnECYfFVlARfuqIqCL3bD2L5ikUNxYfsr9QrlDUTSPGxlXHQwe1Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c05d76-2256-4350-2624-08d82373569a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 19:15:55.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbUQgIQb/J3Efgu37h+VkMh6sj23d+6tUTzGefQWgOqd1C6NfeVmG73Mu+GJ+FtLHfcbj+YOuUdq/5ZF+62VCT/UMemEQBRYGwEABI8sG0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:31:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, armbru@redhat.com,
 kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

We understood, that keepalive is almost superfluous with default 2 hours
in /proc/tcp_keepalive_time. Forcing user to setup keepalive for the
whole system doesn't seem right, better setup it per-socket.

These series suggests to set some defaults for keepalive settings as
well as set keepalive itself by default.

keepalive helps to not hang on io other side is down.

Vladimir Sementsov-Ogievskiy (2):
  sockets: keep-alive settings
  util/qemu-sockets: make keep-alive enabled by default

 qapi/sockets.json   | 33 +++++++++++++++++-
 util/qemu-sockets.c | 81 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 102 insertions(+), 12 deletions(-)

-- 
2.21.0


