Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9A8C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0287216C8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0287216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgED4-0003lF-WA
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgE8u-0007s5-Hw
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgE8t-00018f-9S
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37915)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgE8r-000155-9p; Wed, 26 Jun 2019 16:03:43 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTAJl-1i93784A5n-00UdDd; Wed, 26 Jun 2019 22:02:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 22:02:50 +0200
Message-Id: <20190626200252.30220-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626200252.30220-1-laurent@vivier.eu>
References: <20190626200252.30220-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SDsrwGvhBVkJ1fQwnm9ExkGPbQNuyGaBfWIh6K97u5SFy6/iUwr
 94CiJlMZk2roPrD9Zbmqnj9or6zVrBAgRX4XX24yvxM1W8ne5tesrQ93Sq+gOooixZGA9xg
 PbTjBFoouLcCFg015N6Iou2k6YKmnK18ESsgsuJsddlSQVMDsUidL3nZhYTtAfViE/qhe2f
 XAbpoj/jSJK6icLFJMAIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ktFOV5d8Jyg=:YxQAZ5bbj5BXviSveKSRrQ
 YxS/xcm955RkJztqm6GpN1DxR3x/+/SL+Fu8AGbpysdSxm4fn9mChqNdjMeDwoTd/ljncWCu/
 WHqs6AxLtgayStqlMt7iVxBsf4m7M8WqmphdiTWHGq7RCsPyL0Vn6b9Z4b7GuQhTbwe4HlSFb
 VSNtWpfjr9Sc5Oq2aekTxWjeleBJNnlQLSTiVRn79v6K49f2SYkJ13skk5kwsRTvMZpUHiNkf
 vEqFYQLXXI8+vShpLzENNnVgTBAOaJpRaTFeWac7ArWXh4gWHsSrPCT+KfhZ3rU6l5CpwDgcu
 ZUgFdst0bw8QqDu0/nK60NEZNSM8CSfOBy/+eWiZmQH+uqkY12R6BMH8XC7yfXobS49D4j10x
 hpB8TmgkuCh7hRu8jxJ744TDGENa+GfTs+Qln14Gf31oGUksn0ZLLO91O13wvSnmM/SN+wWVv
 YEyG3t2cvUCf7PnxZUy6dmWL7pQoSnmq8ENgeqLHQUwNqS1witNtpStfFEN/wp9mylCkuo7dJ
 jjjmG0/rSHBMysBBEsiyi5VMXZ+hsWdzIYlKqsYsK1cyCm6Et1OmH42FDzyjjORmKq82g0uR+
 5M1uFbwZFQbHENbkVWRseRbGku9rhHp5dkdxkQ9HH0GTTp8ES14JZNVIQSmKQit+B1NANZtRd
 f/AWpomKYUe9v37+CL7yXSVhEg2xPA2yyq0PxeWHDJ5TK9V+N8EKngkZHqWqd7ERwYYX2V6Zv
 xNXSP6Jt2bEoSttAmTrahUrUqpzgIzpHoXrG6w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 2/4] configure: disallow spaces and colons in
 source path and build path
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
Cc: qemu-trivial@nongnu.org, Antonio Ospite <antonio.ospite@collabora.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Antonio Ospite <antonio.ospite@collabora.com>

The configure script breaks when the qemu source directory is in a path
containing white spaces, in particular the list of targets is not
correctly generated when calling "./configure --help" because of how the
default_target_list variable is built.

In addition to that, *building* qemu from a directory with spaces breaks
some assumptions in the Makefiles, even if the original source path does
not contain spaces like in the case of an out-of-tree build, or when
symlinks are involved.

To avoid these issues, refuse to run the configure script and the
Makefile if there are spaces or colons in the source path or the build
path, taking as inspiration what the kbuild system in linux does.

Buglink: https://bugs.launchpad.net/qemu/+bug/1817345

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
Message-Id: <20190526144747.30019-3-ao2@ao2.it>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile  | 4 ++++
 configure | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index cfb18f152544..c62594445d5f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,9 @@
 # Makefile for QEMU.
 
+ifneq ($(words $(subst :, ,$(CURDIR))), 1)
+  $(error main directory cannot contain spaces nor colons)
+endif
+
 # Always point to the root of the build tree (needs GNU make).
 BUILD_DIR=$(CURDIR)
 
diff --git a/configure b/configure
index b6962d1381a5..cf3d9d30bfce 100755
--- a/configure
+++ b/configure
@@ -279,6 +279,11 @@ ld_has() {
 # make source path absolute
 source_path=$(cd "$(dirname -- "$0")"; pwd)
 
+if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
+then
+  error_exit "main directory cannot contain spaces nor colons"
+fi
+
 # default parameters
 cpu=""
 iasl="iasl"
-- 
2.21.0


