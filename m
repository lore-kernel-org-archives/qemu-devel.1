Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC0C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9D920674
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/YE4wHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9D920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiIV-0001oE-KG
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi6R-0003FR-DE
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi6P-0005cM-Eq
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voPjCiZWVDBPQH65LrK+W3HZpGd+P96aarosFlVdCOo=;
 b=Z/YE4wHpkKlOUSG/gQ6vh+wYVjkNUd3f+PyFAJlsq6Kte4RePRV7iG3paMn+v/wtRsHRmP
 43OecmKWaPFluMHlghgfYYjVIB6L+UBmCaENRsQxg98wjcDq+tXmIycbLuP1nWU2cMDf6T
 gTIwJeuxvvwoZcQ3wA0zpWFGXwUQB1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-ho2pcMK4P1-31mvpUrfFaA-1; Sun, 11 Oct 2020 16:37:53 -0400
X-MC-Unique: ho2pcMK4P1-31mvpUrfFaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1EBE185A0C0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:37:52 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8733660C05;
 Sun, 11 Oct 2020 20:37:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 15/15] rust: use vendored-sources
Date: Mon, 12 Oct 2020 00:35:13 +0400
Message-Id: <20201011203513.1621355-16-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:23:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Most likely, QEMU will want tighter control over the sources, rather
than relying on crates.io downloading, use a git submodule with all the
dependencies.

"cargo vendor" makes that simple.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .cargo/config            | 5 +++++
 .gitmodules              | 3 +++
 configure                | 8 ++++++++
 rust/vendored            | 1 +
 scripts/cargo_wrapper.py | 1 +
 5 files changed, 18 insertions(+)
 create mode 100644 .cargo/config
 create mode 160000 rust/vendored

diff --git a/.cargo/config b/.cargo/config
new file mode 100644
index 0000000000..a8c55940d5
--- /dev/null
+++ b/.cargo/config
@@ -0,0 +1,5 @@
+[source.crates-io]
+replace-with = "vendored-sources"
+
+[source.vendored-sources]
+directory = "rust/vendored"
diff --git a/.gitmodules b/.gitmodules
index 2bdeeacef8..62a2be12b9 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -64,3 +64,6 @@
 [submodule "roms/vbootrom"]
 	path = roms/vbootrom
 	url = https://git.qemu.org/git/vbootrom.git
+[submodule "rust/vendored"]
+	path = rust/vendored
+	url = https://github.com/elmarco/qemu-rust-vendored.git
diff --git a/configure b/configure
index 7945ceac63..702546d87f 100755
--- a/configure
+++ b/configure
@@ -1932,6 +1932,14 @@ if test "$with_rust" = auto && has cargo; then
     with_rust=yes
 fi
 
+case "$with_rust" in
+  yes)
+    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+      git_submodules="${git_submodules} rust/vendored"
+    fi
+    ;;
+esac
+
 # Check that the C compiler works. Doing this here before testing
 # the host CPU ensures that we had a valid CC to autodetect the
 # $cpu var (and we should bail right here if that's not the case).
diff --git a/rust/vendored b/rust/vendored
new file mode 160000
index 0000000000..71ee65d042
--- /dev/null
+++ b/rust/vendored
@@ -0,0 +1 @@
+Subproject commit 71ee65d042606d18de3175d67f9e4e4b78a1f865
diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
index 164fad5123..4a0673407b 100644
--- a/scripts/cargo_wrapper.py
+++ b/scripts/cargo_wrapper.py
@@ -51,6 +51,7 @@ def build_lib(args: argparse.Namespace) -> None:
         target_dir,
         "--manifest-path",
         manifest_path,
+        "--offline",
     ]
     if args.target_triple:
         cargo_cmd += ["--target", args.target_triple]
-- 
2.28.0


