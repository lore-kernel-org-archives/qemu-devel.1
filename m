Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1561AC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA872074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WdJJAzc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA872074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8eX-0001qn-Tw
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bL-0004M2-6v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bI-0005lQ-W2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:38 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:65454 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bF-0005iB-5H; Thu, 30 Apr 2020 08:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RodcuL3f1Q8gcNQ8UfS95eSBpPIhRYGRJlsc965YVDvtn7N+6ediBz715z4ZUjigxPI6PpXU1WdAKPSeCf6mDBWWEyij9C6ddEdXpINL9DJTphfnoBcFA/pQSoWaFvKE3882iLgTt/u2zWQxn+rcSPO1nrE7SjjGH6iPjHgoLYJVnjUX7qztJwNnaEtCmRAA/F0VGF1R9UmoZzyAh42i0b6nE+LvC2ZH2w5iuekVhcSHdOn1jxEdgECp20kwG+o6rz/WfIRB92tSP/yvSstzUxhK+fthiyEDTVWr/tgT7NPK+zOzQll6G36kFaVjtJE0VjB99DN0l4AjNGwkMhZQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL5eP93RdeHAZIU5R6fyFOw4LwegxRo1jhvKPPme9oU=;
 b=mam6ivGieyv/FZdM9CpCkO4URxOlBNjhU6Tmz3jU+oq91VK+g4NKe2moDoYuYH8Er1UMYa/RxolGvc5KVNwEk9uu4TZRtADkDrZLxPsZy30PjsQ9tjgo99iNdfX8UMK8WmgDNX0/6PKXZ0LXWe05L16ZWpVaCsTqhbaS8z3sUp9cc66s6g2ciLL4eoYLTQ/CW/Guc3bQSadcG8Afek5dEaKEDk54Efc1GkRr9cklufxJFcfJwBfrICPtPqqznNfJJek9Ge2OBfZr9jkTTvs4H6C48B6kRDXtAUBPiYLOscfl/ER9RLRRC74XcuzpgcHs3HSPfIH0JcRXKCet7lkDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL5eP93RdeHAZIU5R6fyFOw4LwegxRo1jhvKPPme9oU=;
 b=WdJJAzc5yuK9gdKBQT0/3R6f18VXiXV+P7P1/KLdCgoOvIGN0JGlgMtUh1luImO9HMAVhIMaXR1WiVZ+xv5M7CEaTXQpEnw4rig7HDRcU+YDizeQIYyT23zICOsZh9uGOU5F+VbUQcbEhu8QYR9jAG+5lfbLjahH6NyoSwSHRKw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 12:47:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/8] iotests skipping
Date: Thu, 30 Apr 2020 15:47:05 +0300
Message-Id: <20200430124713.3067-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
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
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:28 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7990a760-e1d3-4c48-8a25-08d7ed04a486
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544829CCC892C444B32C6BBBC1AA0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(6512007)(36756003)(4326008)(186003)(478600001)(8936002)(52116002)(6486002)(86362001)(26005)(1076003)(107886003)(16526019)(6666004)(316002)(6506007)(2906002)(8676002)(6916009)(956004)(5660300002)(66556008)(2616005)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+SMZPUxDd6wEFMAhvVaRUfntvSr3lSIn2XKg9MxtmtFEk/RKy8LXx4YVVOww1PZznQQnOxu9Gw/3sCit346fOs5SRdtzj9lFMt8zxLyao/coQE3sYzkcfdwsHf0rif/cr7IcsKDwi31KhvNn9UzXwJ1RElP0yFpgxJkmmIB8Dh6gvEut93wy7fSFGcK3N4Dbge5WPubxVOtKYAoYbAmwbCMu0uVu88nrSt4udes3toSpN3rIlJx4Sn+8V2FFCLqeq6Sf3rzLBSlgRnAGPzjLGQ2+ZqS0mfBggTdiMetM/ETCCT/CPKbi8cROXbN8F6lI6ONR1lM+lVyMwOhbU0u0//EdmwrgK7F+Qvs15bo7LbLOKBrIOYlx2AgIp8EYyen8aC+M1MpF8fApS2wROgVZL8ayXt4Vvnd2dnQ3Z6VtMIUtbePW5QxI+drim7GYi/a
X-MS-Exchange-AntiSpam-MessageData: PZ0QY8bIxgqIYhp1F7jgakAYwMIYN8iV+fbKZbIHZMDWYWH62ryJnINByHLayNBQFUN28esoT0UGZNnbeaqApZ2HbnodHFx9Brq/9ygTiXBD467dgHO4wf7ja/WWEeS+wVo4+OKZ0FYL7rk3otyDg5wYy1vkMISPowN2mXgoOHkILgRATVIPcgNUVML4ojRMq3Qv3+RAs7GurCnCVUG0WCKOgPCm/soqz1s9iwsfsGQcY5MFv2ghgDFhGFdTuk7YY3SucLWnEnBvQQ4qc1I3J01hTE5CRp7Pd6caSsk4pvXttuT22/7ZkM2xEwDivvI5AMcRR1VHNeaSED478QskfwVVuDQLXwogIEeDN1e8vdqgAriuZmgUUD5xeW8c5wMichFZlQc8flS7N3qvzV6HwdoImCP4PX9cQe4xFpSscL93avfkqsJPn2d6gJbpmowXm6a9cnXbqk/Q02xXcVTsp6AQrCiz5QabgzF4rODQCZkw/plmUOGAe1njA65Cs9zAuWEcbUOTp3Y0RkVNnLpSUpzsSZT6mCrP2ln7iCWGIK2Zisbrjpnq3uxbnZBLWrmT2RjEUivaBhnzxcVYE3WnQ61MOsfJVkMeL6T6b4Rdl6tkOmVHekbIi57mhCusxQsfie+92WjiVsJpe49El3yQTfYOg2CWDreiiPglwEWddmrOaGPXSWenJNqW9Joio+xQ0XeZaEZDA9oYLO2rXj25nuUiYWMOAE8ayZ6FuiYHr2D3gXK7f1MfGVUIYvVeQ1xNbjDX+UdB9FEDscpDYY/5ON3JGakOv86ezb/TcHOuWr4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7990a760-e1d3-4c48-8a25-08d7ed04a486
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:29.3879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xew7gR6xkBb77Gx9iJlSHpjc8sH6QRPEXSoLS6IFzwd4BtiA1sJIutX8lfXJi7uX+etgRogC8AZbkh3eqquB8lVBEVtv/8P3QjhW9LSU7q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.117
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

Hi all!

This series adds a bit more support for iotests skipping due to format
whitelisting. Not pretend to be something complete. It just lay in its
folder I don't know how much time, I forgot to send it.

Still, now I've rebased it on master, let's take them, they are useful.

Vladimir Sementsov-Ogievskiy (8):
  iotests: handle tmpfs
  iotests/082: require bochs
  iotests/148: use skip_if_unsupported
  iotests/041: drop self.assert_no_active_block_jobs()
  iotests/055: refactor compressed backup to vmdk
  iotests/055: skip vmdk target tests if vmdk is not whitelisted
  iotests/109: mark required formats as required to support whitelisting
  iotests/113: mark bochs as required to support whitelisting

 tests/qemu-iotests/041       |  8 ----
 tests/qemu-iotests/055       | 74 ++++++++++++++++++++----------------
 tests/qemu-iotests/055.out   |  4 +-
 tests/qemu-iotests/082       |  1 +
 tests/qemu-iotests/091       |  2 +-
 tests/qemu-iotests/109       |  1 +
 tests/qemu-iotests/113       |  4 +-
 tests/qemu-iotests/148       |  1 +
 tests/qemu-iotests/common.rc | 37 +++++++++++++++++-
 9 files changed, 84 insertions(+), 48 deletions(-)

-- 
2.21.0


