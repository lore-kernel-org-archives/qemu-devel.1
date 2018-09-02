Received: from [2001:4830:134:3::10] (port=53301 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwRfM-00020c-CB
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwRf2-0006Tu-Fr
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:39:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fwRe1-0006CT-MI
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 08:39:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 540244021705
	for <qemu-devel@nongnu.org>; Sun,  2 Sep 2018 12:36:23 +0000 (UTC)
From: Yoni Bettan <ybettan@redhat.com>
Date: Sun,  2 Sep 2018 15:36:06 +0300
Message-Id: <20180902123608.124586-3-ybettan@redhat.com>
In-Reply-To: <20180902123608.124586-1-ybettan@redhat.com>
References: <20180902123608.124586-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] CODING_STYLE.md : Reformatted to fit the
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, Yoni Bettan <ybettan@redhat.com>

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 CODING_STYLE => CODING_STYLE.md | 151 +++++++++++++++++---------------
 1 file changed, 80 insertions(+), 71 deletions(-)
 rename CODING_STYLE => CODING_STYLE.md (50%)

diff --git a/CODING_STYLE b/CODING_STYLE.md
similarity index 50%
rename from CODING_STYLE
rename to CODING_STYLE.md
index ec075dedc4..5b1523ba63 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE.md
@@ -1,10 +1,9 @@
-QEMU Coding Style
-=================
+# QEMU Coding Style
 
 Please use the script checkpatch.pl in the scripts directory to check
 patches before submitting.
 
-1. Whitespace
+## Whitespace
 
 Of course, the most important aspect in any coding style is whitespace.
 Crusty old coders who have trouble spotting the glasses on their noses
@@ -16,20 +15,20 @@ QEMU indents are four spaces.  Tabs are never used, except in Makefiles
 where they have been irreversibly coded into the syntax.
 Spaces of course are superior to tabs because:
 
- - You have just one way to specify whitespace, not two.  Ambiguity breeds
+* You have just one way to specify whitespace, not two.  Ambiguity breeds
    mistakes.
- - The confusion surrounding 'use tabs to indent, spaces to justify' is gone.
- - Tab indents push your code to the right, making your screen seriously
+* The confusion surrounding 'use tabs to indent, spaces to justify' is gone.
+* Tab indents push your code to the right, making your screen seriously
    unbalanced.
- - Tabs will be rendered incorrectly on editors who are misconfigured not
+* Tabs will be rendered incorrectly on editors who are misconfigured not
    to use tab stops of eight positions.
- - Tabs are rendered badly in patches, causing off-by-one errors in almost
+* Tabs are rendered badly in patches, causing off-by-one errors in almost
    every line.
- - It is the QEMU coding style.
+* It is the QEMU coding style.
 
 Do not leave whitespace dangling off the ends of lines.
 
-2. Line width
+## Line width
 
 Lines should be 80 characters; try not to make them longer.
 
@@ -38,28 +37,28 @@ that use long function or symbol names.  Even in that case, do not make
 lines much longer than 80 characters.
 
 Rationale:
- - Some people like to tile their 24" screens with a 6x4 matrix of 80x24
-   xterms and use vi in all of them.  The best way to punish them is to
-   let them keep doing it.
- - Code and especially patches is much more readable if limited to a sane
-   line length.  Eighty is traditional.
- - The four-space indentation makes the most common excuse ("But look
-   at all that white space on the left!") moot.
- - It is the QEMU coding style.
+* Some people like to tile their 24" screens with a 6x4 matrix of 80x24
+  xterms and use vi in all of them.  The best way to punish them is to
+  let them keep doing it.
+* Code and especially patches is much more readable if limited to a sane
+  line length.  Eighty is traditional.
+* The four-space indentation makes the most common excuse ("But look
+  at all that white space on the left!") moot.
+* It is the QEMU coding style.
 
-3. Naming
+## Naming
 
-Variables are lower_case_with_underscores; easy to type and read.  Structured
-type names are in CamelCase; harder to type but standing out.  Enum type
-names and function type names should also be in CamelCase.  Scalar type
-names are lower_case_with_underscores_ending_with_a_t, like the POSIX
-uint64_t and family.  Note that this last convention contradicts POSIX
+Variables are `lower_case_with_underscores`; easy to type and read.  Structured
+type names are in `CamelCase`; harder to type but standing out.  Enum type
+names and function type names should also be in `CamelCase`.  Scalar type
+names are `lower_case_with_underscores_ending_with_a_t`, like the POSIX
+`uint64_t` and family.  Note that this last convention contradicts POSIX
 and is therefore likely to be changed.
 
-When wrapping standard library functions, use the prefix qemu_ to alert
+When wrapping standard library functions, use the prefix `qemu_` to alert
 readers that they are seeing a wrapped version; otherwise avoid this prefix.
 
-4. Block structure
+## Block structure
 
 Every indented statement is braced; even if the block contains just one
 statement.  The opening brace is on the line that contains the control
@@ -67,69 +66,79 @@ flow statement that introduces the new block; the closing brace is on the
 same line as the else keyword, or on a line by itself if there is no else
 keyword.  Example:
 
-    if (a == 5) {
-        printf("a was 5.\n");
-    } else if (a == 6) {
-        printf("a was 6.\n");
-    } else {
-        printf("a was something else entirely.\n");
-    }
+```
+if (a == 5) {
+    printf("a was 5.\n");
+} else if (a == 6) {
+    printf("a was 6.\n");
+} else {
+    printf("a was something else entirely.\n");
+}
+```
 
-Note that 'else if' is considered a single statement; otherwise a long if/
-else if/else if/.../else sequence would need an indent for every else
+Note that `else if` is considered a single statement; otherwise a long `if/
+else` `if/else` `if/.../else` sequence would need an indent for every else
 statement.
 
 An exception is the opening brace for a function; for reasons of tradition
 and clarity it comes on a line by itself:
 
-    void a_function(void)
-    {
-        do_something();
-    }
+```
+void a_function(void)
+{
+    do_something();
+}
+```
 
 Rationale: a consistent (except for functions...) bracing style reduces
 ambiguity and avoids needless churn when lines are added or removed.
 Furthermore, it is the QEMU coding style.
 
-5. Declarations
+## Declarations
 
 Mixed declarations (interleaving statements and declarations within
 blocks) are generally not allowed; declarations should be at the beginning
 of blocks.
 
 Every now and then, an exception is made for declarations inside a
-#ifdef or #ifndef block: if the code looks nicer, such declarations can
+`#ifdef` or `#ifndef` block: if the code looks nicer, such declarations can
 be placed at the top of the block even if there are statements above.
-On the other hand, however, it's often best to move that #ifdef/#ifndef
+On the other hand, however, it's often best to move that `#ifdef/#ifndef`
 block to a separate function altogether.
 
-6. Conditional statements
+## Conditional statements
 
 When comparing a variable for (in)equality with a constant, list the
 constant on the right, as in:
 
+```
 if (a == 1) {
     /* Reads like: "If a equals 1" */
     do_something();
 }
+```
 
-Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
-Besides, good compilers already warn users when '==' is mis-typed as '=',
+Rationale: Yoda conditions (as in `if (1 == a)`) are awkward to read.
+Besides, good compilers already warn users when `==` is mis-typed as `=`,
 even when the constant is on the right.
 
-7. Comment style
+## Comment style
 
-We use traditional C-style /* */ comments and avoid // comments.
+We use traditional C-style `/* comment */` and avoid `// comment`.
 
-Rationale: The // form is valid in C99, so this is purely a matter of
+Rationale: The `// comment` form is valid in C99, so this is purely a matter of
 consistency of style. The checkpatch script will warn you about this.
 
 Multiline comment blocks should have a row of stars on the left,
-and the initial /* and terminating */ both on their own lines:
-    /*
-     * like
-     * this
-     */
+and the initial `/*` and terminating `*/` both on their own lines:
+
+```
+/*
+ * like
+ * this
+ */
+```
+     
 This is the same format required by the Linux kernel coding style.
 
 (Some of the existing comments in the codebase use the GNU Coding
@@ -141,37 +150,37 @@ comment anyway.)
 Rationale: Consistency, and ease of visually picking out a multiline
 comment from the surrounding code.
 
-8. trace-events style
+## trace-events style
 
-8.1 0x prefix
+### 0x prefix
 
-In trace-events files, use a '0x' prefix to specify hex numbers, as in:
+In trace-events files, use a `0x` prefix to specify hex numbers, as in:
 
-some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
+`some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64`
 
 An exception is made for groups of numbers that are hexadecimal by
-convention and separated by the symbols '.', '/', ':', or ' ' (such as
+convention and separated by the symbols `.`, `/`, `:`, or ` ` (such as
 PCI bus id):
 
-another_trace(int cssid, int ssid, int dev_num) "bus id: %x.%x.%04x"
+`another_trace(int cssid, int ssid, int dev_num) "bus id: %x.%x.%04x"`
 
-However, you can use '0x' for such groups if you want. Anyway, be sure that
+However, you can use `0x` for such groups if you want. Anyway, be sure that
 it is obvious that numbers are in hex, ex.:
 
-data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %02x %02x"
+`data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %02x %02x"`
 
-Rationale: hex numbers are hard to read in logs when there is no 0x prefix,
+Rationale: hex numbers are hard to read in logs when there is no `0x` prefix,
 especially when (occasionally) the representation doesn't contain any letters
 and especially in one line with other decimal numbers. Number groups are allowed
-to not use '0x' because for some things notations like %x.%x.%x are used not
-only in Qemu. Also dumping raw data bytes with '0x' is less readable.
+to not use `0x` because for some things notations like `%x.%x.%x` are used not
+only in Qemu. Also dumping raw data bytes with `0x` is less readable.
 
-8.2 '#' printf flag
+### '#' printf flag
 
-Do not use printf flag '#', like '%#x'.
+Do not use printf flag `#'`, like `%#x`.
 
-Rationale: there are two ways to add a '0x' prefix to printed number: '0x%...'
-and '%#...'. For consistency the only one way should be used. Arguments for
-'0x%' are:
- - it is more popular
- - '%#' omits the 0x for the value 0 which makes output inconsistent
+Rationale: there are two ways to add a `0x` prefix to printed number: `0x%...`
+and `%#...`. For consistency the only one way should be used. Arguments for
+`0x%` are:
+* it is more popular
+* `%#` omits the `0x` for the value 0 which makes output inconsistent
-- 
2.17.1
