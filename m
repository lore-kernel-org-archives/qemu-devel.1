Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FEAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFA620656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="w8lohUUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFA620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAL2k-0008I0-Qn
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAL0G-0005JJ-GH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:31:48 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
 ([40.107.1.128]:39578 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAL0E-0003by-VR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:31:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFD8KUXFwN7LCuFBlBWV8aWyaaHUivtMMcNxFhZagXe9ZIsVyByDONEB7wc6Z7yS79wNSu0N5DgYl3YiEgR2MSJlHHdkkEv4bh8v/YTQgAsSX2A0o9S4mRTE/OYQqILUyChY3osgfM+aor2GcLBgTPdbOnaYYFN1Y92kD0P5hnXWTKn5jnru82cxt3+wsR8hkPe28mZuM4p2TlkI/OjGLoEkWdLoUvht/7DvQi74/6IuQzeS5ewK8+Yu170Tmbq1R6duSV/K5Mwr+P6HUSaVBb2da4ccVtsThKSzp0tUM9BYl/1GyIGUxMC6A37nAZ3UBmVwiTpb1Rs2PSoiYxcu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBbdD5nQGnUlNVNcqZ/DZs3bPnAMcgtXPCbBcZP2TT4=;
 b=nOP3SExLxPwGrQ38AibOwhExK/Mq2YAy79g1VHFg6uO3U6nkmTndT8nJGe2wLiEiaV5CvxOrJOBiBKdAFOTBvPiaY0FMjRJZDrpz/+BLs/tAEMX+hIzG13mK/0GCWu36RJPw+VRv36cFwqgS6QQGFAzdEwGTaAtLWwH0ZDDXy4qKjQoKYF6ZypIbYt1xu/cn47Ay8N+O13OVb75bJ5kDrhO7bf0WIMQaZFtNN8Cn2sFEFh+60ypzVZrIFY2dxgr+3WFYWTYAsxqpHPdBNZCzA3elHhVmXqwnL0JUN6rYZT39quoAd6IuhIIyCVTbN6X1+DXLmQqUZdupgO9quFvhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBbdD5nQGnUlNVNcqZ/DZs3bPnAMcgtXPCbBcZP2TT4=;
 b=w8lohUUf8wWNDdxE4EWLS+hnWO+trGNIIxGZviwZ9f5u3+3PbSWgXeCiQ4ARh8+upy7g1jTFKZor5/P91r7/TZ884gOVSb3JbR6o/fOQ7n8w4iH0ArGOBUaidl+FcIYrV1MlR9tlThik5W2WZZqNadRyfDqMcUOqOxqRnxVy3Po=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4575.eurprd03.prod.outlook.com (2603:10a6:803:59::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 22:31:05 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 22:31:05 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] linux-user: Adding support for a group of 4 time64
 syscalls
Date: Tue, 25 Aug 2020 00:30:48 +0200
Message-Id: <20200824223050.92032-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 22:31:04 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a7a28fc-01c6-40e0-4419-08d8487d634e
X-MS-TrafficTypeDiagnostic: VI1PR03MB4575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB4575D49A35829B224933424DEB560@VI1PR03MB4575.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbtqsHhD27cVBS87rV4VrnA+9u1m9rbFcwQFKovx375pcHiXeZ8AH4nsaipBd0kSdDM3XKpV9Vbt+sdZPBwVg7kODAe15/tta1DY2xPHyoQfpZnTTzLsrzJEGrJsbs+EqnBcIeVmM+WFzmqr4OHHkFScy16GtnK7R7JVV0qhTcYQRaKIah1txLVwJYF+8DY9WTxKISEC0FgZcLIHnaVPcG7uufeO8UceYnG8mHLyGuTL4lbpLhAmwK21CxHIGanx0A0ToyTmnguPzE7ddqBuHH3WzJ8KuXBQbU4JNSbg2sTDqrPwzs+3QYUG2zXrOfB2P6Dpz1edUt1bXxlyqdhOvfU/CoZxbusAkM7zZ3R4NCds47gD56OZhNDtyk2e3AX+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(346002)(366004)(396003)(39830400003)(6506007)(6486002)(6916009)(83380400001)(69590400007)(2906002)(956004)(8676002)(2616005)(8936002)(26005)(478600001)(36756003)(54906003)(316002)(66556008)(66946007)(186003)(16526019)(4326008)(66476007)(6666004)(4744005)(1076003)(52116002)(86362001)(107886003)(6512007)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cGAnyy3C2qtL4vTWCPcizzz25/L5LCdPV1wv8tqXGs0H9wZwvTCbTuqUukIVMlfbQEaPhNG3Ctj/Vrt/ZR2F5Df/1GBzuDUu8CzvQmDlG8p88dWkmYRWrrbxOuJvR7yh31E34H/L1R7VS0cXImQKmMK2Wj3rw7attCp8YWfvKHO5m6zRSPHMI6e2fWGDEYDEVX7eBjpoJWL9evYZI/fFSqZa0vu0tGoMM2iH1ols03oxjJz8dGms9Kt7muc7Fo2gHx3vRHEwu6MoP3775dR/lkw3MO4LJvYwcVmlaAPJ3wxvpylEClEXkNek5XzyhIMAZv1HIivxfhbZeJtx840rQ0S3vRl1UGoiFUBFj3sAcoNOXRXwS9BNkTqwk2vX2kEtxYG/Jw+pFMmIg6Qj6TRgt2CjHJboReDomm2A8XQqfcetoF0WqAKjuoe3SXaOsrewQPm8zqFH2haTXqTkwNrNhKhRqm4fr29N0DzPhx0fJ7O6AaUv+nneID3WeZpT23/awpgTMTeFFB9p9cXCUdn/l9xWmdd+CwI835oPQoPoVI4VHB8oA/FxCcwvepvnM4Caf4Ujw0fcYwqV2XYiG6aeB9LRlUTMqYBTDrf7GyFkH5PEax4csZOL5Bk10Ie4HmmkKj+wnMxyQKCyQv8xxCA9Hw==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7a28fc-01c6-40e0-4419-08d8487d634e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 22:31:04.8639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UY3YQ2yTXMtoUtVPzY/XvnP1eeXLVOcMCvgNQSj5I8ixf6T72r+bQ6zE6TZdZyN23Rl85tXvpcZ5FCEPY+FZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4575
Received-SPF: pass client-ip=40.107.1.128;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 18:31:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This two patch series introduces functionality for following
Year 2038 safe syscalls:

--Introduced in first patch--
*ppoll_time64()
*pselect6_time64()

--Introduced in second patch--
*utimensat_time64()
*semtimedop_time64()

Testing notes:

   The implementations of these time64 syscalls was tested
   using tests from the LTP test suite which was built inside
   a chroot.

v2:

   -Moved code of 'ppoll()' and 'pselect6()' to a separate
    function
   -Changed 'time64' from 'int' to 'bool'

Filip Bozuta (2):
  linux-user: Add support for ppoll_time64() and pselect6_time64()
  linux-user: Add support for utimensat_time64() and semtimedop_time64()

 linux-user/syscall.c | 520 +++++++++++++++++++++++++------------------
 1 file changed, 300 insertions(+), 220 deletions(-)

-- 
2.25.1


