Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3456AC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23DC2075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTEX8tgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23DC2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1eq-0005pg-Kb
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Qd-0005s1-On; Thu, 01 Oct 2020 12:27:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:46314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Qb-0003GF-Qf; Thu, 01 Oct 2020 12:27:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id b124so4985527pfg.13;
 Thu, 01 Oct 2020 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FJ7Ef1/m9lpzTEr425fS28KWzMjxylwCQmwLFMMCyOg=;
 b=BTEX8tgWcGQuIWjA9Oid5gYrnEjazYqO2GpNYckvSkQglFkKPoJTkl1nBKw28xL+CL
 RsplShqHsOSl0y3dr9mBrWkom4KfqUQZJZCbaKJ7QHjZXes76QcY/D5VtIAAJHppIyEa
 6qloXs9tunrJNbELm4XSfRGvLIbG7wsp1JHMSyitPSxkPRA5WeJ0qVK4hec+I3dkrzt+
 f/CGVpyUb2WtGQ69A0G6LabymE5r2gI1QRMy/loB7V7gTvHNVyCB4B+dY9O4lQ+Fzob+
 DghjpW5ZTn43IeDnNw5MkMuo8JUlZkKSSKWJphLr8arsA8Fcs5Dax6A1SSn+Yve4bQin
 kNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FJ7Ef1/m9lpzTEr425fS28KWzMjxylwCQmwLFMMCyOg=;
 b=L0QnrVWzdUe5e2CTdqFDLkT4fdqfzDosFZcyGcLlQQ1RqTaqJsaz73gnKcebkwqc6b
 RZkTIt+sSaOqAcO8hRhu5HfA/nnH5DR/TzlD7Z7A1huxx3VE412wN+xtOhAzzmzZs9PT
 Nhp40wHX3g+5PBHoZyfbJP2H5spSrVYyAdWMj1TLNovh4kqFq4HIdATa1PUM/sN0w7Ie
 t0OebS/PwEyCEI/6t18Tkub25awV5o6qn4imG3/xUE8Y6A/2unBaQdFyI3wbEWZsNgnc
 NDhClYzwbsRI0agJppeQPWQPeTO97UtYKsDgAFMW055O9ncgqP5g1p3Do4UHI5FKbD0F
 D1lQ==
X-Gm-Message-State: AOAM532x4JpJJrksBdWKBz+Yme46R/jafO7+Yq+zCnb/ScaE7PtigtIZ
 qlLtHuTqrFEyLYaedTEHb6F0LmcEA75VUg==
X-Google-Smtp-Source: ABdhPJxmtZd1D16RunNdWgSzONRb1c7CGzz4om7chKQlpw7y1DgoCta9TJUPgqKTfVEhwUE0wPMcLQ==
X-Received: by 2002:a62:7b90:0:b029:152:ebe:828 with SMTP id
 w138-20020a627b900000b02901520ebe0828mr3057133pfc.38.1601569649985; 
 Thu, 01 Oct 2020 09:27:29 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id e8sm3810174pgj.8.2020.10.01.09.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:27:29 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] doc: remove hxtool-conv.pl
Date: Fri,  2 Oct 2020 00:27:05 +0800
Message-Id: <20201001162705.219-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001162705.219-1-luoyonggang@gmail.com>
References: <20201001162705.219-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script doesn't need anymore as all texi are already convert to rST

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 scripts/hxtool-conv.pl | 137 -----------------------------------------
 1 file changed, 137 deletions(-)
 delete mode 100755 scripts/hxtool-conv.pl

diff --git a/scripts/hxtool-conv.pl b/scripts/hxtool-conv.pl
deleted file mode 100755
index eede40b346..0000000000
--- a/scripts/hxtool-conv.pl
+++ /dev/null
@@ -1,137 +0,0 @@
-#!/usr/bin/perl -w
-#
-# Script to convert .hx file STEXI/ETEXI blocks to SRST/ERST
-#
-# Copyright (C) 2020 Linaro
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# (at your option) any later version. See the COPYING file in the
-# top-level directory.
-
-# This script was only ever intended as a one-off conversion operation.
-# Please excuse the places where it is a bit hacky.
-# Some manual intervention after the conversion is expected, as are
-# some warnings from makeinfo.
-# Warning: this script is not idempotent: don't try to run it on
-# a .hx file that already has SRST/ERST sections.
-
-# Expected usage:
-# scripts/hxtool-conv.pl file.hx > file.hx.new
-
-use utf8;
-
-my $reading_texi = 0;
-my $texiblock = '';
-my @tables = ();
-
-sub update_tables($) {
-    my ($texi) = @_;
-    # Update our list of open table directives: every @table
-    # line in the texi fragment is added to the list, and every
-    # @end table line means we remove an entry from the list.
-    # If this fragment had a completely self contained table with
-    # both the @table and @end table lines, this will be a no-op.
-    foreach (split(/\n/, $texi)) {
-        push @tables, $_ if /^\@table/;
-        pop @tables if /^\@end table/;
-    }
-}
-
-sub only_table_directives($) {
-    # Return true if every line in the fragment is a start or end table directive
-    my ($texi) = @_;
-    foreach (split(/\n/, $texi)) {
-        return 0 unless /^\@table/ or /^\@end table/;
-    }
-    return 1;
-}
-
-sub output_rstblock($) {
-    # Write the output to /tmp/frag.texi, wrapped in whatever current @table
-    # lines we need.
-    my ($texi) = @_;
-
-    # As a special case, if this fragment is only table directives and
-    # nothing else, update our set of open table directives but otherwise
-    # ignore it. This avoids emitting an empty SRST/ERST block.
-    if (only_table_directives($texi)) {
-        update_tables($texi);
-        return;
-    }
-
-    open(my $fragfh, '>', '/tmp/frag.texi');
-    # First output the currently active set of open table directives
-    print $fragfh join("\n", @tables);
-    # Next, update our list of open table directives.
-    # We need to do this before we emit the closing table directives
-    # so that we emit the right number if this fragment had an
-    # unbalanced set of directives.
-    update_tables($texi);
-    # Then emit the texi fragment itself.
-    print $fragfh "\n$texi\n";
-    # Finally, add the necessary closing table directives.
-    print $fragfh "\@end table\n" x scalar @tables;
-    close $fragfh;
-
-    # Now invoke makeinfo/pandoc on it and slurp the results into a string
-    open(my $fh, '-|', "makeinfo --force -o - --docbook "
-         . "-D 'qemu_system_x86 QEMU_SYSTEM_X86_MACRO' "
-         . "-D 'qemu_system     QEMU_SYSTEM_MACRO'  /tmp/frag.texi "
-         . " | pandoc  -f docbook -t rst")
-        or die "can't start makeinfo/pandoc: $!";
-
-    binmode $fh, ':encoding(utf8)';
-
-    print "SRST\n";
-
-    # Slurp the whole thing into a string so we can do multiline
-    # string matches on it.
-    my $rst = do {
-        local $/ = undef;
-        <$fh>;
-    };
-    $rst =~ s/^-  − /-  /gm;
-    $rst =~ s/“/"/gm;
-    $rst =~ s/”/"/gm;
-    $rst =~ s/‘/'/gm;
-    $rst =~ s/’/'/gm;
-    $rst =~ s/QEMU_SYSTEM_MACRO/|qemu_system|/g;
-    $rst =~ s/QEMU_SYSTEM_X86_MACRO/|qemu_system_x86|/g;
-    $rst =~ s/(?=::\n\n +\|qemu)/.. parsed-literal/g;
-    $rst =~ s/:\n\n::$/::/gm;
-
-    # Fix up the invalid reference format makeinfo/pandoc emit:
-    # `Some string here <#anchorname>`__
-    # should be:
-    # :ref:`anchorname`
-    $rst =~ s/\`[^<`]+\<\#([^>]+)\>\`__/:ref:`$1`/gm;
-    print $rst;
-
-    close $fh or die "error on close: $!";
-    print "ERST\n";
-}
-
-# Read the whole .hx input file.
-while (<>) {
-    # Always print the current line
-    print;
-    if (/STEXI/) {
-        $reading_texi = 1;
-        $texiblock = '';
-        next;
-    }
-    if (/ETEXI/) {
-        $reading_texi = 0;
-        # dump RST version of block
-        output_rstblock($texiblock);
-        next;
-    }
-    if ($reading_texi) {
-        # Accumulate the texi into a string
-        # but drop findex entries as they will confuse makeinfo
-        next if /^\@findex/;
-        $texiblock .= $_;
-    }
-}
-
-die "Unexpectedly still in texi block at EOF" if $reading_texi;
-- 
2.28.0.windows.1


