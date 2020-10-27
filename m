Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2879C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9F72224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nukToy3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9F72224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJs7-00048o-0O
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvq-0007Pf-9K
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:06 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvo-000447-D4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEc1DHs3w3Ng3MnUBIu2gCbkQuwCi27fSzBAkgk8D/fhrGOl65lbfEQinjnlARVJ2/q+e6Um5kqrxXkqNuCqDYRdsFwsn4r2idyCnZtzMnNlkNrLzg2JH7HETDceCLv0hYpMypJSYH6DuYz1sUP+a4UEiXgn8oZzI1r1NrmP555W1hUZ59vFxkhkltQXlzP+2J6A+9xsZPzzNg54zBLbvOj/BkJrR7hPwam4pvayHchF9ybzc4E8iHTyAZ6qZcG8brRiIitL2XwEvkXu8NUkJOKBDRMM85ZOi89V7pQY6Pn3FqhZxYy/H8SobVJThRaE/Pav2GOG2CEpsQKn/CAExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVAOZEe3ltdaN+xXNGEZE9xJWVazPAG0yk/RwS7lW8w=;
 b=V2+EiNmjSQgzsRoHPkt59mwC4LqLs7XqFOcKVzmoay4NFGpjqAXVhrmEtlEhpNfrQq/q1gcDoZjvDnM1AacPE5dlxp9J0abbudCmHuuLtBnYVmxgBhkOy3AkITq25pOVg4sKKqxq1Kean4cEchtnR5+xTQchfFX9qHRIdyOLbFDIxRyhGh8J+QjNzVQR1C2EWbgYIjowKd8/ZY51mfmFXcaYtQ/AhLrTNVNW5BSfbcnidMHWDRsFMij0x65ylpI0hilYtxqR0btmDJdv5xdWWPvtFgjcn5m7hDU7Lw1b7ZyW4lRPcW984Ncx3J7n+cEqmbBVgjyGNGuZk5Sgxrf4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVAOZEe3ltdaN+xXNGEZE9xJWVazPAG0yk/RwS7lW8w=;
 b=nukToy3ZORJPA2L7BwbJolDkNmaeV78AYaQZeGrD07L32UrOcHCZhRbSbbUVAXPHf1HFB1FDUq3VaPeV9VpW1T2jDXuMgORZtx7YvH8G0r7g3J5ZufHAz794PLjGvtZ5tDSP8H96ZLekhVcEHoJscWLPjQbpo+QOLDPnl5Ag5gI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:51 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:51 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] qga: add implementation of guest-get-disks for Linux
Date: Tue, 27 Oct 2020 00:53:11 -0500
Message-Id: <20201027055317.351868-7-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN1PR12CA0110.namprd12.prod.outlook.com
 (2603:10b6:802:21::45) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN1PR12CA0110.namprd12.prod.outlook.com (2603:10b6:802:21::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Tue, 27 Oct 2020 05:53:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10df9f43-9ba3-46c6-cf41-08d87a3cadf4
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5004F3933D810F380E5BAB6095160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rPakAVOxK2hSje2oBHFX4lfieVpUvdMu7JkjL6a4APk1eGglxKI47ICWzdL6IBAFRdAkUiHGWpr4As7knJm2WMTFkGbZKl5w5OhL9MjM8c3pO9NKfr8byUDcvl9avu8RqMnBLQLjTJRN8NVJh6+KrPKfNkuNUuc2i9R9RW4h7jls7SFp26V9xIJ4MvY3nObLxy+uWO3oyGCCKvwrg8xAHftQun1dsqu7LCkgMAAq/1ZmEE+OX008HZDVhPMuKlvh7SutxsGHhIn+ngNoIxMJvrxzAHpqw+LNr+j3Y699iu4wdmlWqIc1toVSPH2gQAa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(30864003)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cZ01zk0WsWmit/yceNYFF8FxORhFqwiHkgB0CgVULF7TmYv7EAa5O0vVIJ5XNFDRGhYz+zUS54jkuR4WTsNYSfuOqpAGCbQUneeLhHjI0Hzh6bAClC8nkSJIkcEtYgUluHW+JQyUt6FEGAzZ0Jjty9M610dgjUWOHbyJzvK5F+MYEcVU2KXEDmdLW97oPR53lHZ3S7OpE+WLTzZ2CzkeOBp0EmQcK1hdf0GoLfcknwi5UQzcvdL9aWjXDt9OmE6I6qT9Pc3+0u+cJot+ZnsKS3VQcrrR8orTW43i91HdIODThrc9cPHJAfGCCusxn2NsUorZQi4qsRbbXzsANnbTDTdEjCF28Pb6OF4sPVO2PbGAhRZivWEh7i85uzaRymjRuoGRIaMnMiT3Jik/eiWZsZdrSfl1b0ssEoLWxGIrTRAG+Ll8RxQ5NK1AFdoQGV8vmhlJBzj/bui0PD/OeVkG3/ZBGSKkAi6F4QsB5W2N9xQ/wC07HJfannEzCC8HBPM7RXfxnSryrm+jKjuy434Q+KgYse2FPM8j3kOjb/M6Ng0dAiESqe4ghhihB3p+PwRK/PLWy+5p0wyAjkXdY2Cxt1lqOJFgXFhOGvwLz2Nf4ZVhbcMe2mGrluAjA8K5VZCB5GzB0Htl3hiUSPIT5gGeMg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10df9f43-9ba3-46c6-cf41-08d87a3cadf4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:50.9905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuOHo2ZHZ/zYvZUTPyoXfPwawIRsV2QP9qlH9poCr8kDzUakJQhA9rz80pH5E2jIeIECPastbTvXNY++99235g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Received-SPF: none client-ip=40.107.92.50; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:53:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:50 -0400
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tomáš Golembiovský <tgolembi@redhat.com>

The command lists all disks (real and virtual) as well as disk
partitions. For each disk the list of dependent disks is also listed and
/dev path is used as a handle so it can be matched with "name" field of
other returned disk entries. For disk partitions the "dependents" list
is populated with the the parent device for easier tracking of
hierarchy.

Example output:
{
  "return": [
    ...
    {
      "name": "/dev/dm-0",
      "partition": false,
      "dependents": [
        "/dev/sda2"
      ],
      "alias": "luks-7062202e-5b9b-433e-81e8-6628c40da9f7"
    },
    {
      "name": "/dev/sda2",
      "partition": true,
      "dependents": [
        "/dev/sda"
      ]
    },
    {
      "name": "/dev/sda",
      "partition": false,
      "address": {
        "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
        "bus-type": "sata",
        ...
        "dev": "/dev/sda",
        "target": 0
      },
      "dependents": []
    },
    ...
  ]
}

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix.c | 296 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 285 insertions(+), 11 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 422144bcff..14683dfbd5 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1150,13 +1150,27 @@ static void build_guest_fsinfo_for_virtual_device(char const *syspath,
     closedir(dir);
 }
 
+static bool is_disk_virtual(const char *devpath, Error **errp)
+{
+    g_autofree char *syspath = realpath(devpath, NULL);
+
+    if (!syspath) {
+        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
+        return false;
+    }
+    return strstr(syspath, "/devices/virtual/block/") != NULL;
+}
+
 /* Dispatch to functions for virtual/real device */
 static void build_guest_fsinfo_for_device(char const *devpath,
                                           GuestFilesystemInfo *fs,
                                           Error **errp)
 {
-    char *syspath = realpath(devpath, NULL);
+    ERRP_GUARD();
+    g_autofree char *syspath = NULL;
+    bool is_virtual = false;
 
+    syspath = realpath(devpath, NULL);
     if (!syspath) {
         error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
         return;
@@ -1167,16 +1181,281 @@ static void build_guest_fsinfo_for_device(char const *devpath,
     }
 
     g_debug("  parse sysfs path '%s'", syspath);
-
-    if (strstr(syspath, "/devices/virtual/block/")) {
+    is_virtual = is_disk_virtual(syspath, errp);
+    if (*errp != NULL) {
+        return;
+    }
+    if (is_virtual) {
         build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
     } else {
         build_guest_fsinfo_for_real_device(syspath, fs, errp);
     }
+}
+
+#ifdef CONFIG_LIBUDEV
+
+/*
+ * Wrapper around build_guest_fsinfo_for_device() for getting just
+ * the disk address.
+ */
+static GuestDiskAddress *get_disk_address(const char *syspath, Error **errp)
+{
+    g_autoptr(GuestFilesystemInfo) fs = NULL;
+
+    fs = g_new0(GuestFilesystemInfo, 1);
+    build_guest_fsinfo_for_device(syspath, fs, errp);
+    if (fs->disk != NULL) {
+        return g_steal_pointer(&fs->disk->value);
+    }
+    return NULL;
+}
+
+static char *get_alias_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    if (udev == NULL) {
+        g_debug("failed to query udev");
+        goto out;
+    }
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udevice == NULL) {
+        g_debug("failed to query udev for path: %s", syspath);
+        goto out;
+    } else {
+        const char *alias = udev_device_get_property_value(
+            udevice, "DM_NAME");
+        /*
+         * NULL means there was an error and empty string means there is no
+         * alias. In case of no alias we return NULL instead of empty string.
+         */
+        if (alias == NULL) {
+            g_debug("failed to query udev for device alias for: %s",
+                syspath);
+        } else if (*alias != 0) {
+            ret = g_strdup(alias);
+        }
+    }
+
+out:
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+static char *get_device_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    if (udev == NULL) {
+        g_debug("failed to query udev");
+        goto out;
+    }
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udevice == NULL) {
+        g_debug("failed to query udev for path: %s", syspath);
+        goto out;
+    } else {
+        ret = g_strdup(udev_device_get_devnode(udevice));
+    }
+
+out:
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)
+{
+    g_autofree char *deps_dir = NULL;
+    const gchar *dep;
+    GDir *dp_deps = NULL;
+
+    /* List dependent disks */
+    deps_dir = g_strdup_printf("%s/slaves", disk_dir);
+    g_debug("  listing entries in: %s", deps_dir);
+    dp_deps = g_dir_open(deps_dir, 0, NULL);
+    if (dp_deps == NULL) {
+        g_debug("failed to list entries in %s", deps_dir);
+        return;
+    }
+    while ((dep = g_dir_read_name(dp_deps)) != NULL) {
+        g_autofree char *dep_dir = NULL;
+        strList *dep_item = NULL;
+        char *dev_name;
 
-    free(syspath);
+        /* Add dependent disks */
+        dep_dir = g_strdup_printf("%s/%s", deps_dir, dep);
+        dev_name = get_device_for_syspath(dep_dir);
+        if (dev_name != NULL) {
+            g_debug("  adding dependent device: %s", dev_name);
+            dep_item = g_new0(strList, 1);
+            dep_item->value = dev_name;
+            dep_item->next = disk->dependents;
+            disk->dependents = dep_item;
+        }
+    }
+    g_dir_close(dp_deps);
 }
 
+/*
+ * Detect partitions subdirectory, name is "<disk_name><number>" or
+ * "<disk_name>p<number>"
+ *
+ * @disk_name -- last component of /sys path (e.g. sda)
+ * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)
+ * @disk_dev -- device node of the disk (e.g. /dev/sda)
+ */
+static GuestDiskInfoList *get_disk_partitions(
+    GuestDiskInfoList *list,
+    const char *disk_name, const char *disk_dir,
+    const char *disk_dev)
+{
+    GuestDiskInfoList *item, *ret = list;
+    struct dirent *de_disk;
+    DIR *dp_disk = NULL;
+    size_t len = strlen(disk_name);
+
+    dp_disk = opendir(disk_dir);
+    while ((de_disk = readdir(dp_disk)) != NULL) {
+        g_autofree char *partition_dir = NULL;
+        char *dev_name;
+        GuestDiskInfo *partition;
+
+        if (!(de_disk->d_type & DT_DIR)) {
+            continue;
+        }
+
+        if (!(strncmp(disk_name, de_disk->d_name, len) == 0 &&
+            ((*(de_disk->d_name + len) == 'p' &&
+            isdigit(*(de_disk->d_name + len + 1))) ||
+                isdigit(*(de_disk->d_name + len))))) {
+            continue;
+        }
+
+        partition_dir = g_strdup_printf("%s/%s",
+            disk_dir, de_disk->d_name);
+        dev_name = get_device_for_syspath(partition_dir);
+        if (dev_name == NULL) {
+            g_debug("Failed to get device name for syspath: %s",
+                disk_dir);
+            continue;
+        }
+        partition = g_new0(GuestDiskInfo, 1);
+        partition->name = dev_name;
+        partition->partition = true;
+        /* Add parent disk as dependent for easier tracking of hierarchy */
+        partition->dependents = g_new0(strList, 1);
+        partition->dependents->value = g_strdup(disk_dev);
+
+        item = g_new0(GuestDiskInfoList, 1);
+        item->value = partition;
+        item->next = ret;
+        ret = item;
+
+    }
+    closedir(dp_disk);
+
+    return ret;
+}
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskInfoList *item, *ret = NULL;
+    GuestDiskInfo *disk;
+    DIR *dp = NULL;
+    struct dirent *de = NULL;
+
+    g_debug("listing /sys/block directory");
+    dp = opendir("/sys/block");
+    if (dp == NULL) {
+        error_setg_errno(errp, errno, "Can't open directory \"/sys/block\"");
+        return NULL;
+    }
+    while ((de = readdir(dp)) != NULL) {
+        g_autofree char *disk_dir = NULL, *line = NULL,
+            *size_path = NULL, *deps_dir = NULL;
+        char *dev_name;
+        Error *local_err = NULL;
+        if (de->d_type != DT_LNK) {
+            g_debug("  skipping entry: %s", de->d_name);
+            continue;
+        }
+
+        /* Check size and skip zero-sized disks */
+        g_debug("  checking disk size");
+        size_path = g_strdup_printf("/sys/block/%s/size", de->d_name);
+        if (!g_file_get_contents(size_path, &line, NULL, NULL)) {
+            g_debug("  failed to read disk size");
+            continue;
+        }
+        if (g_strcmp0(line, "0\n") == 0) {
+            g_debug("  skipping zero-sized disk");
+            continue;
+        }
+
+        g_debug("  adding %s", de->d_name);
+        disk_dir = g_strdup_printf("/sys/block/%s", de->d_name);
+        dev_name = get_device_for_syspath(disk_dir);
+        if (dev_name == NULL) {
+            g_debug("Failed to get device name for syspath: %s",
+                disk_dir);
+            continue;
+        }
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = dev_name;
+        disk->partition = false;
+        disk->alias = get_alias_for_syspath(disk_dir);
+        disk->has_alias = (disk->alias != NULL);
+        item = g_new0(GuestDiskInfoList, 1);
+        item->value = disk;
+        item->next = ret;
+        ret = item;
+
+        /* Get address for non-virtual devices */
+        bool is_virtual = is_disk_virtual(disk_dir, &local_err);
+        if (local_err != NULL) {
+            g_debug("  failed to check disk path, ignoring error: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+            /* Don't try to get the address */
+            is_virtual = true;
+        }
+        if (!is_virtual) {
+            disk->address = get_disk_address(disk_dir, &local_err);
+            if (local_err != NULL) {
+                g_debug("  failed to get device info, ignoring error: %s",
+                    error_get_pretty(local_err));
+                error_free(local_err);
+                local_err = NULL;
+            } else if (disk->address != NULL) {
+                disk->has_address = true;
+            }
+        }
+
+        get_disk_deps(disk_dir, disk);
+        ret = get_disk_partitions(ret, de->d_name, disk_dir, dev_name);
+    }
+    return ret;
+}
+
+#else
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
+#endif
+
 /* Return a list of the disk device(s)' info which @mount lies on */
 static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
                                                Error **errp)
@@ -2809,7 +3088,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
         const char *list[] = {
             "guest-get-fsinfo", "guest-fsfreeze-status",
             "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
-            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
+            "guest-fsfreeze-thaw", "guest-get-fsinfo",
+            "guest-get-disks", NULL};
         char **p = (char **)list;
 
         while (*p) {
@@ -3051,9 +3331,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
 
     return NULL;
 }
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-- 
2.25.1


