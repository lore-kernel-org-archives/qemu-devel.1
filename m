Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ADCC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4251B2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijq7AzGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4251B2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4ov-0003eP-5i
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY4ke-0007rc-PS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kY4kO-0007yO-7k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603965691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZ8IFaQBZcOSjaBHYfaa3yIbHOC+XSS65MZm2UNrKGA=;
 b=ijq7AzGWPfcltSYpQ3GsvPZ+p8Dni1UbEn3dwwPmElxbL90C3Bfv8fX2ShF5hpTLMmuGvu
 l6UnMvm2AHWHT3XdCThIpGINUTdCTJdHXT4vrjcbmCHXcZ1UiGXFELOLOfxokROt1cZndf
 8fFARO1svp0Oj3tjUFjhGTWY08VK3DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-09iAvBfPOL-FkKJOehwtgA-1; Thu, 29 Oct 2020 06:01:28 -0400
X-MC-Unique: 09iAvBfPOL-FkKJOehwtgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5C01018F82;
 Thu, 29 Oct 2020 10:01:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-62.ams2.redhat.com
 [10.36.115.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90AE9100238E;
 Thu, 29 Oct 2020 10:01:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] io: Fix Lesser GPL version number
Date: Thu, 29 Oct 2020 10:01:15 +0000
Message-Id: <20201029100119.30696-2-berrange@redhat.com>
In-Reply-To: <20201029100119.30696-1-berrange@redhat.com>
References: <20201029100119.30696-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Chetan Pant <chetan4windows@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chetan Pant <chetan4windows@gmail.com>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel-buffer.h     | 2 +-
 include/io/channel-command.h    | 2 +-
 include/io/channel-file.h       | 2 +-
 include/io/channel-socket.h     | 2 +-
 include/io/channel-tls.h        | 2 +-
 include/io/channel-util.h       | 2 +-
 include/io/channel-watch.h      | 2 +-
 include/io/channel-websock.h    | 2 +-
 include/io/channel.h            | 2 +-
 include/io/dns-resolver.h       | 2 +-
 include/io/task.h               | 2 +-
 io/channel-buffer.c             | 2 +-
 io/channel-command.c            | 2 +-
 io/channel-file.c               | 2 +-
 io/channel-socket.c             | 2 +-
 io/channel-tls.c                | 2 +-
 io/channel-util.c               | 2 +-
 io/channel-watch.c              | 2 +-
 io/channel-websock.c            | 2 +-
 io/channel.c                    | 2 +-
 io/dns-resolver.c               | 2 +-
 io/task.c                       | 2 +-
 tests/test-io-channel-buffer.c  | 2 +-
 tests/test-io-channel-command.c | 2 +-
 tests/test-io-channel-file.c    | 2 +-
 tests/test-io-channel-socket.c  | 2 +-
 tests/test-io-task.c            | 2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/io/channel-buffer.h b/include/io/channel-buffer.h
index 518c28f13f..c9463ee655 100644
--- a/include/io/channel-buffer.h
+++ b/include/io/channel-buffer.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-command.h b/include/io/channel-command.h
index 5556a38d7e..27e42bdadc 100644
--- a/include/io/channel-command.h
+++ b/include/io/channel-command.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index c61d6e0ef7..50e8eb1138 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index d07d67fab6..e747e63514 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 6dd1a3cd3c..5672479e9e 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-util.h b/include/io/channel-util.h
index c0b79cf603..a5d720d9a0 100644
--- a/include/io/channel-util.h
+++ b/include/io/channel-util.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-watch.h b/include/io/channel-watch.h
index 63bc4ae2d9..a36aab8f8f 100644
--- a/include/io/channel-watch.h
+++ b/include/io/channel-watch.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index 9c40513e74..e180827c57 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel.h b/include/io/channel.h
index 3c04f0edda..4d6fe45f63 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 01d0bd7a42..558ea517de 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/task.h b/include/io/task.h
index 6818dfedd0..beec4f5cfd 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 5402e0cced..baa4e2b089 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-command.c b/io/channel-command.c
index 368dd62b7e..b2a9e27138 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-file.c b/io/channel-file.c
index 2ed3b75e8b..c4bf799a80 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-socket.c b/io/channel-socket.c
index e1b4667087..de259f7eed 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8ceff2f..388f019977 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-util.c b/io/channel-util.c
index 423d79845a..848a7a43d6 100644
--- a/io/channel-util.c
+++ b/io/channel-util.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-watch.c b/io/channel-watch.c
index 8640d1c464..0289b3647c 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 47a0e941d9..bb545fa327 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel.c b/io/channel.c
index e4376eb0bc..93d449dee2 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index b55d8cc3fe..743a0efc87 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/task.c b/io/task.c
index 53c0bed686..451f26f8b4 100644
--- a/io/task.c
+++ b/io/task.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-buffer.c b/tests/test-io-channel-buffer.c
index 59d6c64b04..9c6724dea4 100644
--- a/tests/test-io-channel-buffer.c
+++ b/tests/test-io-channel-buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-command.c
index 3bc5266121..99056e07c0 100644
--- a/tests/test-io-channel-command.c
+++ b/tests/test-io-channel-command.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index 0aa0477541..29038e67b6 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index 743577d744..c49eec1f03 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index 85e7a98da5..953a50ae66 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.28.0


