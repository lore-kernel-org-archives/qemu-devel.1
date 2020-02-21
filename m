Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384AAC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EEA208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gt8BQl0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EEA208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58YU-0001XF-6o
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j58JV-0002rx-RM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j58JU-0007Ir-4b
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j58JT-0007Hr-V3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uX9UesRfQ5VevuWklXMAkSBnSnsaUKk6WMwfeYmvayw=;
 b=Gt8BQl0Gp1OOPAwTX4+NURk8CmYVJg/WTY11vQc7DzHMBYyU2tM/5g6YcZhkClN+XKVO4b
 elurKyWXVlCmzoaE9oIoIejdJFtb3ABgrUWsA6QDfBHVJZXxG027bAxWdD+/XvnfpPAVHb
 wjTvIoD4K7CllHisN96rYrlNGVxe/Qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-eYrySuXtP06viUveA0SgSA-1; Fri, 21 Feb 2020 08:25:45 -0500
X-MC-Unique: eYrySuXtP06viUveA0SgSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67956107ACC5;
 Fri, 21 Feb 2020 13:25:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6135F84BCC;
 Fri, 21 Feb 2020 13:25:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, philmd@redhat.com, yangx.jy@cn.fujitsu.com,
 mrezanin@redhat.com
Subject: [PULL 3/6] tools/virtiofsd/passthrough_ll: Remove unneeded variable
 assignment
Date: Fri, 21 Feb 2020 13:25:33 +0000
Message-Id: <20200221132536.38364-4-dgilbert@redhat.com>
In-Reply-To: <20200221132536.38364-1-dgilbert@redhat.com>
References: <20200221132536.38364-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

    CC      tools/virtiofsd/passthrough_ll.o
  tools/virtiofsd/passthrough_ll.c:925:9: warning: Value stored to 'newfd' =
is never read
          newfd =3D -1;
          ^       ~~
  tools/virtiofsd/passthrough_ll.c:942:9: warning: Value stored to 'newfd' =
is never read
          newfd =3D -1;
          ^       ~~

Fixes: 7c6b66027
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e9e71d5fc2..02ff01fad0 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -922,7 +922,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
     inode =3D lo_find(lo, &e->attr);
     if (inode) {
         close(newfd);
-        newfd =3D -1;
     } else {
         inode =3D calloc(1, sizeof(struct lo_inode));
         if (!inode) {
@@ -939,7 +938,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
=20
         inode->nlookup =3D 1;
         inode->fd =3D newfd;
-        newfd =3D -1;
         inode->key.ino =3D e->attr.st_ino;
         inode->key.dev =3D e->attr.st_dev;
         pthread_mutex_init(&inode->plock_mutex, NULL);
--=20
2.24.1


