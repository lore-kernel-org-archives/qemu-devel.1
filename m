Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE83C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB38E206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="MPipzm5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB38E206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6ft-0002Ql-0I
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UL-0000Qg-Dg
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:49 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com
 ([40.107.20.98]:20705 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UJ-0000f1-3E
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2uAMxaGH/cxftezCxVKdC1G2Z0dkdB9+6xahOa99Vfnlkke4qmh2YAYvdeLmxMNFSomfraVY9HMCTiDOAbpPlbMgoeUxdB1IKtnbzYPOMyds1mGNLWODaaQevs8w4O1LDdZlstOge2KTYYoTKD0lVhb3FzuKe0Bb73Mo4uglSvMx7BXEVxC3ycpBlYsxCuVMmSpWyAMxD21Vq0xYkIGbjBkF7Twd7WMPP+YYOxmFXYVSQpZEAUMHQuYaZs8+PY4jNpmIXAM1WEJDOm5CTQ+IWACEKHTyOjef+T5VFQxru8NNLmZEdZCSb8ND+gPbUeINMODiBRVUWTCVL4pr4Jnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXiVoXd7EWS+6kkRgluOHzIPh2UVxT6GxUsKB6G9vaw=;
 b=WV/Vriw0O1HZwHJgFGdE2KtniwMB6PIXqmDImy3foSb1PW8KaTjeRtVmh8N+pF/DvZTCCGeBZdmLtxhmTVcqKZZ0dn4dZ+BgWO+iUm0VwobNzr+6XexXkbtmI+dGTG2VL4rauCfZA6jhbOq11I/HalIOSlKBeh4FWX0yGAjG6rYOEnjskUgaBo+s8zws5r0018PrEsejerQ+5sIjrtn8DOD3EvK1LKBqN/zZ0a2B+Q7dcth+boGMyn7xee+igI3AweM9eOGSiwqpQLPXOZjaSgvzOEpcmB9IX0DhIqPqIABYL4JvYdWOZuxx6xSV0Q1ARHvIwlLIkhmN9Jxk06k+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXiVoXd7EWS+6kkRgluOHzIPh2UVxT6GxUsKB6G9vaw=;
 b=MPipzm5DoWFCb3HpWZ0xRKyMZqDe2X3rukrRRfjkGFq1IrssyozL8RLajs9sDmius+cMs9I5c6ESlcXEAjS2SW7W9UbWd33Vu9O6kjr/0pvvO4rOMRUMZuKkK/Qi94fQ0lmgpulO0DbukY6BUW7i0mQl0fzcpRFAR7MYyPhTDYU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4022.eurprd03.prod.outlook.com (2603:10a6:20b:22::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 11:53:43 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 11:53:43 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] Add strace support for printing arguments of selected
 syscalls
Date: Tue,  2 Jun 2020 13:53:26 +0200
Message-Id: <20200602115331.1659-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 11:53:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af26a941-b453-4d4c-83e2-08d806eb998f
X-MS-TrafficTypeDiagnostic: AM6PR03MB4022:
X-Microsoft-Antispam-PRVS: <AM6PR03MB40227EFAA312BDF2BA303A10EB8B0@AM6PR03MB4022.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:261;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bj7xdXEbqDlTBum9bu8vNlKdHiSkFEr2V7jM+4YRz6l3b6LBbZ/9OZSFO5QCpS8wV6QgHJKcjnh9PvJcN3/5dfbV+2oBjE2V+O29T0mB0uVr+A+P8+jKUThIXl8CcWzQU6+SBFDWdH/weYf4O151AiJHjqbA9P1jXZ0I12OnXwJvQHMYCT8b+SGiNlL3jngpPbhMXpCPrLr7itM3zm/vlSf6YJxpEqAuQerm3COK7fdSy+JpnjvZ3PFRbJDKrwjKWKee9meu9CQejfGRE2QIhCbSei7CCnPVI9PFeozYyAYF5U2ie9jW8gd9jU0+Mf2tnGo0jMCOifQBeL0l3H1Exw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(39830400003)(136003)(396003)(44832011)(956004)(2906002)(4326008)(36756003)(2616005)(86362001)(508600001)(66556008)(66476007)(7696005)(66946007)(26005)(8676002)(52116002)(6666004)(6916009)(8936002)(316002)(1076003)(5660300002)(16526019)(83380400001)(186003)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qKoQOwRUKTgRvxzH4cVCk8IA9wbZLAAW668MPdTIBWGmBv2KbKnH4TR9sj+lS0Q7c8dNXDJ7MaKUm9j8yLHYbOUsoMNTnzYflAZA0X6RIDBGI7uCXQ+xBKLY44eHm1jmVzu/qH3sZrxmRR4aDg1AqWnj2mahpHdF0+kU6a13/noiojlsuaeuNKa0lQQJv1Aj3cM3Zj273i2gIlwOr6+oGCYcJxaI3p2RV6QzXaIi6scgi7Yhc6SvK6+9hoJw/WD1QP27IdYAf/Zv22qwhlnWV/239AJ6Ld51mJZC8Z6+ru1E7pNIwxrCFzlGxEcPLEJGJprPGL0VVlgt4cdngZzGtUu1RWLxmd+EEYHjDjnkFAOaG63hLlfWrTHuDmd/Uh2M5iFpn1zAC7C0gvcZLGRV/I9FflpFzaUPESUqICtPCY5jw6qvtiV5HcsAxJ6JfQuMReJuTcHAlJwbQZQxzk6YnCX2SmJ7RlTEvImdyOqI724=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af26a941-b453-4d4c-83e2-08d806eb998f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:53:43.8494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC6vCwZ4L9dBlkrNFUebXHfv4Qim3C2eHzOOzzKGQHmKVZl2c7/lRwbrbzQu/l6fYolA9VsQub1a6+uUNc63YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4022
Received-SPF: pass client-ip=40.107.20.98;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:53:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2020 09:04:50 -0400
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This series covers strace support for printing arguments of following syscalls:

    *acct()         *lgetxattr()        *lseek()
    *fsync()        *fgetxattr()        *chown()
    *fdatasync()    *listxattr()        *lchown()
    *listen()       *llistxattr()       *fallocate()
    *getxattr()     *flistxattr()

The implementation details for strace support is described in this series patch
commit messages.

Testing method:

    Mini test programs were written that run these syscalls for different arguments.
    Those programs were compiled (sometimes using cross-compilers) for the following
    architectures:

        * Intel 64-bit (little endian) (gcc)
        * Power pc 32-bit (big endian) (powerpc-linux-gnu-gcc)
        * Power pc 64-bit (big endian) (powerpc64-linux-gnu-gcc)
        * Mips 32-bit (little endian) (mipsel-linux-gnu-gcc)
        * Mips 64-bit (little endian) (mips64el-linux-gnuabi64-gcc)

    The corresponding native programs were executed with strace, without using
    QEMU, on Intel Core i7-4790K (x86_64) host.

    All applicable compiled programs were in turn executed with "-strace"
    through QEMU and the strace printing results obtained were the same 
    ones gotten for native execution.

Filip Bozuta (5):
  linux-user: Add strace support for a group of syscalls
  linux-user: Add strace support for printing argument of syscalls used
    for extend attributes
  linux-user: Add strace support for printing arguments of lseek()
  linux-user: Add strace support for printing arguments of
    chown()/lchown()
  linux-user: Add strace support for printing arguments of fallocate()

 linux-user/strace.c    | 174 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  28 +++----
 2 files changed, 188 insertions(+), 14 deletions(-)

-- 
2.17.1


