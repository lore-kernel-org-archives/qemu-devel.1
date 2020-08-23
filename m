Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E8BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949FC2075E
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="VOGCOobX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949FC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9wAO-0004hx-Sr
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 16:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w9d-0004AD-D3
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:59:49 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:30689 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w9Z-0007BN-Sb
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:59:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8H3XjPO3Z1Woc7TsbSSJYw5QeGBGDCU/trXJ/rgTaTaHsb4n3t7+hly5olo5ydC/NZIX1LKZ9wEuuMNz3v5F4bjOgYu8gDjoOALbMbiBT2ftUcajPTb0LZBwAKL3ifDPvkpUz8fqi8RRE9+xI6dGEpqGolb5kACHYMX8Nw+T1j65qvfeO32c8V5qmC54HrQY6POu3B8nCAhuySrebYySgNDxAeVj4LPSfDXD8GOzokJsRjyIYj4ywQOUfN6lwvqOqxvfShHWFJYKydTAZEE2ZyUrPxb47YHLWwj5vg3I9m4YORSI/pxItw0OHwKX7e9hWK7yUjRJ1AosWXyukROhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMFa0FiIBzRXQ4m0IiPCjLLT9ZoveybgJX5NxxhJMY0=;
 b=SVsvmHHyCpD/yzd3eZ59CQ1eyvX+Cg6DAfR6CmgUgcg2aW+vRpPRfPFamULm7r+EMaL5LOjB8jV5Y1otGFhA8hu4L1CQB3hjdh+Gh4qxpncetoZcKHRV4FjRqHVqEAZevtYO6yP9sG4JLi4MI4Yy9H8CKSNxS1OtPTdWJgS/OOFCJtN7AAyn3ktflimQU5MRRBQQM8E1b3yj1BLEp3oj3Rli7H/WL2HB+OKb2Y1EAihuCX1BVNQtodSL/wUONWGBiqakkrW40cyVUN2Boh04/iUn+ZBdCXUApYPn1msY1pDmxD+86Nxf7arcF1rNQe0rF5wWxqnAIsM8Yq9Qc1mztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMFa0FiIBzRXQ4m0IiPCjLLT9ZoveybgJX5NxxhJMY0=;
 b=VOGCOobXcOvpR0pd3JL7GUpZ/SoQ01TXLlBGtJkONfkrJNrLAV2Fp7yH8F7Ms67/0MNlk3JaOEkQt6LgIX7vvlw3f/zYcHwk3pBADhn6Jyty0do0Q1jZzL0dZbWZeLF3vZcWkH+jr7MGoa6BBcTaRN2pCTmvJkyZ5gNy5HzobZo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:59:38 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:59:38 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Add support for a group of '_V2' btrfs ioctls
Date: Sun, 23 Aug 2020 21:59:25 +0200
Message-Id: <20200823195925.117104-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0103.eurprd05.prod.outlook.com
 (2603:10a6:207:1::29) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.236) by
 AM3PR05CA0103.eurprd05.prod.outlook.com (2603:10a6:207:1::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:59:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9edb5f0a-8fbf-4cee-38a9-08d8479f10d3
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-Microsoft-Antispam-PRVS: <VI1PR03MB614300BE0719D7AC0EA90125EB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mm62ZV9COv88IcAegaRKLZMdeaGQ8cBWoq2QcTJiNYh9F1XT13NIDVk4SmFhrzsaPv4Qr+89ugMK45GrzlTYSx684QlRUBPapGxpCUBd/NbFFUTiZrjSzrYcAIOJ6++CQWSEIUI5QJDcEBHWGaZJr4NKZP6xNbKFZpaNXPx7x1V2nM0b+zUIeQiwc3gYrFyKhXckICixI8diBBHkBi5wLf8bbFD8NcUPSvnV94TEo3eLKGsdLCL5oUIMwheYIH8RMRt+ujPnYChu3p5uul/3Vx/eNOhA5RVDXp0gDPMSYGV+PdcaCe56PgBFYyy6Ayisx58mlLncomQYxCyfkvz+LOZNZJ2NpmmHai71r/05SRncT2Q/KRHU4g9cxXOByLQwN4VpiFzNzyGZgsK77AvT+/pL7Eb7J+Y+iEJKCe2hl+uZ6v+OGVuQEnRHJ8BaLQ1pPMuiQPWWSVoDQZyU3Gv2T3yR72R1AYsU4MoXWt54W0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(30864003)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(966005)(69590400007)(16526019)(1076003)(83380400001)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bxv0GHK3hPAxoXfWXyeQTrQ0Ap1FWJS3CUDNlgZ0Pzl0Qae+pSmlQGHKqJRRyrXJjnLtJ1FeQN06FQaEIlz81bmocaQJy4w3HF5I96GoOTd9n40m5jJZy+czmx7UAkA0Dh5SBEUKVV7oz908cqhDZZMFNJrTWhe9kqMeOJLEmT1US1pxHgPradxF4YQlXZT1APONWfrNUuOepm6/pzZCeggb2HABc5wTl2cA7Ej0zwA1a05sJbIMknFFYaarjiZwb+O3tXgiujUX3jekEsMAGIQYYKiPpTE2TdWfFkq3G65rHE3R0XKdfneRKsrrZ9+zq9NKlcjaIgDO8wi2vwyOS9dnn+Y+doMB3xM0jsvELrnXeorOAK/81HrdaROfwqLfM8//405Px2hW+XWx+3iRuJqGS/NiQE1bU8W0TuyrdswlVb0sGYejoKbQ24/XG9BKgJbpI5bY1u/zr3O7WsV0Fb0xaAvboHdnKjnHdZuiaetE5pKJty83uzKrV+WXi2f7rKKToolzr0f9wPrJOWHoN/ZCQMKvh51ZidKvIl6baoe3w2KvW0ujYqbNy/qWpYgZt5CllyNbZl13nRoPFl1nhi436jdLEpf5MUzHiSqmow1n/dZ+kr2MsLeYTw3MWPtjk9VJzhNyhJJncEgVy/UpxQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edb5f0a-8fbf-4cee-38a9-08d8479f10d3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:59:38.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRFPgaUHwwF8vPyWGhcBhfSyt6Nkns0gno18zuix/aG7SrpqmuHOELDGuIpml+a7CDiYZCcROHtlY9xeXoDnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6143
Received-SPF: pass client-ip=40.107.8.121;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 15:50:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces functionality for following btrfs ioctls:

BTRFS_IOC_SUBVOL_CREATE_V2 - Adding a new btrfs subvolume

    Create a new btrfs subvolume (same as with BTRFS_IOC_SUBVOL_CREATE).
    The third ioctl's argument is a pointer to a following type:

    struct btrfs_ioctl_vol_args_v2 {
	__s64 fd;
	__u64 transid;
	__u64 flags;
	union {
		struct {
			__u64 size;
			struct btrfs_qgroup_inherit __user *qgroup_inherit;
		};
		__u64 unused[4];
	};
	union {
		char name[BTRFS_SUBVOL_NAME_MAX + 1];
		__u64 devid;
		__u64 subvolid; /* added in kernel version 5.8 */
	};
    };

    When calling this ioctl, the 'name' field should be filled with
    the aproppriate value that contains the name of the subvolume that
    is to be created. The flags field can take values that are
    'BTRFS_SUBVOL_RDONLY' or 'BTRFS_SUBVOL_QGROUP_INHERIT'. If the
    latter is specified, the field 'qgroup_inherit' should be filled
    with aproppriate values of the quota group in which the newly
    created subvolume is to be added. The definition of
    'struct btrfs_qgroup_inherit' can be found at:
    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L90

BTRFS_IOC_SNAP_CREATE_V2 - Adding a btrfs snapshot for a subvolume

    Create a new btrfs snapshot for a specified subvolume (same as with
    BTRFS_IOC_SNAP_CREATE). The ioctl's third argument is a pointer to
    the above mentioned 'struct btrfs_ioctl_vol_args_v2'. Before calling
    this ioctl, field 'fd' should be filled with the aproppriate file
    descriptor value for the btrfs subvolume for which the snapshot is
    to be created. Also, the 'name' field should be filled with the
    aproppriate value that represents the name of the snapshot that is
    to be created. The 'flags' field takes the same values as in case
    of 'BTRFS_IOC_SUBVOL_CREATE_V2' and represents the same functionality.

BTRFS_IOC_RM_DEV_V2 - Removing a btrfs device

    Delete a btrfs device (same as with BTRFS_IOC_RM_DEV). The ioctl's third
    argument is a pointer to the above mentioned 'struct btrfs_ioctl_vol_args_v2'.
    Before calling this ioctl, either the 'name' or the 'devid' field should
    be filled with the name or id of the device that is to be removed. Also, the
    flags field should be filled either with 0 or 'BTRFS_DEVICE_SPEC_BY_ID'
    depending on if the device is gonna be specified via name or id.

BTRFS_IOC_SNAP_DESTROY_V2 - Removing a btrfs snapshot

    Remove a btrfs snapshot (same as with BTRFS_IOC_SNAP_DESTROY). The ioctl's
    third argument is a pointer to the above mentioned 'struct btrfs_ioctl_vol_args_v2'.
    Before calling this ioctl, either the 'name' or the 'subvolid' field should
    be filled with the name or id of the snapshot that is to be removed. Also, the
    flags field should be filled either with 0 or 'BTRFS_SUBVOL_SPEC_BY_ID'
    depending on if the snapshot is gonna be specified via name or id.

Implementation notes:

    Since the third argument of the implemented ioctl's is a
    structure that contains unions, a special converting function
    'target_to_host_btrfs_ioctl_vol_args_v2' was defined in 'syscall.c'.
    This function is called instead of 'thunk_convert()' to convert
    the values of the third argument from target to host. All of
    the ioctls in this patch are of type 'IOW' which is why a converting
    function from host to target is not required. Also, a separate printing
    function was defined in file 'strace.c' that is called instead of
    'thunk_print()' to print the contents of the third argument.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Based-on: <20200811164553.27713-2-Filip.Bozuta@syrmia.com>
Based-on: <20200723210233.349690-4-Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h        | 16 +++++++
 linux-user/qemu.h          |  5 ++
 linux-user/strace.c        | 95 ++++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c       | 77 ++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  | 28 +++++++++++
 linux-user/syscall_types.h |  5 ++
 thunk.c                    |  2 +-
 7 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index e3bfe78774..a29ce6b69d 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -209,6 +209,14 @@
 #ifdef BTRFS_IOC_DEFAULT_SUBVOL
      IOCTL(BTRFS_IOC_DEFAULT_SUBVOL, IOC_W, MK_PTR(TYPE_ULONGLONG))
 #endif
+#ifdef BTRFS_IOC_SNAP_CREATE_V2
+     IOCTL(BTRFS_IOC_SNAP_CREATE_V2, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args_v2)))
+#endif
+#ifdef BTRFS_IOC_SUBVOL_CREATE_V2
+     IOCTL(BTRFS_IOC_SUBVOL_CREATE_V2, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args_v2)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
@@ -281,6 +289,10 @@
      IOCTL(BTRFS_IOC_GET_SUPPORTED_FEATURES, IOC_R,
            MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 3)))
 #endif
+#ifdef BTRFS_IOC_RM_DEV_V2
+     IOCTL(BTRFS_IOC_RM_DEV_V2, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args_v2)))
+#endif
 #ifdef BTRFS_IOC_LOGICAL_INO_V2
      IOCTL(BTRFS_IOC_LOGICAL_INO_V2, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
@@ -297,6 +309,10 @@
      IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
 #endif
+#ifdef BTRFS_IOC_SNAP_DESTROY_V2
+     IOCTL(BTRFS_IOC_SNAP_DESTROY_V2, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args_v2)))
+#endif
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index a69a0bd347..4add164673 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -708,6 +708,11 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 
 void print_termios(void *arg);
 
+#if defined(BTRFS_IOC_SUBVOL_CREATE_V2) || defined(BTRFS_IOC_SNAP_CREATE_V2) \
+ || defined(BTRFS_IOC_SNAP_DESTROY_V2)  || defined(BTRFS_IOC_RM_DEV_V2)
+void print_btrfs_ioctl_vol_args_v2(void *arg);
+#endif
+
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
 static inline int regpairs_aligned(void *cpu_env, int num)
diff --git a/linux-user/strace.c b/linux-user/strace.c
index b9ba39ce6e..04fe38a846 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -9,6 +9,9 @@
 #include <netinet/tcp.h>
 #include <linux/if_packet.h>
 #include <linux/netlink.h>
+#ifdef CONFIG_BTRFS
+#include <linux/btrfs.h>
+#endif
 #include <sched.h>
 #include "qemu.h"
 
@@ -1434,6 +1437,22 @@ UNUSED static struct enums itimer_types[] = {
     ENUM_END,
 };
 
+UNUSED static struct flags btrfs_args_vol_v2_flags[] = {
+#ifdef BTRFS_SUBVOL_RDONLY
+    FLAG_GENERIC(BTRFS_SUBVOL_RDONLY),
+#endif
+#ifdef BTRFS_SUBVOL_QGROUP_INHERIT
+    FLAG_GENERIC(BTRFS_SUBVOL_QGROUP_INHERIT),
+#endif
+#ifdef BTRFS_DEVICE_SPEC_BY_ID
+    FLAG_GENERIC(BTRFS_DEVICE_SPEC_BY_ID),
+#endif
+#ifdef BTRFS_SUBVOL_SPEC_BY_ID
+    FLAG_GENERIC(BTRFS_SUBVOL_SPEC_BY_ID),
+#endif
+    FLAG_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1774,6 +1793,82 @@ print_termios(void *arg)
     qemu_log("}");
 }
 
+#if defined(BTRFS_IOC_SUBVOL_CREATE_V2) || defined(BTRFS_IOC_SNAP_CREATE_V2) \
+ || defined(BTRFS_IOC_SNAP_DESTROY_V2)  || defined(BTRFS_IOC_RM_DEV_V2)
+void
+print_btrfs_ioctl_vol_args_v2(void *arg)
+{
+    struct target_btrfs_ioctl_vol_args_v2 *target_args_v2 = arg;
+    uint64_t flags = tswap64(target_args_v2->flags);
+    int device_spec_by_id = 0;
+    int subvol_spec_by_id = 0;
+
+    qemu_log("{fd = %" PRId64 ", flags = ", tswap64(target_args_v2->fd));
+    print_flags(btrfs_args_vol_v2_flags, flags, 0);
+    qemu_log(" transid = %" PRIu64 ",", tswap64(target_args_v2->transid));
+
+#ifdef BTRFS_SUBVOL_QGROUP_INHERIT
+    if (flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
+
+        struct btrfs_qgroup_inherit *target_inherit;
+        abi_long inherit_addr = tswapal(target_args_v2->qgroup_inherit);
+
+        target_inherit = lock_user(VERIFY_READ, inherit_addr,
+                                   sizeof(*target_inherit), 1);
+
+        if (target_inherit) {
+            qemu_log(" size = %" PRIu64,
+                     tswap64(target_args_v2->size));
+            qemu_log(", qgroup_inherit = {");
+
+            qemu_log("flags = %" PRIu64,
+                     tswap64(target_inherit->flags));
+            qemu_log(", num_qgroups = %" PRIu64,
+                     tswap64(target_inherit->num_qgroups));
+            qemu_log(", num_ref_copies = %" PRIu64,
+                     tswap64(target_inherit->num_ref_copies));
+            qemu_log(", num_excl_copies = %" PRIu64,
+                     tswap64(target_inherit->num_excl_copies));
+
+            qemu_log(", lim = {");
+            qemu_log("lim.flags = %" PRIu64,
+                     tswap64(target_inherit->lim.flags));
+            qemu_log(", lim.max_rfer = %" PRIu64,
+                     tswap64(target_inherit->lim.max_rfer));
+            qemu_log(", lim.max_excl = %" PRIu64,
+                     tswap64(target_inherit->lim.max_excl));
+            qemu_log(", lim.rsv_rfer = %" PRIu64,
+                     tswap64(target_inherit->lim.rsv_rfer));
+            qemu_log(", lim.rsv_excl = %" PRIu64 "}",
+                     tswap64(target_inherit->lim.rsv_excl));
+
+            qemu_log(", ...}, ");
+        }
+
+        unlock_user(target_inherit, inherit_addr, 0);
+    }
+#endif
+
+#ifdef BTRFS_DEVICE_SPEC_BY_ID
+    if (flags & BTRFS_DEVICE_SPEC_BY_ID) {
+        qemu_log(" devid = %" PRIu64, tswap64(target_args_v2->devid));
+        device_spec_by_id = 1;
+    }
+#endif
+#ifdef BTRFS_SUBVOL_SPEC_BY_ID
+    if (flags & BTRFS_SUBVOL_SPEC_BY_ID) {
+        qemu_log(" subvolid = %" PRIu64, tswap64(target_args_v2->subvolid));
+        subvol_spec_by_id = 1;
+    }
+#endif
+    if (!device_spec_by_id && !subvol_spec_by_id) {
+        qemu_log(" name = \"%s\"", target_args_v2->name);
+    }
+
+    qemu_log("}");
+}
+#endif
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b58098b5bb..78d7106b80 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5668,6 +5668,83 @@ static const StructEntry struct_termios_def = {
     .print = print_termios,
 };
 
+#if defined(BTRFS_IOC_SUBVOL_CREATE_V2) || defined(BTRFS_IOC_SNAP_CREATE_V2) \
+ || defined(BTRFS_SNAP_DESTROY_V2)      || defined(BTRFS_RM_DEV_V2)
+static void target_to_host_btrfs_ioctl_vol_args_v2(void *dst, const void *src)
+{
+    struct btrfs_ioctl_vol_args_v2 *host_args_v2 = dst;
+    const struct target_btrfs_ioctl_vol_args_v2 *target_args_v2 = src;
+    int device_spec_by_id = 0;
+    int subvol_spec_by_id = 0;
+
+    __get_user(host_args_v2->fd, &target_args_v2->fd);
+    __get_user(host_args_v2->flags, &target_args_v2->flags);
+    __get_user(host_args_v2->transid, &target_args_v2->transid);
+
+    if (host_args_v2->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
+        struct btrfs_qgroup_inherit *target_inherit;
+        abi_long inherit_addr = tswapal(target_args_v2->qgroup_inherit);
+
+        target_inherit = lock_user(VERIFY_READ, inherit_addr,
+                                   sizeof(*target_inherit), 1);
+
+        host_args_v2->qgroup_inherit = g_new(struct btrfs_qgroup_inherit, 1);
+
+        if (!target_inherit) {
+            host_args_v2->qgroup_inherit = NULL;
+        } else {
+            __get_user(host_args_v2->qgroup_inherit->flags,
+                       &target_inherit->flags);
+            __get_user(host_args_v2->qgroup_inherit->num_qgroups,
+                       &target_inherit->num_qgroups);
+            __get_user(host_args_v2->qgroup_inherit->num_ref_copies,
+                       &target_inherit->num_ref_copies);
+            __get_user(host_args_v2->qgroup_inherit->num_excl_copies,
+                       &target_inherit->num_excl_copies);
+            __get_user(host_args_v2->qgroup_inherit->lim.flags,
+                       &target_inherit->lim.flags);
+            __get_user(host_args_v2->qgroup_inherit->lim.max_rfer,
+                       &target_inherit->lim.max_rfer);
+            __get_user(host_args_v2->qgroup_inherit->lim.max_excl,
+                       &target_inherit->lim.max_excl);
+            __get_user(host_args_v2->qgroup_inherit->lim.rsv_rfer,
+                       &target_inherit->lim.rsv_rfer);
+            __get_user(host_args_v2->qgroup_inherit->lim.rsv_excl,
+                       &target_inherit->lim.rsv_excl);
+        }
+
+        unlock_user(target_inherit, inherit_addr, 0);
+    }
+
+#ifdef BTRFS_DEVICE_SPEC_BY_ID
+    if (host_args_v2->flags & BTRFS_DEVICE_SPEC_BY_ID) {
+        __get_user(host_args_v2->devid, &target_args_v2->devid);
+        device_spec_by_id = 1;
+    }
+#endif
+#ifdef BTRFS_SUBVOL_SPEC_BY_ID
+    if (host_args_v2->flags & BTRFS_SUBVOL_SPEC_BY_ID) {
+        __get_user(host_args_v2->subvolid, &target_args_v2->subvolid);
+        subvol_spec_by_id = 1;
+    }
+#endif
+
+    if (!device_spec_by_id & !subvol_spec_by_id) {
+        memcpy(host_args_v2->name, target_args_v2->name,
+               BTRFS_SUBVOL_NAME_MAX + 1);
+    }
+}
+
+static const StructEntry struct_btrfs_ioctl_vol_args_v2_def = {
+    .convert = { NULL, target_to_host_btrfs_ioctl_vol_args_v2},
+    .print = print_btrfs_ioctl_vol_args_v2,
+    .align = { __alignof__(struct target_btrfs_ioctl_vol_args_v2),
+               __alignof__(struct btrfs_ioctl_vol_args_v2) },
+    .size = { sizeof(struct target_btrfs_ioctl_vol_args_v2),
+              sizeof(struct btrfs_ioctl_vol_args_v2) },
+};
+#endif
+
 static bitmask_transtbl mmap_flags_tbl[] = {
     { TARGET_MAP_SHARED, TARGET_MAP_SHARED, MAP_SHARED, MAP_SHARED },
     { TARGET_MAP_PRIVATE, TARGET_MAP_PRIVATE, MAP_PRIVATE, MAP_PRIVATE },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 969377d622..d2d4d1e1cb 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -967,6 +967,26 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
+#define TARGET_BTRFS_SUBVOL_NAME_MAX    4039
+
+struct target_btrfs_ioctl_vol_args_v2 {
+    uint64_t fd;
+    uint64_t transid;
+    uint64_t flags;
+    union {
+        struct {
+            uint64_t size;
+            abi_long qgroup_inherit;
+        };
+        uint64_t unused[4];
+    };
+    union {
+        char name[TARGET_BTRFS_SUBVOL_NAME_MAX + 1];
+        uint64_t devid;
+        uint64_t subvolid;
+    };
+};
+
 /* btrfs ioctls */
 #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
 #define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOWU(BTRFS_IOCTL_MAGIC, 4)
@@ -978,6 +998,10 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
 #define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, 19,\
                                                            abi_ullong)
+#define TARGET_BTRFS_IOC_SNAP_CREATE_V2         TARGET_IOW(BTRFS_IOCTL_MAGIC, 23,\
+                                            struct target_btrfs_ioctl_vol_args_v2)
+#define TARGET_BTRFS_IOC_SUBVOL_CREATE_V2       TARGET_IOW(BTRFS_IOCTL_MAGIC, 24,\
+                                            struct target_btrfs_ioctl_vol_args_v2)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
@@ -999,10 +1023,14 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_RM_DEV_V2              TARGET_IOW(BTRFS_IOCTL_MAGIC, 58,\
+                                            struct target_btrfs_ioctl_vol_args_v2)
 #define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 61)
 #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
+#define TARGET_BTRFS_IOC_SNAP_DESTROY_V2        TARGET_IOW(BTRFS_IOCTL_MAGIC, 63,\
+                                            struct target_btrfs_ioctl_vol_args_v2)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 8d4b5b3e92..83aee1fcf9 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -358,6 +358,11 @@ STRUCT(btrfs_ioctl_vol_args,
        TYPE_LONGLONG, /* fd */
        MK_ARRAY(TYPE_CHAR, BTRFS_PATH_NAME_MAX + 1)) /* name */
 
+#if defined(BTRFS_IOC_SUBVOL_CREATE_V2) || defined(BTRFS_IOC_SNAP_CREATE_V2) \
+ || defined(BTRFS_IOC_SNAP_DESTROY_V2)  || defined(BTRFS_IOC_RM_DEV_V2)
+STRUCT_SPECIAL(btrfs_ioctl_vol_args_v2)
+#endif
+
 STRUCT(btrfs_ioctl_timespec,
        TYPE_ULONGLONG, /* sec */
        TYPE_INT) /* nsec */
diff --git a/thunk.c b/thunk.c
index 0718325d86..0dfecb644b 100644
--- a/thunk.c
+++ b/thunk.c
@@ -246,7 +246,7 @@ const argtype *thunk_convert(void *dst, const void *src,
 
             assert(*type_ptr < max_struct_entries);
             se = struct_entries + *type_ptr++;
-            if (se->convert[0] != NULL) {
+            if (se->convert[to_host] != NULL) {
                 /* specific conversion is needed */
                 (*se->convert[to_host])(dst, src);
             } else {
-- 
2.25.1


