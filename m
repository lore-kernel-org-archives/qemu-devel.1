Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE76DC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5ED20B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="up0KztIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5ED20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNiOt-0008FG-UN
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:31:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiN2-0007E1-SV
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiN1-0000JS-KQ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:35271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNiN1-0000Iq-Cu
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id w24so6793929plp.2
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=aOndsQdbM3kEhAR2nREOKWxj88rFf9PBZroBuJd+MwA=;
	b=up0KztIyuKg4cu1gGVw+Wxq/RuJ4ShV6LODEOlgIX8oj+gn+p4DBogoCU5OQTVml9p
	7jEPjWGVUoOrYstZ1D59Yp48SfA5wQcT94OBV/Gng+Xv7g8wdbwImMcv4vx7k15vDUrm
	BY7xNPlnn0Bw3K8vsh06laeopbYQBduanb/Ro9ocXVY21LikqxYl+lDTHjSAAZTlqWmN
	E0ycI/a347k0upGt8ddI+kaixtX0hP0Yp4JE25bgJqGu9YFYkFlrLU+ej4uUDwVjt8mb
	yNMr0TIkQ+ZH3uHr7Bnpkh3RRB76Us6ftzGYutuW8u/e0KJVRZIJGTCRG8Vc4UebXVBi
	yF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=aOndsQdbM3kEhAR2nREOKWxj88rFf9PBZroBuJd+MwA=;
	b=AS+LoPBnN3ZZhR3S1XNiwH90wNtXqSVZHKzfXIr9mZ2cnTEZU/sBbkkstpN+Wx6HNS
	1S4UmM9HQ8pJJLKAtbcNPc1rt/Aad/HgddiVYdJwM7LybMd9fiz6zpJTKqSfC/QuwgP8
	dtGq6qdHsfbc88MjH+FNdOY5jW1HqBRpfC18P+aqcIb7W/QlACeKi+D0r1oplLF3J+rS
	SMJrpDRrey3C57pGPK5BAwEk05nWSJJLeFBuV/F0edy0Olu4s7DieP9n6Xc3gKDAIJYY
	kmUeXEu8dLJDgmracZmBmSVkND9zmOaeFKv6LJwipSMsVscprsVWXDzyOhfln/0tOYjo
	4hFw==
X-Gm-Message-State: APjAAAXjedxD762EymnoQTZ13gTBghyJDutnfpI5F9q9WpPj9MmLp3BY
	aBUEL/MQTSwFB23Jwm9g6uxKJumaEn4=
X-Google-Smtp-Source: APXvYqz1/7f7xnCt0OShcdN0tRwwj9HWpGsbHp6mKOLQP5r3iQfpGSdTV3/tbf1lTGbusI9uuHvyFA==
X-Received: by 2002:a17:902:6b8b:: with SMTP id
	p11mr33685759plk.225.1557167385988; 
	Mon, 06 May 2019 11:29:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j32sm12909924pgi.73.2019.05.06.11.29.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 11:29:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 11:29:39 -0700
Message-Id: <20190506182940.2200-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506182940.2200-1-richard.henderson@linaro.org>
References: <20190506182940.2200-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62b
Subject: [Qemu-devel] [PULL 2/3] decodetree: Expand a decode_load function
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

Read the instruction, loading no more bytes than necessary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 175 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 3 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 555a46522b..4536e3a63d 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -965,6 +965,147 @@ def build_tree(pats, outerbits, outermask):
 # end build_tree
 
 
+class SizeTree:
+    """Class representing a node in a size decode tree"""
+
+    def __init__(self, m, w):
+        self.mask = m
+        self.subs = []
+        self.base = None
+        self.width = w
+
+    def str1(self, i):
+        ind = str_indent(i)
+        r = '{0}{1:08x}'.format(ind, self.mask)
+        r += ' [\n'
+        for (b, s) in self.subs:
+            r += '{0}  {1:08x}:\n'.format(ind, b)
+            r += s.str1(i + 4) + '\n'
+        r += ind + ']'
+        return r
+
+    def __str__(self):
+        return self.str1(0)
+
+    def output_code(self, i, extracted, outerbits, outermask):
+        ind = str_indent(i)
+
+        # If we need to load more bytes to test, do so now.
+        if extracted < self.width:
+            output(ind, 'insn = ', decode_function,
+                   '_load_bytes(ctx, insn, {0}, {1});\n'
+                   .format(extracted / 8, self.width / 8));
+            extracted = self.width
+
+        # Attempt to aid the compiler in producing compact switch statements.
+        # If the bits in the mask are contiguous, extract them.
+        sh = is_contiguous(self.mask)
+        if sh > 0:
+            # Propagate SH down into the local functions.
+            def str_switch(b, sh=sh):
+                return '(insn >> {0}) & 0x{1:x}'.format(sh, b >> sh)
+
+            def str_case(b, sh=sh):
+                return '0x{0:x}'.format(b >> sh)
+        else:
+            def str_switch(b):
+                return 'insn & 0x{0:08x}'.format(b)
+
+            def str_case(b):
+                return '0x{0:08x}'.format(b)
+
+        output(ind, 'switch (', str_switch(self.mask), ') {\n')
+        for b, s in sorted(self.subs):
+            innermask = outermask | self.mask
+            innerbits = outerbits | b
+            output(ind, 'case ', str_case(b), ':\n')
+            output(ind, '    /* ',
+                   str_match_bits(innerbits, innermask), ' */\n')
+            s.output_code(i + 4, extracted, innerbits, innermask)
+        output(ind, '}\n')
+        output(ind, 'return insn;\n')
+# end SizeTree
+
+class SizeLeaf:
+    """Class representing a leaf node in a size decode tree"""
+
+    def __init__(self, m, w):
+        self.mask = m
+        self.width = w
+
+    def str1(self, i):
+        ind = str_indent(i)
+        return '{0}{1:08x}'.format(ind, self.mask)
+
+    def __str__(self):
+        return self.str1(0)
+
+    def output_code(self, i, extracted, outerbits, outermask):
+        global decode_function
+        ind = str_indent(i)
+
+        # If we need to load more bytes, do so now.
+        if extracted < self.width:
+            output(ind, 'insn = ', decode_function,
+                   '_load_bytes(ctx, insn, {0}, {1});\n'
+                   .format(extracted / 8, self.width / 8));
+            extracted = self.width
+        output(ind, 'return insn;\n')
+# end SizeLeaf
+
+
+def build_size_tree(pats, width, outerbits, outermask):
+    global insnwidth
+
+    # Collect the mask of bits that are fixed in this width
+    innermask = 0xff << (insnwidth - width)
+    innermask &= ~outermask
+    minwidth = None
+    onewidth = True
+    for i in pats:
+        innermask &= i.fixedmask
+        if minwidth is None:
+            minwidth = i.width
+        elif minwidth != i.width:
+            onewidth = False;
+            if minwidth < i.width:
+                minwidth = i.width
+
+    if onewidth:
+        return SizeLeaf(innermask, minwidth)
+
+    if innermask == 0:
+        if width < minwidth:
+            return build_size_tree(pats, width + 8, outerbits, outermask)
+
+        pnames = []
+        for p in pats:
+            pnames.append(p.name + ':' + p.file + ':' + str(p.lineno))
+        error_with_file(pats[0].file, pats[0].lineno,
+                        'overlapping patterns size {0}:'.format(width), pnames)
+
+    bins = {}
+    for i in pats:
+        fb = i.fixedbits & innermask
+        if fb in bins:
+            bins[fb].append(i)
+        else:
+            bins[fb] = [i]
+
+    fullmask = outermask | innermask
+    lens = sorted(bins.keys())
+    if len(lens) == 1:
+        b = lens[0]
+        return build_size_tree(bins[b], width + 8, b | outerbits, fullmask)
+
+    r = SizeTree(innermask, width)
+    for b, l in bins.items():
+        s = build_size_tree(l, width, b | outerbits, fullmask)
+        r.subs.append((b, s))
+    return r
+# end build_size_tree
+
+
 def prop_format(tree):
     """Propagate Format objects into the decode tree"""
 
@@ -987,6 +1128,23 @@ def prop_format(tree):
 # end prop_format
 
 
+def prop_size(tree):
+    """Propagate minimum widths up the decode size tree"""
+
+    if isinstance(tree, SizeTree):
+        min = None
+        for (b, s) in tree.subs:
+            width = prop_size(s)
+            if min is None or min > width:
+                min = width
+        assert min >= tree.width
+        tree.width = min
+    else:
+        min = tree.width
+    return min
+# end prop_size
+
+
 def main():
     global arguments
     global formats
@@ -1042,8 +1200,12 @@ def main():
         parse_file(f)
         f.close()
 
-    t = build_tree(patterns, 0, 0)
-    prop_format(t)
+    if variablewidth:
+        stree = build_size_tree(patterns, 8, 0, 0)
+        prop_size(stree)
+
+    dtree = build_tree(patterns, 0, 0)
+    prop_format(dtree)
 
     if output_file:
         output_fd = open(output_file, 'w')
@@ -1084,11 +1246,18 @@ def main():
             f = arguments[n]
             output(i4, i4, f.struct_name(), ' f_', f.name, ';\n')
         output(i4, '} u;\n\n')
-        t.output_code(4, False, 0, 0)
+        dtree.output_code(4, False, 0, 0)
 
     output(i4, 'return false;\n')
     output('}\n')
 
+    if variablewidth:
+        output('\n', decode_scope, insntype, ' ', decode_function,
+               '_load(DisasContext *ctx)\n{\n',
+               '    ', insntype, ' insn = 0;\n\n')
+        stree.output_code(4, 0, 0, 0)
+        output('}\n')
+
     if output_file:
         output_fd.close()
 # end main
-- 
2.17.1


