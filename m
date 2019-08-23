Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD49BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6343921848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6343921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Ci7-0003yg-Jr
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i1CbF-0006Zq-Ib
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i1CbC-0002so-JO
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i1CbC-0002r1-Bf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C02A30A7BAE;
 Fri, 23 Aug 2019 16:39:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-60.ams2.redhat.com
 [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 894E0BA90;
 Fri, 23 Aug 2019 16:39:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 17:39:28 +0100
Message-Id: <20190823163931.7442-2-berrange@redhat.com>
In-Reply-To: <20190823163931.7442-1-berrange@redhat.com>
References: <20190823163931.7442-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 23 Aug 2019 16:39:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] docs: convert CODING_STYLE and HACKING to
 markdown syntax
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 CODING_STYLE =3D> CODING_STYLE.md | 37 +++++++++---------
 HACKING =3D> HACKING.md           | 68 ++++++++++++++++++---------------
 README                          |  2 +-
 3 files changed, 58 insertions(+), 49 deletions(-)
 rename CODING_STYLE =3D> CODING_STYLE.md (92%)
 rename HACKING =3D> HACKING.md (88%)

diff --git a/CODING_STYLE b/CODING_STYLE.md
similarity index 92%
rename from CODING_STYLE
rename to CODING_STYLE.md
index cb8edcbb36..056eda7739 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE.md
@@ -4,7 +4,7 @@ QEMU Coding Style
 Please use the script checkpatch.pl in the scripts directory to check
 patches before submitting.
=20
-1. Whitespace
+## Whitespace
=20
 Of course, the most important aspect in any coding style is whitespace.
 Crusty old coders who have trouble spotting the glasses on their noses
@@ -29,7 +29,7 @@ Spaces of course are superior to tabs because:
=20
 Do not leave whitespace dangling off the ends of lines.
=20
-1.1 Multiline Indent
+### Multiline Indent
=20
 There are several places where indent is necessary:
=20
@@ -53,9 +53,8 @@ For example:
=20
 In case of function, there are several variants:
=20
-    * 4 spaces indent from the beginning
-    * align the secondary lines just after the opening parenthesis of th=
e
-      first
+ * 4 spaces indent from the beginning
+ * align the secondary lines just after the opening parenthesis of the f=
irst
=20
 For example:
=20
@@ -68,7 +67,7 @@ For example:
     do_something(x, do_another(y,
                                z));
=20
-2. Line width
+## Line width
=20
 Lines should be 80 characters; try not to make them longer.
=20
@@ -77,6 +76,7 @@ that use long function or symbol names.  Even in that c=
ase, do not make
 lines much longer than 80 characters.
=20
 Rationale:
+
  - Some people like to tile their 24" screens with a 6x4 matrix of 80x24
    xterms and use vi in all of them.  The best way to punish them is to
    let them keep doing it.
@@ -86,7 +86,7 @@ Rationale:
    at all that white space on the left!") moot.
  - It is the QEMU coding style.
=20
-3. Naming
+## Naming
=20
 Variables are lower_case_with_underscores; easy to type and read.  Struc=
tured
 type names are in CamelCase; harder to type but standing out.  Enum type
@@ -98,7 +98,7 @@ and is therefore likely to be changed.
 When wrapping standard library functions, use the prefix qemu_ to alert
 readers that they are seeing a wrapped version; otherwise avoid this pre=
fix.
=20
-4. Block structure
+## Block structure
=20
 Every indented statement is braced; even if the block contains just one
 statement.  The opening brace is on the line that contains the control
@@ -130,7 +130,7 @@ Rationale: a consistent (except for functions...) bra=
cing style reduces
 ambiguity and avoids needless churn when lines are added or removed.
 Furthermore, it is the QEMU coding style.
=20
-5. Declarations
+## Declarations
=20
 Mixed declarations (interleaving statements and declarations within
 blocks) are generally not allowed; declarations should be at the beginni=
ng
@@ -142,7 +142,7 @@ be placed at the top of the block even if there are s=
tatements above.
 On the other hand, however, it's often best to move that #ifdef/#ifndef
 block to a separate function altogether.
=20
-6. Conditional statements
+## Conditional statements
=20
 When comparing a variable for (in)equality with a constant, list the
 constant on the right, as in:
@@ -156,7 +156,7 @@ Rationale: Yoda conditions (as in 'if (1 =3D=3D a)') =
are awkward to read.
 Besides, good compilers already warn users when '=3D=3D' is mis-typed as=
 '=3D',
 even when the constant is on the right.
=20
-7. Comment style
+## Comment style
=20
 We use traditional C-style /* */ comments and avoid // comments.
=20
@@ -165,10 +165,12 @@ consistency of style. The checkpatch script will wa=
rn you about this.
=20
 Multiline comment blocks should have a row of stars on the left,
 and the initial /* and terminating */ both on their own lines:
+
     /*
      * like
      * this
      */
+
 This is the same format required by the Linux kernel coding style.
=20
 (Some of the existing comments in the codebase use the GNU Coding
@@ -180,24 +182,24 @@ comment anyway.)
 Rationale: Consistency, and ease of visually picking out a multiline
 comment from the surrounding code.
=20
-8. trace-events style
+## trace-events style
=20
-8.1 0x prefix
+### 0x prefix
=20
 In trace-events files, use a '0x' prefix to specify hex numbers, as in:
=20
-some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
+    some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
=20
 An exception is made for groups of numbers that are hexadecimal by
 convention and separated by the symbols '.', '/', ':', or ' ' (such as
 PCI bus id):
=20
-another_trace(int cssid, int ssid, int dev_num) "bus id: %x.%x.%04x"
+    another_trace(int cssid, int ssid, int dev_num) "bus id: %x.%x.%04x"
=20
 However, you can use '0x' for such groups if you want. Anyway, be sure t=
hat
 it is obvious that numbers are in hex, ex.:
=20
-data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %02x=
 %02x"
+    data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x =
%02x %02x"
=20
 Rationale: hex numbers are hard to read in logs when there is no 0x pref=
ix,
 especially when (occasionally) the representation doesn't contain any le=
tters
@@ -205,12 +207,13 @@ and especially in one line with other decimal numbe=
rs. Number groups are allowed
 to not use '0x' because for some things notations like %x.%x.%x are used=
 not
 only in Qemu. Also dumping raw data bytes with '0x' is less readable.
=20
-8.2 '#' printf flag
+### '#' printf flag
=20
 Do not use printf flag '#', like '%#x'.
=20
 Rationale: there are two ways to add a '0x' prefix to printed number: '0=
x%...'
 and '%#...'. For consistency the only one way should be used. Arguments =
for
 '0x%' are:
+
  - it is more popular
  - '%#' omits the 0x for the value 0 which makes output inconsistent
diff --git a/HACKING b/HACKING.md
similarity index 88%
rename from HACKING
rename to HACKING.md
index 097d482603..f2f85be40f 100644
--- a/HACKING
+++ b/HACKING.md
@@ -1,19 +1,22 @@
-1. Preprocessor
+QEMU Hacking
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-1.1. Variadic macros
+## Preprocessor
+
+### Variadic macros
=20
 For variadic macros, stick with this C99-like syntax:
=20
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("IRQ: " fmt, ## __VA_ARGS__); } while (0)
+    #define DPRINTF(fmt, ...)                                       \
+        do { printf("IRQ: " fmt, ## __VA_ARGS__); } while (0)
=20
-1.2. Include directives
+### Include directives
=20
 Order include directives as follows:
=20
-#include "qemu/osdep.h"  /* Always first... */
-#include <...>           /* then system headers... */
-#include "..."           /* and finally QEMU headers. */
+    #include "qemu/osdep.h"  /* Always first... */
+    #include <...>           /* then system headers... */
+    #include "..."           /* and finally QEMU headers. */
=20
 The "qemu/osdep.h" header contains preprocessor macros that affect the b=
ehavior
 of core system headers like <stdint.h>.  It must be the first include so=
 that
@@ -23,12 +26,12 @@ that QEMU depends on.
 Do not include "qemu/osdep.h" from header files since the .c file will h=
ave
 already included it.
=20
-2. C types
+## C types
=20
 It should be common sense to use the right type, but we have collected
 a few useful guidelines here.
=20
-2.1. Scalars
+### Scalars
=20
 If you're using "int" or "long", odds are good that there's a better typ=
e.
 If a variable is counting something, it should be declared with an
@@ -89,7 +92,7 @@ Finally, while using descriptive types is important, be=
 careful not to
 go overboard.  If whatever you're doing causes warnings, or requires
 casts, then reconsider or ask for help.
=20
-2.2. Pointers
+### Pointers
=20
 Ensure that all of your pointers are "const-correct".
 Unless a pointer is used to modify the pointed-to storage,
@@ -99,7 +102,7 @@ importantly, if we're diligent about this, when you se=
e a non-const
 pointer, you're guaranteed that it is used to modify the storage
 it points to, or it is aliased to another pointer that is.
=20
-2.3. Typedefs
+### Typedefs
=20
 Typedefs are used to eliminate the redundant 'struct' keyword, since typ=
e
 names have a different style than other identifiers ("CamelCase" versus
@@ -114,11 +117,11 @@ definitions instead of typedefs in headers and func=
tion prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
=20
-2.4. Reserved namespaces in C and POSIX
+### Reserved namespaces in C and POSIX
 Underscore capital, double underscore, and underscore 't' suffixes shoul=
d be
 avoided.
=20
-3. Low level memory management
+## Low level memory management
=20
 Use of the malloc/free/realloc/calloc/valloc/memalign/posix_memalign
 APIs is not allowed in the QEMU codebase. Instead of these routines,
@@ -133,16 +136,15 @@ Calling g_malloc with a zero size is valid and will=
 return NULL.
 Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
 reasons:
=20
-  a. It catches multiplication overflowing size_t;
-  b. It returns T * instead of void *, letting compiler catch more type
-     errors.
+ * It catches multiplication overflowing size_t;
+ * It returns T * instead of void *, letting compiler catch more type er=
rors.
=20
 Declarations like T *v =3D g_malloc(sizeof(*v)) are acceptable, though.
=20
 Memory allocated by qemu_memalign or qemu_blockalign must be freed with
 qemu_vfree, since breaking this will cause problems on Win32.
=20
-4. String manipulation
+## String manipulation
=20
 Do not use the strncpy function.  As mentioned in the man page, it does =
*not*
 guarantee a NULL-terminated buffer, which makes it extremely dangerous t=
o use.
@@ -151,15 +153,17 @@ use this similar function when possible, but note i=
ts different signature:
 void pstrcpy(char *dest, int dest_buf_size, const char *src)
=20
 Don't use strcat because it can't check for buffer overflows, but:
-char *pstrcat(char *buf, int buf_size, const char *s)
+
+    char *pstrcat(char *buf, int buf_size, const char *s)
=20
 The same limitation exists with sprintf and vsprintf, so use snprintf an=
d
 vsnprintf.
=20
 QEMU provides other useful string functions:
-int strstart(const char *str, const char *val, const char **ptr)
-int stristart(const char *str, const char *val, const char **ptr)
-int qemu_strnlen(const char *s, int max_len)
+
+    int strstart(const char *str, const char *val, const char **ptr)
+    int stristart(const char *str, const char *val, const char **ptr)
+    int qemu_strnlen(const char *s, int max_len)
=20
 There are also replacement character processing macros for isxyz and tox=
yz,
 so instead of e.g. isalnum you should use qemu_isalnum.
@@ -167,7 +171,7 @@ so instead of e.g. isalnum you should use qemu_isalnu=
m.
 Because of the memory management rules, you must use g_strdup/g_strndup
 instead of plain strdup/strndup.
=20
-5. Printf-style functions
+## Printf-style functions
=20
 Whenever you add a new printf-style function, i.e., one with a format
 string argument and following "..." in its prototype, be sure to use
@@ -177,12 +181,13 @@ This makes it so gcc's -Wformat and -Wformat-securi=
ty options can do
 their jobs and cross-check format strings with the number and types
 of arguments.
=20
-6. C standard, implementation defined and undefined behaviors
+## C standard, implementation defined and undefined behaviors
=20
 C code in QEMU should be written to the C99 language specification. A co=
py
 of the final version of the C99 standard with corrigenda TC1, TC2, and T=
C3
 included, formatted as a draft, can be downloaded from:
- http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf
+
+    http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf
=20
 The C language specification defines regions of undefined behavior and
 implementation defined behavior (to give compiler authors enough leeway =
to
@@ -193,17 +198,18 @@ argument...) However there are a few areas where we=
 allow ourselves to
 assume certain behaviors because in practice all the platforms we care a=
bout
 behave in the same way and writing strictly conformant code would be
 painful. These are:
- * you may assume that integers are 2s complement representation
- * you may assume that right shift of a signed integer duplicates
+
+ - you may assume that integers are 2s complement representation
+ - you may assume that right shift of a signed integer duplicates
    the sign bit (ie it is an arithmetic shift, not a logical shift)
=20
 In addition, QEMU assumes that the compiler does not use the latitude
 given in C99 and C11 to treat aspects of signed '<<' as undefined, as
 documented in the GNU Compiler Collection manual starting at version 4.0=
.
=20
-7. Error handling and reporting
+## Error handling and reporting
=20
-7.1 Reporting errors to the human user
+### Reporting errors to the human user
=20
 Do not use printf(), fprintf() or monitor_printf().  Instead, use
 error_report() or error_vreport() from error-report.h.  This ensures the
@@ -217,7 +223,7 @@ like command line parsing, the current location is tr=
acked
 automatically.  To manipulate it manually, use the loc_*() from
 error-report.h.
=20
-7.2 Propagating errors
+### Propagating errors
=20
 An error can't always be reported to the user right where it's detected,
 but often needs to be propagated up the call chain to a place that can
@@ -242,7 +248,7 @@ Do not report an error to the user when you're also r=
eturning an error
 for somebody else to handle.  Leave the reporting to the place that
 consumes the error returned.
=20
-7.3 Handling errors
+### Handling errors
=20
 Calling exit() is fine when handling configuration errors during
 startup.  It's problematic during normal operation.  In particular,
diff --git a/README b/README
index 441c33eb2f..374b8f1486 100644
--- a/README
+++ b/README
@@ -60,7 +60,7 @@ When submitting patches, one common approach is to use =
'git
 format-patch' and/or 'git send-email' to format & send the mail to the
 qemu-devel@nongnu.org mailing list. All patches submitted must contain
 a 'Signed-off-by' line from the author. Patches should follow the
-guidelines set out in the HACKING and CODING_STYLE files.
+guidelines set out in the HACKING.md and CODING_STYLE.md files.
=20
 Additional information on submitting patches can be found online via
 the QEMU website
--=20
2.21.0


