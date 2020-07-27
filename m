Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D21C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEDC208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNgzBvLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEDC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0CTp-0008Uu-HN
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 19:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CT1-0007Er-7K
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:23:35 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30]:43341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CSz-00060B-G7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:23:34 -0400
Received: by mail-oo1-xc30.google.com with SMTP id z10so597713ooi.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 16:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wuQZwfssSAsYztJ3hgK0A+C7+4FbLE10/5wG+EJMbpU=;
 b=pNgzBvLdF84dOrviSw0i4irLw8H/4wb4P6xc37nfe7j58nl09H1k9swD/3bqqE3KzI
 EuMVOvmttJQEjwjc54ZYBPVMTIr2ddkGSC2yYklHnmHH8+C3g2BriO9bVexpye0y4vEm
 5CDtK3S+gZpN6see5VI50XAOLt93J9OEmqRQRAoY6ffqjlAKDZTJrC2bx7wBl/RbG15R
 E0/Ek3SEw7Z5r5ukrcc5cmGGtHl4Lkqk1yY9eM53DYcwQeZdWVQF2C1jdKQ8k+aA+g7S
 PiifTeyYMOU6GqQkY1L5aNRHki6cKs4KZeM6CVZsPsV6uzEIv34OunI3gq6KjgUZc+QZ
 zxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=wuQZwfssSAsYztJ3hgK0A+C7+4FbLE10/5wG+EJMbpU=;
 b=dqTDARBb4lSOdSH3rmNw/UFcZqM/gAGt/Tm3dRd/hardIpfmZ8OCKKU0PGi1OBa1TX
 GZ6F6FRHOLOd/JP1PZuIrfFmhd3HSHapvIXrRDsBTSuLM2dXbL6i21S+Ju6ZIOTQWwLy
 phz7IHcsX+hB27OvLSkNnulsFErkMtswUXz1Ei02lun3/+E2Wzs4YyP5TNlVDFlE4CeP
 Js+hVFyZ9k1LGrWi0OEJhFWMFU4xWx664yz161LlOu+SAIFd+gZwgm5c0pGZO7j4sK3A
 jvt11dbatsXLcVCuGGiTVhuwN8pIWkWfW8UAGbkU0ikqGXaFK1MJObbDKOGKX3f0GMZ5
 EOpA==
X-Gm-Message-State: AOAM533oROI4SIcKJ2pCuEwfuSRfvjTuSFCt4gfnUpH7tDMflAkyipC5
 mtFAJuC3rJMRGzQNsPL3QsI4DRbY
X-Google-Smtp-Source: ABdhPJxlMxmU88eFfMfOthsbHp9kPLIFU2jJWX2heQHuDC53lD5kQ8p83o0TRb4uvtWr3IaymuIiBQ==
X-Received: by 2002:a4a:d74d:: with SMTP id h13mr22794219oot.56.1595892212098; 
 Mon, 27 Jul 2020 16:23:32 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f26sm2737338oop.46.2020.07.27.16.23.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jul 2020 16:23:31 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 1/2] qga-win: fix "guest-get-fsinfo" wrong filesystem
 type
Date: Mon, 27 Jul 2020 18:22:36 -0500
Message-Id: <20200727232237.31024-2-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727232237.31024-1-mdroth@linux.vnet.ibm.com>
References: <20200727232237.31024-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc30.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, Basil Salman <bsalman@redhat.com>,
 Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <bsalman@redhat.com>

This patch handles the case where unmounted volumes exist,
where in that case GetVolumePathNamesForVolumeName returns
empty path, GetVolumeInformation will use the current working
directory instead.
This patch fixes the issue by opening a handle to the volumes,
and using GetVolumeInformationByHandleW instead.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1746667

Signed-off-by: Basil Salman <bsalman@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
*fix crash when guest_build_fsinfo() sets errp multiple times
*make new error message more distinct from existing ones
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index aaa71f147b..15c9d7944b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -958,11 +958,13 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
 {
     DWORD info_size;
     char mnt, *mnt_point;
+    wchar_t wfs_name[32];
     char fs_name[32];
-    char vol_info[MAX_PATH+1];
+    wchar_t vol_info[MAX_PATH + 1];
     size_t len;
     uint64_t i64FreeBytesToCaller, i64TotalBytes, i64FreeBytes;
     GuestFilesystemInfo *fs = NULL;
+    HANDLE hLocalDiskHandle = NULL;
 
     GetVolumePathNamesForVolumeName(guid, (LPCH)&mnt, 0, &info_size);
     if (GetLastError() != ERROR_MORE_DATA) {
@@ -977,18 +979,27 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
         goto free;
     }
 
+    hLocalDiskHandle = CreateFile(guid, 0 , 0, NULL, OPEN_EXISTING,
+                                  FILE_ATTRIBUTE_NORMAL |
+                                  FILE_FLAG_BACKUP_SEMANTICS, NULL);
+    if (INVALID_HANDLE_VALUE == hLocalDiskHandle) {
+        error_setg_win32(errp, GetLastError(), "failed to get handle for volume");
+        goto free;
+    }
+
     len = strlen(mnt_point);
     mnt_point[len] = '\\';
     mnt_point[len+1] = 0;
-    if (!GetVolumeInformation(mnt_point, vol_info, sizeof(vol_info), NULL, NULL,
-                              NULL, (LPSTR)&fs_name, sizeof(fs_name))) {
+
+    if (!GetVolumeInformationByHandleW(hLocalDiskHandle, vol_info,
+                                       sizeof(vol_info), NULL, NULL, NULL,
+                                       (LPWSTR) & wfs_name, sizeof(wfs_name))) {
         if (GetLastError() != ERROR_NOT_READY) {
             error_setg_win32(errp, GetLastError(), "failed to get volume info");
         }
         goto free;
     }
 
-    fs_name[sizeof(fs_name) - 1] = 0;
     fs = g_malloc(sizeof(*fs));
     fs->name = g_strdup(guid);
     fs->has_total_bytes = false;
@@ -1007,9 +1018,11 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
             fs->has_used_bytes = true;
         }
     }
+    wcstombs(fs_name, wfs_name, sizeof(wfs_name));
     fs->type = g_strdup(fs_name);
     fs->disk = build_guest_disk_info(guid, errp);
 free:
+    CloseHandle(hLocalDiskHandle);
     g_free(mnt_point);
     return fs;
 }
@@ -1027,8 +1040,12 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     }
 
     do {
-        GuestFilesystemInfo *info = build_guest_fsinfo(guid, errp);
-        if (info == NULL) {
+        Error *local_err = NULL;
+        GuestFilesystemInfo *info = build_guest_fsinfo(guid, &local_err);
+        if (local_err) {
+            g_debug("failed to get filesystem info, ignoring error: %s",
+                    error_get_pretty(local_err));
+            error_free(local_err);
             continue;
         }
         new = g_malloc(sizeof(*ret));
-- 
2.17.1


