Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE26221FB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaIarx7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE26221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJHp-0002cZ-Gj
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDv-0005ye-6W
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDj-0008BA-LC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBunUuWmAomrQ6w5UmL7RDBuXkF+iF/WZpVXixC+DAo=;
 b=WaIarx7yKKvA8jqPwj+z70GXQGAOtK7b6ATFT4rgIyaxZKzDBzAz2838/b6J/LCvWqmbwG
 XnB7Ar3+L+RPxgr3gp+0OGdSnpZedsc1qNQqZaHFKFBOgJKbKlJroc7NGsLTJhURgDUib3
 e2coqJ30zVlNx/D7wNNmNy5WIGjaJu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-jl7fdQEKOUqxd5rwlFcsZg-1; Wed, 21 Oct 2020 14:52:17 -0400
X-MC-Unique: jl7fdQEKOUqxd5rwlFcsZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B3655F9C5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:16 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA2081002C01;
 Wed, 21 Oct 2020 18:52:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/15] scripts/qom-fuse: Add docstrings
Date: Wed, 21 Oct 2020 14:52:01 -0400
Message-Id: <20201021185208.1611145-9-jsnow@redhat.com>
In-Reply-To: <20201021185208.1611145-1-jsnow@redhat.com>
References: <20201021185208.1611145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The methods inherited from fuse don't need docstrings; that's up to
fusepy to handle.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qom-fuse | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 805e99c8ec..5b80da9df6 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -1,7 +1,20 @@
 #!/usr/bin/env python3
+"""
+QEMU Object Model FUSE filesystem tool
+
+This script offers a simple FUSE filesystem within which the QOM tree
+may be browsed, queried and edited using traditional shell tooling.
+
+This script requires the 'fusepy' python package;
+you may install it by using ``pip3 install --user fusepy``.
+
+ENV:
+    QMP_SOCKET: Path to the QMP server socket
+
+Usage:
+    qom-fuse /mount/to/here
+"""
 ##
-# QEMU Object Model test tools
-#
 # Copyright IBM, Corp. 2012
 # Copyright (C) 2020 Red Hat, Inc.
 #
@@ -30,6 +43,7 @@ fuse.fuse_python_api = (0, 2)
 
 
 class QOMFS(Operations):
+    """QOMFS implements fuse.Operations to provide a QOM filesystem."""
     def __init__(self, qmp):
         self.qmp = qmp
         self.qmp.connect()
@@ -37,6 +51,7 @@ class QOMFS(Operations):
         self.ino_count = 1
 
     def get_ino(self, path):
+        """Get an inode number for a given QOM path."""
         if path in self.ino_map:
             return self.ino_map[path]
         self.ino_map[path] = self.ino_count
@@ -44,6 +59,7 @@ class QOMFS(Operations):
         return self.ino_map[path]
 
     def is_object(self, path):
+        """Is the given QOM path an object?"""
         try:
             self.qmp.command('qom-list', path=path)
             return True
@@ -51,6 +67,7 @@ class QOMFS(Operations):
             return False
 
     def is_property(self, path):
+        """Is the given QOM path a property?"""
         path, prop = path.rsplit('/', 1)
         if path == '':
             path = '/'
@@ -63,6 +80,7 @@ class QOMFS(Operations):
             return False
 
     def is_link(self, path):
+        """Is the given QOM path a link?"""
         path, prop = path.rsplit('/', 1)
         if path == '':
             path = '/'
-- 
2.26.2


