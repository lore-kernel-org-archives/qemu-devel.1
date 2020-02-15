Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02EBC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9272073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSV7eKdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9272073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vvZ-0007f8-ON
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpQ-0004VR-V0
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpP-0006t3-Lv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpP-0006sa-HM
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6m6UYFo1J37x7do2RDtMKIqDl/JvngWEfu3H4c5CMc=;
 b=WSV7eKdHIvMpwY5PbDsB5xYuDfPJlqpLunP4jcHLsROcZ9BIFOJywy/W+32MptPdvRrYaj
 lt/+hJJTz87u1OLuTGHaxZlt9ztmJr5SvUUeqFo9RYMBoZSkGvPLVXXZhNBMycoS/MqglL
 /bzUJ0x+j5kNFmee32LYTDg4mtkbI4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-n8WX7Jk_Nze_C9K-oheouA-1; Sat, 15 Feb 2020 06:41:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3EACDB20;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5BE2859BF;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4524E1136447; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] qapi: Remove hardcoded tabs
Date: Sat, 15 Feb 2020 12:41:27 +0100
Message-Id: <20200215114133.15097-13-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: n8WX7Jk_Nze_C9K-oheouA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

There are some stray hardcoded tabs in some of our json files;
remove them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200213175647.17628-11-peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 4 ++--
 qapi/migration.json  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c62b7db281..31f7a1281c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2938,8 +2938,8 @@
             '*pr-manager': 'str',
             '*locking': 'OnOffAuto',
             '*aio': 'BlockdevAioOptions',
-=09    '*drop-cache': {'type': 'bool',
-=09                    'if': 'defined(CONFIG_LINUX)'},
+            '*drop-cache': {'type': 'bool',
+                            'if': 'defined(CONFIG_LINUX)'},
             '*x-check-cache-dropped': 'bool' },
   'features': [ { 'name': 'dynamic-auto-read-only',
                   'if': 'defined(CONFIG_POSIX)' } ] }
diff --git a/qapi/migration.json b/qapi/migration.json
index aa160e9e42..11033b7a8e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -98,7 +98,7 @@
 ##
 { 'struct': 'CompressionStats',
   'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
-=09   'compressed-size': 'int', 'compression-rate': 'number' } }
+           'compressed-size': 'int', 'compression-rate': 'number' } }
=20
 ##
 # @MigrationStatus:
@@ -713,7 +713,7 @@
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
-=09    '*max-cpu-throttle': 'int' } }
+            '*max-cpu-throttle': 'int' } }
=20
 ##
 # @migrate-set-parameters:
@@ -845,7 +845,7 @@
             '*block-incremental': 'bool' ,
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
-=09    '*max-postcopy-bandwidth': 'size',
+            '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle':'uint8'} }
=20
 ##
--=20
2.21.1


