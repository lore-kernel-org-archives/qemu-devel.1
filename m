Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D4FC4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53822073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQ4rxFSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53822073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vqJ-00061n-Pf
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpN-0004Rf-36
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpM-0006pQ-5d
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpM-0006pC-1q
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kW8MWC9McUlnlDBZUsLL9IawHoY7VEe1T/O93WO57SI=;
 b=TQ4rxFSMriNu75UPqZKgh3uiOhXormGWQJW+8KuIP/d5GJq5VFp5stAr/4Pn4umx4y53uF
 I6bkCVqvsl0DOjKzek4utVuR3td/z9g+AbRwgjCnsZiqpNOh12XfIOf0j4hkjDVs/S9L7w
 aDzGxP4yoK6Sh1Z7AD11EPgE+xozlx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-55cGBYXEMZiyD4XcpeBz2Q-1; Sat, 15 Feb 2020 06:41:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 642ADDB21;
 Sat, 15 Feb 2020 11:41:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 302EB1001DF0;
 Sat, 15 Feb 2020 11:41:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E27F11366CE; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] qga/qapi-schema.json: Fix missing '-' in
 GuestDiskBusType doc comment
Date: Sat, 15 Feb 2020 12:41:21 +0100
Message-Id: <20200215114133.15097-7-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 55cGBYXEMZiyD4XcpeBz2Q-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The doc comment for GuestDiskBusType doesn't match up with the
enumeration because of a missing hyphen in 'file-backed-virtual'.
This means the docs are rendered wrongly:
       "virtual"
           Win virtual bus type "file-backed" virtual: Win file-backed bus =
type

       "file-backed-virtual"
           Not documented

Add the missing hyphen.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200213175647.17628-5-peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index fb4605cc19..23ce6af597 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -809,7 +809,7 @@
 # @sas: Win serial-attaches SCSI bus type
 # @mmc: Win multimedia card (MMC) bus type
 # @virtual: Win virtual bus type
-# @file-backed virtual: Win file-backed bus type
+# @file-backed-virtual: Win file-backed bus type
 #
 # Since: 2.2; 'Unknown' and all entries below since 2.4
 ##
--=20
2.21.1


