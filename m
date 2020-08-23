Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C531C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3DB206B5
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="uORzYjO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3DB206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9wFx-0006sk-VJ
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 16:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9wFP-0006SE-H6
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 16:05:47 -0400
Received: from mail-eopbgr60112.outbound.protection.outlook.com
 ([40.107.6.112]:3556 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9wFN-000815-A3
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 16:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv0tfbpKsGY+ydafhKS/SSEeeIXbpiP08d5cmtKSCOdPVBySrYeG+vdxpUUSTF/fuPVmHl9maustF7pGYN1gtNO+PNru1qWoB+3udz8hhUO9dY8TBplzCOULL2VJbW6WIvHgb5X54ua3V+pQzNhrw/ZCq4SWo1QmtbdIt9A3F7xk1A/99Hv0H/1q1bPNiushhYroHC0bUiaSHmjHWseuLMzGuSsgVPCURMqv2C8BFayzAD8D1yCz1ItaLNolQsjzRzlOqXgI4FaDlC4bSU+gvUSXH6CvCJ2nmu4RGRd94/cCcleFIBYr+maH6aZ6P85XQRgts8tvIc+YMy1Z+4eelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXvTqARcubT7NrjZST8nmdLWL5bQrEK4SCZIkK9n+mk=;
 b=oZp0GtS0FNnTMnChTVGOC4FT2gYd3FSETAEgBtn76fY2xj5/ygxlj64kavhj30uc5z00SDC72DCnJMvvsHv+KatjzNmY0Iw0N3QAlW44NP4cW6FQuAH3GUM1saT4hrcq7UXkh1yOciJ1u6/5XcE+oUMYoDl5Q9CXhSx7LHqOq96lcIIJMBByy/kiXsrENg7DN6+vh2sc1ZulpTjgLRxAeOY/aWjrFVLiA9QKterjS/3gHQWhVIvYni2bkppTPgioJg1EpT7YJ0VZE+o3bhXTL19YJqeH3r3W6wllVPsK2ZUgazLEvaE0edBIFJ6br8VHoItM2/zxo+Lc7FI9RXghNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXvTqARcubT7NrjZST8nmdLWL5bQrEK4SCZIkK9n+mk=;
 b=uORzYjO2bU6Usnd2BNJzdMhZUXX+8txWo5iOx7ErXihfQd5IZi6BvTcz152HuOwmKlB/KJC8BnVFN7jSbyF9doqDOWvTIR4ntintKMMNgL6yupU6UY5TrZ+zriNspBmCvyEs54IhXH2xRxd7YhQkCxsHDHwE4OeV6CPUBM3TiQk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:33 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:33 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] linux-user: Adding support for a group of btrfs ioctls
Date: Sun, 23 Aug 2020 21:50:06 +0200
Message-Id: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::16) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:50:32 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5761162-c9cd-4ec3-efd1-08d8479dcbfb
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB61437F98E6618480F1457B4EEB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g771zFumxE+O1BePziW7dtzu5tIaqUxMhhk2P0X5t6Q8MlKMW3NWFZHHjmzNiArrTnzX/jITmxFlSG7pgS59GOPcOtbXKuJw2UeR6Q2VLMBUbwmQ+BzwcEvee64zrNCfgGvmumn18SUpij6qfRPouSJSLxAOGc+8Z8Rqo4vsmB1I7Wu2srb3AL2tj9qw2aBXj0IMoDblp/LLyd3ImFVEosiwTL8ZruFWCWyYyQ4poCoQxZ9ymiPA/h+bzIQ5o4esXy0+71cRC380oQ6SK3miv1vmdXn4j2egS1HmVj2AAFOuOf4H173QoIxp4AbBZD+IMTwBheiMTmFdDSnjaCnmx3uBGeQPXOccjHA59YLF6D/MHlqIuWxU8JGyjoD6h/tVcQXl8P61cqZEpVLmq4UZe433LTppGjKR6mhtmcKjA+VE1efei/10Dcn/nUIKPyWKEk2KEl1nbIRJxsQ7plk+KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(966005)(69590400007)(16526019)(1076003)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: N4KbiQNaogEG414M0KpSBqnrLPYSOcGO2UQgzKlYYmaL8/JmXfE0pEciqACH918A5xLLltq931cQe0SfejzUKBreH+1e/ocMMsGVnyYm+/kpI/SBQktutNnLlAWKUNS7zMJKrBR/1pORYZEasb9ystrqc/9kvZ40CF0UJcUUsZP27pwVD5kVcHcyqVHwvndLNNqdpGEjY6Ej+WjGkkVKGS0IO1yB6dLo++f5XfANYYUKDobUtUDiRtWtTacqKC1kb+myICKWd1B68aOjrPcGcasm21wPYpyFMP/f/eBz8rktGgfsjWXKsfgnQmmyeqzUfRxuFqy6+j764B8MLt2/sqrUTg7LZaQutqtVwX7RQy7SjiUZ6yg67+HPz8qRcHZg4hdnobKzPhh/eKf3UJiPl2DP00qok9pXJv4jsCygJDv4fbmCR39Mufr3jJ88964KJTsot4v4URfHFXF9a07VxP0iI7H4viDTS/GyHoG61yNeBPck1dijZExnbx2yN4GeN5qhWDep6MkZ3yKYcbMdvZBl+s1/p5kV4vLKcGvxwsgKci34pS19xp32VdIVVrcV6LfMg4lfyE38WskRH2WCGUuoA5mO0bpKGLOUpUOWQGhv4eUBtju325fAI5wu9ntCKLHP4UnZ6I84MC+VxmhdhQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5761162-c9cd-4ec3-efd1-08d8479dcbfb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:33.3057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGQsKE0bq64KFgGW1Xu2ocC0TjwWxA7yrqlnpZTuHWgNELfkk9sq/qlF31GHb1ZSK/hzv8mTUdhSWwrnvQZ12Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6143
Received-SPF: pass client-ip=40.107.6.112;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 16:05:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series covers support for following btrfs ioctls

    *BTRFS_SUBVOL_CREATE           *BTRFS_IOC_ADD_DEV
    *BTRFS_SUBVOL_SETFLAGS         *BTRFS_IOC_RM_DEV
    *BTRFS_SUBVOL_GETFLAGS         *BTRFS_IOC_DEV_INFO
    *BTRFS_GET_SUBVOL_INFO         *BTRFS_IOC_GET_DEV_STATS
    *BTRFS_IOC_SNAP_CREATE         *BTRFS_IOC_GET_FEATURES
    *BTRFS_IOC_SNAP_DESTROY        *BTRFS_IOC_SET_FEATURES
    *BTRFS_IOC_SCAN_DEV            *BTRFS_IOC_GET_SUPPORTED_FEATURES
    *BTRFS_IOC_DEFAULT_SUBVOL      *BTRFS_IOC_QUOTA_RESCAN
    *BTRFS_IOC_GET_SUBVOL_ROOTREF  *BTRFS_IOC_QUOTA_RESCAN_WAIT
    *BTRFS_IOC_QUOTA_CTL           *BTRFS_IOC_SCRUB
    *BTRFS_IOC_QGROUP_CREATE       *BTRFS_IOC_SCRUB_CANCEL
    *BTRFS_IOC_QGROUP_ASSIGN       *BTRFS_IOC_SCRUB_PROGRESS
    *BTRFS_IOC_INO_PATHS           *BTRFS_IOC_QGROUP_LIMIT
    *BTRFS_IOC_LOGICAL_INO         *BTRFS_IOC_QUOTA_RESCAN_STATUS
    *BTRFS_IOC_LOGICAL_INO_V2
    *BTRFS_IOC_INO_LOOKUP_USER
    *BTRFS_IOC_INO_LOOKUP

The functionalities of individual ioctls were described in this series
patch commit messages. Since all of these ioctls are added in kernel
version 3.9, their definitions in file 'linux-user/ioctls.h' are
enwrapped in an #ifdef directive.

Testing method:

    Mini test programs were written for these ioctls. These test programs
    can be found on a repositort which is located on the link:
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

v2:

    * Merged two series in one 8 patch series
    * Changed target ioctl definitions from IOR/IOW/IOWR to IORU/IOWU/IOWRU
    * Fixed some thunk struct definitions

v3:

   * Added some checks in fine 'syscall_types.h' to see whether the ioctls that
     use the defined thunk types are present. This is done to support systems
     that have older versions of 'btrfs.h' file or if the file is not present
     at all. This is neccesary as to not cause build errors as some structures
     depend on values which are defined in 'btrfs.h'.

Filip Bozuta (8):
  linux-user: Add support for a group of btrfs ioctls used for
    subvolumes
  linux-user: Add support for a group of btrfs ioctls used for snapshots
  linux-user: Add support for btrfs ioctls used to manipulate with
    devices
  linux-user: Add support for btrfs ioctls used to get/set features
  linux-user: Add support for a group of btrfs inode ioctls
  linux-user: Add support for two btrfs ioctls used for subvolume
  linux-user: Add support for btrfs ioctls used to manage quota
  linux-user: Add support for btrfs ioctls used to scrub a filesystem

 configure                  |   9 ++
 linux-user/ioctls.h        | 124 ++++++++++++++++++++++++++++
 linux-user/syscall.c       |   3 +
 linux-user/syscall_defs.h  |  37 +++++++++
 linux-user/syscall_types.h | 163 +++++++++++++++++++++++++++++++++++++
 5 files changed, 336 insertions(+)

-- 
2.25.1


