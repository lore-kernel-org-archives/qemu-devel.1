Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A3C2BBC7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8600120753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0/PIOPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8600120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFoh-0000R2-MM
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnR-00078Q-WA
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnR-0002eJ-0j
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNFnQ-0002e4-Ty
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586610220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P56R64IaJ6gfTEzL2RgaUuq/gNeSQNkZAtDxvgY+xLI=;
 b=H0/PIOPS8mCHPcjufLA+WIEZP6ZT7qYMTfSF0KSb4Umtgh+q/XVawhHfs/ZkMLUWU0hz7q
 lbHaZY8q+MHuG6JZhOJRStcpJejj74Dr6jWRjhkutfu/w1idKYNmUF9Hhz3MtCVAr7Ij4F
 +tkmRX+qdTwrF0NS6aYMer9sxrRdLE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-gchASvu_PN6RhP7UbcIZ2w-1; Sat, 11 Apr 2020 09:03:38 -0400
X-MC-Unique: gchASvu_PN6RhP7UbcIZ2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AFD01005509;
 Sat, 11 Apr 2020 13:03:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD1D69E0EC;
 Sat, 11 Apr 2020 13:03:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] module: increase dirs array size by one
Date: Sat, 11 Apr 2020 09:03:30 -0400
Message-Id: <20200411130330.1993-9-pbonzini@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
References: <20200411130330.1993-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bruce Rogers <brogers@suse.com>

With the module upgrades code change, the statically sized dirs array
can now overflow. Increase it's size by one, according to the new
maximum possible usage.

Fixes: bd83c861c0 ("modules: load modules from versioned /var/run dir")
Signed-off-by: Bruce Rogers <brogers@suse.com>
Message-Id: <20200411010746.472295-1-brogers@suse.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 5f7896870a..e48d9aacc0 100644
--- a/util/module.c
+++ b/util/module.c
@@ -177,7 +177,7 @@ bool module_load_one(const char *prefix, const char *li=
b_name)
     char *version_dir;
 #endif
     const char *search_dir;
-    char *dirs[4];
+    char *dirs[5];
     char *module_name;
     int i =3D 0, n_dirs =3D 0;
     int ret;
--=20
2.18.2


