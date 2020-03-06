Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1960C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0812073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbCyKgUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0812073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAtC-00056q-Jj
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAro-00032S-Ku
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAArn-0004Dp-7V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:08 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAArn-0004Bl-0z
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:07 -0500
Received: by mail-wr1-x434.google.com with SMTP id n7so1838111wrt.11
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AaYzuDEpKUEZmukyHkMDOESReHv5q9LdwP18n+bqCHQ=;
 b=CbCyKgUR1/ptLLNcXP+rpR1j/LiJnJfQyw5/VwmJJqKVTqETgi2CZ5VmzkrfSqOJal
 3hrr5LdqBbCkgLm6i4Gwhf8yaSFdTYppsCxpR1dToMZsMEieIEtkhp3gyP3gKGQdIVqD
 4gNqmzXSrpah+yHHB8TMmPye9UrhQ1QwhdsLDMAs/80Eh+fjhnutTk9Qmuqt873OMo0A
 K+Phn0ZqvsM3CwSz0pbWPrXaFU545JYitznyF6KYgUnlkXeHUBfvp8EzXzNbd5KVZO4C
 aXuyYfFbYuCVknafQoIVTyJHuMIj/wJHRb2V7hcubVRyHSwIly0FHuOnUnv/qfQAB3i8
 11Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AaYzuDEpKUEZmukyHkMDOESReHv5q9LdwP18n+bqCHQ=;
 b=BevuuhMGBa5iVDt6X6AgVYtvr0yEw8MSIY2P94o0WQ4JEYRqFR5A3wYAo01iSvmagm
 x+JNwSMbOgeJTAH0PKS8xbZt1WUWHi32wjg9zReFmst5vIA0FB+6zPvl6K2lyCqxfwV/
 aIKsbdgsW0cLRQUsvPQgmAnd+2MJwjjSsJbhGGVdvk5ud3n8EfBcNr1zz/L+EWz8LeLo
 bRPQO42XFN1oLUak7nZCd2AwlvgEmlZs+aGkr+hwckc3qgUmtxyTRy1Tq3SSe+q1cy0s
 F+HqJ2PXPhL57zekxR9BAEJkRdooT2AZ4bymasPY7zTioy2vN5hVhS4xHKFK1unwnb4I
 vbrg==
X-Gm-Message-State: ANhLgQ0qrlc3JLei43zMeKrBaD9BAC34GGDJzTULR7GVfvEgACfjrqBx
 LBreWJXymjSPbBrBrlac/L8zWDT9VvFLGQ==
X-Google-Smtp-Source: ADFU+vvQ4UqZRT++uV8Ug/KDXoicjWyeFEHvp/EZXZTPE21vt8unneESN96xzwg7PuSCLk2GJww8FQ==
X-Received: by 2002:adf:a512:: with SMTP id i18mr3567233wrb.61.1583493005680; 
 Fri, 06 Mar 2020 03:10:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/33] texi2pod: parse @include directives outside "@c man"
 blocks
Date: Fri,  6 Mar 2020 11:09:29 +0000
Message-Id: <20200306110959.29461-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

From: Paolo Bonzini <pbonzini@redhat.com>

This enables splitting the huge qemu-doc.texi file and keeping parallel
Texinfo and rST versions of the documentation.  texi2pod is not going to
live much longer and hardly anyone cares about its upstream status,
so the temporary fork should be acceptable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200228153619.9906-4-peter.maydell@linaro.org
Message-id: 20200226113034.6741-4-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/texi2pod.pl | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
index 839b7917cf7..8bfc6f6f4c4 100755
--- a/scripts/texi2pod.pl
+++ b/scripts/texi2pod.pl
@@ -143,6 +143,24 @@ while(<$inf>) {
 	next;
     };
 
+    # Single line command handlers.
+
+    /^\@include\s+(.+)$/ and do {
+	push @instack, $inf;
+	$inf = gensym();
+	$file = postprocess($1);
+
+	# Try cwd and $ibase, then explicit -I paths.
+	$done = 0;
+	foreach $path ("", $ibase, @ipath) {
+	    $mypath = $file;
+	    $mypath = $path . "/" . $mypath if ($path ne "");
+	    open($inf, "<" . $mypath) and ($done = 1, last);
+	}
+	die "cannot find $file" if !$done;
+	next;
+    };
+
     next unless $output;
 
     # Discard comments.  (Can't do it above, because then we'd never see
@@ -242,24 +260,6 @@ while(<$inf>) {
 	s/>/&GT;/g;
     }
 
-    # Single line command handlers.
-
-    /^\@include\s+(.+)$/ and do {
-	push @instack, $inf;
-	$inf = gensym();
-	$file = postprocess($1);
-
-	# Try cwd and $ibase, then explicit -I paths.
-	$done = 0;
-	foreach $path ("", $ibase, @ipath) {
-	    $mypath = $file;
-	    $mypath = $path . "/" . $mypath if ($path ne "");
-	    open($inf, "<" . $mypath) and ($done = 1, last);
-	}
-	die "cannot find $file" if !$done;
-	next;
-    };
-
     /^\@(?:section|unnumbered|unnumberedsec|center)\s+(.+)$/
 	and $_ = "\n=head2 $1\n";
     /^\@subsection\s+(.+)$/
-- 
2.20.1


