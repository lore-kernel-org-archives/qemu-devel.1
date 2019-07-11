Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A00BC742A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DFC20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBuBNeBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DFC20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhdg-0002yP-Tk
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdA-00016f-FR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhd2-0003rX-2m
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:30 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:41904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhcy-0003fC-U8
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:25 -0400
Received: by mail-yb1-xb44.google.com with SMTP id 13so3196970ybx.8
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dCnnbb8AWZepBe80f73sl6PvHUpiI5AToL5sD/uo3so=;
 b=LBuBNeBP8jmrmvJyCvmZS4xYmE2cGEiieJvk/+jxwgDlDVIZENw+3jbgIBXOtD7CcV
 7T02n1OhrGY11MAnHLkCQs0eYGkvKlK8GE/Cvr5GjsIVY0WRmTRdYqVQPd9UmJYc9lay
 Zz4u7DuoEFvnzei9NfXdPqgrZNLHQV3rZpOD70Viz9kNuye6/SbxYCLU5Ae7nlkU9Jyw
 VwjBmFxN7XWqqyvXyKF8Dxr37OtkcGLZrXEnp3hP5lEgxFKgM8liS9nVTV6Jtrnm3rwe
 EQVYIcTKVhic5f6YHWekg69jrdJDfzb29eLZgsFUaHvWTPDnqLq5Klt2GV9fLSXCtNjv
 7uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dCnnbb8AWZepBe80f73sl6PvHUpiI5AToL5sD/uo3so=;
 b=oV4l86794k6CZ+zpTyrIs/PEQD5MveHyI+JIUlYvIZe72lrtC/5hqcD6yIKCPfthNr
 Grn12ttb/Fr0ZuU3L95XKhhsPKAle95ouIaUsyPh+id3mSr/yQJ4cTI2ED/JBm7Q8oI2
 sa/fZIgH66DSt58U4nvBO1lZasdrdos7I+OZeAuEikSDAn4bnfsfsrhYlzmSEDKuETYw
 UutcQ0YeXQsXzCRgtxSSOitlU1jkmOGKYDioaCfB2fHsnF3O5SXULvRFW0/Hdd+ECQ8j
 93vIDbCSXSx2o+tNWzpfNrCztCzUQEIKZyTGNZCe30j5IRtGiUsJrSuFfJO5to9CFxzc
 GY4Q==
X-Gm-Message-State: APjAAAVXrmVqiwvdQHOe0a4fm8CjKPb/S/1VoDF7cSjcHYRj+jb6x18+
 gFd6u9eaxHq5xRWUOSmnA9K7jbRS
X-Google-Smtp-Source: APXvYqwK/oLEIgxMGK32pPybjEbxxHylGWyRORXlWfcYqJwExZ0k0nH0G+kMDmApCtqy/uDmwKxlGQ==
X-Received: by 2002:a25:7083:: with SMTP id l125mr4158067ybc.449.1562884397940; 
 Thu, 11 Jul 2019 15:33:17 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:17 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:50 -0400
Message-Id: <20190711223300.6061-9-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU PATCH v3 08/18] risugen: add command-line flag
 --x86_64
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This flag instructs the x86 backend to emit 64-bit (rather than
32-bit) code.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/risugen b/risugen
index 0c859aa..50920eb 100755
--- a/risugen
+++ b/risugen
@@ -10,6 +10,7 @@
 #     Peter Maydell (Linaro) - initial implementation
 #     Claudio Fontana (Linaro) - initial aarch64 support
 #     Jose Ricardo Ziviani (IBM) - initial ppc64 support and arch isolation
+#     Jan Bobek - initial x86 support
 ###############################################################################
 
 # risugen -- generate a test binary file for use with risu
@@ -309,6 +310,7 @@ Valid options:
                    Useful to test before support for FP is available.
     --sve        : enable sve floating point
     --be         : generate instructions in Big-Endian byte order (ppc64 only).
+    --x86_64     : generate 64-bit (rather than 32-bit) code. (x86 only)
     --help       : print this message
 EOT
 }
@@ -321,6 +323,7 @@ sub main()
     my $fp_enabled = 1;
     my $sve_enabled = 0;
     my $big_endian = 0;
+    my $is_x86_64 = 0;
     my ($infile, $outfile);
 
     GetOptions( "help" => sub { usage(); exit(0); },
@@ -338,6 +341,7 @@ sub main()
                 "be" => sub { $big_endian = 1; },
                 "no-fp" => sub { $fp_enabled = 0; },
                 "sve" => sub { $sve_enabled = 1; },
+                "x86_64" => sub { $is_x86_64 = 1; },
         ) or return 1;
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
@@ -371,7 +375,8 @@ sub main()
         'keys' => \@insn_keys,
         'arch' => $full_arch[0],
         'subarch' => $full_arch[1] || '',
-        'bigendian' => $big_endian
+        'bigendian' => $big_endian,
+        'x86_64' => $is_x86_64,
     );
 
     write_test_code(\%params);
-- 
2.20.1


