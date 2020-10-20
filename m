Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5858C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF13D206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6+9Emf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF13D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmq5-0002GD-St
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kUmm3-0006Yq-HM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kUmlz-0001d9-TR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603181614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMk0al0zeovsGmlIhx/ed/Qyn+bVEIP38hbp992ehZs=;
 b=X6+9Emf5fud9iAKFkm87xb5QKnnVRS/Pc7Ws32dTdLCr2qZ1FODbgPDaP6EKgT2xMaf3Uo
 dBC820AN/xLdiXAr4VVtbJqpdNIUQZkovrsJku8zaSt6dQKEssea3CME1OLiWDd50h6dWE
 1xQODid9XdEmdQ+GidnuZvRh9c/cCFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-hWUqgWYtOF6XFiJ8pBzXjw-1; Tue, 20 Oct 2020 04:13:32 -0400
X-MC-Unique: hWUqgWYtOF6XFiJ8pBzXjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7484D108E1A2;
 Tue, 20 Oct 2020 08:13:31 +0000 (UTC)
Received: from localhost (unknown [10.36.110.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 472C85C1C2;
 Tue, 20 Oct 2020 08:13:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] fixup! qga: add ssh-{add,remove}-authorized-keys
Date: Tue, 20 Oct 2020 12:12:53 +0400
Message-Id: <20201020081257.2054548-4-marcandre.lureau@redhat.com>
In-Reply-To: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
References: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

I forgot to reset the file ownership after it is written.
---
 qga/commands-posix-ssh.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index d41c114c3c..a7bc9a1c24 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -120,7 +120,8 @@ check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
 }
 
 static bool
-write_authkeys(const char *path, const GStrv keys, Error **errp)
+write_authkeys(const char *path, const GStrv keys,
+               const struct passwd *p, Error **errp)
 {
     g_autofree char *contents = NULL;
     g_autoptr(GError) err = NULL;
@@ -133,6 +134,12 @@ write_authkeys(const char *path, const GStrv keys, Error **errp)
         return false;
     }
 
+    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
+        error_setg(errp, "failed to set ownership of directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
     if (chmod(path, 0600) == -1) {
         error_setg(errp, "failed to set permissions of '%s': %s",
                    path, g_strerror(errno));
@@ -203,7 +210,7 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
         authkeys[nauthkeys++] = g_strdup(k->value);
     }
 
-    write_authkeys(authkeys_path, authkeys, errp);
+    write_authkeys(authkeys_path, authkeys, p, errp);
 }
 
 void
@@ -254,7 +261,7 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
         new_keys[nkeys++] = *a;
     }
 
-    write_authkeys(authkeys_path, new_keys, errp);
+    write_authkeys(authkeys_path, new_keys, p, errp);
 }
 
 
-- 
2.28.0


