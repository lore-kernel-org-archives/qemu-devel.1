Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CB7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B5A218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BH97PbI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B5A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvYh-00012N-2y
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuyn-0001EC-Vo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuym-00065C-Li
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ihuym-00062s-Cj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuyE/qTzYXt1c1/LGWpcX7MbcN7ayH6LYIr9Eyrm/Cw=;
 b=BH97PbI3nIcwphZ3vQesrr+S1m8C+er+05fvDUaqnTneXO2FRaY5n4XZfVaTuQmvJa4hPx
 r6MCJxHY8Fz9o0HFVxwGWVoQIqd5bclVtRAR8P5kr7SbSYD3+5deDeDvj2LLGdOnKCjZ9O
 XNattln1wqjQERMaWqyXkVYBgJoqSDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-td0z7RckPEGu2tHdflxYuw-1; Thu, 19 Dec 2019 07:32:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EE36800D41
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:32:30 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5F6060BC7;
 Thu, 19 Dec 2019 12:32:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 7/9] dockerfiles: add dbus-daemon to some of latest
 distributions
Date: Thu, 19 Dec 2019 16:30:27 +0400
Message-Id: <20191219123029.200788-8-marcandre.lureau@redhat.com>
In-Reply-To: <20191219123029.200788-1-marcandre.lureau@redhat.com>
References: <20191219123029.200788-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: td0z7RckPEGu2tHdflxYuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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
2.24.0.308.g228f53135a


