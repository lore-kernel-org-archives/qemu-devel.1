Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E321C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B51920767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="wPfKWIgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B51920767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl91K-0008EO-GU
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90L-0006q8-Sn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:45 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com
 ([40.107.20.113]:30304 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90J-0002xB-K7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Q8tS6QRD3+heztD2rcPqcCV3ZEX/l/qAOk42sRJqWB0SYHpPyiqq4nTBlH/W2FTHmZURYgkI+0hwF16z/CMWl5f9r8RhCezns3wZw4UJU+DpZu4whFvjr4YgKzJaf6uNrJ83AFJRSnkj5RE54Koz/kRQLUMufNbl5WLGSrs04OXbOBczFABHRgX+kjDVK7h+rG8x23s2Cxi3GEmyWERRmlpLZGUoXvsSSO3a/sfTMBFi+Z18IthYeZo205yA/bzwfXKLlwJq+lS9QR5/zc6SS9VWqJytpwZPS4ib8cGt6rbo+Qdcnia44ayQZbSWuj14kAuFy+NNNXq8vdnRyf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91qdY0rGJ8MdG/EzuGqPeYgutMj2P6XI3XpmzSsCx2I=;
 b=Afe5TyixdoG/2bHRHAxp6g9B6rkhTOQaZvhsgNa0uf+LV7uC5ra5bn+n5P2bF/+eEh0w3BfIbA+psv1f5ibLb+0PSe6Ije9NMJSSrPjQjyEw8yy08UNj+p38e6CEQLjesUYR0uyCfPkB2FiZ7FW7CnruThgBg/NMAV0iSKnjXupYa4MgVGPONLnnCTaTD9s0ZhvwsIg+mth3mMZxvevobFdbyRXXrBLbIUBXVBLLii6cILB+1Xy6wX8+dmQQyiYJEFYQZgOowTVWZR+sfrlbyoFjMIubpz2g3ipRUJJ6fRKA7sA0mKCk6HR7+EPhWeburf8eBsBVnivjv0g3HpqGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91qdY0rGJ8MdG/EzuGqPeYgutMj2P6XI3XpmzSsCx2I=;
 b=wPfKWIgbO9syMFbWXff2qDBKQGzE5chSiA5S146nUcE9ysJ4MI+gY3XY1WSw+WZ1UNMLRdzGLjJzoulhOMwr7Cvt4o9n4VqZfUw5tIrUPJ9v2zZPIzmSaAIN2/FLgGlP/WzJDbrzFR/xo3QFf4bHju4x19/+D/psklB0IIue18U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3960.eurprd03.prod.outlook.com (2603:10a6:20b:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:39:41 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:39:41 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] Add strace support for printing arguments of selected
 syscalls
Date: Tue, 16 Jun 2020 12:39:21 +0200
Message-Id: <20200616103927.20222-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 10:39:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a94f3e3-16f6-4934-d6cb-08d811e19347
X-MS-TrafficTypeDiagnostic: AM6PR03MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR03MB39600F8D87AB53633472A868EB9D0@AM6PR03MB3960.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o88e4yNMuVlBKuaNb4Zd9Fi6CXF1WT0AIOpILIiGa671BBazi0pI73Z5GXk4hmmoYuDU7jZO/dxbVq8Fikq2XqQXQbdX9kG7niYu0m+KgmA/btQezGiMxG8FAPNZDTnt8GINeIVhemBIyY5JJzOjldGsiTyjHYmrKQuGxPvanCZmd7FG/qeTBg8kkUznKKNEIL4Q7g+v58yXPZgvWIOkRuFFI8VWZflyWaIIt0Maxi2lKn0jnWuCONUqn8Jkb68ivAqHcUV3WwWJVFKWXPuFIl2ZYUuk2gnAR9CZN3qbIeFsLJAH0ZV1THNKarCAH8NuqDxFpLULSGuJElU50g277A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(366004)(376002)(39830400003)(136003)(5660300002)(83380400001)(86362001)(508600001)(8936002)(316002)(6666004)(66476007)(6916009)(7696005)(36756003)(2616005)(52116002)(66946007)(66556008)(956004)(44832011)(26005)(1076003)(2906002)(4326008)(16526019)(6486002)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SPgmL7IlUPz9KKmQYftlQqOnB6IseBl/qNWnhC9BKdefGkFtwPcuyFRZF9F5awCYDB71saiL2Cw2I7PIBa0TUlQr/LqkzQBoRWzzAvQeKe+osT4H0hjsanlJJHUu7ffVZezy89Xu4VJaunvwaKQ+03DiqVLdNCyvtRYedP0XvENuEhIRgFenPVrHZJpUlprXLIgaLNm17P9R6+rAZe/phOg+567MRlG05ZJwEXqx372ImudE9w71f6MuLZq7BHGEv4ojvd+SKTJuiYyYHkK9+eCPGHV4MqjxoiI0uGnr+pn0rTXpAnq+txxwVFB98goZaJrT7c6aspe6LcJyeMQqXDMz0+uD9RcVUYpv82fBjOvc9H8zKsA6lCO9uvo8+EeFVxAUVstvD4up7b+IH1kS9CeXlSe9UfmatQqd0aT4JtdwykRBNKg1qQerUUTJJO0cPGrPRwiDggXX9XhWtUK6UPNU5NfnNANdiFTd9AnC31+xR88WcB1D6llOGsLUBHZ1
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a94f3e3-16f6-4934-d6cb-08d811e19347
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:39:41.0806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma05W/7LScd6oCdDRKWZULnLynO0oUk44Es4ArCToKMoIR5Ss45bXvHoDP99I2/4wmc/rH17/klpiso3pawNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3960
Received-SPF: pass client-ip=40.107.20.113;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:39:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This series covers strace support for printing arguments of following syscalls:

    *acct()           *lgetxattr()       *removexattr()       *lchown()
    *fsync()          *fgetxattr()       *lremovexattr()      *fallocate()
    *fdatasync()      *listxattr()       *fremovexattr()
    *listen()         *llistxattr()      *lseek()
    *getxattr()       *flistxattr()      *chown()

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

v2:

    * Added patch that extends strace support by enabling argument printing
      after syscall execution
    * Added strace support for argument printing for syscalls:
      removexattr(), lremovexattr(), fremovexattr()
    * Added "print_syscall_ret_listxattr()" that prints list of extended
      attributes after execution of syscalls: listxattr(), llistxattr(),
      flistxattr()
    * Corrected formats in some printing functions
    * Moved target_offset64() function definition from "syscall.c" to
      "qemu.h"

v3:

    * Added generic function SYSCALL_RET_ERR() that checks the return value
      and prints the approppriate error message
    * Added "print_syscall_ret_llistxattr" and "print_syscall_ret_flistxattr"
      in strace.list for "llistxattr()" and "flistxattr()" that have same
      definition as "print_syscall_ret_listxattr"

v4:

    * Changed error printing from macro SYSCALL_RET_ERR() to function
      print_syscall_err()
    * Changed while loop in print_syscall_ret_listxattr() to check printed
      bytes against size of the return value


Filip Bozuta (6):
  linux-user: Extend strace support to enable argument printing after
    syscall execution
  linux-user: Add strace support for a group of syscalls
  linux-user: Add strace support for printing argument of syscalls used
    for extended attributes
  linux-user: Add strace support for printing arguments of lseek()
  linux-user: Add strace support for printing arguments of
    chown()/lchown()
  linux-user: Add strace support for printing arguments of fallocate()

 linux-user/qemu.h      |  20 ++-
 linux-user/strace.c    | 286 +++++++++++++++++++++++++++++++++++++----
 linux-user/strace.list |  37 +++---
 linux-user/syscall.c   |  18 +--
 4 files changed, 298 insertions(+), 63 deletions(-)

-- 
2.17.1


