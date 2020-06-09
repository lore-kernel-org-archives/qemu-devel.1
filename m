Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B50C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F0D20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZ6SXRTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F0D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihEh-0006oH-4K
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3u-0000Gc-Rh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:18 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:40751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3r-0000U9-7d
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id e18so487002pgn.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vTBtqxUpy9WkyuXZwOdXZa6I5esZFyA9WphOj0ye99o=;
 b=eZ6SXRTV115YwAmdENSYcxs7DpEutxCjzyqjTznnWFKZEP7jM3vxI3FC6QbGZMB9yG
 liQziy+ahbb+PzYlHvdowVC37QR3Mp5lhlp0fEuEaWQhirRF69O+WBhHvpvymU49kcCc
 On9FGfmCyvfmMiZTmJiTRo77yXFBw7SoQFv4fluez8NN/8IuGH6wamjBrxqXGLs4tHQG
 3qctfdgKUVHJJXK6Y+TA0K0HkNjF8orNDvgMVHCeNDVeck//WZUxRnQ478hY5k/phxwy
 Pa8bBXK34xP0GsIfzKX6xu/Tx0H2NzO6dZYaMP8kT9QTVEH9R3ZJBfQs1yAIpaEfG9LB
 vhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vTBtqxUpy9WkyuXZwOdXZa6I5esZFyA9WphOj0ye99o=;
 b=s6dX8zqMr9xgIoGB77GAFNrLtuMYVG8HQXIiRJA5LiF+Ei5ywVCuQ/UBDSYi04CyhV
 IfVOogJZxjYF/XH6ojt4HVfbutmUTlq8+ShN6X0LSo/aYppWcYiP6e6JOp7+2wYMElPW
 UZZXJ6DDtxXPfc3XOtngmYbUdl45RvBxOe70+GHmTxLR126WbccvGuG1zdlOGcXQXRfB
 +4D80FVE7Vxp6LH3ycTgx+QXjgU1530Rhi1f6Ywfkr5+6Ix6OEtiC3xabpfKJcn/MD5F
 2Rrag20xkHT9DNCke/1gPIqnAsSdhjSGUMvIHKEAW+LscnL/z/tVYoGE2IYr4QAMTUj4
 R9Ew==
X-Gm-Message-State: AOAM533qdgRKSeTGkH8iPlHKLLQ+LZB3J7a6X0cKNicrnF6KFujOhEun
 +jIb28LrNZ1erALegcY+0Jt2JAuWWFI=
X-Google-Smtp-Source: ABdhPJxo3P9xRNVegSQH3UX3G0XDnuHXizpGJyo8psJBwE6u6qLeyat9s0P5a8YG7EQqu55Zv1qiWw==
X-Received: by 2002:a62:7c49:: with SMTP id x70mr20933899pfc.66.1591719912911; 
 Tue, 09 Jun 2020 09:25:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] decodetree: Move semantic propagation into classes
Date: Tue,  9 Jun 2020 09:25:00 -0700
Message-Id: <20200609162504.780080-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
References: <20200609162504.780080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create ExcMultiPattern to hold an set of non-overlapping patterns.
The body of build_tree, prop_format become member functions on this
class.  Add minimal member functions to Pattern and MultiPattern
to allow recusion through the tree.

Move the bulk of build_incmulti_pattern to prop_masks and prop_width
in MultiPattern, since we will need this for both kinds of containers.
Only perform prop_width for variablewidth.

Remove global patterns variable, and pass down container object into
parse_file from main.

No functional change in all of this.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 464 +++++++++++++++++++++++-------------------
 1 file changed, 253 insertions(+), 211 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 3307c74c30..0ba01e049c 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -31,7 +31,6 @@ variablewidth = False
 fields = {}
 arguments = {}
 formats = {}
-patterns = []
 allpatterns = []
 anyextern = False
 
@@ -371,16 +370,27 @@ class Pattern(General):
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
         output(ind, 'if (', translate_prefix, '_', self.name,
                '(ctx, &u.f_', arg, ')) return true;\n')
+
+    # Normal patterns do not have children.
+    def build_tree(self):
+        return
+    def prop_masks(self):
+        return
+    def prop_format(self):
+        return
+    def prop_width(self):
+        return
+
 # end Pattern
 
 
 class MultiPattern(General):
     """Class representing a set of instruction patterns"""
 
-    def __init__(self, lineno, pats):
+    def __init__(self, lineno):
         self.file = input_file
         self.lineno = lineno
-        self.pats = pats
+        self.pats = []
         self.base = None
         self.fixedbits = 0
         self.fixedmask = 0
@@ -396,22 +406,63 @@ class MultiPattern(General):
     def output_decl(self):
         for p in self.pats:
             p.output_decl()
+
+    def prop_masks(self):
+        global insnmask
+
+        fixedmask = insnmask
+        undefmask = insnmask
+
+        # Collect fixedmask/undefmask for all of the children.
+        for p in self.pats:
+            p.prop_masks()
+            fixedmask &= p.fixedmask
+            undefmask &= p.undefmask
+
+        # Widen fixedmask until all fixedbits match
+        repeat = True
+        fixedbits = 0
+        while repeat and fixedmask != 0:
+            fixedbits = None
+            for p in self.pats:
+                thisbits = p.fixedbits & fixedmask
+                if fixedbits is None:
+                    fixedbits = thisbits
+                elif fixedbits != thisbits:
+                    fixedmask &= ~(fixedbits ^ thisbits)
+                    break
+            else:
+                repeat = False
+
+        self.fixedbits = fixedbits
+        self.fixedmask = fixedmask
+        self.undefmask = undefmask
+
+    def build_tree(self):
+        for p in self.pats:
+            p.build_tree()
+
+    def prop_format(self):
+        for p in self.pats:
+            p.build_tree()
+
+    def prop_width(self):
+        width = None
+        for p in self.pats:
+            p.prop_width()
+            if width is None:
+                width = p.width
+            elif width != p.width:
+                error_with_file(self.file, self.lineno,
+                                'width mismatch in patterns within braces')
+        self.width = width
+
 # end MultiPattern
 
 
 class IncMultiPattern(MultiPattern):
     """Class representing an overlapping set of instruction patterns"""
 
-    def __init__(self, lineno, pats, fixb, fixm, udfm, w):
-        self.file = input_file
-        self.lineno = lineno
-        self.pats = pats
-        self.base = None
-        self.fixedbits = fixb
-        self.fixedmask = fixm
-        self.undefmask = udfm
-        self.width = w
-
     def output_code(self, i, extracted, outerbits, outermask):
         global translate_prefix
         ind = str_indent(i)
@@ -431,6 +482,153 @@ class IncMultiPattern(MultiPattern):
 #end IncMultiPattern
 
 
+class Tree:
+    """Class representing a node in a decode tree"""
+
+    def __init__(self, fm, tm):
+        self.fixedmask = fm
+        self.thismask = tm
+        self.subs = []
+        self.base = None
+
+    def str1(self, i):
+        ind = str_indent(i)
+        r = '{0}{1:08x}'.format(ind, self.fixedmask)
+        if self.format:
+            r += ' ' + self.format.name
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
+        # If we identified all nodes below have the same format,
+        # extract the fields now.
+        if not extracted and self.base:
+            output(ind, self.base.extract_name(),
+                   '(ctx, &u.f_', self.base.base.name, ', insn);\n')
+            extracted = True
+
+        # Attempt to aid the compiler in producing compact switch statements.
+        # If the bits in the mask are contiguous, extract them.
+        sh = is_contiguous(self.thismask)
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
+        output(ind, 'switch (', str_switch(self.thismask), ') {\n')
+        for b, s in sorted(self.subs):
+            assert (self.thismask & ~s.fixedmask) == 0
+            innermask = outermask | self.thismask
+            innerbits = outerbits | b
+            output(ind, 'case ', str_case(b), ':\n')
+            output(ind, '    /* ',
+                   str_match_bits(innerbits, innermask), ' */\n')
+            s.output_code(i + 4, extracted, innerbits, innermask)
+            output(ind, '    return false;\n')
+        output(ind, '}\n')
+# end Tree
+
+
+class ExcMultiPattern(MultiPattern):
+    """Class representing a non-overlapping set of instruction patterns"""
+
+    def output_code(self, i, extracted, outerbits, outermask):
+        # Defer everything to our decomposed Tree node
+        self.tree.output_code(i, extracted, outerbits, outermask)
+
+    @staticmethod
+    def __build_tree(pats, outerbits, outermask):
+        # Find the intersection of all remaining fixedmask.
+        innermask = ~outermask & insnmask
+        for i in pats:
+            innermask &= i.fixedmask
+
+        if innermask == 0:
+            # Edge condition: One pattern covers the entire insnmask
+            if len(pats) == 1:
+                t = Tree(outermask, innermask)
+                t.subs.append((0, pats[0]))
+                return t
+
+            text = 'overlapping patterns:'
+            for p in pats:
+                text += '\n' + p.file + ':' + str(p.lineno) + ': ' + str(p)
+            error_with_file(pats[0].file, pats[0].lineno, text)
+
+        fullmask = outermask | innermask
+
+        # Sort each element of pats into the bin selected by the mask.
+        bins = {}
+        for i in pats:
+            fb = i.fixedbits & innermask
+            if fb in bins:
+                bins[fb].append(i)
+            else:
+                bins[fb] = [i]
+
+        # We must recurse if any bin has more than one element or if
+        # the single element in the bin has not been fully matched.
+        t = Tree(fullmask, innermask)
+
+        for b, l in bins.items():
+            s = l[0]
+            if len(l) > 1 or s.fixedmask & ~fullmask != 0:
+                s = ExcMultiPattern.__build_tree(l, b | outerbits, fullmask)
+            t.subs.append((b, s))
+
+        return t
+
+    def build_tree(self):
+        super().prop_format()
+        self.tree = self.__build_tree(self.pats, self.fixedbits,
+                                      self.fixedmask)
+
+    @staticmethod
+    def __prop_format(tree):
+        """Propagate Format objects into the decode tree"""
+
+        # Depth first search.
+        for (b, s) in tree.subs:
+            if isinstance(s, Tree):
+                ExcMultiPattern.__prop_format(s)
+
+        # If all entries in SUBS have the same format, then
+        # propagate that into the tree.
+        f = None
+        for (b, s) in tree.subs:
+            if f is None:
+                f = s.base
+                if f is None:
+                    return
+            if f is not s.base:
+                return
+        tree.base = f
+
+    def prop_format(self):
+        super().prop_format()
+        self.__prop_format(self.tree)
+
+# end ExcMultiPattern
+
+
 def parse_field(lineno, name, toks):
     """Parse one instruction field from TOKS at LINENO"""
     global fields
@@ -587,18 +785,19 @@ def infer_format(arg, fieldmask, flds, width):
 # end infer_format
 
 
-def parse_generic(lineno, is_format, name, toks):
+def parse_generic(lineno, parent_pat, name, toks):
     """Parse one instruction format from TOKS at LINENO"""
     global fields
     global arguments
     global formats
-    global patterns
     global allpatterns
     global re_ident
     global insnwidth
     global insnmask
     global variablewidth
 
+    is_format = parent_pat is None
+
     fixedmask = 0
     fixedbits = 0
     undefmask = 0
@@ -749,7 +948,7 @@ def parse_generic(lineno, is_format, name, toks):
                 error(lineno, 'field {0} not initialized'.format(f))
         pat = Pattern(name, lineno, fmt, fixedbits, fixedmask,
                       undefmask, fieldmask, flds, width)
-        patterns.append(pat)
+        parent_pat.pats.append(pat)
         allpatterns.append(pat)
 
     # Validate the masks that we have assembled.
@@ -769,61 +968,16 @@ def parse_generic(lineno, is_format, name, toks):
                           .format(allbits ^ insnmask))
 # end parse_general
 
-def build_incmulti_pattern(lineno, pats):
-    """Validate the Patterns going into a IncMultiPattern."""
-    global patterns
-    global insnmask
 
-    if len(pats) < 2:
-        error(lineno, 'less than two patterns within braces')
-
-    fixedmask = insnmask
-    undefmask = insnmask
-
-    # Collect fixed/undefmask for all of the children.
-    # Move the defining lineno back to that of the first child.
-    for p in pats:
-        fixedmask &= p.fixedmask
-        undefmask &= p.undefmask
-        if p.lineno < lineno:
-            lineno = p.lineno
-
-    width = None
-    for p in pats:
-        if width is None:
-            width = p.width
-        elif width != p.width:
-            error(lineno, 'width mismatch in patterns within braces')
-
-    repeat = True
-    fixedbits = 0
-    while repeat and fixedmask != 0:
-        fixedbits = None
-        for p in pats:
-            thisbits = p.fixedbits & fixedmask
-            if fixedbits is None:
-                fixedbits = thisbits
-            elif fixedbits != thisbits:
-                fixedmask &= ~(fixedbits ^ thisbits)
-                break
-        else:
-            repeat = False
-
-    mp = IncMultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
-    patterns.append(mp)
-# end build_incmulti_pattern
-
-def parse_file(f):
+def parse_file(f, parent_pat):
     """Parse all of the patterns within a file"""
 
-    global patterns
-
     # Read all of the lines of the file.  Concatenate lines
     # ending in backslash; discard empty lines and comments.
     toks = []
     lineno = 0
     nesting = 0
-    saved_pats = []
+    nesting_pats = []
 
     for line in f:
         lineno += 1
@@ -868,16 +1022,20 @@ def parse_file(f):
 
         # End nesting?
         if name == '}':
-            if nesting == 0:
-                error(start_lineno, 'mismatched close brace')
             if len(toks) != 0:
                 error(start_lineno, 'extra tokens after close brace')
+            if len(parent_pat.pats) < 2:
+                error(lineno, 'less than two patterns within braces')
+
+            try:
+                parent_pat = nesting_pats.pop()
+            except:
+                error(lineno, 'mismatched close brace')
+
             nesting -= 2
             if indent != nesting:
-                error(start_lineno, 'indentation ', indent, ' != ', nesting)
-            pats = patterns
-            patterns = saved_pats.pop()
-            build_incmulti_pattern(lineno, pats)
+                error(lineno, 'indentation ', indent, ' != ', nesting)
+
             toks = []
             continue
 
@@ -889,8 +1047,12 @@ def parse_file(f):
         if name == '{':
             if len(toks) != 0:
                 error(start_lineno, 'extra tokens after open brace')
-            saved_pats.append(patterns)
-            patterns = []
+
+            nested_pat = IncMultiPattern(start_lineno)
+            parent_pat.pats.append(nested_pat)
+            nesting_pats.append(parent_pat)
+            parent_pat = nested_pat
+
             nesting += 2
             toks = []
             continue
@@ -901,121 +1063,13 @@ def parse_file(f):
         elif name[0] == '&':
             parse_arguments(start_lineno, name[1:], toks)
         elif name[0] == '@':
-            parse_generic(start_lineno, True, name[1:], toks)
+            parse_generic(start_lineno, None, name[1:], toks)
         else:
-            parse_generic(start_lineno, False, name, toks)
+            parse_generic(start_lineno, parent_pat, name, toks)
         toks = []
 # end parse_file
 
 
-class Tree:
-    """Class representing a node in a decode tree"""
-
-    def __init__(self, fm, tm):
-        self.fixedmask = fm
-        self.thismask = tm
-        self.subs = []
-        self.base = None
-
-    def str1(self, i):
-        ind = str_indent(i)
-        r = '{0}{1:08x}'.format(ind, self.fixedmask)
-        if self.format:
-            r += ' ' + self.format.name
-        r += ' [\n'
-        for (b, s) in self.subs:
-            r += '{0}  {1:08x}:\n'.format(ind, b)
-            r += s.str1(i + 4) + '\n'
-        r += ind + ']'
-        return r
-
-    def __str__(self):
-        return self.str1(0)
-
-    def output_code(self, i, extracted, outerbits, outermask):
-        ind = str_indent(i)
-
-        # If we identified all nodes below have the same format,
-        # extract the fields now.
-        if not extracted and self.base:
-            output(ind, self.base.extract_name(),
-                   '(ctx, &u.f_', self.base.base.name, ', insn);\n')
-            extracted = True
-
-        # Attempt to aid the compiler in producing compact switch statements.
-        # If the bits in the mask are contiguous, extract them.
-        sh = is_contiguous(self.thismask)
-        if sh > 0:
-            # Propagate SH down into the local functions.
-            def str_switch(b, sh=sh):
-                return '(insn >> {0}) & 0x{1:x}'.format(sh, b >> sh)
-
-            def str_case(b, sh=sh):
-                return '0x{0:x}'.format(b >> sh)
-        else:
-            def str_switch(b):
-                return 'insn & 0x{0:08x}'.format(b)
-
-            def str_case(b):
-                return '0x{0:08x}'.format(b)
-
-        output(ind, 'switch (', str_switch(self.thismask), ') {\n')
-        for b, s in sorted(self.subs):
-            assert (self.thismask & ~s.fixedmask) == 0
-            innermask = outermask | self.thismask
-            innerbits = outerbits | b
-            output(ind, 'case ', str_case(b), ':\n')
-            output(ind, '    /* ',
-                   str_match_bits(innerbits, innermask), ' */\n')
-            s.output_code(i + 4, extracted, innerbits, innermask)
-            output(ind, '    return false;\n')
-        output(ind, '}\n')
-# end Tree
-
-
-def build_tree(pats, outerbits, outermask):
-    # Find the intersection of all remaining fixedmask.
-    innermask = ~outermask & insnmask
-    for i in pats:
-        innermask &= i.fixedmask
-
-    if innermask == 0:
-        # Edge condition: One pattern covers the entire insnmask
-        if len(pats) == 1:
-            t = Tree(outermask, innermask)
-            t.subs.append((0, pats[0]))
-            return t
-
-        text = 'overlapping patterns:'
-        for p in pats:
-            text += '\n' + p.file + ':' + str(p.lineno) + ': ' + str(p)
-        error_with_file(pats[0].file, pats[0].lineno, text)
-
-    fullmask = outermask | innermask
-
-    # Sort each element of pats into the bin selected by the mask.
-    bins = {}
-    for i in pats:
-        fb = i.fixedbits & innermask
-        if fb in bins:
-            bins[fb].append(i)
-        else:
-            bins[fb] = [i]
-
-    # We must recurse if any bin has more than one element or if
-    # the single element in the bin has not been fully matched.
-    t = Tree(fullmask, innermask)
-
-    for b, l in bins.items():
-        s = l[0]
-        if len(l) > 1 or s.fixedmask & ~fullmask != 0:
-            s = build_tree(l, b | outerbits, fullmask)
-        t.subs.append((b, s))
-
-    return t
-# end build_tree
-
-
 class SizeTree:
     """Class representing a node in a size decode tree"""
 
@@ -1157,28 +1211,6 @@ def build_size_tree(pats, width, outerbits, outermask):
 # end build_size_tree
 
 
-def prop_format(tree):
-    """Propagate Format objects into the decode tree"""
-
-    # Depth first search.
-    for (b, s) in tree.subs:
-        if isinstance(s, Tree):
-            prop_format(s)
-
-    # If all entries in SUBS have the same format, then
-    # propagate that into the tree.
-    f = None
-    for (b, s) in tree.subs:
-        if f is None:
-            f = s.base
-            if f is None:
-                return
-        if f is not s.base:
-            return
-    tree.base = f
-# end prop_format
-
-
 def prop_size(tree):
     """Propagate minimum widths up the decode size tree"""
 
@@ -1199,7 +1231,6 @@ def prop_size(tree):
 def main():
     global arguments
     global formats
-    global patterns
     global allpatterns
     global translate_scope
     global translate_prefix
@@ -1246,18 +1277,29 @@ def main():
 
     if len(args) < 1:
         error(0, 'missing input file')
+
+    toppat = ExcMultiPattern(0)
+
     for filename in args:
         input_file = filename
         f = open(filename, 'r')
-        parse_file(f)
+        parse_file(f, toppat)
         f.close()
 
-    if variablewidth:
-        stree = build_size_tree(patterns, 8, 0, 0)
-        prop_size(stree)
+    # We do not want to compute masks for toppat, because those masks
+    # are used as a starting point for build_tree.  For toppat, we must
+    # insist that decode begins from naught.
+    for i in toppat.pats:
+        i.prop_masks()
 
-    dtree = build_tree(patterns, 0, 0)
-    prop_format(dtree)
+    toppat.build_tree()
+    toppat.prop_format()
+
+    if variablewidth:
+        for i in toppat.pats:
+            i.prop_width()
+        stree = build_size_tree(toppat.pats, 8, 0, 0)
+        prop_size(stree)
 
     if output_file:
         output_fd = open(output_file, 'w')
@@ -1316,7 +1358,7 @@ def main():
             f = arguments[n]
             output(i4, i4, f.struct_name(), ' f_', f.name, ';\n')
         output(i4, '} u;\n\n')
-        dtree.output_code(4, False, 0, 0)
+        toppat.output_code(4, False, 0, 0)
 
     output(i4, 'return false;\n')
     output('}\n')
-- 
2.25.1


