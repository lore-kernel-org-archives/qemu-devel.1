Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3781C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDE82467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hid7JL4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDE82467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uuw-0002A9-Kr
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utj-0000Zn-N9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uti-0005or-KW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6uti-0005je-De
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so2615363wmj.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fw/rJa8dhtp/mvFKBv5486BhN3zvfJhs9x20gT+6mYA=;
 b=hid7JL4p0EyLwAJVb7B2zEOGy0u96FpGFTQu9zULjdJ+PTTA6DC7c95OZ8SRdIRa2p
 19KVtKOkWc3ryZ6Ig64PMj1ZM/qqf6k0mSHE/LefEoQnvtQTDVbXjCocLNGyNFUiG1Mh
 iLUTgaE+M5NVGLqsS9Xi18kq4qg5kd1YCjNnAV6K2bsIs6Bs+LOX0BsF4GMTmJCI1G1v
 ISo60DwTmcmKa+9vrwEi7zdL5rydJFcp0+uiNHFV0b2YApsfTTux3egen43h6k09W/Hm
 hIZNWCOWPTWmf70vjDgmBr2svCKJI92DbkizhVIPfaL/farNXYzuwSo3reXjGT+2IJLW
 7Z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fw/rJa8dhtp/mvFKBv5486BhN3zvfJhs9x20gT+6mYA=;
 b=MxfJO+4yEUj5O3UfI4GME3mK+iLd0HiLjjGcepCF1yHhhg/AwcWAs/82/Ena0CT4JB
 PV3BJHWMxeQI+IcaDYJ+Y8E2XYKVq1/lT3Oy9eMea8NfimUp6ZA/cxnPTNAlpK+CuuOb
 NDE/ej8/Lf7Uvv4evFFTjfrSe+0C386KWq3GXYQterZ2b6+JzgagQCfxVFawEfmrXQ2a
 8gHI3eIJ4GffRGTeS2uJPCMTkxq9gQd8lwBvVPDKvm9YY8DtCP0Je9CRvkGO1Y7TocrU
 T1bTW6vIKDg88BD5OGrAUHL2Adhs/bT83xueosz8A+lokkVj07nHEfN7X64Dq49A1u0S
 SV3Q==
X-Gm-Message-State: APjAAAVQ8PTaqYr4zhU7vuVbpUfMsQzSCOl8fZwhQ8sUcW/ZLRx0FWTK
 qMtmRRZtMNI8WSbBToifPVrVAn+H
X-Google-Smtp-Source: APXvYqzwsTq6SPkYGZp+q+OB0bSf9EUo8SWV8xRqb61smIAaIExVHR3HyH6yyJO89anRn3KZtB25cg==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr5335996wmh.104.1582716636972; 
 Wed, 26 Feb 2020 03:30:36 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/18] texi2pod: parse @include directives outside "@c man"
 blocks
Date: Wed, 26 Feb 2020 12:30:19 +0100
Message-Id: <20200226113034.6741-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This enables splitting the huge qemu-doc.texi file and keeping parallel
Texinfo and rST versions of the documentation.  texi2pod is not going to
live much longer and hardly anyone cares about its upstream status,
so the temporary fork should be acceptable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/texi2pod.pl | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
index 839b7917cf..8bfc6f6f4c 100755
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
2.21.1



