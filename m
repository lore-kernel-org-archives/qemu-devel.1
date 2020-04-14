Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56161C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDF620678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOkfzDe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDF620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOORG-0002fI-6s
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOQ-0005Ju-6O
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOK-0007DM-4U
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOJ-0007DA-Uj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id f13so15048008wrm.13
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qGeIMQxu3PilBoKo2MoV3NHkvFJQkVL7vf1SB9ePcU4=;
 b=HOkfzDe9OAZb+EK6qsQwwxdfm54o74IIqr7XfCaFq2v0irBwZZw6Wel1g8Vfvm/9yY
 ZYs7utHS5Z0D/Z0x/FWQ3OVF/ikVadxpX9fITDrNQ4tHGPFsvdTNXR4cbNaW7Daop3Ta
 RVeLiu+AUg8EelHyd/QVQSeJ/hL8BxqWjKJr1hLkzjGSZylIEPa5wZATl2Ar+Eo5eAKJ
 gFxXVvGLne75oHDCmggxY9BnZTJ7pA2TVi7kCIds3O+JyzHpErC+UenE7Kasso/qea3F
 hsrUhkWNLjIlfbk6hUVzfB74XRquBtPc4eUxQdkNsin34IYDGQORtQxFQRAiY3UTYGR3
 3DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qGeIMQxu3PilBoKo2MoV3NHkvFJQkVL7vf1SB9ePcU4=;
 b=dAIfHgjDXVv+xIGifx+6Dp7fq2VtfGE+QOLG6txJe/U6VyBDBnK1EkGS+cMcpp8RnV
 2mH7c28U3DAfc2/YdH+gBGJk+l2Tl85uSXSK2KCLpFF378HnJKlDPF1dqzRxMcyG2Hd3
 R/67Rx9vKx/HoPnFoGyjZR9wTv6dsgvu0hFpNYZpXeqGiTlRtn1Tl95ya7nRG7Nd2Sup
 Q7zFRnXVvWnqismdwZllWtskZGyFYD6deuTgg6ko4IV/NqxOvbuNst0esNDcYmMqAXUX
 /N5cYuYVu47oO4b1/YZ2qG6RoKsb0vyDcuKKKiIgD8U7ZQ7V+xJbwgzwZxeqbtHSt8G7
 c65Q==
X-Gm-Message-State: AGi0PuZY7AlG3GIpgK5qTjPUPWXOQFnsnfyk1LqzgsUfSk/itcJAE3yE
 GMHeoJPFTQab1KKHxNOyui39iDoQW3sEnQ==
X-Google-Smtp-Source: APiQypJtGNodIz3H5usVxy9Hg65QLi2sciZR5aAgkbnpeDQrONHrhIrahP/38FvvsMEdUwq2OrDKjQ==
X-Received: by 2002:a5d:5707:: with SMTP id a7mr24549392wrv.108.1586881586529; 
 Tue, 14 Apr 2020 09:26:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] kernel-doc: Use c:struct for Sphinx 3.0 and later
Date: Tue, 14 Apr 2020 17:26:11 +0100
Message-Id: <20200414162613.4479-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel-doc Sphinx plugin and associated script currently emit
'c:type' directives for "struct foo" documentation.

Sphinx 3.0 warns about this:
  /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/exec/memory.h:3: WARNING: Type must be either just a name or a typedef-like declaration.
  If just a name:
    Error in declarator or parameters
    Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
      struct MemoryListener
      ------^
  If typedef-like declaration:
    Error in declarator or parameters
    Invalid C declaration: Expected identifier in nested name. [error at 21]
      struct MemoryListener
      ---------------------^

because it wants us to use the new-in-3.0 'c:struct' instead.

Plumb the Sphinx version through to the kernel-doc script
and use it to select 'c:struct' for newer versions than 3.0.

Fixes: LP:1872113
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/sphinx/kerneldoc.py |  1 +
 scripts/kernel-doc       | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 1159405cb92..3e879402064 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -99,6 +99,7 @@ class KernelDocDirective(Directive):
                 env.note_dependency(os.path.abspath(f))
                 cmd += ['-export-file', f]
 
+        cmd += ['-sphinx-version', sphinx.__version__]
         cmd += [filename]
 
         try:
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 8dc30e01e58..030b5c8691f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -71,6 +71,8 @@ Output selection (mutually exclusive):
 			DOC: sections. May be specified multiple times.
 
 Output selection modifiers:
+  -sphinx-version VER   Generate rST syntax for the specified Sphinx version.
+                        Only works with reStructuredTextFormat.
   -no-doc-sections	Do not output DOC: sections.
   -enable-lineno        Enable output of #define LINENO lines. Only works with
                         reStructuredText format.
@@ -286,6 +288,7 @@ use constant {
 };
 my $output_selection = OUTPUT_ALL;
 my $show_not_found = 0;	# No longer used
+my $sphinx_version = "0.0"; # if not specified, assume old
 
 my @export_file_list;
 
@@ -436,6 +439,8 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	    $enable_lineno = 1;
     } elsif ($cmd eq 'show-not-found') {
 	$show_not_found = 1;  # A no-op but don't fail
+    } elsif ($cmd eq 'sphinx-version') {
+        $sphinx_version = shift @ARGV;
     } else {
 	# Unknown argument
         usage();
@@ -963,7 +968,16 @@ sub output_struct_rst(%) {
     my $oldprefix = $lineprefix;
     my $name = $args{'type'} . " " . $args{'struct'};
 
-    print "\n\n.. c:type:: " . $name . "\n\n";
+    # Sphinx 3.0 and up will emit warnings for "c:type:: struct Foo".
+    # It wants to see "c:struct:: Foo" (and will add the word 'struct' in
+    # the rendered output).
+    if ((split(/\./, $sphinx_version))[0] >= 3) {
+        my $sname = $name;
+        $sname =~ s/^struct //;
+        print "\n\n.. c:struct:: " . $sname . "\n\n";
+    } else {
+        print "\n\n.. c:type:: " . $name . "\n\n";
+    }
     print_lineno($declaration_start_line);
     $lineprefix = "   ";
     output_highlight_rst($args{'purpose'});
-- 
2.20.1


