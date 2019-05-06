Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5420BC04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFAF20B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+gDCQWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFAF20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNiOs-0008EF-W9
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:31:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiN1-0007Ds-MJ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiN0-0000IE-Bp
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:41115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNiN0-0000HS-3X
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:46 -0400
Received: by mail-pl1-x629.google.com with SMTP id d9so6783276pls.8
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=tOB7k/2hv0qgDPmpyJIjmIejxWr898ct1NuzMnEJO5o=;
	b=x+gDCQWrb4dORd3sZG+iZE+WUrUZJGWBWhX3G2TBLHhQIlLjMK45xy54joOqsNVAhg
	7TwVA4wWbI88Ys2rL+fS4SNPmyGoYrpcPZZ8OSXnR2YsdE1wecN2ui1CEP9gzXpiw3Oj
	3el0ojP/U6nAFOXczberquzHpEqCRoqlJ7JN4jFYFE11vsOkxq8KY3Vown5Uiz6OrII2
	pAoyeXt+jgROX6YEWSKoRNFdghasxJ3RngZ+06vSDAQ1hk5LHWLPQe+Edl5xYUzgZAlD
	ZYVkM8A2EQmyKqCqw6MzP7KPzJZPOsda2D4wP6iWuGBJEJsWqPi5hH/sLxG1P67XOBMW
	OE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=tOB7k/2hv0qgDPmpyJIjmIejxWr898ct1NuzMnEJO5o=;
	b=Q6PFTXFc+5691ou4Sk0CtgX9ES1gWl2yBAaQ6y91KPXURbqHnrnnSp9pQDuRHbb0kp
	rq4jEyAZpHWrO4ugyY9i8dTNyXGC/rutOMUXj5GDO1RW3NGkMW7/CWzAoG6wTbmpmYMc
	bo77w9aMFK2gb52m8p9HBgx6T3E4stUezQ/QNlH/Unfn5pcgdda4E3acTrpd6ppWpi8l
	RxBnjPybMI2elFDaawpdSwY/BmhPoPm6bsnx/ZHtT+vT+6RbhUJPJaU+oi7LSfn5qg8h
	tasVaDN146CASqEbA4/tifTAcukmXMNykaA+rQ9/bJvomkhilYwxLqk3hD55TtDvOktw
	ibbw==
X-Gm-Message-State: APjAAAWCQoC5Yb8T31zwjzyYmlMAnT+8dNwIOVC0NUA222qs8TXA9WCT
	eFriABNRlAB3dw2HzRcqDkRNj7W3psw=
X-Google-Smtp-Source: APXvYqyXxppT+7rZDvcpBZkYT3Uzz/KIqAmBRv9Xi4hS1K3xDb8iKmKfcCQgMz0gOXDBEtqAF2T1qA==
X-Received: by 2002:a17:902:e183:: with SMTP id
	cd3mr34356435plb.233.1557167384669; 
	Mon, 06 May 2019 11:29:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j32sm12909924pgi.73.2019.05.06.11.29.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 11:29:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 11:29:38 -0700
Message-Id: <20190506182940.2200-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506182940.2200-1-richard.henderson@linaro.org>
References: <20190506182940.2200-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PULL 1/3] decodetree: Initial support for
 variable-length ISAs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Assuming that the ISA clearly describes how to determine
the length of the instruction, and the ISA has a reasonable
maximum instruction length, the input to the decoder can be
right-justified in an appropriate insn word.

This is not 100% convenient, as out-of-line %fields are
numbered relative to the maximum instruction length, but
this appears to still be usable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 49 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index aa790b596a..555a46522b 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -27,6 +27,7 @@ import getopt
 
 insnwidth = 32
 insnmask = 0xffffffff
+variablewidth = False
 fields = {}
 arguments = {}
 formats = {}
@@ -289,7 +290,7 @@ class Arguments:
 
 class General:
     """Common code between instruction formats and instruction patterns"""
-    def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds):
+    def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, w):
         self.name = name
         self.file = input_file
         self.lineno = lineno
@@ -299,6 +300,7 @@ class General:
         self.undefmask = udfm
         self.fieldmask = fldm
         self.fields = flds
+        self.width = w
 
     def __str__(self):
         return self.name + ' ' + str_match_bits(self.fixedbits, self.fixedmask)
@@ -352,7 +354,7 @@ class Pattern(General):
 class MultiPattern(General):
     """Class representing an overlapping set of instruction patterns"""
 
-    def __init__(self, lineno, pats, fixb, fixm, udfm):
+    def __init__(self, lineno, pats, fixb, fixm, udfm, w):
         self.file = input_file
         self.lineno = lineno
         self.pats = pats
@@ -360,6 +362,7 @@ class MultiPattern(General):
         self.fixedbits = fixb
         self.fixedmask = fixm
         self.undefmask = udfm
+        self.width = w
 
     def __str__(self):
         r = "{"
@@ -502,7 +505,7 @@ def infer_argument_set(flds):
     return arg
 
 
-def infer_format(arg, fieldmask, flds):
+def infer_format(arg, fieldmask, flds, width):
     global arguments
     global formats
     global decode_function
@@ -521,6 +524,8 @@ def infer_format(arg, fieldmask, flds):
             continue
         if fieldmask != fmt.fieldmask:
             continue
+        if width != fmt.width:
+            continue
         if not eq_fields_for_fmts(flds, fmt.fields):
             continue
         return (fmt, const_flds)
@@ -529,7 +534,7 @@ def infer_format(arg, fieldmask, flds):
     if not arg:
         arg = infer_argument_set(flds)
 
-    fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds)
+    fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds, width)
     formats[name] = fmt
 
     return (fmt, const_flds)
@@ -546,6 +551,7 @@ def parse_generic(lineno, is_format, name, toks):
     global re_ident
     global insnwidth
     global insnmask
+    global variablewidth
 
     fixedmask = 0
     fixedbits = 0
@@ -633,8 +639,15 @@ def parse_generic(lineno, is_format, name, toks):
             error(lineno, 'invalid token "{0}"'.format(t))
         width += shift
 
+    if variablewidth and width < insnwidth and width % 8 == 0:
+        shift = insnwidth - width
+        fixedbits <<= shift
+        fixedmask <<= shift
+        undefmask <<= shift
+        undefmask |= (1 << shift) - 1
+
     # We should have filled in all of the bits of the instruction.
-    if not (is_format and width == 0) and width != insnwidth:
+    elif not (is_format and width == 0) and width != insnwidth:
         error(lineno, 'definition has {0} bits'.format(width))
 
     # Do not check for fields overlaping fields; one valid usage
@@ -660,7 +673,7 @@ def parse_generic(lineno, is_format, name, toks):
         if name in formats:
             error(lineno, 'duplicate format name', name)
         fmt = Format(name, lineno, arg, fixedbits, fixedmask,
-                     undefmask, fieldmask, flds)
+                     undefmask, fieldmask, flds, width)
         formats[name] = fmt
     else:
         # Patterns can reference a format ...
@@ -670,12 +683,14 @@ def parse_generic(lineno, is_format, name, toks):
                 error(lineno, 'pattern specifies both format and argument set')
             if fixedmask & fmt.fixedmask:
                 error(lineno, 'pattern fixed bits overlap format fixed bits')
+            if width != fmt.width:
+                error(lineno, 'pattern uses format of different width')
             fieldmask |= fmt.fieldmask
             fixedbits |= fmt.fixedbits
             fixedmask |= fmt.fixedmask
             undefmask |= fmt.undefmask
         else:
-            (fmt, flds) = infer_format(arg, fieldmask, flds)
+            (fmt, flds) = infer_format(arg, fieldmask, flds, width)
         arg = fmt.base
         for f in flds.keys():
             if f not in arg.fields:
@@ -687,7 +702,7 @@ def parse_generic(lineno, is_format, name, toks):
             if f not in flds.keys() and f not in fmt.fields.keys():
                 error(lineno, 'field {0} not initialized'.format(f))
         pat = Pattern(name, lineno, fmt, fixedbits, fixedmask,
-                      undefmask, fieldmask, flds)
+                      undefmask, fieldmask, flds, width)
         patterns.append(pat)
         allpatterns.append(pat)
 
@@ -727,6 +742,13 @@ def build_multi_pattern(lineno, pats):
         if p.lineno < lineno:
             lineno = p.lineno
 
+    width = None
+    for p in pats:
+        if width is None:
+            width = p.width
+        elif width != p.width:
+            error(lineno, 'width mismatch in patterns within braces')
+
     repeat = True
     while repeat:
         if fixedmask == 0:
@@ -742,7 +764,7 @@ def build_multi_pattern(lineno, pats):
         else:
             repeat = False
 
-    mp = MultiPattern(lineno, pats, fixedbits, fixedmask, undefmask)
+    mp = MultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
     patterns.append(mp)
 # end build_multi_pattern
 
@@ -979,13 +1001,14 @@ def main():
     global insntype
     global insnmask
     global decode_function
+    global variablewidth
 
     decode_scope = 'static '
 
     long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=',
-                 'static-decode=']
+                 'static-decode=', 'varinsnwidth=']
     try:
-        (opts, args) = getopt.getopt(sys.argv[1:], 'o:w:', long_opts)
+        (opts, args) = getopt.getopt(sys.argv[1:], 'o:vw:', long_opts)
     except getopt.GetoptError as err:
         error(0, err)
     for o, a in opts:
@@ -999,7 +1022,9 @@ def main():
         elif o == '--translate':
             translate_prefix = a
             translate_scope = ''
-        elif o in ('-w', '--insnwidth'):
+        elif o in ('-w', '--insnwidth', '--varinsnwidth'):
+            if o == '--varinsnwidth':
+                variablewidth = True
             insnwidth = int(a)
             if insnwidth == 16:
                 insntype = 'uint16_t'
-- 
2.17.1


