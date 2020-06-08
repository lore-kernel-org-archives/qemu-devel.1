Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9492053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="N4nSreQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9492053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL9J-0001Xa-W2
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiL7E-0007n5-PX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:59:16 -0400
Received: from mail-eopbgr50096.outbound.protection.outlook.com
 ([40.107.5.96]:33157 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiL7D-0001pO-AT
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8bMsqoAhh2qje2ZYZc1232RBG/zoIJOOmHy9i4G+o1EM3jRGuHI7/pQgKYrdA+AqfHoJjIxy2nbHi1Xm8mQ4zCWdnf7PmvDsFhQOZkLu+KC9YFUN1THf7UaCxZhdfSm6V422yXQP2BByC8xNALs0F64LMkV5sVcRc+0OZfo4ARTImUk27uT9yl60+3tNk3LC9Oc/qqEBfiIgcNuafUUjRXvh+fyT8NeIn6PHPN1+lIkbuWyyg48brjeyY2VuiWoSV94XZ2/qCR2hX08pCmHznpnXDRyUgzDOaGN1yzTQZFeEUr3PG9nxw0hrs4HQTocWhUcV3tt/Jc1Xl/dmadEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIrVYOX06+V5FLupYX+cipJ8PLcSlwirK2qQrlOna1Q=;
 b=jqcITv01zslOtxs29e5wys27ZflNM4rJscUp0gQxrU6o1Tf+dctZSLR9oPdUxY/tYy9JHWJWMj4J8q19/Q45T4pRvNrsWGpRFKGfVzViByw317ZUg9A+lRb30O87ek4YzgkFIfJk4BFLgrlqW7Vb6Jksh0efYH2ljz8Zuaa1j4r1/0qXPm2nQispodq26ruiGKUpPIrxx16qNUY/SUnskAzy6+D2Dq6ncdshaNg3qkE6a6q4rhFT88XkJVMHz6BxrWUDH/1/NicRyncd/CuuolGwVfFGADzzDkd2m1XENn51Y9dJyXTA2yxu2JMEuLEDcqB15QvjWHSqMZM14JcMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIrVYOX06+V5FLupYX+cipJ8PLcSlwirK2qQrlOna1Q=;
 b=N4nSreQcwuuODM34zxOdYZcEpoeXxKSln9SHxxYEX6mmPq7sAeC7zG2GfZCjpnNSV0g8yAOQtnHNT29/Gxcdmma3A1F62wlg3vNgOZkFnBH/wi6FlU+lPt8BRN9CtgWljWEJjZ6QrW0cOPXaLeFX7kZqPhKyqYjh5FUD4bzKdzw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3798.eurprd03.prod.outlook.com (2603:10a6:20b:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 16:44:10 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 16:44:10 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] Add strace support for printing arguments of selected
 syscalls
Date: Mon,  8 Jun 2020 18:43:51 +0200
Message-Id: <20200608164357.25065-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 16:44:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5fb38c-bce6-4ed9-2599-08d80bcb2b0a
X-MS-TrafficTypeDiagnostic: AM6PR03MB3798:
X-Microsoft-Antispam-PRVS: <AM6PR03MB37982CDE3F5D4D05646C1EDEEB850@AM6PR03MB3798.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCeGFP6hWHAwianLtRdKWqEC/RudUl6rYxVU0+PmG0RP17+3bc2CIR6Hay5cogf8fcva2JYltgFTgrP8Yh30MqS1817xqMwUBwUx/MOLSh0FWvE5lAQBZnzXwleyqwFbvMXjRfTZnbHbsyo2/shb0wgM3lFQ/UrgkHNR+z1YioEv343E2fAZI7+m2cm9IM5oCUIjwW1BtI2Vp2kTt4rBFTYRuzFh95EpJg4dBbySvyjL0yosfCo87dZ+QKeNuvkUf4ubGP/rmCJWE1aKffk+8tUiu0fD64Q0N1jFF7FZLKJr0Nd7G61zBdaEiqm1GHPT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(508600001)(4326008)(8676002)(8936002)(1076003)(66556008)(6916009)(66476007)(5660300002)(66946007)(86362001)(316002)(36756003)(16526019)(26005)(2906002)(52116002)(83380400001)(2616005)(956004)(44832011)(6486002)(7696005)(186003)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XSKLAGPADnHSS5Ze9pthJM4NyE3aVdCnqxfD3XFKvUbhFYxEDK+a8CWjruYqkz0YZx496d7FVdWeRWl1rKvSMS16SyUrc4M3gwmhIeFT7VnzqAXLZXOXz42YAZTrCuw5UdBH3v+c2XZ3RHNGr18sJCRYtTbH2tzhxg5GIKPC1C399unnsQEviwFLUzNqi5aJ09cg0rt8kz/Qkw9wFeGJ7K87wLybkJ9KYBrUxfjF7m+VAWX6Kf7/CQraGL2K8ulzf6lAKpFBLpSOl1hYHIXpn5wJXQxr9BGI0aVUhs1wtPeHqy+Coj+9cXQMfJrUaR+x+Np3D9FCMyZB4UJm0ZGbtaTx0QSrRroNNw/62FanFOLm66gYv89XGw1v0aNzCZvzz5pj90lmMsFV7mCmoy2tf8OiPPEhjPXmjdG3iqTQvs4+KDyxp9RMUj/4nV2RD0Kww9B1OYcZip6sQIhwIoQBx9mwx31icwHZ8JKNdGLnz2E=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5fb38c-bce6-4ed9-2599-08d80bcb2b0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 16:44:10.3295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZoyMbbHeU//LFHzM9/E0eJbqz08+qeABTSuEQww4OYBc1unQYqxFrakVnouFjAGSrnEQVjQyTLVmB8UFjcG7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3798
Received-SPF: pass client-ip=40.107.5.96; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:59:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

 linux-user/qemu.h      |  20 +++-
 linux-user/strace.c    | 247 ++++++++++++++++++++++++++++++++++++++++-
 linux-user/strace.list |  37 +++---
 linux-user/syscall.c   |  18 +--
 4 files changed, 281 insertions(+), 41 deletions(-)

-- 
2.17.1


