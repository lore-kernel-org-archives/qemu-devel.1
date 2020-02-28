Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7776C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9EC2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asQAiJMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9EC2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hsN-0005bg-So
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhI-0001Pn-84
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhG-00055i-Lj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hhG-00055F-F5
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:02 -0500
Received: by mail-wm1-x32f.google.com with SMTP id m3so3683126wmi.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B3NhFkcMtDjhdPvA9G8QXToc593uTJoPg9kwAJf/gXQ=;
 b=asQAiJMRC1DL7aXj3nhyt60TSidA9aozJ4qR2hxu+0l+XerypP1e6EFXbUekqrstF8
 +5BNWuAq1QpeJ5wY4jV2ZSBY5gVAOx9UygIzG7oe8ALTC0KfAzw9+6exxPgNRb2WO55D
 WxNC+Olxpd/H9LcLmTDbI/vCwcE5gQjQZmXgaKFgob9cuHO86d2OaMXvovJ8a1aQu5LQ
 GOB53nx5E2gopuMzBNrlpBdmAqMo3/AcKddwgr4U2mkFd0iiblKqm/OZ8rok4FBtjeFF
 C0zHXWknGfpzZBM4qkE/fuIpWoXTArIMwbdc+Rkr0tfxLlI0Dx078o3mW+6U0mezN1Qu
 ZbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B3NhFkcMtDjhdPvA9G8QXToc593uTJoPg9kwAJf/gXQ=;
 b=K5e87hc0nlD61ha9Yz/H0rd1Q0GjmV8FeSNdhFfOveQDYDRmA4vzCNByCcoewMN7fT
 B8HILrcVWM9rkehrAM5Itj5mdakGuCRG9ZO37Io+qKSGRW1DjMYdoVkdRUigo7n2vik6
 Tg0OXLXOfKwlBsHssj/EO296p1z+SDP8/NfjLqkTfEidU6mx97c0cOqVhUTK8ktUe1EU
 oqQT8ZtVI4CbFeGrwLlhZvsgYDz7kndceQ7kk9LA0fgvn6gtXxNQt5d27u/aE4+OslHV
 CRFmraw25Ab/6kFNaKWhQORyssxss00p0nri5Idsq0Ew/T5aA31zdtUBLtPB1dJC/gsG
 Anzw==
X-Gm-Message-State: APjAAAX1oN1qh4fmpnAOANNb5zWOz8Ck5J+xElL+H4pMAHg/dgv4RZE+
 VSm3tDSLMTQXHzOLZChEHzhYDHxCr2Kvzw==
X-Google-Smtp-Source: APXvYqzrHUV9sXPybWTBTxdPnuxWE93dxIxSsGabjSiEbPwaDLhPz0U2u8DLJP1xZZuFmODtQnXCAw==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr5394944wmh.84.1582904221036; 
 Fri, 28 Feb 2020 07:37:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:37:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/33] scripts/hxtool-conv: Archive script used in
 qemu-options.hx conversion
Date: Fri, 28 Feb 2020 15:36:11 +0000
Message-Id: <20200228153619.9906-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit archives the perl script used to do conversion of the
STEXI/ETEXI blocks in qemu-options.hx. (The other .hx files were
manually converted, but qemu-options.hx is complicated enough that
I felt I needed some scripting.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Please don't critique the script, it is purely for a one-off
conversion job, and I then did manual fixups on the output
to get the changes in the following patch. I merely felt it
was potentially useful to archive a copy of the mechanism used.
Or we could drop this patch if that's not needed.
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


