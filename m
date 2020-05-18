Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B695C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68D620756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMaFKO1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68D620756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamou-0002sd-0h
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jammr-00082f-W0
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jammq-0006ab-Ki
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589835299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUfkJPA69IGdxhH4nsuPZv9nlqPCRHx21myOagT+/Mg=;
 b=iMaFKO1jBLRIMSFWNMMJfVt6HZoMCMzVYU/POcW/zT4QgTRCmcvgkvUpaqqjTDXZXe6iEj
 bqxTPPvI1tIKVwnA4SU7EdwNXqEwhEBTx5xUxfwmIoucNCC1/dtkFC5K2YD856QkkvcK7t
 /CbzatkCIdLsDnbqIo9oItINNDt5cWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-2McYHKy6NBiFn7I4gWhB9A-1; Mon, 18 May 2020 16:54:52 -0400
X-MC-Unique: 2McYHKy6NBiFn7I4gWhB9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA0B1902EA4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 20:54:51 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA58797F7;
 Mon, 18 May 2020 20:54:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] bitmaps: Update maintainer
Date: Mon, 18 May 2020 15:54:42 -0500
Message-Id: <20200518205448.690566-2-eblake@redhat.com>
In-Reply-To: <20200518205448.690566-1-eblake@redhat.com>
References: <20200518205448.690566-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dirty bitmaps are important to incremental backups, including exposure
over NBD where I'm already maintainer.  Also, I'm aware that lately I
have been doing as much code/review on bitmaps as John Snow who is
trying to scale back in order to focus elsewhere; and many of the
recent patches have come from Vladimir, who is also interested in
taking on maintainer duties, but would like to start with
co-maintainership.  Therefore, it's time to revamp the ownership of
this category, as agreed between the three of us.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200514180003.325406-1-eblake@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47ef3139e6d6..4e99bb05dad8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2011,8 +2011,9 @@ F: qapi/transaction.json
 T: git https://repo.or.cz/qemu/armbru.git block-next

 Dirty Bitmaps
-M: John Snow <jsnow@redhat.com>
-R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+M: Eric Blake <eblake@redhat.com>
+M: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+R: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: include/qemu/hbitmap.h
@@ -2023,7 +2024,7 @@ F: migration/block-dirty-bitmap.c
 F: util/hbitmap.c
 F: tests/test-hbitmap.c
 F: docs/interop/bitmaps.rst
-T: git https://github.com/jnsnow/qemu.git bitmaps
+T: git https://repo.or.cz/qemu/ericb.git bitmaps

 Character device backends
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
-- 
2.26.2


