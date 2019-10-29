Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61968CA9EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECD020874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxCAwClj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECD020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOmC-0006Ye-75
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeF-0005Y3-Tw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeE-0001EH-Pi
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54419
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeE-0001E0-Kq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S36T8nwF13z1jgj6foVTl0MPyPUCcTK8njdEkhrBvQs=;
 b=YxCAwCljQNjS1S+LCfcGj5HsMYXhzLmCl2XkZteDW9wj2NDegQ1CIY/Tjohb2jrM0SgWLQ
 J7HY5ZoJrAIITeQponSXerHdpNrBDKF0erCbBdZg0k5xLjb/ZlI8U3YpSjJnfJkkdn5pEo
 higucxdM0k52t3G2QU/E1kDcqJclp3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-0nB2cZo_PemgV8Wc5V2z9A-1; Tue, 29 Oct 2019 06:22:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F208185B6F0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFC4810027AF
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CAA81132C0F; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] qemu-doc: Belatedly document QMP command deprecation
Date: Tue, 29 Oct 2019 11:22:14 +0100
Message-Id: <20191029102228.20740-6-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0nB2cZo_PemgV8Wc5V2z9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

Commit 24fb413300 "qmp: Introduce blockdev-change-medium" (v2.5.0)
deprecated change.

Commit 2ff3025797 "migrate: move max-bandwidth and downtime-limit to
migrate_set_parameter" (v2.8.0) deprecated migrate_set_downtime and
migrate_set_speed.

These wre missed in commit eb22aeca65 "docs: document deprecation
policy & deprecated features in appendix" (v2.10.0).

Commit 73af8dd8d7 "migration: Make xbzrle_cache_size a migration
parameter" (v2.11.0) deprecated migrate-set-cache-size and
query-migrate-cache-size, but neglected to update qemu-doc.

Make up for that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-6-armbru@redhat.com>
---
 qemu-deprecated.texi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 7239e0959d..f727bd3932 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -149,6 +149,18 @@ QEMU 4.1 has three options, please migrate to one of t=
hese three:
=20
 @section QEMU Machine Protocol (QMP) commands
=20
+@subsection change (since 2.5.0)
+
+Use ``blockdev-change-medium'' or ``change-vnc-password'' instead.
+
+@subsection migrate_set_downtime and migrate_set_speed (since 2.8.0)
+
+Use ``migrate-set-parameters'' instead.
+
+@subsection migrate-set-cache-size and query-migrate-cache-size (since 2.1=
1.0)
+
+Use ``migrate-set-parameters'' and ``query-migrate-parameters'' instead.
+
 @subsection query-block result field dirty-bitmaps[i].status (since 4.0)
=20
 The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
--=20
2.21.0


