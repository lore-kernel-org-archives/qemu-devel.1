Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B46C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319E12070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="E1UZp7Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319E12070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRF9-0004rp-GI
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwREO-0003wD-7G
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:20:56 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com
 ([40.107.4.90]:41631 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwREL-0008Hm-VT
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVCKLeg0VUdp1nBOX+i981ujfzRLJy3n15BPjzX3cC7xEH64W5JlXgpR1x9fhexNd03Tt8Uk9yM1Eiy5uUc+YZf1Uo/ZUsJRr6Hq0nuaVMc08YOp+nuWQjf5Ssq2Bq0/+DNM7uvEZ4DM4SX3ziEoLw9gfeqzpbrG5gY05Xc65vqoti7H8I2vfmqHE+bplE7JT2ocunb5ae7IvzTXXXSw9fBAHpYyOE7iwCSLpaqProwtLT9h9vJ9MJXGzZL407bOYAjHy6EmbphHzOmTVmcLvvD/o+uWD0GA0hrOUSAMmNQRWtFPBcFhQ0tq745b4d2SBcJFldR9CUCq5Way5j8T9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/JAG6JXLqGZxY9fFsCIEOaB7BPDHNPEj4WMQkiAac=;
 b=kMknVaR0dIwzKGUCwsrpDovcPG6kTbZL0akUgACMrBDeP691nQszitg5a/Sgb3loZyODQVlfENSVToXUyel7tcwowZXvwH8nu1vuMdwvaNyPcoAnh2B4qySQf+fXsBvO6zhyYDwlfVz4TVoAZF67T2N6Pv8mYMk0wNYhv5JnEMnunq9Zg2liaeMc+2ud7z/dXtV3SoaMFXeVul7J4ZKA09HJcNqHZxxXfKGJk4N/WES2p8fI2wOiBUwzkR0RHimSXmoIObezVqKQQKfaFRz6PWAGQ5bXgS3WjVOtzPwyCroT84HD7+AuN9fWYTqEeJLTmBkxe9ZHFgpgaxkSGyib+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/JAG6JXLqGZxY9fFsCIEOaB7BPDHNPEj4WMQkiAac=;
 b=E1UZp7PbI+EEB2/fggz9RYPPdtKKRSUTy8lmM7mTfqE8dVfWn17Olcr3BLtjombZKuM/zT0739LNA2i8U818Kyl6ZQLDGI7bjBs1kOWryqEsZCPXou2QBzI8FcHSl/YxjgrMLmvb8pWn8O6bTvX/cqjEiBdgg8XqEv5tAbioXd8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB5967.eurprd03.prod.outlook.com (2603:10a6:803:108::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 14:05:49 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:05:49 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Add support for a group of btrfs ioctls - 2
Date: Fri, 17 Jul 2020 16:04:29 +0200
Message-Id: <20200717140433.265599-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0026.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 14:05:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e4d68d9-ecdb-4bb2-5097-08d82a5a820e
X-MS-TrafficTypeDiagnostic: VE1PR03MB5967:
X-Microsoft-Antispam-PRVS: <VE1PR03MB5967E55DF0E8D9E1BCFF07DFEB7C0@VE1PR03MB5967.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/5/a7mMFXSNbflS8iMUW+5vkoYuBYw5/T2Ixwrimk/fX3gfJZnPbPS3nUTgag3d8+YkOWyHPujbXu5RrJeKjcCS75TyiZOp2Vt4iSGxfDHaztsW3b/kmIrLdmNE+lHwmIJ0jlOc5+n3RQS86V4gAqt5jbHtYOFUn1etxXejGBZomcTAdIA9lyXzKeieRVp2ouLZjbv0rAMHuv3XgHHjQ3eayLzxt9IXhQz51xzQ3Xz7BkKXnAisKraWwKpm5GUDrJQH+eGgOu65o25QnA6ut8f1GBfSDWRRN/Jdp9hK/zAVdu8G52KLrpl3+ETb32PlRt18uySvAbDxqk/U0kyY/81GN+UYGnCLgLWMdEsWvqQJ8bG03Jjvq9Q65mDbWMCjJPSqZYxkCWC5qobJBVbgrfslfNw0kQrXrZDbDeRd0NMVXbw7HMEQuHEVjrD85FpMflK1yi01fwS17wz/PPxmHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(136003)(366004)(346002)(396003)(376002)(2906002)(1076003)(83380400001)(52116002)(8936002)(66946007)(956004)(316002)(66476007)(36756003)(66556008)(508600001)(6512007)(966005)(6916009)(6666004)(2616005)(69590400007)(26005)(8676002)(6486002)(6506007)(16526019)(5660300002)(4326008)(186003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ScKBD+5Vi3kLxNBObGbMLSYrADvVKR/6QMIm/4XU3ZeiQp1+aH/29SrCvQWtyQS377hY7PrCHx/6WooT8xcqYBUdVgx5wYW+l/I95PNeyrS6NfOtn432YWqSQE9PyIl4jka7mi9DukrPkuBIzLeJr+ZUpW3l+0p/Frxb84d7CoFjisCWrcOM0q59l5PxAY9no4goAHb6xytlpSdNco+zmYkGc4o9TPYItzJtDAl7BdW+EK6wwHaGn6Y2uOLcU29GaArMPu4viVPAkbPLjbEMKbZl5lPPAtIQMveJK7LKGeN4xp0Isxje1whk5xlGbcqigyVwP4o/Je7hI+NKL/mEKMY2hKaF/uiioIMeWZhlKqFg6mkRoWB8fnMBrcLgVxR6WXWeuFE55Mhvr3Gt+Alx2ky4Mrn47ICC5Jgf/1RO05wcdV5fbwGkpjeYU4bA0gF5QxbR2HYjodKOUlGpaFg0NPDAuQDjGaWTmYf4ll5WJ4g=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4d68d9-ecdb-4bb2-5097-08d82a5a820e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:05:49.2813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4fVy6ciVL28rWWukbPWUaCPJLiLdcC7M2YcnclZg5sexHw2L3Uio2jl/a+b0VHyRWkc3Abj6wMz/zpt0PR2Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5967
Received-SPF: pass client-ip=40.107.4.90; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:20:51
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
Cc: riku.voipio@iki.fi, laurent@viver.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series covers support for following btrfs ioctls

    *BTRFS_IOC_DEFAULT_SUBVOL        *BTRFS_IOC_QUOTA_RESCAN
    *BTRFS_IOC_GET_SUBVOL_ROOTREF    *BTRFS_IOC_QUOTA_RESCAN_WAIT
    *BTRFS_IOC_QUOTA_CTL             *BTRFS_IOC_SCRUB
    *BTRFS_IOC_QGROUP_CREATE         *BTRFS_IOC_SCRUB_CANCEL
    *BTRFS_IOC_QGROUP_ASSIGN         *BTRFS_IOC_SCRUB_PROGRESS
    *BTRFS_IOC_INO_PATHS             *BTRFS_IOC_QGROUP_LIMIT
    *BTRFS_IOC_LOGICAL_INO           *BTRFS_IOC_QUOTA_RESCAN_STATUS
    *BTRFS_IOC_LOGICAL_INO_V2
    *BTRFS_IOC_INO_LOOKUP_USER
    *BTRFS_IOC_INO_LOOKUP

The functionalities of individual ioctls were described in this series
patch commit messages. Since all of these ioctls are added in kernel
version 3.9, their definitions in file 'linux-user/ioctls.h' are
enwrapped in an #ifdef directive.

Testing method:

    Mini test programs were written for these ioctls. These test programs
    can be found on a repository which is located on the link:
    https://github.com/bozutaf/btrfs-tests

    These test programs were compiled (sometimes using cross compilers) for
    following architectures:

         * Intel 64-bit (little endian)
         * Power pc 32-bit (big endian)
         * Power pc 64-bit (big endian)

    The corresponding native programs were executed without using QEMU on
    an intel x86_64 host.

    All applicable compiled programs were in turn executed through QEMU
    and the results obtained were the same ones gotten for native
    execution.

Based-on: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>

Filip Bozuta (4):
  linux-user: Add support for a group of btrfs inode ioctls
  linux-user: Add support for two btrfs ioctls used for subvolume
  linux-user: Add support for btrfs ioctls used to manage quota
  linux-user: Add support for btrfs ioctls used to scrub a filesystem

 linux-user/ioctls.h        | 65 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h  | 34 ++++++++++++++
 linux-user/syscall_types.h | 90 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)

-- 
2.25.1


