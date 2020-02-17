Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78848C34020
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419902070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkhztElo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419902070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gUr-0000FX-AP
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3gRn-0004N0-4O
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3gRl-0000vg-5k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3gRj-0000ty-C2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581946101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1bA5OGLFHfqXFmB475gsziHs61YshYEijMxzJbiKFM=;
 b=XkhztElornZeiWAn+GApAyvTPCwMSSQjazk8oE82yS9YawHV5VxmSPy20WTJ+TBwt3qn5M
 1aC5fzv9kPR4fEL0B/Y1bk59buH8nEGkQVIr5Zm+zuKWIer9Jmg6G0fPMvhIlgdwCOyd2o
 4RNj9KqSiKzbL4B5WOMnzw0AkUELv8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-gFo6CXbPOfGZG1D_DAF8xA-1; Mon, 17 Feb 2020 08:28:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDEA28017CC
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 13:28:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0D119757;
 Mon, 17 Feb 2020 13:28:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B59CF11366CD; Mon, 17 Feb 2020 14:28:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 5/5] qemu-doc: Clarify extent of build platform support
Date: Mon, 17 Feb 2020 14:28:14 +0100
Message-Id: <20200217132814.9018-6-armbru@redhat.com>
In-Reply-To: <20200217132814.9018-1-armbru@redhat.com>
References: <20200217132814.9018-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gFo6CXbPOfGZG1D_DAF8xA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Supporting a build platform beyond its end of life makes no sense.
Spell that out just to be clear.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200213084335.15100-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-doc.texi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index a1ef6b6484..33b9597b1d 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2880,10 +2880,11 @@ lifetime distros will be assumed to ship similar so=
ftware versions.
=20
 For distributions with long-lifetime releases, the project will aim to sup=
port
 the most recent major version at all times. Support for the previous major
-version will be dropped 2 years after the new major version is released. F=
or
-the purposes of identifying supported software versions, the project will =
look
-at RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distros=
 will
-be assumed to ship similar software versions.
+version will be dropped 2 years after the new major version is released,
+or when it reaches ``end of life''. For the purposes of identifying
+supported software versions, the project will look at RHEL, Debian,
+Ubuntu LTS, and SLES distros. Other long-lifetime distros will be
+assumed to ship similar software versions.
=20
 @section Windows
=20
--=20
2.21.1


