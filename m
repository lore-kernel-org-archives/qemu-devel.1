Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34F0206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="EKOz1SuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34F0206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPpU-0005CK-5y
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPio-0000WU-66
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:06:30 -0400
Received: from mail-eopbgr70123.outbound.protection.outlook.com
 ([40.107.7.123]:33789 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPim-0001c3-1G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Khb2Sv3jc8rQuz+ZsrrfCYGjqxECQiOoYLVmQc/n6QW4Ge8Rd3FhZFePvT4Eb6bdN4Glo4himbHF5xQb954+nRHDWsdbg9BMYpUyzfBVfzj02t8IZ1o1pbvfN6nJs77g5n9yUHq5zQYCay9YXpuo+ocR+XTiqaLLhM8qT/24uO+fWxNt8COurqFheg9gyD0VRjkRDPXNRFClGuuM3V7GEPcMHIQLgnTY8NeNjpzkBG3qz2uoaXV45R94lTbnlyHyj+woU5jUghZpf4j1YeCgbue3IGnKLZQLt60RlbFk+uj2zmTVZkyhtBui8l1lHzictk285K9z6BtaSZjUZZjT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhFkruw75deiqXMeTyWi/H4pVV47jtnGgySXcvCn+cc=;
 b=Qn3jCao6qVNSLe9jIgOemjoiHAe8dtNCEjTORifKnk5ZB6vMpCEaoynPGqWTfIyXCMkxUf2//nnERoqH3gFTg+Z89rE3fnNhdd5yqlEU/SCdvhfP20GFkrMO3JG1rNLCj4cP2jzB6QuHfiN9uv6oHpeAxFCIkEwnH6WxY4bwLifJ7XoFfFNxed59sruJHPtceQINx9419B4D6bHhdcEonm7cU5KJjOBO4ChiIvWh2K0+fq7PMTEszZZNIREpiCbx1ydPOMC3yctnRhqJsSmZ2BksAgBiLgx6E7wEqNtePK4whCd/5YsSFT9Ra4NHqz4SD4Ko+Xq+S+wlrI++zjB33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhFkruw75deiqXMeTyWi/H4pVV47jtnGgySXcvCn+cc=;
 b=EKOz1SuJ++uhTYNU4mMwLYoR+RdQ9Rzd/onDSE9a3OJoep6GuE57MjfMfytohlSXZ5P7T05uNVHMhoKpkagHc9wXgXCS0sAnhMUbBk6tiRIxkzIo6ZhPT7kvfzws3k76dW9EDqqvLfZJls96BVMbMS/1KZ4Yj82ewayPonPeVPQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4869.eurprd03.prod.outlook.com (2603:10a6:20b:6f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 15:51:22 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:51:22 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/6] Add strace support for printing arguments of selected
 syscalls
Date: Thu, 11 Jun 2020 17:51:03 +0200
Message-Id: <20200611155109.3648-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 15:51:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68157a94-6f1a-4653-7633-08d80e1f4a3a
X-MS-TrafficTypeDiagnostic: AM6PR03MB4869:
X-Microsoft-Antispam-PRVS: <AM6PR03MB48695BA453EBDC055B35EC16EB800@AM6PR03MB4869.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNimOlSZZObKMnpDENYEm49+7mZQBiZFSNaMgu5nC9zsCEfPKSlnNx9uwVEjkMmRlpV9nwMYVd0BLhFdGodoIEJPy/ySatx9b3bw8JwcPw5tbyUk/8/9BlFVG+k7yHnQN1mVTsXTBNnXe4XViJ0JUowUKDsEjA4ZZnd91r1NWq4VHiTVeFJMRVJeHiLABjmx2YkC4MSGwaVlxOk3cJaAK86O5wT/FsIeTC3t9N9yC1upCPkFxD9i9TCfiGNxEVTeT3HiCaBfDwGYRbON/xUIuFIpd2C0mCQhgwbdDYUpll7I3fFdtj4mwuS33y76dFbVir1xiiB9dJC3TnMkpsjaVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(376002)(346002)(39830400003)(366004)(186003)(16526019)(4326008)(66946007)(66476007)(5660300002)(2906002)(66556008)(36756003)(7696005)(6916009)(86362001)(52116002)(6486002)(316002)(6666004)(2616005)(8936002)(1076003)(508600001)(26005)(83380400001)(8676002)(956004)(44832011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EUJhFQ0l2q9Bt+UVm6jIAdjl47lbto7vt1TEx2jl7CMxX87Fu2yTzLXNbDuU9Jpfasn+ZM6VtBWJwBaQx6QPXObjZrWe1ZNGb8micEnQUSWogeRPm9vrWUhKVhAigUSKiu9n8afGmad+s654oo0gkHt3Q6YBsx/kFMmAMhDkrtAR+CzZ5mbEijESKb06CzD9m9MdsSArsHfnuglBH/wpxHHU7Z72sNiOl0G4zP5sG5O5lG9wMvjVT6FRmwjhXDwzXhuZiolTh3we15zz6bKpIEA5s4frB58aVpoUdga9wsCAOXgc9a4weFXpY5u75x1mxUf+Vb2gvcZIAlkY55V7xyv2opo/wPoqULZ/Cy/ShIsH02bCXNNzIaIHD/STPMdAwIb8+9+n96fhsU6bYR0BXGgkgJizULmbnx5Y9aNeoh5o/UTJWS/wYtudmWPQM/4rt9S/Wnu4WiwrdUbz6Pk5oyjF+n4JVJHtBwin/QVpNok=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68157a94-6f1a-4653-7633-08d80e1f4a3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:51:22.6264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT9l+gYHqrLSLXxRCShLpIn9Kl/3Igl4W0v6JbdGsPbuo0Yo1jC+GwfCwh8xkgVJEwEe0b0XVhfKNzXbaG/Y/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4869
Received-SPF: pass client-ip=40.107.7.123;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 12:06:26
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
 linux-user/strace.c    | 263 ++++++++++++++++++++++++++++++++++++-----
 linux-user/strace.list |  31 ++---
 linux-user/syscall.c   |  18 +--
 4 files changed, 271 insertions(+), 61 deletions(-)

-- 
2.17.1


