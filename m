Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0645C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68862206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="VSwGuuLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68862206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9w3A-0007LO-Nv
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w0x-0002rS-Ad
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:51 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:48453 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w0v-0006Ij-TD
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvihsU0oWiPM8l/isp5z8eqm/Wn23wsIrlyC+3MUUkpYfZIYqI1joDp29tNKL0JFWU4sWjYZfugOU7quNhLOoP+ddiDCXvnCBxYs2RLTdpjMqynC3jx7BMSBVnHuPGvvZMFWZuL7FWzICoPOWJeH0G9An7yy51x3fMhl2avjBeok9cpycQOzbnq6HrVv63ZYe89cX12qpgC6Bg45TNXQMhXqgup1UdGoya4d1TYrnN6XtnuBM6asCMdZUUdbnqh8HYoUxu1gNu066CghZxOFDIuBccWDZHLOu9JV4g/mRYADF25znFLo/0ziYtPHsIm41Um9Y5Zj6s5vy0P4FKHwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3K1Hw13tM0eU4oMXNfO5F/khM0Chg60kBr/6nHp6Lo=;
 b=PRBjXb287o+hDdUb8v4ihKvj4MH7xwIru4ZhwYNdVhGNnveV8y+uj+42ed2dsNL6mzVQ8hYCV457NDRf2DhAdFMYTYe0vfLgev2lTYerxwCt4mRLtjsN3BFjoCkXRIw/q+Eq2AZS3W/NrDKbkZVWAvV7uTbk09WoyIv99+lfInPM3XdxoPWd5pf7dczZ09Qc/+6kR9rNwUl54D5w2duWqvb+OxYyXksSVooKcB9S6HanmIDBrcwZzsW8RZhGdKkiFnnk+sciU8psAJ01R4so6qM7hzC9jHMCVSSOcUaIlCEjkwCiAjrK61EoUNY48draE1wjYXBvm6nLegCk3x3y8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3K1Hw13tM0eU4oMXNfO5F/khM0Chg60kBr/6nHp6Lo=;
 b=VSwGuuLM2DAHsjJmTyDbpYLTTbt4DVupZVOARgpY7Pe6KrHe+Hnp4dTMPOdjvsY1WEGEPxHjFDu3m2P6Hj49T3pLJdxI717rsfQI5C8qyui1fK02IjQ4JbtD+mcvlejM3WI5Wx9v+4A++egqWNmg7nI28I+TY2zunpuaV5I0GTM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:35 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:35 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] linux-user: Add support for a group of btrfs ioctls
 used for snapshots
Date: Sun, 23 Aug 2020 21:50:08 +0200
Message-Id: <20200823195014.116226-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
References: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
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
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:50:34 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8611fd6b-a492-4f07-0788-08d8479dcd08
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB6143859F7ED6B3635BFE9E43EB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Dqp3DZb9OBEjvU0wzI4CbUR8ZWDWc4Ar8RRHIIgdo+ExRQmZRbVD9xTllWWO+8cV5T2vzdMDpXjJvy25lIigQME1aB+aPIE5yaq9Xf2LvepM5FM6801fbYY2hLDVb8vJNH5h8OZykU+BS8pAblG3dB4mUh1FZVt5oYuqmOB7gkX0Oj2hnkS8EWutl+gaM1SB+Pyb1G79GY3mTPVjOrwZRdAXD8FdI/sFkYIbi61mdU54x7Jn6qJpqMoBsyOHW6SGLhi80KZEwMn9yIARE5OnAbdP/m0LYDQL0gqliM2uXtFXbVasZgBDNilSCGZsBpfXNwNefvrCn9Z74bof2wdHWrEETlU+fB9ETAsGI5jpv7lLRgzC/rfueU8prYO0YbF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(69590400007)(16526019)(1076003)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: K+I+lT/E2nNllKC6jNerULmtJalFg9jySfUgg7GY1D4+yS9MIi3i4prD8F85UZD48q/VNWwPSI0dmSWkWB1qC+7jXI1JMiH+G4px9qNZPDNs2Bce4dLX/v6SqCkgQgsCDOsLUSM2LMHJKuEUPrhBTvQXlKznvB06+NRxA1zDZ1EMkU40zBnaSH3QzIhyH9iHp6gXOVgCX4edjv5bn+cPFpx0sMOFf43GkTQ9N6GuWzuC3byjHa9/krexV2e+fIEAMqrWwet66NwSfPHpYJ4SvvdF8YU4xKoYTssGa+E+l2m1UwSgfodQCGK3C4kso6OMx6Z1SIeBSQpzoWgcOs8es1UAvnukTUFT1Zpdx9Is7roLWCQc64D/bBegBSAerJLI49mmkj/cZ8w9qrOwxI7b2e4ss/pHvL1H2OTawgK4XgZ6QymLRtsR+ZE6yCVs+8v7zdSjTVfbCSVgJ7WBDl2/fEOZnDfggO8huZ/A/CRg3kqhlw0hFf0aMaGfcQH4cS6orJMarF8TQ0ZvqJSUizc7noAjtfHfuoXSb1ZkFD+bZ/U1A0DD8pq7w8nLgCKBcHmeC0B27ykto7gUyyYzk0xpfoqvXQYy6X0F4u9PILTUiSRfVPd1jgFsI9kU/RZaL3YSmYCCcNuZT5ea0e5I7KTHSA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8611fd6b-a492-4f07-0788-08d8479dcd08
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:35.0646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSOHJYcRDaapj9t++2SGUKg6/h/QCGE/frj2/2SPuCdpPqEjm0s1/7s5qB4JdFHa42m0N7jKA1/5lfO9sz9bIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6143
Received-SPF: pass client-ip=40.107.8.121;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 15:50:44
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
 linux-user/ioctls.h        | 8 ++++++++
 linux-user/syscall_defs.h  | 2 ++
 linux-user/syscall_types.h | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 12d1444224..f33a99f8b6 100644
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
index 2757956dfa..a945e12547 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -968,7 +968,9 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* btrfs ioctls */
+#define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
+#define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index db61dbc1b3..038cd7869b 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -354,7 +354,8 @@ STRUCT(blkpg_partition,
        MK_ARRAY(TYPE_CHAR, BLKPG_DEVNAMELTH), /* devname */
        MK_ARRAY(TYPE_CHAR, BLKPG_VOLNAMELTH)) /* volname */
 
-#ifdef BTRFS_IOC_SUBVOL_CREATE
+#if defined(BTRFS_IOC_SUBVOL_CREATE) || defined(BTRFS_IOC_SNAP_CREATE) || \
+    defined(BTRFS_IOC_SNAP_DESTROY)
 STRUCT(btrfs_ioctl_vol_args,
        TYPE_LONGLONG, /* fd */
        MK_ARRAY(TYPE_CHAR, BTRFS_PATH_NAME_MAX + 1)) /* name */
-- 
2.25.1


