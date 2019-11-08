Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0711BC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8285C214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHrJw3IH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8285C214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT17J-0006JW-Co
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iT13l-0003FK-18
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iT13j-0002tS-UY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:00:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44146
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iT13j-0002tH-Qo
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDtaUVN4udIdkorfhyIBq/ib/+LSzEez0EMfa/xjECc=;
 b=jHrJw3IH/PKFeADnfMR/ZRRuX2KYZDRWOsgUazLAtHM6w8MuvM43/GiFPvjy0XB6Y4Fyyz
 v5+Ym7LfJsoIQlZsP0qkWeiW20DENpLgi5+CsZcgb6VmjA2EVkiw7Y1VGjZPc5ue2PLfZ/
 S19eQSUMihSDGrTqGD6Tchge8xzTFgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-WZBjsmcVOXSWxiyYU6YyWQ-1; Fri, 08 Nov 2019 05:00:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ADAD477;
 Fri,  8 Nov 2019 09:59:59 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43FE75C548;
 Fri,  8 Nov 2019 09:59:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] docs: install CSS and Javascript files for HTML docs
Date: Fri,  8 Nov 2019 10:59:42 +0100
Message-Id: <20191108095942.401225-4-stefanha@redhat.com>
In-Reply-To: <20191108095942.401225-1-stefanha@redhat.com>
References: <20191108095942.401225-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: WZBjsmcVOXSWxiyYU6YyWQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install the sphinx CSS/Javascript support files needed by the HTML
documentation.  The documentation looks ugly without this.

The previous patch switched to only invoking sphinx once so there is
only one _static/ directory that needs to be installed across all manual
sections.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9487a06bed..dd60787d4c 100644
--- a/Makefile
+++ b/Makefile
@@ -813,6 +813,7 @@ endef
 # for QEMU developers, and not interesting to our users.
 .PHONY: install-sphinxdocs
 install-sphinxdocs: sphinxdocs
+=09$(call install-manual,_static)
 =09$(call install-manual,interop)
 =09$(call install-manual,specs)
 =09$(INSTALL_DATA) "$(MANUAL_BUILDDIR)/index.html" "$(DESTDIR)$(qemu_docdi=
r)/index.html"
--=20
2.23.0


