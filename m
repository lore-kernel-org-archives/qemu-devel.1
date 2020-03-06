Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970BC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047532072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAzZgT30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047532072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB6p-0006bi-51
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsP-0004Gi-NH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAsN-0005mf-W1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAsN-0005io-Ha
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:43 -0500
Received: by mail-wm1-x329.google.com with SMTP id a132so1935368wme.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KEuiqLQJQeVIcNdqiDmm+jMBwfWT2SyGRR7407Clxj8=;
 b=xAzZgT306BpsxEsIzrzeH2R0ba7leC42M3kH+8GLSabzcRbwAJXtl02Xt4Gw0DswTM
 SKcMfgRvi+qvrvcG5i9h7xERK+x54sI3+xNHp4ZiR9VYUg3XzTEQQ/wSFSuDEVlbeqzh
 /ihAooOP//6fVWgkljlxLM/URuV8ntdiGTbCMGfGateIPPJNI0/r6I2fVQbolDUqQv6g
 W6uUNFQuvL3hNwH3vaGLGcD31meRBTS9CpT3W4Wa576FekZuGDIuuyqjMOIyqqWrh1F4
 EcM+vznR3aueKp+svdNj19CQfftMCEIkvrSmXcbyUiDxEYZGUGRDFDLrjMFoY2WjGmMv
 mNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KEuiqLQJQeVIcNdqiDmm+jMBwfWT2SyGRR7407Clxj8=;
 b=XExI/jDkGtrw8VwlGMbmziYKUUCSxNEjp1nn78Y1ycPYiBDNeYcSgTGLFhbDIVSDO6
 btYwb/pRltzFZpkLNYjUHEApxOeoFHRTdgYn/1T5Egvo75uoywxf7v0dPG5JIAzht5kH
 1KHWO9npbXLtBPZkGrjzyFXGrlm8dBprxVi0kRRxQ7tvjFfM7q5PkJUMQ6TlOvHINajC
 3YcC0W3yNsNN06xpaVtNMaiNgBG0858fCuJCP7ifYR6jnHQpJ5d1P7xRFz7XNh0ZNbjf
 xeIjMh66Bjs6WE6gmuh05IeNiKJE/xqAq7supRsEvmmhIQhl+FbUIQCbY/8/u0uV5J8J
 qpTA==
X-Gm-Message-State: ANhLgQ07ORNR9nqZCXwBw7QpLM+IPvy2hF8us5IKQ6mLbbEXE3+O+zYU
 Hpco8YrQdXOi5PmCC9IavpFDy7w2aRez8g==
X-Google-Smtp-Source: ADFU+vvM48ilmydGx6ykhlxvSDSxP4cK9RvsMlrYXJPY0HsfE9qFpKAVH8uSEi9TD1kI5mdOB/lhHA==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr3650043wmj.56.1583493038315;
 Fri, 06 Mar 2020 03:10:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/33] scripts/hxtool-conv: Archive script used in
 qemu-options.hx conversion
Date: Fri,  6 Mar 2020 11:09:51 +0000
Message-Id: <20200306110959.29461-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

This commit archives the perl script used to do conversion of the
STEXI/ETEXI blocks in qemu-options.hx. (The other .hx files were
manually converted, but qemu-options.hx is complicated enough that
I felt I needed some scripting.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-26-peter.maydell@linaro.org
---
 scripts/hxtool-conv.pl | 137 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100755 scripts/hxtool-conv.pl

diff --git a/scripts/hxtool-conv.pl b/scripts/hxtool-conv.pl
new file mode 100755
index 00000000000..eede40b3462
--- /dev/null
+++ b/scripts/hxtool-conv.pl
@@ -0,0 +1,137 @@
+#!/usr/bin/perl -w
+#
+# Script to convert .hx file STEXI/ETEXI blocks to SRST/ERST
+#
+# Copyright (C) 2020 Linaro
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# (at your option) any later version. See the COPYING file in the
+# top-level directory.
+
+# This script was only ever intended as a one-off conversion operation.
+# Please excuse the places where it is a bit hacky.
+# Some manual intervention after the conversion is expected, as are
+# some warnings from makeinfo.
+# Warning: this script is not idempotent: don't try to run it on
+# a .hx file that already has SRST/ERST sections.
+
+# Expected usage:
+# scripts/hxtool-conv.pl file.hx > file.hx.new
+
+use utf8;
+
+my $reading_texi = 0;
+my $texiblock = '';
+my @tables = ();
+
+sub update_tables($) {
+    my ($texi) = @_;
+    # Update our list of open table directives: every @table
+    # line in the texi fragment is added to the list, and every
+    # @end table line means we remove an entry from the list.
+    # If this fragment had a completely self contained table with
+    # both the @table and @end table lines, this will be a no-op.
+    foreach (split(/\n/, $texi)) {
+        push @tables, $_ if /^\@table/;
+        pop @tables if /^\@end table/;
+    }
+}
+
+sub only_table_directives($) {
+    # Return true if every line in the fragment is a start or end table directive
+    my ($texi) = @_;
+    foreach (split(/\n/, $texi)) {
+        return 0 unless /^\@table/ or /^\@end table/;
+    }
+    return 1;
+}
+
+sub output_rstblock($) {
+    # Write the output to /tmp/frag.texi, wrapped in whatever current @table
+    # lines we need.
+    my ($texi) = @_;
+
+    # As a special case, if this fragment is only table directives and
+    # nothing else, update our set of open table directives but otherwise
+    # ignore it. This avoids emitting an empty SRST/ERST block.
+    if (only_table_directives($texi)) {
+        update_tables($texi);
+        return;
+    }
+
+    open(my $fragfh, '>', '/tmp/frag.texi');
+    # First output the currently active set of open table directives
+    print $fragfh join("\n", @tables);
+    # Next, update our list of open table directives.
+    # We need to do this before we emit the closing table directives
+    # so that we emit the right number if this fragment had an
+    # unbalanced set of directives.
+    update_tables($texi);
+    # Then emit the texi fragment itself.
+    print $fragfh "\n$texi\n";
+    # Finally, add the necessary closing table directives.
+    print $fragfh "\@end table\n" x scalar @tables;
+    close $fragfh;
+
+    # Now invoke makeinfo/pandoc on it and slurp the results into a string
+    open(my $fh, '-|', "makeinfo --force -o - --docbook "
+         . "-D 'qemu_system_x86 QEMU_SYSTEM_X86_MACRO' "
+         . "-D 'qemu_system     QEMU_SYSTEM_MACRO'  /tmp/frag.texi "
+         . " | pandoc  -f docbook -t rst")
+        or die "can't start makeinfo/pandoc: $!";
+
+    binmode $fh, ':encoding(utf8)';
+
+    print "SRST\n";
+
+    # Slurp the whole thing into a string so we can do multiline
+    # string matches on it.
+    my $rst = do {
+        local $/ = undef;
+        <$fh>;
+    };
+    $rst =~ s/^-  − /-  /gm;
+    $rst =~ s/“/"/gm;
+    $rst =~ s/”/"/gm;
+    $rst =~ s/‘/'/gm;
+    $rst =~ s/’/'/gm;
+    $rst =~ s/QEMU_SYSTEM_MACRO/|qemu_system|/g;
+    $rst =~ s/QEMU_SYSTEM_X86_MACRO/|qemu_system_x86|/g;
+    $rst =~ s/(?=::\n\n +\|qemu)/.. parsed-literal/g;
+    $rst =~ s/:\n\n::$/::/gm;
+
+    # Fix up the invalid reference format makeinfo/pandoc emit:
+    # `Some string here <#anchorname>`__
+    # should be:
+    # :ref:`anchorname`
+    $rst =~ s/\`[^<`]+\<\#([^>]+)\>\`__/:ref:`$1`/gm;
+    print $rst;
+
+    close $fh or die "error on close: $!";
+    print "ERST\n";
+}
+
+# Read the whole .hx input file.
+while (<>) {
+    # Always print the current line
+    print;
+    if (/STEXI/) {
+        $reading_texi = 1;
+        $texiblock = '';
+        next;
+    }
+    if (/ETEXI/) {
+        $reading_texi = 0;
+        # dump RST version of block
+        output_rstblock($texiblock);
+        next;
+    }
+    if ($reading_texi) {
+        # Accumulate the texi into a string
+        # but drop findex entries as they will confuse makeinfo
+        next if /^\@findex/;
+        $texiblock .= $_;
+    }
+}
+
+die "Unexpectedly still in texi block at EOF" if $reading_texi;
-- 
2.20.1


