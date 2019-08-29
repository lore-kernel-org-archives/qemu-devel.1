Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97BDC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D92420828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D92420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Nhw-0006EA-9n
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i3NdI-00011L-C2
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i3NdE-0007t4-Q7
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i3NdE-0007ro-HJ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D00C010F23EA;
 Thu, 29 Aug 2019 16:50:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-60.ams2.redhat.com
 [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820481001B05;
 Thu, 29 Aug 2019 16:50:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 17:50:33 +0100
Message-Id: <20190829165036.9773-2-berrange@redhat.com>
In-Reply-To: <20190829165036.9773-1-berrange@redhat.com>
References: <20190829165036.9773-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 29 Aug 2019 16:50:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/4] docs: convert README,
 CODING_STYLE and HACKING to RST syntax
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 CODING_STYLE =3D> CODING_STYLE.rst | 121 +++++++++++++++++++-----------
 HACKING =3D> HACKING.rst           | 123 +++++++++++++++++++++----------
 README =3D> README.rst             |  47 +++++++-----
 scripts/checkpatch.pl            |   2 +-
 4 files changed, 191 insertions(+), 102 deletions(-)
 rename CODING_STYLE =3D> CODING_STYLE.rst (72%)
 rename HACKING =3D> HACKING.rst (79%)
 rename README =3D> README.rst (84%)

diff --git a/CODING_STYLE b/CODING_STYLE.rst
similarity index 72%
rename from CODING_STYLE
rename to CODING_STYLE.rst
index cb8edcbb36..713357cb80 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE.rst
@@ -1,10 +1,14 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 QEMU Coding Style
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+.. contents:: Table of Contents
+
 Please use the script checkpatch.pl in the scripts directory to check
 patches before submitting.
=20
-1. Whitespace
+Whitespace
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Of course, the most important aspect in any coding style is whitespace.
 Crusty old coders who have trouble spotting the glasses on their noses
@@ -16,26 +20,27 @@ QEMU indents are four spaces.  Tabs are never used, e=
xcept in Makefiles
 where they have been irreversibly coded into the syntax.
 Spaces of course are superior to tabs because:
=20
- - You have just one way to specify whitespace, not two.  Ambiguity bree=
ds
-   mistakes.
- - The confusion surrounding 'use tabs to indent, spaces to justify' is =
gone.
- - Tab indents push your code to the right, making your screen seriously
-   unbalanced.
- - Tabs will be rendered incorrectly on editors who are misconfigured no=
t
-   to use tab stops of eight positions.
- - Tabs are rendered badly in patches, causing off-by-one errors in almo=
st
-   every line.
- - It is the QEMU coding style.
+* You have just one way to specify whitespace, not two.  Ambiguity breed=
s
+  mistakes.
+* The confusion surrounding 'use tabs to indent, spaces to justify' is g=
one.
+* Tab indents push your code to the right, making your screen seriously
+  unbalanced.
+* Tabs will be rendered incorrectly on editors who are misconfigured not
+  to use tab stops of eight positions.
+* Tabs are rendered badly in patches, causing off-by-one errors in almos=
t
+  every line.
+* It is the QEMU coding style.
=20
 Do not leave whitespace dangling off the ends of lines.
=20
-1.1 Multiline Indent
+Multiline Indent
+----------------
=20
 There are several places where indent is necessary:
=20
- - if/else
- - while/for
- - function definition & call
+* if/else
+* while/for
+* function definition & call
=20
 When breaking up a long line to fit within line width, we need a proper =
indent
 for the following lines.
@@ -45,6 +50,8 @@ opening parenthesis of the first.
=20
 For example:
=20
+.. code-block:: c
+
     if (a =3D=3D 1 &&
         b =3D=3D 2) {
=20
@@ -53,12 +60,13 @@ For example:
=20
 In case of function, there are several variants:
=20
-    * 4 spaces indent from the beginning
-    * align the secondary lines just after the opening parenthesis of th=
e
-      first
+* 4 spaces indent from the beginning
+* align the secondary lines just after the opening parenthesis of the fi=
rst
=20
 For example:
=20
+.. code-block:: c
+
     do_something(x, y,
         z);
=20
@@ -68,7 +76,8 @@ For example:
     do_something(x, do_another(y,
                                z));
=20
-2. Line width
+Line width
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Lines should be 80 characters; try not to make them longer.
=20
@@ -77,16 +86,18 @@ that use long function or symbol names.  Even in that=
 case, do not make
 lines much longer than 80 characters.
=20
 Rationale:
- - Some people like to tile their 24" screens with a 6x4 matrix of 80x24
-   xterms and use vi in all of them.  The best way to punish them is to
-   let them keep doing it.
- - Code and especially patches is much more readable if limited to a san=
e
-   line length.  Eighty is traditional.
- - The four-space indentation makes the most common excuse ("But look
-   at all that white space on the left!") moot.
- - It is the QEMU coding style.
=20
-3. Naming
+* Some people like to tile their 24" screens with a 6x4 matrix of 80x24
+  xterms and use vi in all of them.  The best way to punish them is to
+  let them keep doing it.
+* Code and especially patches is much more readable if limited to a sane
+  line length.  Eighty is traditional.
+* The four-space indentation makes the most common excuse ("But look
+  at all that white space on the left!") moot.
+* It is the QEMU coding style.
+
+Naming
+=3D=3D=3D=3D=3D=3D
=20
 Variables are lower_case_with_underscores; easy to type and read.  Struc=
tured
 type names are in CamelCase; harder to type but standing out.  Enum type
@@ -95,10 +106,11 @@ names are lower_case_with_underscores_ending_with_a_=
t, like the POSIX
 uint64_t and family.  Note that this last convention contradicts POSIX
 and is therefore likely to be changed.
=20
-When wrapping standard library functions, use the prefix qemu_ to alert
+When wrapping standard library functions, use the prefix ``qemu_`` to al=
ert
 readers that they are seeing a wrapped version; otherwise avoid this pre=
fix.
=20
-4. Block structure
+Block structure
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Every indented statement is braced; even if the block contains just one
 statement.  The opening brace is on the line that contains the control
@@ -106,6 +118,8 @@ flow statement that introduces the new block; the clo=
sing brace is on the
 same line as the else keyword, or on a line by itself if there is no els=
e
 keyword.  Example:
=20
+.. code-block:: c
+
     if (a =3D=3D 5) {
         printf("a was 5.\n");
     } else if (a =3D=3D 6) {
@@ -121,6 +135,8 @@ statement.
 An exception is the opening brace for a function; for reasons of traditi=
on
 and clarity it comes on a line by itself:
=20
+.. code-block:: c
+
     void a_function(void)
     {
         do_something();
@@ -130,7 +146,8 @@ Rationale: a consistent (except for functions...) bra=
cing style reduces
 ambiguity and avoids needless churn when lines are added or removed.
 Furthermore, it is the QEMU coding style.
=20
-5. Declarations
+Declarations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Mixed declarations (interleaving statements and declarations within
 blocks) are generally not allowed; declarations should be at the beginni=
ng
@@ -142,11 +159,14 @@ be placed at the top of the block even if there are=
 statements above.
 On the other hand, however, it's often best to move that #ifdef/#ifndef
 block to a separate function altogether.
=20
-6. Conditional statements
+Conditional statements
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 When comparing a variable for (in)equality with a constant, list the
 constant on the right, as in:
=20
+.. code-block:: c
+
     if (a =3D=3D 1) {
         /* Reads like: "If a equals 1" */
         do_something();
@@ -156,19 +176,24 @@ Rationale: Yoda conditions (as in 'if (1 =3D=3D a)'=
) are awkward to read.
 Besides, good compilers already warn users when '=3D=3D' is mis-typed as=
 '=3D',
 even when the constant is on the right.
=20
-7. Comment style
+Comment style
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-We use traditional C-style /* */ comments and avoid // comments.
+We use traditional C-style /``*`` ``*``/ comments and avoid // comments.
=20
 Rationale: The // form is valid in C99, so this is purely a matter of
 consistency of style. The checkpatch script will warn you about this.
=20
 Multiline comment blocks should have a row of stars on the left,
-and the initial /* and terminating */ both on their own lines:
+and the initial /``*`` and terminating ``*``/ both on their own lines:
+
+.. code-block:: c
+
     /*
      * like
      * this
      */
+
 This is the same format required by the Linux kernel coding style.
=20
 (Some of the existing comments in the codebase use the GNU Coding
@@ -180,24 +205,32 @@ comment anyway.)
 Rationale: Consistency, and ease of visually picking out a multiline
 comment from the surrounding code.
=20
-8. trace-events style
+trace-events style
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-8.1 0x prefix
+0x prefix
+---------
=20
 In trace-events files, use a '0x' prefix to specify hex numbers, as in:
=20
-some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
+.. code-block::
+
+    some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
=20
 An exception is made for groups of numbers that are hexadecimal by
 convention and separated by the symbols '.', '/', ':', or ' ' (such as
 PCI bus id):
=20
-another_trace(int cssid, int ssid, int dev_num) "bus id: %x.%x.%04x"
+.. code-block::
+
+    another_trace(int cssid, int ssid, int dev_num) "bus id: %x.%x.%04x"
=20
 However, you can use '0x' for such groups if you want. Anyway, be sure t=
hat
 it is obvious that numbers are in hex, ex.:
=20
-data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %02x=
 %02x"
+.. code-block::
+
+    data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x =
%02x %02x"
=20
 Rationale: hex numbers are hard to read in logs when there is no 0x pref=
ix,
 especially when (occasionally) the representation doesn't contain any le=
tters
@@ -205,12 +238,14 @@ and especially in one line with other decimal numbe=
rs. Number groups are allowed
 to not use '0x' because for some things notations like %x.%x.%x are used=
 not
 only in Qemu. Also dumping raw data bytes with '0x' is less readable.
=20
-8.2 '#' printf flag
+'#' printf flag
+---------------
=20
 Do not use printf flag '#', like '%#x'.
=20
 Rationale: there are two ways to add a '0x' prefix to printed number: '0=
x%...'
 and '%#...'. For consistency the only one way should be used. Arguments =
for
 '0x%' are:
- - it is more popular
- - '%#' omits the 0x for the value 0 which makes output inconsistent
+
+* it is more popular
+* '%#' omits the 0x for the value 0 which makes output inconsistent
diff --git a/HACKING b/HACKING.rst
similarity index 79%
rename from HACKING
rename to HACKING.rst
index 097d482603..668fc420c3 100644
--- a/HACKING
+++ b/HACKING.rst
@@ -1,19 +1,32 @@
-1. Preprocessor
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+QEMU Hacking
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-1.1. Variadic macros
+.. contents:: Table of Contents
+
+Preprocessor
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Variadic macros
+---------------
=20
 For variadic macros, stick with this C99-like syntax:
=20
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("IRQ: " fmt, ## __VA_ARGS__); } while (0)
+.. code-block:: c
=20
-1.2. Include directives
+    #define DPRINTF(fmt, ...)                                       \
+        do { printf("IRQ: " fmt, ## __VA_ARGS__); } while (0)
+
+Include directives
+------------------
=20
 Order include directives as follows:
=20
-#include "qemu/osdep.h"  /* Always first... */
-#include <...>           /* then system headers... */
-#include "..."           /* and finally QEMU headers. */
+.. code-block:: c
+
+    #include "qemu/osdep.h"  /* Always first... */
+    #include <...>           /* then system headers... */
+    #include "..."           /* and finally QEMU headers. */
=20
 The "qemu/osdep.h" header contains preprocessor macros that affect the b=
ehavior
 of core system headers like <stdint.h>.  It must be the first include so=
 that
@@ -23,12 +36,14 @@ that QEMU depends on.
 Do not include "qemu/osdep.h" from header files since the .c file will h=
ave
 already included it.
=20
-2. C types
+C types
+=3D=3D=3D=3D=3D=3D=3D
=20
 It should be common sense to use the right type, but we have collected
 a few useful guidelines here.
=20
-2.1. Scalars
+Scalars
+-------
=20
 If you're using "int" or "long", odds are good that there's a better typ=
e.
 If a variable is counting something, it should be declared with an
@@ -68,8 +83,8 @@ it may be 32 or 64 bits depending on which target is be=
ing built. It should
 therefore be used only in target-specific code, and in some
 performance-critical built-per-target core code such as the TLB code.
 There is also a signed version, target_long.
-abi_ulong is for the *-user targets, and represents a type the size of
-'void *' in that target's ABI. (This may not be the same as the size of =
a
+abi_ulong is for the ``*``-user targets, and represents a type the size =
of
+'void ``*``' in that target's ABI. (This may not be the same as the size=
 of a
 full CPU virtual address in the case of target ABIs which use 32 bit poi=
nters
 on 64 bit CPUs, like sparc32plus.) Definitions of structures that must m=
atch
 the target's ABI must use this type for anything that on the target is d=
efined
@@ -89,7 +104,8 @@ Finally, while using descriptive types is important, b=
e careful not to
 go overboard.  If whatever you're doing causes warnings, or requires
 casts, then reconsider or ask for help.
=20
-2.2. Pointers
+Pointers
+--------
=20
 Ensure that all of your pointers are "const-correct".
 Unless a pointer is used to modify the pointed-to storage,
@@ -99,7 +115,8 @@ importantly, if we're diligent about this, when you se=
e a non-const
 pointer, you're guaranteed that it is used to modify the storage
 it points to, or it is aliased to another pointer that is.
=20
-2.3. Typedefs
+Typedefs
+--------
=20
 Typedefs are used to eliminate the redundant 'struct' keyword, since typ=
e
 names have a different style than other identifiers ("CamelCase" versus
@@ -114,11 +131,14 @@ definitions instead of typedefs in headers and func=
tion prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
=20
-2.4. Reserved namespaces in C and POSIX
+Reserved namespaces in C and POSIX
+----------------------------------
+
 Underscore capital, double underscore, and underscore 't' suffixes shoul=
d be
 avoided.
=20
-3. Low level memory management
+Low level memory management
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
 Use of the malloc/free/realloc/calloc/valloc/memalign/posix_memalign
 APIs is not allowed in the QEMU codebase. Instead of these routines,
@@ -130,36 +150,51 @@ Please note that g_malloc will exit on allocation f=
ailure, so there
 is no need to test for failure (as you would have to with malloc).
 Calling g_malloc with a zero size is valid and will return NULL.
=20
-Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
+Prefer g_new(T, n) instead of g_malloc(sizeof(T) ``*`` n) for the follow=
ing
 reasons:
=20
-  a. It catches multiplication overflowing size_t;
-  b. It returns T * instead of void *, letting compiler catch more type
-     errors.
+* It catches multiplication overflowing size_t;
+* It returns T ``*`` instead of void ``*``, letting compiler catch more =
type errors.
+
+Declarations like
+
+.. code-block:: c
+
+    T *v =3D g_malloc(sizeof(*v))
=20
-Declarations like T *v =3D g_malloc(sizeof(*v)) are acceptable, though.
+are acceptable, though.
=20
 Memory allocated by qemu_memalign or qemu_blockalign must be freed with
 qemu_vfree, since breaking this will cause problems on Win32.
=20
-4. String manipulation
+String manipulation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Do not use the strncpy function.  As mentioned in the man page, it does =
*not*
 guarantee a NULL-terminated buffer, which makes it extremely dangerous t=
o use.
 It also zeros trailing destination bytes out to the specified length.  I=
nstead,
 use this similar function when possible, but note its different signatur=
e:
-void pstrcpy(char *dest, int dest_buf_size, const char *src)
+
+.. code-block:: c
+
+    void pstrcpy(char *dest, int dest_buf_size, const char *src)
=20
 Don't use strcat because it can't check for buffer overflows, but:
-char *pstrcat(char *buf, int buf_size, const char *s)
+
+.. code-block:: c
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
+.. code-block:: c
+
+    int strstart(const char *str, const char *val, const char **ptr)
+    int stristart(const char *str, const char *val, const char **ptr)
+    int qemu_strnlen(const char *s, int max_len)
=20
 There are also replacement character processing macros for isxyz and tox=
yz,
 so instead of e.g. isalnum you should use qemu_isalnum.
@@ -167,7 +202,8 @@ so instead of e.g. isalnum you should use qemu_isalnu=
m.
 Because of the memory management rules, you must use g_strdup/g_strndup
 instead of plain strdup/strndup.
=20
-5. Printf-style functions
+Printf-style functions
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Whenever you add a new printf-style function, i.e., one with a format
 string argument and following "..." in its prototype, be sure to use
@@ -177,12 +213,14 @@ This makes it so gcc's -Wformat and -Wformat-securi=
ty options can do
 their jobs and cross-check format strings with the number and types
 of arguments.
=20
-6. C standard, implementation defined and undefined behaviors
+C standard, implementation defined and undefined behaviors
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 C code in QEMU should be written to the C99 language specification. A co=
py
 of the final version of the C99 standard with corrigenda TC1, TC2, and T=
C3
 included, formatted as a draft, can be downloaded from:
- http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf
+
+    `<http://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf>`_
=20
 The C language specification defines regions of undefined behavior and
 implementation defined behavior (to give compiler authors enough leeway =
to
@@ -193,17 +231,20 @@ argument...) However there are a few areas where we=
 allow ourselves to
 assume certain behaviors because in practice all the platforms we care a=
bout
 behave in the same way and writing strictly conformant code would be
 painful. These are:
- * you may assume that integers are 2s complement representation
- * you may assume that right shift of a signed integer duplicates
-   the sign bit (ie it is an arithmetic shift, not a logical shift)
+
+* you may assume that integers are 2s complement representation
+* you may assume that right shift of a signed integer duplicates
+  the sign bit (ie it is an arithmetic shift, not a logical shift)
=20
 In addition, QEMU assumes that the compiler does not use the latitude
 given in C99 and C11 to treat aspects of signed '<<' as undefined, as
 documented in the GNU Compiler Collection manual starting at version 4.0=
.
=20
-7. Error handling and reporting
+Error handling and reporting
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=20
-7.1 Reporting errors to the human user
+Reporting errors to the human user
+----------------------------------
=20
 Do not use printf(), fprintf() or monitor_printf().  Instead, use
 error_report() or error_vreport() from error-report.h.  This ensures the
@@ -214,10 +255,11 @@ Use error_printf() & friends to print additional in=
formation.
=20
 error_report() prints the current location.  In certain common cases
 like command line parsing, the current location is tracked
-automatically.  To manipulate it manually, use the loc_*() from
+automatically.  To manipulate it manually, use the loc_``*``() from
 error-report.h.
=20
-7.2 Propagating errors
+Propagating errors
+------------------
=20
 An error can't always be reported to the user right where it's detected,
 but often needs to be propagated up the call chain to a place that can
@@ -233,16 +275,17 @@ error, non-negative / -errno, non-null / null, or E=
rror objects.
 Example: when a function returns a non-null pointer on success, and it
 can fail only in one way (as far as the caller is concerned), returning
 null on failure is just fine, and certainly simpler and a lot easier on
-the eyes than propagating an Error object through an Error ** parameter.
+the eyes than propagating an Error object through an Error ``*````*`` pa=
rameter.
=20
 Example: when a function's callers need to report details on failure
-only the function really knows, use Error **, and set suitable errors.
+only the function really knows, use Error ``*````*``, and set suitable e=
rrors.
=20
 Do not report an error to the user when you're also returning an error
 for somebody else to handle.  Leave the reporting to the place that
 consumes the error returned.
=20
-7.3 Handling errors
+Handling errors
+---------------
=20
 Calling exit() is fine when handling configuration errors during
 startup.  It's problematic during normal operation.  In particular,
diff --git a/README b/README.rst
similarity index 84%
rename from README
rename to README.rst
index 441c33eb2f..9ff2877416 100644
--- a/README
+++ b/README.rst
@@ -1,5 +1,6 @@
-         QEMU README
-         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+QEMU README
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 QEMU is a generic and open source machine & userspace emulator and
 virtualizer.
@@ -37,6 +38,9 @@ QEMU is multi-platform software intended to be buildabl=
e on all modern
 Linux platforms, OS-X, Win32 (via the Mingw64 toolchain) and a variety
 of other UNIX targets. The simple steps to build QEMU are:
=20
+
+.. code-block:: shell
+
   mkdir build
   cd build
   ../configure
@@ -44,9 +48,9 @@ of other UNIX targets. The simple steps to build QEMU a=
re:
=20
 Additional information can also be found online via the QEMU website:
=20
-  https://qemu.org/Hosts/Linux
-  https://qemu.org/Hosts/Mac
-  https://qemu.org/Hosts/W32
+* `<https://qemu.org/Hosts/Linux>`_
+* `<https://qemu.org/Hosts/Mac>`_
+* `<https://qemu.org/Hosts/W32>`_
=20
=20
 Submitting patches
@@ -54,24 +58,29 @@ Submitting patches
=20
 The QEMU source code is maintained under the GIT version control system.
=20
+.. code-block:: shell
+
    git clone https://git.qemu.org/git/qemu.git
=20
 When submitting patches, one common approach is to use 'git
 format-patch' and/or 'git send-email' to format & send the mail to the
 qemu-devel@nongnu.org mailing list. All patches submitted must contain
 a 'Signed-off-by' line from the author. Patches should follow the
-guidelines set out in the HACKING and CODING_STYLE files.
+guidelines set out in the HACKING.rst and CODING_STYLE.rst files.
=20
 Additional information on submitting patches can be found online via
 the QEMU website
=20
-  https://qemu.org/Contribute/SubmitAPatch
-  https://qemu.org/Contribute/TrivialPatches
+* `<https://qemu.org/Contribute/SubmitAPatch>`_
+* `<https://qemu.org/Contribute/TrivialPatches>`_
=20
 The QEMU website is also maintained under source control.
=20
+.. code-block:: shell
+
   git clone https://git.qemu.org/git/qemu-web.git
-  https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
+
+* `<https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/>`_
=20
 A 'git-publish' utility was created to make above process less
 cumbersome, and is highly recommended for making regular contributions,
@@ -82,10 +91,12 @@ manually for once.
=20
 For installation instructions, please go to
=20
-  https://github.com/stefanha/git-publish
+*  `<https://github.com/stefanha/git-publish>`_
=20
 The workflow with 'git-publish' is:
=20
+.. code-block:: shell
+
   $ git checkout master -b my-feature
   $ # work on new commits, add your 'Signed-off-by' lines to each
   $ git publish
@@ -95,6 +106,8 @@ back to it in the future.
=20
 Sending v2:
=20
+.. code-block:: shell
+
   $ git checkout my-feature # same topic branch
   $ # making changes to the commits (using 'git rebase', for example)
   $ git publish
@@ -109,7 +122,7 @@ The QEMU project uses Launchpad as its primary upstre=
am bug tracker. Bugs
 found when running code built from QEMU git or upstream released sources
 should be reported via:
=20
-  https://bugs.launchpad.net/qemu/
+* `<https://bugs.launchpad.net/qemu/>`_
=20
 If using QEMU via an operating system vendor pre-built binary package, i=
t
 is preferable to report bugs to the vendor's own bug tracker first. If
@@ -118,7 +131,7 @@ reported via launchpad.
=20
 For additional information on bug reporting consult:
=20
-  https://qemu.org/Contribute/ReportABug
+* `<https://qemu.org/Contribute/ReportABug>`_
=20
=20
 Contact
@@ -127,13 +140,11 @@ Contact
 The QEMU community can be contacted in a number of ways, with the two
 main methods being email and IRC
=20
- - qemu-devel@nongnu.org
-   https://lists.nongnu.org/mailman/listinfo/qemu-devel
- - #qemu on irc.oftc.net
+* `<mailto:qemu-devel@nongnu.org>`_
+* `<https://lists.nongnu.org/mailman/listinfo/qemu-devel>`_
+* #qemu on irc.oftc.net
=20
 Information on additional methods of contacting the community can be
 found online via the QEMU website:
=20
-  https://qemu.org/Contribute/StartHere
-
--- End
+* `<https://qemu.org/Contribute/StartHere>`_
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d24c9441ee..aa9a354a0e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -461,7 +461,7 @@ sub top_of_kernel_tree {
=20
 	my @tree_check =3D (
 		"COPYING", "MAINTAINERS", "Makefile",
-		"README", "docs", "VERSION",
+		"README.rst", "docs", "VERSION",
 		"vl.c"
 	);
=20
--=20
2.21.0


