Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E39C433E8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E2A20792
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="w0wve8zF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E2A20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyic4-0008Ns-Fx
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 17:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyibE-0007yV-FP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:17:56 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com
 ([40.107.8.99]:34176 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyibB-0008Di-FK
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:17:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpTBBBP65NL+Z+UPn40lFwvdnSYQZjVefj89p6PJqgKV5EWGS89eFEaZmoZ6dVD7eDIH9iCHwsfZWciv9lmH6kik6zMA//+FPCqCso1V5jI3zpDYcQz21RwDnlYGu4REOIyQEt3hU3gptmxktpioz4VpUHSkWjA0qMb5NBdBJ7VWaMogEjl3QcMrugbVgK8FjdbOlPUmpj9DEjlpOezy2y4nhkvMkl+0YRuNUCB3cPNrxxL9YTvrdBTp4nc1GEHDfO8zqLQkmJT82MOPbQ+k9R1/VFl0SH0DWHZZ0KtJAfz6bQdIqeOdWrFI9rb4aDcxzqoU3xQxFLFUZ4dYXqKbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxe1uh3fX+tTRFORu6zxyJxsFcgHQPdHDVGJQ5aGNJ4=;
 b=ZXYhbByribxUpEhCJdb3HAizmt3k3n8/GnEFIhpMBXN/AjD8ArrOagP6adERv5IfKIFUGTrDT8zCkqTBPfgKCg5L27YQjHJGsj6zxIz4biadiSpY9NyAN+HwToF9FaLlbfTAfdQBqwUbcPx/T+fwIEuudoQdfc4GiU8poGxnzCtqaONWuQKuyqdF1stJMDRJwGj6MLdtnh5GphaFZ7EAX4RL7Z9JUQl4sxZw0TZ529Q2LaUV/4NEI/MnJVlNS/ZCJHB0PYRYG98ghMG3C3rRWWnAlvvcQ895zIzbKYSw19SKcr7vzgs+lzuSRy1nISeSLsnnl7FpHnSMIpiuNIxXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxe1uh3fX+tTRFORu6zxyJxsFcgHQPdHDVGJQ5aGNJ4=;
 b=w0wve8zF47uGPFuycFYKZZI0BrcBAGllGEcPEoGDQEjYi1aHGGB2EfLUAVCLrAtKZ6DBJ35kjw5LSwrnGj1DGnQlHgfAn+b9xQlgxkPAE69/F6aEBasK/3HqHvG6Xp2n3ymQfTBd5BMtRLPrXMjrz3RK+mQB3V9GIA+dstBPiWg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5687.eurprd03.prod.outlook.com (2603:10a6:20b:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 21:02:47 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Thu, 23 Jul 2020
 21:02:47 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Adding support for printing contents of 'struct
 termios' which is used by ioctls of group 'ioctl_tty'
Date: Thu, 23 Jul 2020 23:02:30 +0200
Message-Id: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::31) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.236) by
 LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Thu, 23 Jul 2020 21:02:46 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc90e672-bde1-4b08-723a-08d82f4bc057
X-MS-TrafficTypeDiagnostic: AM6PR03MB5687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5687373BA6BF30B2DDB2C1D7EB760@AM6PR03MB5687.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hplzjz9vZUbgGqJSbYMhRYHI2V2lex4dco8KX4lkj2ktWtoUZwD0Jeqrc+tu93uyQkBY+ZabTEq7nugSzYf8802TQoUyObiq6VbUnRkllOkQPohG2Woq/Nya+Sn2Mejr+vLCg+ChnZv9L2K3stwQwKi5OvVibKuoxSL6J+c/Se8npOdKhNLYwLEbg1E6CFbdXhLAirjA7nKqbe39n8B05k56UuR8rYgaxvSbMb5ZyiK/QqZvNimfCEChp5Kij0O9CxYeJ64TGB7YwRCV9XJ9mChOH5A5uWlqomlBtC22j21rIlguXjw3LdhlxGqj/FW0iGzUE0ABa3rtIrobT0RYzELF5F1UMdY80JAgvvX167bHQ2dQpG/NzWieWecE47sQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(366004)(39830400003)(346002)(396003)(69590400007)(6486002)(86362001)(6916009)(6666004)(26005)(66556008)(956004)(66946007)(66476007)(2616005)(83380400001)(1076003)(54906003)(508600001)(316002)(4326008)(6512007)(2906002)(5660300002)(6506007)(8936002)(52116002)(8676002)(16526019)(186003)(107886003)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dQVmxsf/3kBDXas5ewiD+F+hsC8XO3+gHgQRXDzrZCTKSpilgSDWzGxQ5KmRz/qvGdOVmZ+/JTgEyGOMFgkWiPCmKCr7kgnf74m51kMAD4FFGn59t0QHyW6Y1ETSVjszxKTyVwkym/74fpn6oZ+55zOZKM1DaUW0Vw8UTeK/kVMZ3bwgU0kza11ZJ13aWkBZ6GpJRbiVnE1jTvbyOIqb87KhTxM1KKj/WrRySZRdt16aCqu3QxomRZx/iypcz/6/dNnPk1MlNHTxc/ur79MNq03ijnrzFMhZnMSMTZyR+dNrNu3diVAkug0QPKYbr+b8R5flWW1pkP9x28TlxxGlUvD0Cax9mB9evm7Xqd7PE12k7RKMuB/iFZ6aLnKqp0bbpqFKwUbSb3ML42Wxnnj7XiiCgWEVgBHWcw5qe1oFfMruay6VD2qPx8n1feKSaX81HC7x4lNNzxxaLDuT6a00vVzQWeomwmOiSDPgsCjujB4=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc90e672-bde1-4b08-723a-08d82f4bc057
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 21:02:47.0983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLfKk2Ve2hRxg6dksjYK5vyELouuSZQBTiZNFsLJS7zmvdgSjAyvykxtWBH/gS2CjZAsIgMGK2Aax3bAtGlg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5687
Received-SPF: pass client-ip=40.107.8.99; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 17:17:51
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series introduces strace printing functionality for
contents of 'struct termios'.

The first patch in the series introduces a generic 'termbits.h'
file for some architectures which have same 'struct termios'
flag values and 'ioctl_tty' definitions.

The second patch introduces some missing types and flag
values for 'struct termios' which are needed to print
it's contents.

The third patch introduces the 'strace' argument printing
functionality itself by using existing functions and macros
in 'strace.c'.

Testing method:

    The argument printing functionality was tested using mini
    test program, which were cross compiled for certain
    architectures ('ppc','ppc64','mips','mips64','mipsel'),
    in which the ioctls of group 'ioctl_tty' were used.
    These programs were cross executed with QEMU with "-strace"
    to check if the contents 'struct termios' are getting
    correctly printed.

Based-on: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>

Filip Bozuta (5):
  linux-user: Add generic 'termbits.h' for some archs
  linux-user: Add missing termbits types and values definitions
  linux-user: Add strace support for printing arguments for ioctls used
    for terminals and serial lines

 include/exec/user/thunk.h        |   1 +
 linux-user/aarch64/termbits.h    | 228 +----------------
 linux-user/alpha/termbits.h      |   1 +
 linux-user/arm/termbits.h        | 223 +----------------
 linux-user/cris/termbits.h       |  18 +-
 linux-user/generic/termbits.h    | 318 +++++++++++++++++++++++
 linux-user/hppa/termbits.h       |  17 +-
 linux-user/i386/termbits.h       | 233 +----------------
 linux-user/m68k/termbits.h       | 234 +----------------
 linux-user/microblaze/termbits.h | 220 +---------------
 linux-user/mips/termbits.h       |  17 +-
 linux-user/nios2/termbits.h      | 228 +----------------
 linux-user/openrisc/termbits.h   | 302 +---------------------
 linux-user/ppc/termbits.h        |  21 +-
 linux-user/qemu.h                |   1 +
 linux-user/riscv/termbits.h      | 228 +----------------
 linux-user/s390x/termbits.h      | 289 +--------------------
 linux-user/sh4/termbits.h        |  19 +-
 linux-user/sparc/termbits.h      |  18 +-
 linux-user/sparc64/termbits.h    |  18 +-
 linux-user/strace.c              | 415 ++++++++++++++++++++++++++++++-
 linux-user/strace.list           |  17 +-
 linux-user/syscall.c             |  35 +--
 linux-user/tilegx/termbits.h     | 276 +-------------------
 linux-user/x86_64/termbits.h     | 254 +------------------
 linux-user/xtensa/termbits.h     |  53 ++--
 thunk.c                          |  23 +-
 27 files changed, 900 insertions(+), 2807 deletions(-)
 create mode 100644 linux-user/generic/termbits.h

-- 
2.25.1


