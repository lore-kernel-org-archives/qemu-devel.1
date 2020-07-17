Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04ABC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE4120734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="V6x+c/Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE4120734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRd5-0008KA-Ns
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbg-0006gU-U0
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:00 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:52288 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbe-0004y5-Ng
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGKCj57lhZbhKXFzb6PgSKWzFbbA9XcpkUQ8ArSIvZdckSP4jHFXkHhJoqXp3ATubDp77uGsbhm+ohhzF45/jP0MUbwSWziJvHfN1ANj7aLkL3HanOFVg/XBnCbJiiu/2gZ4SfsuVsVAGdpfMZ9n3apydtqOj8Lh9uHaoa7W0NOzfR4fRtXxaC5vzLzahcbxeyaTpdnOKTDaaFUUK+b2rYCfwZqHvMX/Np43enTUZOVqoCFmPqlyYVWlHkDf2EAhTYspcilADmFKPOpDApea11AKWaYA0cyg3LYeiP7nV3UvEWkNfpmsHwux0d3TVwbpWSWbM1Got+M9EPGVQnRl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h3Ol14VOarOmBmwFXhbvPY2bOoB+Bqdb0IDqS+qXQo=;
 b=QXXBLhiZgZUlwzWwNbNoXjk+5h9dcajIykH6tONSmWk8Cfd/kpBDUuo+Ea76DfuSHMBJtkq7sdWiGvSP70F6orpJuYyTDK2SUCbmHu7OrGjbdIfgB91LvC8VeTJJApJwblnYUtw+ZPUZL8tNPBXjHnKQrSj1ZeCeIzuEQ5TtMdmt+oJH72ZVKG3P2AzLCL2nvzJZTPu9zcW3wrQUxd5+HgDkclFvfGQw5bkGkBPtuQBo4EqvsEF5usGIt1NmxVTFOzYdrI7Z90/LYsxTmitSDUY7sr+gozA9NUzAuwiBkR/OEdgop6q/xAkXRQCaSBH+Q+yNsKyekQiwMWUuqS53iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h3Ol14VOarOmBmwFXhbvPY2bOoB+Bqdb0IDqS+qXQo=;
 b=V6x+c/UiApKJ3pm4BGdiWs7LfU846AULrr6q72Hd2CEpkRgWCiR7z6KqH+yLsnvvOtidFHoNdSIczFRYCx8k/P3m5PHyG8Fmhqlo0b2RIbbvvC7uK1hF79T0O/UWA2e3zhWmOMKRh4NdCrxPznSAHa/UoocDofAZ17Gy/39Zs5w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6414.eurprd03.prod.outlook.com (2603:10a6:800:19e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 14:44:53 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:44:53 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] Add support for a group of btrfs ioctls - 2
Date: Fri, 17 Jul 2020 16:44:31 +0200
Message-Id: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::15) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0028.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 14:44:52 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62112d31-cc95-4e24-0d7d-08d82a5ff6f7
X-MS-TrafficTypeDiagnostic: VI1PR03MB6414:
X-Microsoft-Antispam-PRVS: <VI1PR03MB64140E91149C276AA9FC0B22EB7C0@VI1PR03MB6414.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kh0BL8FTOMOp/ueb36yKP2u/hiPJlH8e1cLOtw6h0NYwqa7Lqu+WtNTjidqFsCOFL43/Yj0WL6TL8uBQtIUSbVYOoreMVv8k00ZphrhjaXD5R/PfVhmKwAV5jJT2olW2Y6whSfyDlJu2KtsI72C2zLZ39HbfAFv+5P+1qr6VaDnJrdbU6YCmmnlcMedC+1b+m2mjVIuH7lOSaUCksFXjHneyejCv51nwjLaO6Jn+/PY/LKzUKEfR5tGET1vu2/Jn7E+Kyz15ox2oPHjioF9wx1sY+F1uivRnDH5GiSTtNji2Kk0MFuiQ7cyuZVzTm5WNWrwCZ2ssIau/MEYLz0Xg0F6edyy1EiENO0Sr2GB8R8ArLvLMT02Fiyu0rWstf/EVtAPpLBmGwszDDvfHGZr+EfTkaptiPYGLPdHZlmhDg1cuIQpasStUVgytNvy8CfNEpwLGdEnMjA9x7Aw8u1oo3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(136003)(39830400003)(396003)(376002)(966005)(508600001)(83380400001)(66556008)(8936002)(8676002)(6512007)(2906002)(4326008)(66946007)(66476007)(5660300002)(26005)(186003)(956004)(6506007)(316002)(6666004)(86362001)(1076003)(6486002)(2616005)(36756003)(16526019)(6916009)(52116002)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: as9rmc44vihr3RSQdaOVrwg3LZuFlzbY9khmoDDw5Pfuc4TqYzk5ZP9q9T4telXZu9OLo1JJsVSQJSdBo/S82GDpq33ksjKemTKGL5kv2xBWn1hOzTi6YQ9S5cPUaxZ+YBAfzuBDu1BoVXl6r5BmsBpHZYViyMFn07G7eQcFMnu5EljUwd10P5lV7ioAT5aZsPnKuhCbm0yw/CwNPpaLky//DGDj4eIcT6IKyzg5c1tQZMz0LshZaAFYh/CY0Cc3L8aooFvV8WZUW55ewRJtQwwGPUXfmEErLgOlqK0e0J8vTC6WGeMjvoIQRc2nDkaZtSlCg7zzLXrzXgQfzNb5DQYoGtdXwpCbSaJ8iBzpBGUWYaAN9O+/dbu/D79/IHfSk4xtyJt6gCBIRcLqdNsxhiKmgFuxU4QTolyQMNwMirXvFsB8mliYo0ZjsisdV1JVZjGY+j1XGay0jpJ9601NZqbdWOn5BRbN2pCXTgaUAxw=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62112d31-cc95-4e24-0d7d-08d82a5ff6f7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:44:52.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNtQtfHgQxlCBZs/VFJ8MVIv5cU++poO3pJmgcVf3huWGhsTezktyzfQGaxvUgyRlfgjcG+E2chFk6SrCCYtag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6414
Received-SPF: pass client-ip=40.107.1.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:44:54
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

bozutaf/btrfs-tests
Contribute to bozutaf/btrfs-tests development by creating an account on GitHub.
github.com

    These test programs were compiled (sometimes using cross compilers) for
    following architectures:

         * Intel 64-bit (little endian)
         * Power pc 32-bit (big endian)
         * Power pc 64-bit (big endian)

    The corresponding native programs were executed without using QEMU on
    an intel x86_64 host.

    All applicable compiled programs were in turn executed through QEMU
    and the results obtained were the same ones gotten for native
    execution

v2:
    * added Signed-off-by tag (forgot in v1...)

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


