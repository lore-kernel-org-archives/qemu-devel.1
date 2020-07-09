Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C714AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964192078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="lKxh29/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964192078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZ5n-0003IE-Th
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtZ56-0002QS-7M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:07:28 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:38927 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtZ54-0001Sj-9j
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obIm3zmXu0ekq/s1jZJn6ksDk0O+qufZCQaAHs0zap3lMijIX35VMBRHlgha8hCVeqxLcHp4iGy5wZ1RtEZbkK2gL7o4SVyaCFksliVAtkQknICRHvdfywgnyfwGO+J9R/m10VVeQ2jc35Sb3f71RhICcyKnxUCVr4GSuppEdUHpZBxcEIiT1iR6XwwRiY+cHei3/tKOBPTR65+bSC6kn6OFXLq6z6m9YUcBRsgY8N3px/wiXTNu8GmHUeqAjBce6FdR6tyG/Ok/VQmTYxH0w/Z/kW0udiDzIXDYYRVllUhXD+F190Clli3VdQ8StIZnys3PT+tbK3jsbtYOd2XCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqbrL1uyqJdKso/LidwZnYhWNbWd5W1B7hd6KlVBqD0=;
 b=mz5DsE4Qatp/l8VbIykqv0YCk4ZZVXJJ9I7a7DFBgQr5dZgk9YlUoPDrGpocvSaKbmjEjKHj7D48DaRUkDVYzdFR530Qu2seX0ushpLDlZ2LPBYMRCafUdHUnvpiIS0SNhxtfG/xy3K+hKlZW0Di0GbTSE6H39G35/ksSWF6ZYvl7Vi5wENJwTxvBJXFdX3K+0Kfqom1uvbHFTpI4aJcCBQvaWvWqPH7kRUAJbRdwLf4niwUKGrU2JiSCylk7QNwoEmuFA7H5aRSoksxN73sXSFnZrYrr5jYIF3GAslvpRcXRdwkv8kwFt0c7w1T73orl+++4HIsUhr6fUvCF6HowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqbrL1uyqJdKso/LidwZnYhWNbWd5W1B7hd6KlVBqD0=;
 b=lKxh29/0gIl8/BkawqdjoyKgeFghHKf0NppmFi99yEi7Q8GrDm7RGzKT6A/QobhLFSHUQW7fDxJhnTR6A1G0P8Bgc1ZJImxeLDYY4qDWG1NCekoPJAR31tpq2DOxHPgxgaCwNT2yE5oN9Ro8/RIYQFapqePKvudWtic/trqKdnM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR0302MB3223.eurprd03.prod.outlook.com (2603:10a6:209:1d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 9 Jul
 2020 15:52:20 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:52:20 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Add support for a group of btrfs filesystem ioctl
Date: Thu,  9 Jul 2020 17:51:59 +0200
Message-Id: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.245.225.24) by
 AM3PR07CA0147.eurprd07.prod.outlook.com (2603:10a6:207:8::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Thu, 9 Jul 2020 15:52:19 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [109.245.225.24]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f864539-9de3-4877-c870-08d824201013
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0302MB32238A6DB7B9D5C24AB02F2BEB640@AM6PR0302MB3223.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tj/oTro/vUJMhlLUS0CfvtCbzkfX5l/mljUp09bQ+4OO+iKLBCll9AzpXr04LhykbxhF/nCOIyOxvUx6YiFBMCnW550CnUjksnX3iIH5rvUlI77a6RKFgv058tXWzXgl/bhj8fHeDST9oUPWFl1X+jh9ncpBLlvhi78jaur48xW4HwHcCsP/+BNDeA+kCGuvdDJmyjs6Mu6bK3xgO4Nhw+mNI7cmzMmPhkhWWRgtSxcJg6AFHejtj7agRfds80jwjhmS6xwqXnUrWiXeRP1Z/2YoLwzEAVHsHKlTNIdxbg8wvnhO29CMG+335kTvY+DnB5FZ+GAdJUo90+yx87ErqFKapm+HerQh9hYFof4bXVIscEM5dP9kQrtbIgB90gZ5xgXRFEgBvf5L590bqQr+Xgr3g0o73HSlhd2HNqPbC4S/39MY8tXJ0FPE8+4JpBSsxkNtxVaddVTbiaH8KSwtQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(39830400003)(366004)(136003)(346002)(66946007)(66476007)(16526019)(186003)(66556008)(26005)(36756003)(52116002)(2616005)(966005)(956004)(6506007)(6916009)(107886003)(2906002)(6486002)(83380400001)(54906003)(6512007)(86362001)(1076003)(4326008)(8676002)(508600001)(5660300002)(316002)(6666004)(69590400007)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FDjse/CbvLNM8HrNiVrDwnehuGu7r/h1JvcDsUL0o3XQ8OtFqvYc2k4mHhXVsenHC/L+W3aSvmIqYsGHC+hD+ZgX5cKccc4w0mJLMZIJVrFDz9eInVp7TZmcRTRA1pWrMQOj7zF+M9fdAms6gEwd5y9zbLN5PpYerDxrberpBiOs4brw5k5VastC5b0gVd1xDtNwQMk2PvEOnJ21JE9IORg/a1vBZLOLA9Nl5Kxrd2Cm9N/JT7rVK77Q3A0gMAxI7H+ngyM78VSIxO7xwYDAZsyd1AMfOYeFpe1LvpGBjW+oHWYckhieTqdjfNbSS1ZRrCZwemiPK+UgKPRidNXK/UEuTNNNqN1FaBBbDWcrZVGTRyNtTkU+sszUA9f77JE1qWLumUnfxp2m3skYb2zUdG+djRZNYwHdGk1OJ6wKP3cUo2Czl19SoxJXVMfhAj1t3LPuOBHr8ajny7B+d1cvPzp0M6/uBy/X1YWvCk8Q0ag=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f864539-9de3-4877-c870-08d824201013
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:52:20.2639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 028yL9R2JPsHd4BEHaUCkOo5VnLPtHSmEnNPc4Wa4tX+Uj3nEHvJ0tMCT+afKUNy1CSwhKQGvyyYMcdtIrkaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3223
Received-SPF: pass client-ip=40.107.8.111;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 12:07:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

    *BTRFS_SUBVOL_CREATE      *BTRFS_IOC_ADD_DEV
    *BTRFS_SUBVOL_SETFLAGS    *BTRFS_IOC_RM_DEV
    *BTRFS_SUBVOL_GETFLAGS    *BTRFS_IOC_DEV_INFO
    *BTRFS_GET_SUBVOL_INFO    *BTRFS_IOC_GET_DEV_STATS
    *BTRFS_IOC_SNAP_CREATE    *BTRFS_IOC_GET_FEATURES
    *BTRFS_IOC_SNAP_DESTROY   *BTRFS_IOC_SET_FEATURES
    *BTRFS_IOC_SCAN_DEV       *BTRFS_IOC_GET_SUPPORTED_FEATURES

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

Filip Bozuta (4):
  linux-user: Add support for a group of btrfs ioctls used for
    subvolumes
  linux-user: Add support for a group of btrfs ioctls used for snapshots
  linux-user: Add support for btrfs ioctls used to manipulate with
    devices
  linux-user: Add support for btrfs ioctls used to get/set features

 configure                  |  9 ++++++
 linux-user/ioctls.h        | 59 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c       |  3 ++
 linux-user/syscall_defs.h  | 32 +++++++++++++++++++++
 linux-user/syscall_types.h | 49 +++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)

-- 
2.25.1


