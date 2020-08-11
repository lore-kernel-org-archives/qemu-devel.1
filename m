Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198CFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CAB20768
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="mg96G9+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CAB20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XQo-00050c-1u
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPh-0003lk-7U
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:13 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:15741 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPf-0002xQ-8m
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0wiKTo4qSZwSptyu4P0C2dVHd3u0X/0CoFjHu73m1Ncs6UAw+IET85p85hDIN/GlDb6i10x5tB81BCwmHpo+eIKxlaaBj4qMKDXUJ6s5QYZuQ4BZZnS8nlNK4LWv19Nf77Ys7wH5YVdE0bICEPqUJ+PT3cp4bF/cHSqRMXIAkllzGBqIIOv4Ol3V1KUOzpFDcsdgzTHk6DpjlnmsWzeax7UbCIvlEZmeAk20/dAGxHDrSGAMiu5O4bAPcBKEzcsrboXJxz9U2EKda1Q+D64PH06bdEKAQOLMGaoJCy3zPm+fgYC+RZX4PF1OvlK646Lmbd9XVC8aUjqhksyXyiblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ9qVytpV4fl7bMoT8Y+nvnCv791c8IJuiclIPN8V6k=;
 b=E2DX2KvUrGnD5IyZyaHSAjUkYpMkTz2OuAv2a4bCxVJIBq29svOwrVJUzD4N885Cm6MsjDeYIxcowAqJimR6SDZYbjfIXD5woYKNCgiVyAaaWEv8jGwNUTt82pRcCj/W300ETkT52cfWdw0AmMArhE7I7UVFej2OrCnez4v7tDejik6oKcmXpQzyIJbdmNGePqzSKvXzNOX2rI7sHds6AlSS3KHE5p7koQceCG6xRFVozLk8/DoAHXSqMpB2g0jBYGDD0BE4DKmTZ3U5VzboMt8kIWqvqmppahM+q4gx9QsPasJQ+jj8oJaJNHHsIZmYDsUAZ8yBX26CtI2NbRbwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ9qVytpV4fl7bMoT8Y+nvnCv791c8IJuiclIPN8V6k=;
 b=mg96G9+9h1meZPfaW31oeqWO+uRVjB3zbNGJgyMUK/E1PYTmzYSDkarYCXs/yNrN37dQYW+KhdkMUZBEOZC/VGwBS2YFIeI2I0XL5OPauZsk145IHFReiDJufN7VhIvbnWJN2+BARsJ5i84FVmwBVKbr1pDZE/T9HNN/OTUEJ8U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB3662.eurprd03.prod.outlook.com (2603:10a6:803:3a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 16:46:06 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 16:46:06 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] Add strace support for printing arguments for a group
 of selected syscalls
Date: Tue, 11 Aug 2020 18:45:48 +0200
Message-Id: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 16:46:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6ad308-a701-427a-3894-08d83e160ac3
X-MS-TrafficTypeDiagnostic: VI1PR03MB3662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB3662725CBB47BA37B314FD33EB450@VI1PR03MB3662.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgZUN2EHbB+6ih6hSadeJI4ZtRSgvy2xk0IGw6MWPAo8XTJC1nwo1t0a2C1qPJ+LLdB7ukbvWfn0zuYzD/Jub5eB/vNb9ogZcpZ7R9YNnD2tuu9k0AaHs9GtCz+2e9bDL7mLbSu2YZCmsggPJLcIyl+DDGzZOJsTlbcG8bGne/7um8x7IMlXu9P0a4HxKhLGVNm92mLizlFtIiRS79WVtBNvnXrDGisaJ7gWQZ588nXX2Z3n7XdyDgYPov12Oruc6fTq4LPxFb36QHyWlW4+JiSH2dzq9I+Xl7pjQzM9M0lTj/g9Nr13kgZfVuc45SG+oU9ldDig8twQrtyj/smLTiUsqj2nY8iKDs2u10HAHY6Jl/8Ms6URxzAJaxFnFTnv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(396003)(366004)(39830400003)(136003)(956004)(2906002)(508600001)(6512007)(186003)(52116002)(16526019)(66556008)(66946007)(26005)(83380400001)(6666004)(1076003)(66476007)(6506007)(86362001)(54906003)(8936002)(4326008)(107886003)(36756003)(316002)(6916009)(5660300002)(8676002)(6486002)(69590400007)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ti0rtQp2tzWatagwizd8CNEk6SXxuJGXZNlXX426F1NKRu/jnShuVbd8jEOe8CpWcxG6sJDLCHhgHp3s8SvPh0+7fl1sE0jwAi62kKOQcbM/qrzZnOwIuYdbn3fPCe8JegUUExlExaPm2b1UBBqLfiNymqH4cO7HvHej9vZATFVwKkH+ouQz6zsUwBTJjSM199FHWPV/WeWvDZsVcQ26aptZjao8/Bl23lEkEZEPsBqHsTaxV/8f7zJPRJJuvDXftaIlZTOW7yafMV8KGfFpD+li94RNuSS6Ak3Nh2oWWwDahtz7Fq6ar9jWGX6xU0qTW3Q0vw3sgBvJ6ajU9VVwOrlDui3sjne18nOM0WadLQzYxWp4o1M1nCZWGryxU3rH+qmAVmwwfFjpTmBzdrG45Ifpr95GBEfZ4MGtScdhvKeJTXCIH4mOmAgfPxvO9q3M4EsxuLdYjWXUew6JVY5RNy27A6FJtoF1VIqCzNj2vopve8yFJc4g2zj+/f8LxblntDrgk3jL+LYab207f9+q5EUhHnZ5b0L/Kc8LgGV31k0NbsMXqSjtxYY4Fgp0DpTSTYjERom6JD4iM1QDdnwwBsY0C/Un/WmIXljCzLRQAsORk81D13W16nTwj0AMPvLXmWV7NoJ+IZvG6xBl0t2/dg==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6ad308-a701-427a-3894-08d83e160ac3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:46:06.5612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I79NKhGF8AF6hFjQEe3+llBS5ZdvUTCHLvEWfRGjK5wUq6jHfbygS77/UFbZkdivFdybaqJSTNqWgCLAgOmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3662
Received-SPF: pass client-ip=40.107.5.105;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 12:46:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

v3:

    * added patch that introduces an api that prints enumarted values
      with strace
    * used this new introduced api to print certain arguments of syscalls
      in patch 4
    * rebased the series to use the new 'print_syscall_err()'

v4:

    * modified 'print_itimerval()' function in 'syscall.c'

Filip Bozuta (5):
  linux-user: Make cpu_env accessible in strace.c
  linux-user: Add strace support for printing arguments of
    truncate()/ftruncate() and getsid()
  linux-user: Add strace support for printing arguments of syscalls used
    to lock and unlock memory
  linux-user: Add an api to print enumareted argument values with strace
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
 linux-user/strace.c                    | 865 ++++++++++++++++---------
 linux-user/strace.list                 |  35 +-
 linux-user/syscall.c                   |  47 +-
 linux-user/tilegx/target_syscall.h     |   5 +-
 linux-user/x86_64/target_syscall.h     |   5 +-
 linux-user/xtensa/target_syscall.h     |   5 +-
 25 files changed, 694 insertions(+), 399 deletions(-)

-- 
2.25.1


