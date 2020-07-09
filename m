Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12149C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6F22077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="sWiDEFe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6F22077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYrk-0003hq-0f
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYqa-0001e2-1e
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:52:28 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com
 ([40.107.7.95]:49322 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYqY-0006aw-5h
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:52:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i48qROxDvrl6MBf842Gc0viLqky3jODukBOYiOfnZzGMEJQfLVu8z0V6yQ3Dyz5GCvi7bkWvcqBqi9vO2JYY9ZppJxUR1KgnxChg5/49vsnqrAODK2kUmVXHmgkg1JNHqJ0lPRMR9p0nhNJ18GPkOWx8vNbqk2SCn8ryGZuegwaPxsl2bWSbS0K4atlHWu29tZULlB3Fguht52NA5My9/u1+wIOrKd5pC/fwERxdTlcO84zKVI87oULSMQxNcIuAzNHrEJJUr+jECmJNLsZbReDLhawHiQUpKU/cm84ZYed8RFfst/+c+CtEMw+QwqU3UmN10PCJ9uf5Kkzkm10uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb94QBlIVCBKjgw/zGthkYgnaVjsH6UnNivcR6gcdCo=;
 b=InmiJA92saqzsM7TRysWYfXmVCFAXyyz0LGkADXADY8ahzMnLsjAIkjGLDHBWcpYMVNZhcO/usRtsF1Kv/TUn/vVq2e5tmnP0V553TaIcdssV1lYbi4YdfZX72/o6CBlHtdC3kJ+FZOJU/FDMmGrtiHBhKbQzDQUgx+nj+W8FDK5y1YtfY8E69IMtl4omDfHkoXniQ/9dmrrQIPAteL2xvhm9dKrXK7jmCAp2H1DHvNgwp7WTduBk8AbFDM2qOyVoi8Ab3rT6KT0UuvN4kr6u1rVi5CaLlSvgOhVYfAaOQpt/yrT37JCgDY/UC7D6Ox1lpocRrTUbNblowembW0CXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb94QBlIVCBKjgw/zGthkYgnaVjsH6UnNivcR6gcdCo=;
 b=sWiDEFe4wTYvxAkMFG990q8jXRq5kxaW9yn9jrws943AHBrserltRqtYcJHl0b++cvmTHjN7LovmGoCatq3c1MQ/2Q6AwQoHoizFav24qH7Y3zgY4XnKz3Z6VY3J6DklNbWz3eQ5pHrmrm+kpGCCVUIl/VIRtrAJ3ZVIf9pyRe8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6675.eurprd03.prod.outlook.com (2603:10a6:20b:1b9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 9 Jul
 2020 15:52:22 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:52:22 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user: Add support for a group of btrfs ioctls used
 for snapshots
Date: Thu,  9 Jul 2020 17:52:01 +0200
Message-Id: <20200709155203.21106-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
References: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
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
 15.20.3174.8 via Frontend Transport; Thu, 9 Jul 2020 15:52:21 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [109.245.225.24]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2f654af-679c-4d96-7839-08d82420113d
X-MS-TrafficTypeDiagnostic: AM7PR03MB6675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB6675EA3C7247AF7AE22F895DEB640@AM7PR03MB6675.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXXtM5zLOvDk9AGckLehke5+kpZ/NKC0EW6gD7erllc2Z5eSNE6ZTlT5bNa/GsLOre3utj9iTTjD95qGJh7y3+x6O3ltW3MaTr2HhfmF2KP8wS2GNznMXcrM7WekubVYqoYaVvFT9XRYRVPmtUint280JZifGXfrS2H94ySXhHHx8quIg9rU6bF7dYe2+2dAp7Wdk7Xi3On5sUcqBSNK10iegS4+E3v/WrTLahfw5mo7/RyppqdKcb1BJVmF7wDJ5GQgG+XhstBbHbeEzlWF47tejwJFVLdfeQHOzA1pEAdIPhlloAeVZy35juVTxHudEBFC+FmfZCZ15Pd0aZJLwnmbdiS0IxdKSNhgEOEV6/bEhJtuCPvbrl2qg+uWDHuW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(39830400003)(376002)(396003)(136003)(366004)(66476007)(2906002)(107886003)(956004)(2616005)(52116002)(6666004)(6512007)(4326008)(6486002)(5660300002)(26005)(66556008)(16526019)(66946007)(186003)(1076003)(6506007)(36756003)(6916009)(54906003)(83380400001)(86362001)(69590400007)(316002)(8936002)(8676002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: H+q9poCZRKiDV2dXWN6vcS1mP9G2f/jf7oKiVpll4VgtlS+G5r80LV1jB+iDRl+5zQEJM72bpV8vYZUQ4YI1ggXLgi3r3UvAuZ7mjSKzxuzaVObgzKOkfYCS6cBtdeaqcJuVOND+7jfpV+/4wbPZ3WZSnLl+j3hHHnErzl3VzyDyGGhRSEqxg0t/GflgrZsENzNXist84eM4BYBLERFc86OPQ0R08UttnT+/9yvFCLFVo02zGnbGzMDI4TBMtPK9NL4Bryb69++ll6ZattlMpLj9k+SoduJD0H4/V00qV0jWreU6Sd6imrNOf2Sot/V2XMA0Nseo8di79aynAr0BrCwjQOTsbnXPVWkjdSGjIEJxScRB/D1mCG1IbNwEM1fln4W6vR7/lcbPMzs22rxvH8I7NoGCNPRThyW8Jk0Oty/Bn9xwq45BbYyIIrWEJjrs+SkxY2wGaFLVf7kP27OzW4JaW3cFz76832sSEK9Wiz4=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f654af-679c-4d96-7839-08d82420113d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:52:22.1728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQwVSWIAP7R6RRqLRfFxH4rLxJoAUo08DwWpoZFrOUllSJmFDZCheMGihRwH6nbe8AUSLvGQACOZGzawHI9VYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6675
Received-SPF: pass client-ip=40.107.7.95; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:52:23
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

This patch implements functionality for following ioctls:

BTRFS_IOC_SNAP_CREATE - Creating a subvolume snapshot

    Create a snapshot of a btrfs subvolume. The snapshot is created using the
    ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
    (which was mentioned in the previous patch). Before calling this ioctl,
    the fields of the structure should be filled with aproppriate values for
    the file descriptor and path of the subvolume for which the snapshot is to
    be created.

BTRFS_IOC_SNAP_DESTROY - Removing a subvolume snapshot

    Delete a snapshot of a btrfs subvolume. The snapshot is deleted using the
    ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
    (which was mentioned in the previous patch). Before calling this ioctl,
    the fields of the structure should be filled with aproppriate values for
    the file descriptor and path of the subvolume for which the snapshot is to
    be deleted.

Implementation notes:

    Since the thunk type 'struct btrfs_ioctl_vol_args' is defined in the
    previous patch, the implementation for these ioctls was straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h       | 8 ++++++++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 544184ff95..2422675dd0 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -174,10 +174,18 @@
      IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
+#ifdef BTRFS_IOC_SNAP_CREATE
+     IOCTL(BTRFS_IOC_SNAP_CREATE, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_CREATE
      IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
 #endif
+#ifdef BTRFS_IOC_SNAP_DESTROY
+     IOCTL(BTRFS_IOC_SNAP_DESTROY, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index c11bcc6ba9..21d8909fd6 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -968,8 +968,12 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* btrfs ioctls */
+#define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                                1, struct btrfs_ioctl_vol_args)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
                                                14, struct btrfs_ioctl_vol_args)
+#define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                               15, struct btrfs_ioctl_vol_args)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
                                                            25, abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
-- 
2.25.1


