Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F6C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEE42067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEE42067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2Ng-0008JY-U7
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hn2NM-0007BB-K5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hn2NL-0004KG-AN
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hn2NI-0004H4-Ew; Mon, 15 Jul 2019 10:54:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA59230832EF;
 Mon, 15 Jul 2019 14:54:43 +0000 (UTC)
Received: from thuth.com (reserved-198-198.str.redhat.com [10.33.198.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A714E60C05;
 Mon, 15 Jul 2019 14:54:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 16:54:37 +0200
Message-Id: <20190715145438.6880-2-thuth@redhat.com>
In-Reply-To: <20190715145438.6880-1-thuth@redhat.com>
References: <20190715145438.6880-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 15 Jul 2019 14:54:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] tests/qemu-iotests/group: Remove some more
 tests from the "auto" group
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove some more tests from the "auto" group that either have issues
in certain environments (like macOS or FreeBSD, or on certain file system=
s
like ZFS or tmpfs), do not work with the qcow2 format, or that are simply
taking too much time.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/group | 109 ++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b34c8e3c0c..9db19f7bed 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -14,7 +14,8 @@
 #   runnable in any case. That means they should run with every QEMU bin=
ary
 #   (also non-x86), with every QEMU configuration (i.e. must not fail if
 #   an optional feature is not compiled in - but reporting a "skip" is o=
k),
-#   and work all kind of host filesystems and users (e.g. "nobody" or "r=
oot").
+#   work at least with the qcow2 file format and work all kind of host
+#   filesystems and users (e.g. "nobody" or "root").
 #
=20
 #
@@ -33,8 +34,8 @@
 011 rw auto quick
 012 auto quick
 013 rw auto
-014 rw auto
-015 rw snapshot auto
+014 rw
+015 rw snapshot
 # 016 was removed, do not reuse
 017 rw backing auto quick
 018 rw backing auto quick
@@ -42,7 +43,7 @@
 020 rw backing auto quick
 021 io auto quick
 022 rw snapshot auto
-023 rw auto
+023 rw
 024 rw backing auto quick
 025 rw auto quick
 026 rw blkdbg
@@ -78,94 +79,94 @@
 056 rw backing
 057 rw
 058 rw quick
-059 rw auto quick
+059 rw quick
 060 rw auto quick
 061 rw auto
 062 rw auto quick
 063 rw auto quick
-064 rw auto quick
+064 rw quick
 065 rw quick
 066 rw auto quick
 067 rw quick
 068 rw quick
 069 rw auto quick
-070 rw auto quick
+070 rw quick
 071 rw auto quick
 072 rw auto quick
 073 rw auto quick
 074 rw auto quick
-075 rw auto quick
-076 auto
-077 rw auto quick
-078 rw auto quick
+075 rw quick
+076 io
+077 rw quick
+078 rw quick
 079 rw auto
 080 rw auto
-081 rw auto quick
-082 rw auto quick
-083 rw auto
-084 img auto quick
+081 rw quick
+082 rw quick
+083 rw
+084 img quick
 085 rw
 086 rw auto quick
 087 rw quick
-088 rw auto quick
+088 rw quick
 089 rw auto quick
 090 rw auto quick
-091 rw auto migration
-092 rw auto quick
+091 rw migration
+092 rw quick
 093 throttle
-094 rw auto quick
+094 rw quick
 095 rw quick
 096 rw quick
 097 rw auto backing
 098 rw auto backing quick
 099 rw auto quick
 # 100 was removed, do not reuse
-101 rw auto quick
-102 rw auto quick
+101 rw quick
+102 rw quick
 103 rw auto quick
 104 rw auto
 105 rw auto quick
-106 rw auto quick
+106 rw quick
 107 rw auto quick
 108 rw auto quick
-109 rw auto
+109 rw
 110 rw auto backing quick
 111 rw auto quick
 112 rw
-113 rw auto quick
+113 rw quick
 114 rw auto quick
 115 rw
-116 rw auto quick
+116 rw quick
 117 rw auto
 118 rw
-119 rw auto quick
+119 rw quick
 120 rw auto quick
 121 rw
 122 rw auto
-123 rw auto quick
+123 rw quick
 124 rw backing
 125 rw
 126 rw auto backing
 127 rw backing quick
-128 rw auto quick
+128 rw quick
 129 rw quick
 130 rw auto quick
-131 rw auto quick
+131 rw quick
 132 rw quick
 133 auto quick
 134 rw auto quick
-135 rw auto
+135 rw
 136 rw
 137 rw auto
 138 rw auto quick
 139 rw quick
 140 rw auto quick
 141 rw auto quick
-142 auto
+142 o_direct
 143 auto quick
 144 rw quick
 145 quick
-146 auto quick
+146 quick
 147 img
 148 rw quick
 149 rw sudo
@@ -179,18 +180,18 @@
 157 quick
 158 rw auto quick
 159 rw auto quick
-160 rw auto quick
+160 rw quick
 161 rw auto quick
 162 quick
 163 rw
 165 rw quick
 169 rw quick migration
 170 rw auto quick
-171 rw auto quick
+171 rw quick
 172 auto
-173 rw auto
+173 rw
 174 auto
-175 auto quick
+175 quick
 176 rw auto backing
 177 rw auto quick
 178 img
@@ -220,13 +221,13 @@
 204 rw quick
 205 rw quick
 206 rw
-207 rw auto
+207 rw
 208 rw quick
 209 rw quick
-210 rw auto
-211 rw auto quick
-212 rw auto quick
-213 rw auto quick
+210 rw
+211 rw quick
+212 rw quick
+213 rw quick
 214 rw auto
 215 rw auto quick
 216 rw quick
@@ -234,38 +235,38 @@
 218 rw quick
 219 rw
 220 rw auto
-221 rw auto quick
+221 rw quick
 222 rw quick
 223 rw quick
 224 rw quick
-225 rw auto quick
+225 rw quick
 226 auto quick
 227 quick
 228 rw quick
 229 auto quick
-231 auto quick
+231 quick
 232 quick
-233 auto quick
+233 quick
 234 quick migration
 235 quick
 236 quick
-237 rw auto quick
+237 rw quick
 238 quick
-239 rw auto quick
+239 rw quick
 240 quick
-241 rw auto quick
+241 rw quick
 242 rw quick
-243 rw auto quick
+243 rw quick
 244 rw auto quick
 245 rw
 246 rw quick
 247 rw quick
 248 rw quick
 249 rw auto quick
-250 rw auto quick
+250 rw quick
 251 rw auto quick
 252 rw auto backing quick
-253 rw auto quick
-254 rw auto backing quick
-255 rw auto quick
-256 rw auto quick
+253 rw o_direct quick
+254 rw backing quick
+255 rw quick
+256 rw quick
--=20
2.21.0


