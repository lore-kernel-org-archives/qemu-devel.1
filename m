Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B268AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2A720771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="xWbOlPx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2A720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyL00-0007Bq-N5
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 16:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKz4-0005oe-7M
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:04:58 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
 ([40.107.15.133]:53875 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKz1-0002ER-Tz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:04:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuCeJpWZw5VCXF4WejFhZuhTcmHR1UiD4ATM0lJuss+YSxFfqBcD6jo/axwQQniA3Jb6Dv0fGKW+uRhzWxYIedNi/i2CvPOQIxTpnV7Qh5DHg6Qu8ySsI4WGcrpe6IgizRSEsX7eMDwcKRaQ4eoFHL3Jxxsv/m1bHHhFjwo23X9j+UK31fXGxr3fIQeJA39Knk+YHen+3ELfi1j8ezoyp2UOzqM03K/5EHqltwGAlDu9ceIKC4ydJPK7oBgJUWkfsSkrUZXs3mEeRhdNHEH4nMIQ47E9fsZXmExS43D2BtpROhW3sPXrEYmESOd9qPMmh6ESLwBHITKYFQD9+0ab1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVRYqYq8XGqzlGMtZxT7jPjthyics9fPBwlh/R06U/A=;
 b=j0sGD9FULISA6liJ4ZAFxcP6Rj14w7fm6gPsBaUg+FHp38jbFtui3hxvx16bNA4pfVfPefkuQmiqWtdDEOsYLPpKgn2+3+Z+0tbP9KcOoBZrs1xu/FBxsea/9pCmCpu9LD6nCLokxYe4iSKNzqzOot1HU/ylwtghEDzN3l7knFxvTjrPJifjSmGMetvLAaXHd4X9odcpUV+db+SmtKpjNDmariKfFctmN6WYRLjaB20AX0vT8wFPlu7FDOoB6AAa7DKuQF7Na3ETnpTVzgfj2b8lZsbdU/GwVO6LjWNqvIQ9Mhi0hXL6L6M3vEAgGCnSS+ByD4f4ShLhb8JsK/1hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVRYqYq8XGqzlGMtZxT7jPjthyics9fPBwlh/R06U/A=;
 b=xWbOlPx6mb+OdTAy0CII9dMe6EFSh0N4LUHfpq8jrFAk48lc2uGGT8kFl0YkF01BDprP5/brOPm1Bg2ugH+s77+6bWeWvc6GRjoTsSgwj16DcfkkBfKPIBP8E7/XAEe8vp5yd5fvCAevLNYxF/I/9a9aPcsVVkFPkeI/RL9+N5w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6563.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 20:04:52 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 20:04:52 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] Add strace support for printing arguments for a group
 of selected syscalls
Date: Wed, 22 Jul 2020 22:04:32 +0200
Message-Id: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.237) by
 ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Wed, 22 Jul 2020 20:04:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64c3892b-1788-438a-faae-08d82e7a7ed4
X-MS-TrafficTypeDiagnostic: AM7PR03MB6563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB65632E03DF1269A53D350046EB790@AM7PR03MB6563.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pna3VPxkmbQgRFb/dtpMNSj2lOyBr3PfAUf6e3dOXRryh8WlGc3qTzDkKqBi5qbbjeWoWriyZnIBSOqx8V1V8JdTWzdtXTppoWCGToP3CW5RP9iFOQCWo478YKBVfqbcj1srfo25ABtpl8b/0Vrq3Ng9faKwEbHIjRjjOFPTDOF/IE4BqBHhVB0gtYkgvaA61PD+yMugXdol2qRLbofLVdwjofjJmobW4ZBv7QEN7KbbyhxFc9U02TXAuNoIKp7hHzpRO79XdBU152U8ald41P3x/W2iq46dEdhNVPn9XX/JtgMSh/SxZ4S3RCvWoDShaP+HjenmdvC/+SSPNnD738GDDMqlr3Qho1ghFqoTGNZ6rDevjs/rrbqLr6wM/Lo/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(376002)(346002)(39830400003)(136003)(107886003)(956004)(54906003)(26005)(316002)(6666004)(2616005)(1076003)(69590400007)(8936002)(2906002)(86362001)(5660300002)(4326008)(66556008)(6486002)(6916009)(36756003)(6512007)(8676002)(186003)(16526019)(66946007)(83380400001)(508600001)(52116002)(66476007)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Pf3Wm9ixlfYBvorXpdK6VYLgKaKBuWlkd+gvRC1tBM1R5ELzr1768pk6kwQA7VA3kU+WjTuCCt91ipj/Nv9bYZXgamEPTvjj5iPXuhwXDtJqmXF/+r2ZLqqRJJhQyWtf24VIgCoHrRFSm1vbYRelW4Ho7y3NCvFU8OXC0Pf2POEnUC67Cpvc6kqjg3DEvxYf9TJBUZWveWiPHhzABhANxY2FaTd+valw47H/EU706ddA9X/IfzsXMCBWkHpjG6s/aOYmWsPVTN9nXq6FQ03MuTwB8uPjJQVdXBl3lM53xZPNy+JM1gQvENhfjOO1t1Y5pHsgEGpmEIQ6MfpH+JWzC1sCl9X7atgNPqeDbjUFKWm2sIeoGNvM8Yd12Szlc1+mLnwth/R4ClPj9KpFaFyF8M6PqJRo8oANYm0zlROhOKlyum+totTfC+Hqzl+J+ihYD0RvRJkS3tCq3XLeSJ3Yao+LDSnsiUkNL0omuzS7b9Y=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c3892b-1788-438a-faae-08d82e7a7ed4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 20:04:52.4148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvJ6RhsHXncY+x/y82iSgF3fCEvhFA/uAYI62cQ4tXUtVzbPTP6pXoFp9f3DJSRiALURLmwdKg/C5QKFemu0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6563
Received-SPF: pass client-ip=40.107.15.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 16:04:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 linux-user/strace.c                    | 863 ++++++++++++++++---------
 linux-user/strace.list                 |  35 +-
 linux-user/syscall.c                   |  47 +-
 linux-user/tilegx/target_syscall.h     |   5 +-
 linux-user/x86_64/target_syscall.h     |   5 +-
 linux-user/xtensa/target_syscall.h     |   5 +-
 25 files changed, 692 insertions(+), 399 deletions(-)

-- 
2.25.1


