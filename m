Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BB320678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Ssxl3/02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BB320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2XIn-0007e8-M6
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2XI0-0006uK-HH
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:01:52 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:36000 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2XHy-0001w9-9A
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuPCdU81kuTnO08kXQVGj1iQdiVIR7DpDZHLEARuyph+knqGgmcQPp7uudti98IEUNmedK1zr1+tv6mhFN2QLlXbJgTcsv8Tz7VyQzp7OyPAiIOrWRdOOURLjIdrsq37UdWru4YNVb5bvypYrkLV9e40hlQO9gdO5x7EFpwKoP9XknIUc6FkJLcVz+6GUlYsEnUPYBBNrnqpFXt4Csq2zsrGf4I4CXVxT1vi2sAL03q48pfNlWTqjnbMwwwb9PaolApBNXBujOHv2aZqqQBLDw8BjytkQ+pWKD3TTBCdX5nG9waouyZrQRxQ+zLQEJ74g2KM0cOPG4OHYefODPi7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgio8VBR9fgU+zFnjrDnb0ZPd6qkkSaPkNZToAXU6bo=;
 b=iRpSj2cIqBTUW1T6WUmJqPhLRMyvRE7m8i5uQwvvWdbNWf8Aj6nJAeSeirfcCDtexZbcZjdYvuvouiA9qQq3tVqU3JBapXIxNcjQftngjFj0qpfZO0pn3cqulZ8xa2S0Pup39Ven9999OkOP8dvtBr1SmjcoDnWWu9TSWiadoc/6onWaMm8zq351mkPOiq1BJaBFYXtgPM1pPpPU92w3E3D4ukoa7fNcOzO0b08bPyLTjFqfwvI/tUa9OwBGPuEfBuuiiWKIBZLfY0oqG6qYN3w7r5mBqb81GqyL1XIl+/iUrYyN6ujcBUEwdE4GQp6LHOdUuYAX3Yvw14gHd+hU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgio8VBR9fgU+zFnjrDnb0ZPd6qkkSaPkNZToAXU6bo=;
 b=Ssxl3/02b/N7fCSLokR9u6aI1t4x/MAFdSvd3ON6ntC7fneVEDzfRMvCvNXNPm2duDKHt+c0iiWG8QCIiTZ5xjr/i1axZOJmAyrALXzvOB3VBh/Pneu/UekZJDU9siBWQbbh8+dcFBbsDDtshbfvMr5fzHxAN1l1T0vYzJ4NzW0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5457.eurprd03.prod.outlook.com (2603:10a6:20b:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 09:46:44 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:46:44 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] linux-user: Adding support for a group of btrfs ioctls
Date: Mon,  3 Aug 2020 11:46:21 +0200
Message-Id: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::20) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GV0P278CA0051.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:43 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0baa480d-4523-4cee-0bb7-08d837922188
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5457779FA71E59F8D921B7BEEB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rL9GMGLSgmbuncBr7tAbP2ZvQUL2Xijdo3n2Yoa1majKRxd9cKra39WT+f7nTkNm7DoZtZnkFXpvDR39/kHErPuwIIrJSkcfWE7XqokUnC/PTo4wdDWOinDvkTUWmigNn2tbTKp75neGnF8/HVGjpaJ3E01aqTW61YILY6mrZlFKf8HrvqqkH18948OOoG/QIcVj7KwBS+lj0kerKW4E4WOsVQbpMRMMAHru6Y4lZBu+aYgmNN5w+/bE8yrz8ILKGbebDq5mYSut30e8zraP74FswvKw7y7scrig1FU66twwBeeFGDh27eA9LbySEAnLtNpJPVR016c6dluQ2ON7JJKXGke3PnSsmvmyYTb4VRJB2wWq3jXJYNvJhIDIVXU2GsirQEu5i5GQTAA+VFGLkm+J3qOtTsDgDV/BBqaeVDKA4ILDXIC7WIHrjlCJXJXbayYcGCDp6UBx1U5vQ9OMZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(83380400001)(54906003)(966005)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OrKQi3344keSix1+rewDBgd0HOB1/ZFnXdcL6oiLyA+SQJ1Ptk0Cn11gO31twgDXNRiwhPnOLT2dqxe4WzGKLU96WfPn1EL6k7Vwoqd5Zvzli2MjK/kcc+Mi5uenUjSYg7iI0a7tlDWdwq/ctmy0QVZy7CRVckOu+IIHfJdPfZOvwdlU13ydZ82JvPahRoYArPBI/0sop4q4OMA3UKqQ87OptcChTfP+ciIirJErSJ5BrI8Hd7F2bX/Y5fZ7yN0J/gcknxvCLojMVsnzQjFfi25/7owarnL+yQODwOq+hM4DZ+Imw4UT+Fw5RU5hLMsxJW0mUQp0Gsjcgwz2n3K2GXtCxDVF8KzjwIzKghvpwxcOtXjIaxX7gIG8Tq5Gd2zqp/5pjpvKJ8CSOjyEz9TFqVKFCEudKqu6ngiM/qYSsujlrGqRO6xkpn/i5vngnyuoW3UUSPK2R7P6WvGbUARo4/lVr5JXY6nFUNUqFX8E00NJNeYUg65syWIFbDtF/inyBF2HHX21lh+3frCxknyRbD54FSaw/fGP59BpET/mb6giNuawraZuqtahkoT6st/YCcEOacH8YqxR2+3qwsIKkHXQKiXmaom6rjJ2ctcApXWETQnKCCMCKLSeuuemMBWhes+Y1aSVTHrbixEoWHm+gQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baa480d-4523-4cee-0bb7-08d837922188
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:44.1891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jysybeMu+i5CSUJU/eg2Ml9T4teZhI0C3tlyzyyUIBrDUN66cd7iHaRANyje8ZRq2AwN434KapuryR96YoZvYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5457
Received-SPF: pass client-ip=40.107.6.95; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 06:01:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
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

 configure                  |   9 +++
 linux-user/ioctls.h        | 124 ++++++++++++++++++++++++++++++++
 linux-user/syscall.c       |   3 +
 linux-user/syscall_defs.h  |  37 ++++++++++
 linux-user/syscall_types.h | 140 +++++++++++++++++++++++++++++++++++++
 5 files changed, 313 insertions(+)

-- 
2.25.1


