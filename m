Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE0C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA71320659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXTDJVpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA71320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfX3-0007k0-3j
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1izfVr-0006GV-N3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1izfVq-0007wX-8j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:40:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1izfVq-0007ue-4B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580989201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8gbDHiQqeek23yuv570Rj7QFzJPmmBOK6IRd26Jg1rQ=;
 b=LXTDJVpAvRo/+A/Fkh/yYFNfNTxAwMzqy5ZZHVsk/j9f/aaDFze9ajVWVUeSifCRycyZXf
 iUVWxIBoFEDizroCpHSxIZ4Ma1KEGZmhy6qP0GTDaNSDUa+gDfyYZ32voHxxHHyLU+u6a5
 qbAI1LKeflv1iljSnDqKwBpgNL8ztGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-Ksv5ZqU1Mqa76wrIWToFTg-1; Thu, 06 Feb 2020 06:39:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3596800D5F
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 11:39:55 +0000 (UTC)
Received: from localhost (ovpn-116-182.ams2.redhat.com [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6934289A62;
 Thu,  6 Feb 2020 11:39:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] Add Outreachy 2020 announcement to blog
Date: Thu,  6 Feb 2020 11:39:49 +0000
Message-Id: <20200206113949.84022-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Ksv5ZqU1Mqa76wrIWToFTg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 jusual@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let people know that we are participating in Outreachy again this year.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .../2020-02-06-outreachy-internships-2020.md  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 _posts/2020-02-06-outreachy-internships-2020.md

diff --git a/_posts/2020-02-06-outreachy-internships-2020.md b/_posts/2020-=
02-06-outreachy-internships-2020.md
new file mode 100644
index 0000000..78a190b
--- /dev/null
+++ b/_posts/2020-02-06-outreachy-internships-2020.md
@@ -0,0 +1,25 @@
+---
+layout: post
+title:  "Announcing Outreachy 2020 internships"
+date:   2020-02-06 07:00:00 +0000
+categories: [outreachy, internships]
+---
+QEMU is participating in [Outreachy](https://www.outreachy.org/) again thi=
s
+year!  Outreachy is an open source internship program for anyone who faces
+under-representation, systemic bias, or discrimination in the technology
+industry.  Outreachy offers full-time remote work opportunities for talent=
ed
+new developers wishing to get involved in our community.
+
+Each intern works with one or more mentors who support them in their proje=
ct.
+Code is submitted through QEMU's open source development process, giving t=
he
+intern experience in open source software development.
+
+If you are interested in contributing to QEMU through a paid 12-week inter=
nship
+from May to August, take a look at [our project
+ideas](https://www.outreachy.org/apply/project-selection/#qemu) for more
+information.
+
+Please review the [eligibility
+criteria](https://www.outreachy.org/apply/eligibility/) before applying.
+
+These internships are generously funded by Red Hat.
--=20
2.24.1


