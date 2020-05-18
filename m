Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11826C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF5120756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJNfXqF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF5120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamop-0002o3-L7
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamms-00083I-FH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jammr-0006ai-Hx
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589835300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsxA62zEBfFQHazW0+9kbyKyjpv8TBDzxRLJBVqxj70=;
 b=HJNfXqF69G+HK7cZRokuwCFiF3wH45c+326G94rxaRJqi+nbap02cWpIKCIC93P8dfoJ7k
 CJzCh6mbCyWpTC67tZI3eu9/z0b6GDTs1WcNZDFRA5ElIhbPeaxmFxbdyUFwBj8FDqdaWz
 /rTcXzZbos8QHLZhXKqGu6MnugjRT1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-MUmppMigOpqoXcqKfbnJaQ-1; Mon, 18 May 2020 16:54:57 -0400
X-MC-Unique: MUmppMigOpqoXcqKfbnJaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD3F31902EC0;
 Mon, 18 May 2020 20:54:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8B5E795A2;
 Mon, 18 May 2020 20:54:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] qemu-img: Fix stale comments on doc location
Date: Mon, 18 May 2020 15:54:44 -0500
Message-Id: <20200518205448.690566-4-eblake@redhat.com>
In-Reply-To: <20200518205448.690566-1-eblake@redhat.com>
References: <20200518205448.690566-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missed in commit e13c59fa.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513011648.166876-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c       | 2 +-
 qemu-img-cmds.hx | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba56..b6e8af9202a5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -108,7 +108,7 @@ static void QEMU_NORETURN unrecognized_option(const char *option)
     error_exit("unrecognized option '%s'", option);
 }

-/* Please keep in synch with qemu-img.texi */
+/* Please keep in synch with docs/tools/qemu-img.rst */
 static void QEMU_NORETURN help(void)
 {
     const char *help_msg =
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9c54de1df40..e0886437b1f2 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -7,7 +7,7 @@ HXCOMM command structures and help message.
 HXCOMM HXCOMM can be used for comments, discarded from both rST and C

 HXCOMM When amending the rST sections, please remember to copy the usage
-HXCOMM over to the per-command sections in qemu-img.texi.
+HXCOMM over to the per-command sections in docs/tools/qemu-img.rst.

 DEF("amend", img_amend,
     "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
-- 
2.26.2


