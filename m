Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1171EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF70120758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="N2x70x4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF70120758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvNY-0005T2-2x
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1juvLs-0003ew-2V
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:06:24 -0400
Received: from mail-eopbgr70119.outbound.protection.outlook.com
 ([40.107.7.119]:32430 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1juvLo-0004XV-Do
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:06:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmGeA6VIDDNwEq4Ka5PkCJGXUODnb5Z+pwCIuRB/1xzSRIKRIImV5uL7NKr6pUBndrfme89HBixxIA5sQTZXMVsOX5oCQMSLYSuLD46mAgIaENT88TvfTvOt/3dL+v5ZXhk1MbN6/ORppoW55Ss1evr+iMJhB6QrOBv7oOu/G+eVv3ac4ssjWCgZUQA3EI+TyL+5kHOOEIuVhuICYFxmrbz7I7gArkREN9n1wAAiA26GIlAojIt/g5Wbed9UHneprOKbHP5UvqPEFgn/yVnsVtHTZmfuanMPig8ldYDxQj706QcSqHcsgX+CmYFSrvBfiOHCF1cl6KS6xXeI6MXtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXTlyUUfg6W4pfRsL1Bgi5IplC05ZJVUd0fpCuF4g0s=;
 b=d0Kz1U8K6exbxyKSx9Q7hnuIaIrrfMN+5kVpTLAJTyDonymAflQ5KjY93afYdjYtHS2YTGwWjEdQ+ipHoYCpv19Zl/l+xeT+gC9u2SpuZkDmfkJlpa35lCnAiqVPQMcxPN9oYnGJLcmz0oWppKEhdklILEFWvYVutILeF3OByKfmKn7QZzx4VdKhu8xcfIHDm9lffrWG+ob5k0C7cVbSQ3J+wB0ZwAyp1t5onQzByuQWQK/6HjZLDi6W2l/wHACXcT9CSHcIc/RLHChMk8wEZKFXCq3POaMHmA4BGNlJVGvyIjWzIgz3ZEXhn+lDDj+F/ZH1RQMH8tg4Sl7QYvLlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXTlyUUfg6W4pfRsL1Bgi5IplC05ZJVUd0fpCuF4g0s=;
 b=N2x70x4E2UqRaOuevkr6J8VlHlcdFPJ8v/e7VExwyPsQQD/GTmpzfeWChgu5L+I4nZ1mATvRwesqgJrs58IhUi47R2L2w5p/h5K/uTt03Dpmyvhntd8neyGdHdEbs1Wwbufq9bgYnHGUkiozyRN7hWyvkb/Rt1l0yZbeadGUqCs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5234.eurprd03.prod.outlook.com (2603:10a6:20b:c3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 09:51:14 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:51:13 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] Add strace support for printing arguments for a group
 of selected syscalls
Date: Mon, 13 Jul 2020 11:50:54 +0200
Message-Id: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::19) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GV0P278CA0050.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Mon, 13 Jul 2020 09:51:12 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14206472-fb00-478f-d747-08d82712475e
X-MS-TrafficTypeDiagnostic: AM6PR03MB5234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5234A4156C1C7162BDBC6803EB600@AM6PR03MB5234.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LspLEPGDo7y7z41ztCTmBjkRf9UaGJ0l/knfr+FlT8vLX8DHK2cV+xjaPQleGHL2duUjl5k2w1WU/duCwp23nVMdBSbbIExCMcCa1EfaiV4JYmFzF9JUNuvX7vsDA4jmsE9tIKwnirpLM9Q2KxVM25SgpnHODeXN6W6AhbhvNTRKV3BEi9iCefObWIiU3qDmHB6iq5n17AvtWmXlUbDvcHiK5bqB+ffdf2ykuosO789Gfah3FJfSudm2aGOGL54k2WQIQJX5wYX4E5/GOzIaN/KBN+jJrixWEG4Dj31NVjUaK5DeHgILsGHxlNOob+D4jWcnt5+GRTOQiOjegTY32FzG6BmcEqxPcEmE5ipwDbiA3E6D177Jfvxnsfept+EI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39830400003)(54906003)(86362001)(6916009)(16526019)(8676002)(69590400007)(6486002)(2616005)(26005)(8936002)(316002)(186003)(956004)(508600001)(83380400001)(4326008)(107886003)(66556008)(66946007)(66476007)(52116002)(6506007)(1076003)(5660300002)(6512007)(6666004)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MuEZILuDxLnp0XTzlh02xl76svaIhr7xJJQsAQjiKfAMaC5C37wlfF7NW3bPOLpU2n+rr1c4ltWj+xZ3RAR7iG94Z/ZRg5CtnKJdzwL++SrM1m/PuiHmWQbea6CZTA6ae+6zcW/v3C2dzRTWr88ddpG2kGcCZzMPrXaW6EY8MnjHgikNY3/Td6Xp1qhxyscMIkFQYwQWXbFZXuLP3bJsN/aDlSDnYOAXA/jczoDmm+a+MybC7yRbxAM/umAPDuren2ki7hPOFsRJ7p5dH46ZuUUGrVfF/UY7oZ7znTT2TY4fwsWSgXwH4z4lnHe9f60TGCClYbqxVKa8kGuVh+6q2hcDWetfonO3PqnS/4Ssvli0Vu8jMPGIpf0pYH/KVF8Pr2oiqdP2jNadGBnjZiMDo61vw/yWvQ1ueVb5PoPc+8XOVZCL/FJB2myHfAFQj/BSkNercAMbBt/MqQ6pmw/uwyXzAc1DOEjw03DIwBQ+pk8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14206472-fb00-478f-d747-08d82712475e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:51:13.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyfgYQBPwZ2Q+K5ceyPv9dnrZnBCs1/7pH4lvm47TS1ewqjgrRcKutl5c8zG6BL+OfKd9pc8pNT5i6XSfl4/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5234
Received-SPF: pass client-ip=40.107.7.119;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 06:06:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series covers strace support for following syscalls:

   *truncate()     *munlock()          *clock_gettimeofday()
   *ftruncate()    *munlockall()       *clock_getitimer()
   *getsid()       *clock_getres()     *clock_setitimer()
   *mlock()        *clock_gettime()
   *mlockall()     *clock_settime()

Testing method:

    Mini test programs were written that run these syscalls for different arguments.
    Those programs were compiled (sometimes using cross-compilers) for the following
    architectures:

        * Intel 64-bit (little endian) (gcc)
        * Power pc 32-bit (big endian) (powerpc-linux-gnu-gcc)
        * Power pc 64-bit (big endian) (powerpc64-linux-gnu-gcc)

    The corresponding native programs were executed with strace, without using
    QEMU, on intel (x86_64) host.

    All applicable compiled programs were in turn executed with "-strace"
    through QEMU and the strace printing results obtained were the same
    ones gotten for native execution.

v2:
    * added patch that enables 'cpu_env' to be accessible from "strace.c"
    * cut and pasted "regpairs_aligned" from 'syscall.c' to 'qemu.h' so
      that it can be used for "print_truncate64" and "print_ftruncate64"
    * changed flag names from 'TARGET_MLOCKALL_MCL_*' to 'TARGET_MCL_*'
    * added target flag value 'TARGET_MCL_ONFAULT' for 'MCL_ONFAULT'
    * added 'print_syscall_ret_setitimer' for old value of the interval
      timer
    * added a function 'print_itimer_type' that prints the interval timer
      type

Filip Bozuta (4):
  linux-user: Make cpu_env accessible in strace.c
  linux-user: Add strace support for printing arguments of
    truncate()/ftruncate() and getsid()
  linux-user: Add strace support for printing arguments of syscalls used
    to lock and unlock memory
  linux-user: Add strace support for printing arguments of some clock
    and time functions

 linux-user/aarch64/target_syscall.h    |   5 +-
 linux-user/alpha/target_syscall.h      |   5 +-
 linux-user/arm/target_syscall.h        |   6 +-
 linux-user/cris/target_syscall.h       |   5 +-
 linux-user/hppa/target_syscall.h       |   5 +-
 linux-user/i386/target_syscall.h       |   5 +-
 linux-user/m68k/target_syscall.h       |   6 +-
 linux-user/microblaze/target_syscall.h |   5 +-
 linux-user/mips/target_syscall.h       |   5 +-
 linux-user/mips64/target_syscall.h     |   5 +-
 linux-user/nios2/target_syscall.h      |   5 +-
 linux-user/openrisc/target_syscall.h   |   5 +-
 linux-user/ppc/target_syscall.h        |   5 +-
 linux-user/qemu.h                      |  39 +-
 linux-user/riscv/target_syscall.h      |   5 +-
 linux-user/s390x/target_syscall.h      |   5 +-
 linux-user/sh4/target_syscall.h        |   5 +-
 linux-user/sparc/target_syscall.h      |   5 +-
 linux-user/sparc64/target_syscall.h    |   5 +-
 linux-user/strace.c                    | 755 +++++++++++++++++--------
 linux-user/strace.list                 |  35 +-
 linux-user/syscall.c                   |  47 +-
 linux-user/tilegx/target_syscall.h     |   5 +-
 linux-user/x86_64/target_syscall.h     |   5 +-
 linux-user/xtensa/target_syscall.h     |   5 +-
 25 files changed, 648 insertions(+), 335 deletions(-)

-- 
2.25.1


