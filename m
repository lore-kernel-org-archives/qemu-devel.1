Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D4EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48D720776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="jG6CahvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48D720776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGTh-0002s6-W1
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGRv-0000J9-6L
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:48:51 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com
 ([40.107.22.105]:53569 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGRt-0006dB-Cq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:48:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bum1XC9BoBCraele48Jobs3bX9kQBQK3kZ8ss9FRSnk2dWjOhwFD3bhKLeJXJXSTW5ysC/OueGak0MIBbAA6MfVEsrsxzRqJU/HM2Vr3qdAuuxJL0r8ZQjj2dL2+ZTI9N6UbkDGmzOoOLUkgHDfzKnhyROXRqESNiaUqmFqrLmNs4ekDZn2c+sXro7J5KqQiUbnf87+PZss5QLRONaaLMzUS5+qhLf1J82RE6rPQqF6pd5ve5nUCKBr/znbucWZMNLnpIPweltdakUi83QSHNBDhbK4X7NhCKZUXEOzdkv5iH11cnsb4rWw1xqlVJlO1F4hBLeOr1elMAByCaFu8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taXPEV/n87G+ZcN4BNseNL5ET/YXPTfMc71mqV0m6sU=;
 b=a7v2cLVv0tfiiGWOymGcxS4hjauFvIYJdN0iYi5Fw+ZduT9BQrFnJz0J7N6azi/Fj/z0bWZdg27SyaXGEw0UY7pI3Dh7AS+IwVuFZEFKxWDoeq/j2eL85J41i6Bw2eMRnLiC9G1SKVXhkfHHh+xFGGMSqyiiV9OnEbjtg3oaI5oGJKTyZpEAV6ErdZxKVyCL+5V6LCfi14xxByUaPcirGXrWnifKYHwmcDn6pKDK4A7oMlLlBbU4wdJO7rqw10Qc22lJl6EMY22/U8/KG14Yjua1SGDFfHtpM0fR4Sudq0UDRiDrvMbG+k0AmpTaKI6ApRTTovk+A/8Va/jBcUIE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taXPEV/n87G+ZcN4BNseNL5ET/YXPTfMc71mqV0m6sU=;
 b=jG6CahvPwgHCp5Kk0kJXIGWq9treGUBVOmvU0C+GK8j61HT63js7x7RQoesvR23+Xiaw0HesOFGb24ryDYRDtM4VcxXodRccUrFJNUEURnk9Bei/OIg2wTwXtTF3rSm72DW5N47XeLh3fzdEVJdphEWyAHOToQdm+j5T4B9isDA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:33:44 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:33:44 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/6] Add strace support for printing arguments of selected
 syscalls
Date: Fri, 19 Jun 2020 14:33:25 +0200
Message-Id: <20200619123331.17387-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 367a3b6d-073f-485a-08e5-08d8144d016b
X-MS-TrafficTypeDiagnostic: AM6PR03MB5315:
X-Microsoft-Antispam-PRVS: <AM6PR03MB53154BA8845B42BE23A4FAE0EB980@AM6PR03MB5315.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVMC7yIbGRtzi0OAbtoMurQjhHov8owfQ7ugXxxLoHOJTCIQqpm0UU0gpOdjsFnbEzGNKW0u+q+ChpOQ79UYz1rn8ipwtnJPENDV7OgvJqAIpdu+gmv/m3vV2erqQ4No+SLFQCu/093+3kvqjDH6ecoRODM2wvrt6gTq1Jz00pKI+UBPnWwcfDVqdUdOajHuG2lvFzVOgH6dsf383eoLq4aq3acISV8/65Ji4cWsgKwCxd00KUTpxtdSTjwo7BGvFVcvszXZK/aaRA7vqO0tHlWyeakimtTDzWWixIGZUjGCpT/jTOLffK4tAnujiWol
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(7696005)(52116002)(4326008)(186003)(36756003)(6916009)(2616005)(26005)(16526019)(66946007)(66476007)(316002)(956004)(66556008)(1076003)(83380400001)(2906002)(508600001)(6486002)(5660300002)(6666004)(8936002)(86362001)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: l37d9I2omyqHckp59M1QECe8y/pKpw4QwAW3YxMtaEhS5lD/1FDDkU+LZgemqCqEoYMtd6rbojqsOXAoU2ToeDVsoc47lIF4J840rHRoK/PVPnya8NzikpVPnwFElePd2KknzeDUIysiZ5XhOYAk4RDs8MZ4S4dkhm8nssLo/ERw9BE9uGFcsGTexC2dvunEBMSh+ZQZJ7jkoyOm5ZocHyMn+0vaUo4SF0vnzMHBQ0AgnGJ+jYYju0vqV7X1pSM9/tjhhxx/teFH9VPeEJKEVZJXhFJkudH+AwIIIMmlvZgpEDsx9UpWz/8ndPBmLX+6gaBJ+3tl/vEE++YVoBzzoPlK0EjLXfvHm5PN+P2r5O1h4RGM04taMBeNAd443yna7AHBV6SjLcfNYIRZ9JuQjMcPPmIZIXi+cyi4RFtAGe/liWnbJSharxF3OIyyd8+LHT8PC2HwCMKACyWi+Gg+iCgdlNQ9Gf/LB3u//vX9l2w=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367a3b6d-073f-485a-08e5-08d8144d016b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:44.3573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9X/+/d28F9a/3R7zk94jfA6YQIU869PsAfNrHA3EJTdTDWpYldMKbyMHIaVxFeHdgyZCN9f4wRiRkDvAy4PvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5315
Received-SPF: pass client-ip=40.107.22.105;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:48:48
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
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
    * Changed while loop in "print_syscall_ret_listxattr()" to check printed
      bytes against size of the return value

v5:
    * Corrected "print_newselect()" and "print_syscall_ret_newselect()"
      to use the new functionality to store syscall argument values
    * Changed while loop in "print_syscall_ret_listxattr()" to check only the
      size of the return value without the variable for printed bytes

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
 linux-user/strace.c    | 328 ++++++++++++++++++++++++++++++++++-------
 linux-user/strace.list |  37 ++---
 linux-user/syscall.c   |  18 +--
 4 files changed, 315 insertions(+), 88 deletions(-)

-- 
2.17.1


