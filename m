Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5391120679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fwkhc3tL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5391120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMMCS-0001qQ-Ex
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 21:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1iMMAJ-0000Ps-Aw
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1iMMAI-0001OQ-89
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:07:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1iMMAI-0001OJ-4i
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571620037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hvPOC83TFmIPkNxqxmDoKWdTzvISl7j/eoqdVERqfbQ=;
 b=Fwkhc3tL/rD3duFjUXyK4mB4QfzKnxebRbs6jL38gozrORkPGtN3rz7AJWphMLIo7MBUKd
 pDj7OBb/epHXSR9UENwoqjQZVmtdjCzlrJf88kv8N3kDsvbSeajZrF+sLL6q3mPT0mbSt6
 SoQHrEidMXBeFKiyX/+JEj75FVsVTy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-vx2Smd1CMzCvpXSVWM-Fag-1; Sun, 20 Oct 2019 21:07:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 804DD47B;
 Mon, 21 Oct 2019 01:07:13 +0000 (UTC)
Received: from hansolo.nay.redhat.com (unknown [10.66.4.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E0425D9D6;
 Mon, 21 Oct 2019 01:07:11 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qemu-img.texi: Describe data_file and data_file_raw
Date: Mon, 21 Oct 2019 09:07:15 +0800
Message-Id: <20191021010714.24060-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vx2Smd1CMzCvpXSVWM-Fag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Han Han <hhan@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1763105

Signed-off-by: Han Han <hhan@redhat.com>
---
 qemu-img.texi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index b5156d6316..983c6122f8 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -763,6 +763,16 @@ file which is COW and has data blocks already, it coul=
dn't be changed to NOCOW
 by setting @code{nocow=3Don}. One can issue @code{lsattr filename} to chec=
k if
 the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
=20
+@item data_file
+File name of data file that is stored in the image and used as a default f=
or
+opening the image. If the option is used, qcow2 file only stores the metad=
ata
+for the image.
+
+@item data_file_raw
+This option requires @option{data_file}. If this option is set to @code{on=
},
+qemu will always keep the external data file consistent as a standalone
+read-only raw image. Default value is @code{off}.
+
 @end table
=20
 @item Other
--=20
2.20.1


