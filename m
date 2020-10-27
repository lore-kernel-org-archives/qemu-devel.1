Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6032C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055E12076A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055E12076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRyX-00054P-Uz
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRri-0006sv-E0; Tue, 27 Oct 2020 12:30:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRre-0001XT-SU; Tue, 27 Oct 2020 12:30:29 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUGNZ-1kydOp17Hn-00REtQ; Tue, 27 Oct 2020 17:30:20 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] io: Fix Lesser GPL version number
Date: Tue, 27 Oct 2020 17:30:10 +0100
Message-Id: <20201027163014.247336-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027163014.247336-1-laurent@vivier.eu>
References: <20201027163014.247336-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KLcmXN1Xa5j9tgIfaI49+Boc1M5b3FtH+ySWdJeZ4MAY6cMV9Cp
 D+6dXCxDmQit6Zdc+EzwQV2C5CRpgX+90Mg11VGB4hDU+k0G9urZeta7+dBxMbwpa1prNns
 xXrvopP5zqIOeOYYvvwdt1o9jhRD+B8mRTeprKVWcN2DbUh234by5VkdrH7URoXrys5eTo6
 01OQjBNrVOCFBEIAkNRHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8R30D5dc4EE=:7kLc5LI1K0Ot6cRsdL7x0V
 W2qKDFDuxjQxJTH60XHsg8gBsT7P5s7OhzBn+mFi0KXvN+8lnlWwf34p2SNZ/+fnewQaJH4OW
 IBlRqXEKT3ldACFyQeTXBGH5qMIf67Yywzg25fYBE+zsU3hFod4RdZhHq9pX8lMY8dhc/HGB7
 Zphm6Vs4RNtxcYTksIvYZT/wkR7KaCccwoohzG2LBtRREwhHabQAhwjNOYSsGeenFOY6ze4Ht
 j7wFhkzwZ2gQWG5m3FtXR8VQSLdhYjDmwHc2gSxVPsK644oTZiJ6xrvBh+fPQO0cnb4jOj6gA
 aKbuHzsijwsSG2BoWu7RrA+Q54sfdtDABjTDjha36QFz2nCNF83tzNgwiCjEkgITB+fk3PtnZ
 LCphIAtDBFswqAMLgdSyaS6cBQkKMyWpbSKqOlhrIkPoozbSoTU8jv0XWlUw61H1bRnUrTrJ1
 KH3Vxdbemg==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:30:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chetan Pant <chetan4windows@gmail.com>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20201014134033.14095-1-chetan4windows@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
index 518c28f13f5c..c9463ee6551b 100644
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
index 5556a38d7e67..27e42bdadc71 100644
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
index c61d6e0ef7cb..50e8eb113868 100644
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
index d07d67fab66e..e747e635147e 100644
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
index 6dd1a3cd3c66..5672479e9eb6 100644
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
index c0b79cf6036b..a5d720d9a04b 100644
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
index 63bc4ae2d92a..a36aab8f8f2f 100644
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
index 9c40513e745d..e180827c57f1 100644
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
index 3c04f0edda7e..4d6fe45f63d8 100644
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
index 01d0bd7a428c..558ea517ded4 100644
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
index 6818dfedd005..beec4f5cfd1d 100644
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
index 5402e0cced39..baa4e2b089f6 100644
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
index 368dd62b7eda..b2a9e271382a 100644
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
index 2ed3b75e8bf1..c4bf799a8023 100644
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
index e1b46670874f..de259f7eed27 100644
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
index 7ec8ceff2f01..388f01997725 100644
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
index 423d79845a20..848a7a43d671 100644
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
index 8640d1c46408..0289b3647c27 100644
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
index 47a0e941d9f6..bb545fa3271f 100644
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
index e4376eb0bc40..93d449dee261 100644
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
index b55d8cc3feae..743a0efc8767 100644
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
index 53c0bed68673..451f26f8b495 100644
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
index 59d6c64b0431..9c6724dea419 100644
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
index 3bc526612104..99056e07c023 100644
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
index 0aa04775417f..29038e67b64d 100644
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
index 743577d7449b..c49eec1f038a 100644
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
index 85e7a98da50d..953a50ae66e3 100644
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
2.26.2


