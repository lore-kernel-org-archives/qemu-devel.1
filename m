Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C7C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09192222B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PMvgrtMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09192222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZl6D-0007Tf-IN
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksm-0006iT-Vw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:09 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:25952 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksk-0005Yp-Vb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8JXJs9tTwXpafbZYvMaqS+4b9op4rlLk9PIM346t2LBheiDiq6bhcbq4CCYo6AkaLfFY+cEzC0dtAjeAl19Rg5CyPW0ZO9kpynGmwJIgLqR/N35GMRMFRA2EZw1XaiPzvkYgGyX2G/6mqlVyfbHDJVRNfzeqPNDzcFn08bTL9EKm2rlvEgwWDleCFiyh9Gp1RZfp8UTk80I7ZA9bKbOByZsn+jLVOpIscHfPm8vX1qUJ0uxDSnU7PWg2MG8u5CNmfqXx9HS+AIjRR9Hm/qpfszjhUh5Ay/n0QqPxlX7ebya6BJ51joljQLlWf+kD0OnA/UKKCvJb5c+m1Jn4Blt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVteiaszyvTJI5WzzsQ6wCqwI7QUBVQMc+lGITsCvwI=;
 b=TXhWh4A2SIq7iT5ja9MgXIluKD5CJIS0DWJH6xKpRqzmfCKCIM/hdGCGZbiOuXMcatsttLSZKQVIHbwZsbkUjnsWxDJIimZL9lQSEt7aauSSae7F+yNhV8q3xQd+/MWnfvx2vZF9hcJlyftr6TngTcEYkseHcs0rH4KQLvmOrq0nhSh6CQ/UyPWx/J7qMmuTpzTxUHR+Rpmlqv8fgZocvL5ZLjYVR6+Rwfa7Sz+ZOL8PvIlrJwwcp5Tl89f9emRiNJLDHEIWCTrtu0gH+2MCg6heNgzDTdDkSzoMn2n/WNt+PqFnXwFYzkpQmKSFIS1DLgxrRZ5VZ2+B7lysqsjc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVteiaszyvTJI5WzzsQ6wCqwI7QUBVQMc+lGITsCvwI=;
 b=PMvgrtMq3mZCBx/91YHlAgzbT/Vrrpi6ClysQUTeQDv0bVT8hrNCYxnLyzzsHeFSPibHARUFOxw7cvNYWDkYO9C7xICfFYl4GAOZb9BcRoyu3x3B2t/8t1e2I9yZlkXGO5qMPV2JOxgrNAafzlalrOdC3WtufSP7ug5j1KC3VNk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:35 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:35 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/12] qga: add implementation of guest-get-disks for Linux
Date: Mon,  2 Nov 2020 19:11:28 -0600
Message-Id: <20201103011134.887744-7-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0801CA0003.namprd08.prod.outlook.com
 (2603:10b6:803:29::13) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN4PR0801CA0003.namprd08.prod.outlook.com (2603:10b6:803:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 01:12:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3287366-2307-47a1-0b52-08d87f958c7a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50017BC0F9301A7B9D17F41B95110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cxx7+ZSPqkRQoj0HcbeTiCEHa8gJoyxYv3oC/OsF0lUY9l6qtjxqpLObRcUAC1AyC0GiNnbH7OYt5gLpAK32razNCmH2y3wxcnwlpWwi1PDUesgD5bGUL3dH/6jqAWk8gS/jFTy9Q2ZipEr3rKTxdTbJP+vxH/Z7R+Uc/AlszuX0AYbKDwsndMySBDxXIBJuyXmYiEKxPbf2hgyCEqCWWRqDChSZmsg7jc+xD2EdJFoZeUtO/L8hnUaKFafJ7QdXzb9aJQDwbRGXZFwaBuQc7UoqH84BumzUBx9tDvjVxsLvuO+523WsqnsOrK1zII2b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(30864003)(36756003)(54906003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: z/D7Izrxo9Op9JYrpyE+6si4t8siYXmUJMbNSFUurpL52phaLzpFR+bEhRiPnkB6GS4lwTHeejLni+ez30TYIvFsVXc9+W5Mqx8gamQWF5UktIjlQ5dRfWKnWIlZEcf3gq8r2LWL5ubZrZs7xT3tMllI7UzdCNZOSXzKGl83BbUWoRCMrqcfOfA48AZ8dpEzhH328E08kxY6SF8r2E7d3CArhKn2In2YxFpY3FCxgdhMmNE1mx3To8dXbktjS+ZIJjttcMiR/B9CUh00kgNnrTkrw+DmWUmH236wZSf4ivECGDatYELrutqA4rVDzyssjSCvgggZpCARdYhaDzOLX8YP8VgWSAxPGug+wcJpLo09pz1z8xcuFlGWVwqlN+ULOd1Os7rmAaMkMVl7AZoKZas6KAsbPrU4yWbedg1YTJhq3dvswtN+wIB/QI6QRJOSJwRvAcO1fUKGgxwU8vYcDrAUFlAMUYLUjwbabLX+BPO9V7uu+/b/4IrtdL56oyHuu3AkNdS44ixdUkcn5ppkFKtZh6LPRD0mdWkLMSHEjK5qYf1Wt4BdCl5tw1dp+vfBN4ipF1DrM6kYeF1UV92DUT4U+k32/ijP7b3m0DYjQspLJFkhpCLI5+5Sf9nAbhEK8QDcpZoeZblo6QgmbKAJ5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3287366-2307-47a1-0b52-08d87f958c7a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:35.8728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83TzZQfBWfJcbRYZa9TXfzb3wmddCmLgqRdWAkWKljQxlQykerntvN1XErhGo7bCSOA6SA0lnxtXR/9OCji+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.55; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
*add missing stub for !defined(CONFIG_FSFREEZE)
*remove unused deps_dir variable
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix.c | 303 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 292 insertions(+), 11 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 422144bcff..3711080d07 100644
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
 
-    free(syspath);
+    fs = g_new0(GuestFilesystemInfo, 1);
+    build_guest_fsinfo_for_device(syspath, fs, errp);
+    if (fs->disk != NULL) {
+        return g_steal_pointer(&fs->disk->value);
+    }
+    return NULL;
 }
 
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
+
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
+}
+
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
+            *size_path = NULL;
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
@@ -2773,6 +3052,13 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     return 0;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif /* CONFIG_FSFREEZE */
 
 #if !defined(CONFIG_FSTRIM)
@@ -2809,7 +3095,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
         const char *list[] = {
             "guest-get-fsinfo", "guest-fsfreeze-status",
             "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
-            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
+            "guest-fsfreeze-thaw", "guest-get-fsinfo",
+            "guest-get-disks", NULL};
         char **p = (char **)list;
 
         while (*p) {
@@ -3051,9 +3338,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
 
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


