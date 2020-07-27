Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52291C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E56206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="mavECuBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E56206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01Ez-0005ZV-Dc
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k01E5-0004cS-Im
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:25 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com
 ([40.107.20.106]:9642 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k01E3-0007B7-Ur
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5W5qgFW5+rMANZq6ZfwvB01HP73rEHWl/cYmFHh9GH2YJIXRou3/K9ykamcsk8ZtHho656p/tylEEEh2CJMRzI74fCd5FWaSgm26uxQY0I6HZ/CEvZDQ8kHaeObuSgEOCZ31U/TnI3zH3UPqaYN2m//8nEN6AJTYshInw27/2sA28c+SnWHTDbHAz3mvOkgGtTHgc8VSR0W/xRLcrTuuuxW8bjhkKUScHDTfFLl7PCWTj8aR46TkL6VwBxFqaarMwZ02hTm4Y6GZUP19LyBfzTIDftLwW0nginIn9FuwmLLUZJYYjfTtHd+xhS3FRV67tFoweKU1MaX+bBmwU09xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Sz7q5Gchgl8z6/5/JtDO8NQxWmyWJRRDMU4VkD5bQ=;
 b=Vwyo8zCJCDKZ5GI27YSLX3jwFHV/uY6z0lkGqY7E9+owymKLSL+X4iyIQ2OpM1i0DXykVSvpc5sLFY0OB0dtvZNhWMqvL0ygW57J/cuFlnYfseec+7m3bcMUFG2LSk7Sy9Z2C2xUgeYKdHoBh5z/LtreNpbBPSG06tzviML+OES/W16gksf4EHMg5kBNPvdhfHxiKLjO9zLTmubEJS61OivK3tpw/Po3pTFNS9vGnbIo41kkQw+uMuo08u7fKI0Nf/L1CpJMVvg5rBF9mdxeimp6+65EPCprBL3n7jAs4BT8f/87LZC1e2XwNd7i59hdv6ChlUQOUg0kI0n59+oyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Sz7q5Gchgl8z6/5/JtDO8NQxWmyWJRRDMU4VkD5bQ=;
 b=mavECuBTqV5EoA1oB5l4T10BtvEShmvFvZy258/0hPqbe9srkq6aNAo9abwrL1TW1MqZ5eCG+9Go3oy5teqCxOJfcDFM3KYJRe2HX6jcw/qB6CxcoT6ln10cMtH1kzB2cOHvm8kFzo5Erf1+9jNTnVs5WXsD/aVvIfWBwZrWG/Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3509.eurprd03.prod.outlook.com (2603:10a6:209:2f::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 11:23:21 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 11:23:21 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Introducing functionality for a group of 4 time64
 syscalls
Date: Mon, 27 Jul 2020 13:23:05 +0200
Message-Id: <20200727112307.343608-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::8) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.240) by
 ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 11:23:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ed82ae-9caa-435d-611b-08d8321f77be
X-MS-TrafficTypeDiagnostic: AM6PR03MB3509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB35099DA4C66C73ED334FEB8CEB720@AM6PR03MB3509.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOtpwwwvA3AHUoKxkGzqiWBoh6IxOZF6849015t9WklWE8eXNzWzqML7gJpxvBps/+IO75VgRrjvFmbtPMZfN7xtLGqTVYENAkNpHjzB5sORhF58CaBnHZfCxi85xe2yvIY0Z9g6KRUzzDmBWg+1vkxHFUgfNe6O0xhcxlgb3cKAj/VRxYmAArg5DVCBCV/AUncALrgllQD9nH6zILu8lb7ETaRh55CJmiHfG7TuGvJqSkOXG2VAT02O8pKdrdfqYgZeFQqvdyfl5U9dq0hF6s4FWsbyOFaPhToPDdC2suVUwZi9O0M01hU+0753Tc/NvgfWtaEO0UHsfBTjtddQxDY1FF7U5GKadtYb0LZVJYFT4u48rzwUxuQ+ywGfiBwZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(396003)(366004)(39830400003)(346002)(6506007)(83380400001)(107886003)(8936002)(86362001)(69590400007)(66476007)(8676002)(52116002)(66556008)(36756003)(6486002)(5660300002)(1076003)(956004)(2616005)(508600001)(6916009)(26005)(316002)(4326008)(186003)(2906002)(6512007)(16526019)(66946007)(6666004)(54906003)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: urUDD0Ww1EFwWre2ySqlvh/666rQon0yBna2Akr52Kyc8A5cehDXcD3bHwFxS7iYbapCDom9XV7UxNcoLUvKBgdxPK5482rQ5ZqqC4NfYMe+AdXRghJmaY1jYW1YKGfRGOXWyEKrhvxCksGWyIG5md/wQ5+aZVLwE+1g+Y1QqNGVrWiuRuNe6aTs87fJFMKQc9AANgArhbTrYqXybn68BQ8U6wFWPYReO1241b21VYzDXGR77lIjyyzrtScJy8nc4pGE5MbIcX5jJ9g3uKREB2TKbGVaSKTU/C9Gqlm62n4wFxv865nBBK9f0+kf96ClzsgK9ArOFbM0Ls1GXtZQJ1+Z+z9jx9Ib8Ifvcqs6LcBbp1LJLTwsDpws962JQ5XatnPHRAW77ZACME0HVrKYRYp8TKj6tovyBSsLyxt8qyyEg0eng7CJs01i/rlMMrwttO3Bp9IlVIGCdm+nTA1fJ1MEgGThZJMclij99oTLbKA=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ed82ae-9caa-435d-611b-08d8321f77be
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 11:23:20.9524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfrRNcNQvqFcAzhC2jVshjv7z4yqgkNW3rGv3qPwrU/565tVDBTe5ifLYV1TWnxb/rOReng2kpYi4crIjPllWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3509
Received-SPF: pass client-ip=40.107.20.106;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 07:23:22
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

This two patch series introduces functionality for a group
of 4 2038 safe syscalls.

The list of implemented syscalls and implementation details
can be found in the patch commit messages.

Testing method:

    The implementation of the implemented syscalls was tested
    using already existing tests from LTP test suite which
    was built inside chroot.

*v2:
    -Added check for 'clock_nanosleep_time64()' which returns
     '-TARGET_EFAULT' if conversion of 'struct timespec64'
     between host and target fails

    -Removed unnecesary special errno handling for 'PPC'

Filip Bozuta (2):
  linux-user: Add support for two 'clock_nanosleep_time64()' and
    'clock_adjtime64()'
  linux-user: Add support for 'rt_sigtimedwait_time64()' and
    'sched_rr_get_interval_time64()'

 linux-user/syscall.c      | 192 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  31 ++++++
 2 files changed, 221 insertions(+), 2 deletions(-)

-- 
2.25.1


