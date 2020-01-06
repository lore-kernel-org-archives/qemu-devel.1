Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0092C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB0820707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUZB/4zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB0820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUBb-0004HZ-4N
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioTfZ-00042L-RH
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioTfY-0003KR-NX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:47:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioTfY-0003KI-K0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578322068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI0oPjdXxPnk4uQroJ6XZiHyb+OGmgtvKARuoDkxEZI=;
 b=OUZB/4zpwmcOJ32g/K3DhgjjLJ9LIVd7pbSkjQpTLwEhvzygC0OWu1pD09EFC3SzvTXwOv
 cLJPhauEpUcyluv+jcf7p1RmMWWBqymZ8CM+R9UGm5c2PaGZ8rOqHzZBPa/OIeQJcvUfJl
 HM3u0KQoyn/Zzn1PnbpqIiDrNl5LFpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-JnqEEy64M96UYbnv8mdw-A-1; Mon, 06 Jan 2020 09:47:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5755F800582;
 Mon,  6 Jan 2020 14:47:44 +0000 (UTC)
Received: from localhost (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF837DB5C;
 Mon,  6 Jan 2020 14:47:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 7/9] dockerfiles: add dbus-daemon to some of latest
 distributions
Date: Mon,  6 Jan 2020 18:46:20 +0400
Message-Id: <20200106144622.1520994-8-marcandre.lureau@redhat.com>
In-Reply-To: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
References: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: JnqEEy64M96UYbnv8mdw-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To get dbus-vmstate test covered.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker  | 1 +
 tests/docker/dockerfiles/debian10.docker | 1 +
 tests/docker/dockerfiles/fedora.docker   | 1 +
 tests/docker/dockerfiles/ubuntu.docker   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerf=
iles/centos7.docker
index 953637065c..562d65be9e 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -8,6 +8,7 @@ ENV PACKAGES \
     bzip2-devel \
     ccache \
     csnappy-devel \
+    dbus-daemon \
     flex \
     gcc-c++ \
     gcc \
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/docker=
files/debian10.docker
index dad498b52e..5de79ae552 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -21,6 +21,7 @@ RUN apt update && \
         build-essential \
         ca-certificates \
         clang \
+        dbus \
         flex \
         gettext \
         git \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 51d475e6be..987a3c170a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -8,6 +8,7 @@ ENV PACKAGES \
     ccache \
     clang \
     cyrus-sasl-devel \
+    dbus-daemon \
     device-mapper-multipath-devel \
     findutils \
     flex \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfi=
les/ubuntu.docker
index 18f1100409..4177f33691 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -13,6 +13,7 @@ FROM ubuntu:19.04
 ENV PACKAGES flex bison \
     ccache \
     clang \
+    dbus \
     gcc \
     gettext \
     git \
--=20
2.25.0.rc1.1.gb0343b22ed


