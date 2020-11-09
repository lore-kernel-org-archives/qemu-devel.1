Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDEC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE26620731
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbYNeZB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE26620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3A5-0003GD-FA
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34K-0005Bq-JB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc34H-0004ad-Q1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6uUEkiSBUCBQbhCiD2GKNFNDIcq0zljxBD6327CaJc=;
 b=NbYNeZB0HH0Stm4XtMkgOPc3wbGkHvOQTwVPljRdnI4J7aqkT/+n/NhPjEyrmfhcevC7f+
 NV6hvEXgJWzXKkUIi4w+OK/mxO1x+KrBwlJMojTS+2Bjw8G9ktSIXaJ2KUBqNQJYjGKvhf
 S+vD+8UDQxAQtj2B7gn3nwbUJS2Z69I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-w5kDUgnFOL6O5HgQwpP-vg-1; Mon, 09 Nov 2020 04:02:26 -0500
X-MC-Unique: w5kDUgnFOL6O5HgQwpP-vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C72465F9C3;
 Mon,  9 Nov 2020 09:02:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2299E1002C1E;
 Mon,  9 Nov 2020 09:02:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB64A11329AB; Mon,  9 Nov 2020 10:02:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] docs/devel/qapi-code-gen: Fix up examples
Date: Mon,  9 Nov 2020 10:02:16 +0100
Message-Id: <20201109090220.825764-2-armbru@redhat.com>
In-Reply-To: <20201109090220.825764-1-armbru@redhat.com>
References: <20201109090220.825764-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201027121026.3025930-1-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c6438c6aa9..6906a06ad2 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -393,7 +393,7 @@ is identical on the wire to:
  { 'enum': 'Enum', 'data': ['one', 'two'] }
  { 'struct': 'Branch1', 'data': { 'data': 'str' } }
  { 'struct': 'Branch2', 'data': { 'data': 'int' } }
- { 'union': 'Flat': 'base': { 'type': 'Enum' }, 'discriminator': 'type',
+ { 'union': 'Flat', 'base': { 'type': 'Enum' }, 'discriminator': 'type',
    'data': { 'one': 'Branch1', 'two': 'Branch2' } }
 
 The optional 'if' member specifies a conditional.  See "Configuring
@@ -590,6 +590,8 @@ When in doubt, do not implement OOB execution support.
 Member 'allow-preconfig' declares whether the command is available
 before the machine is built.  It defaults to false.  For example:
 
+ { 'enum': 'QMPCapability',
+   'data': [ 'oob' ] }
  { 'command': 'qmp_capabilities',
    'data': { '*enable': [ 'QMPCapability' ] },
    'allow-preconfig': true }
@@ -824,7 +826,7 @@ Example: a struct with conditional feature 'allow-negative-numbers'
 { 'struct': 'TestType',
   'data': { 'number': 'int' },
   'features': [ { 'name': 'allow-negative-numbers',
-                  'if' 'defined(IFCOND)' } ] }
+                  'if': 'defined(IFCOND)' } ] }
 
 Please note that you are responsible to ensure that the C code will
 compile with an arbitrary combination of conditions, since the
-- 
2.26.2


