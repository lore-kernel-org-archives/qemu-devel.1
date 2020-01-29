Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A7B206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0A2knKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A7B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwv4j-0007Js-Fv
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuqD-0007uP-Gd
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuqC-0003NW-Gb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuqC-0003Mg-CY
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0U47tvFxOBzjdEvYY6tVm4z3s5nPc5bzYEYKuKCinc=;
 b=U0A2knKNPytK90pIBOTWxbu8eq4HoQFIEoWuZBJpZ7yVZrLpSEEop6JBd3HrgcgRL9AWS7
 vFX+3ohKS5FohkoIJZTkIc5a0AVDswHw2Wr6A9rEC9Q7wSA7e8sAE039rOvnPT/NjePQoQ
 6TArVce7ZlIfo/bt9zu8gkuQS6calu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-q-10GR83OHOIhk3muljHnw-1; Wed, 29 Jan 2020 16:25:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B6218A6EC1;
 Wed, 29 Jan 2020 21:25:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AD0D60BF3;
 Wed, 29 Jan 2020 21:25:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 29/29] MAINTAINERS: Add Acceptance tests reviewers
Date: Wed, 29 Jan 2020 22:23:45 +0100
Message-Id: <20200129212345.20547-30-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: q-10GR83OHOIhk3muljHnw-1
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acceptance tests can test any piece of the QEMU codebase.
As such, the directory holding them does not belong to a specific
subsystem with designated maintainers.

Each subsystem covered by a test is welcomed to add the test path
to its section.
See for example commits 71b290e70, b11785ca2 or 5d480ddde.

Since Eduardo, Cleber and Philippe have been reviewing the patches
on the list, add them as reviewers.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
Wainer do you want to be listed?
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efd3f3875f..4a3cc3f137 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2733,6 +2733,12 @@ S: Maintained
 F: tests/tcg/Makefile
 F: tests/tcg/Makefile.include
=20
+Acceptance Tests
+R: Eduardo Habkost <ehabkost@redhat.com>
+R: Cleber Rosa <crosa@redhat.com>
+R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+F: tests/acceptance/
+
 Documentation
 -------------
 Build system architecture
--=20
2.21.1


