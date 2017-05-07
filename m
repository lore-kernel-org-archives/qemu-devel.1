Received: from eggs.gnu.org ([2001:4830:134:3::10]:56006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUf-0004Jp-Du
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GUc-00035H-F8
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:20:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:21 +0300
Message-Id: <66440e3b1578ebe891fa35a4c8d66722400a3b98.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/23] scripts: Switch to more portable Perl
 shebang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Kamil Rytarowski <n54@gmx.com>

The default NetBSD package manager is pkgsrc and it installs Perl
along other third party programs under custom and configurable prefix.
The default prefix for binary prebuilt packages is /usr/pkg, and the
Perl executable lands in /usr/pkg/bin/perl.

This change switches "/usr/bin/perl" to "/usr/bin/env perl" as it's
the most portable solution that should work for almost everybody.
Perl's executable is detected automatically.

This change switches -w option passed to the executable with more
modern "use warnings;" approach. There is no functional change to the
default behavior.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/checkpatch.pl           | 3 ++-
 scripts/clean-header-guards.pl  | 3 ++-
 scripts/cleanup-trace-events.pl | 2 +-
 scripts/disas-objdump.pl        | 4 +++-
 scripts/get_maintainer.pl       | 3 ++-
 scripts/shaderinclude.pl        | 2 +-
 scripts/switch-timer-api        | 2 +-
 scripts/texi2pod.pl             | 4 +++-
 8 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f084542934..3bb6fc95bd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
 # (c) 2001, Dave Jones. (the file handling bit)
 # (c) 2005, Joel Schopp <jschopp@austin.ibm.com> (the ugly bit)
 # (c) 2007,2008, Andy Whitcroft <apw@uk.ibm.com> (new conditions, test s=
uite)
@@ -6,6 +6,7 @@
 # Licensed under the terms of the GNU GPL License version 2
=20
 use strict;
+use warnings;
=20
 my $P =3D $0;
 $P =3D~ s@.*/@@g;
diff --git a/scripts/clean-header-guards.pl b/scripts/clean-header-guards=
.pl
index 54ab99ae29..5e67f1998c 100755
--- a/scripts/clean-header-guards.pl
+++ b/scripts/clean-header-guards.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
 #
 # Clean up include guards in headers
 #
@@ -28,6 +28,7 @@
 #   "cc -E -DGUARD_H -c -P -", and fed the test program on stdin.
=20
 use strict;
+use warnings;
 use Getopt::Std;
=20
 # Stuff we don't want to clean because we import it into our tree:
diff --git a/scripts/cleanup-trace-events.pl b/scripts/cleanup-trace-even=
ts.pl
index 7e808efb6a..e93abc00da 100755
--- a/scripts/cleanup-trace-events.pl
+++ b/scripts/cleanup-trace-events.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 # Copyright (C) 2013 Red Hat, Inc.
 #
 # Authors:
diff --git a/scripts/disas-objdump.pl b/scripts/disas-objdump.pl
index 8f7e8182a1..bec905f04b 100755
--- a/scripts/disas-objdump.pl
+++ b/scripts/disas-objdump.pl
@@ -1,4 +1,6 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+
+use warnings;
=20
 use File::Temp qw/ tempfile /;
 use Getopt::Long;
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 8261bcb1ad..d7c2311123 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
 # (c) 2007, Joe Perches <joe@perches.com>
 #           created from checkpatch.pl
 #
@@ -11,6 +11,7 @@
 # Licensed under the terms of the GNU GPL License version 2
=20
 use strict;
+use warnings;
=20
 my $P =3D $0;
 my $V =3D '0.26';
diff --git a/scripts/shaderinclude.pl b/scripts/shaderinclude.pl
index 81b5146332..cd3bb40b12 100644
--- a/scripts/shaderinclude.pl
+++ b/scripts/shaderinclude.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use strict;
 use warnings;
=20
diff --git a/scripts/switch-timer-api b/scripts/switch-timer-api
index b0e230b9f1..41736d11dd 100755
--- a/scripts/switch-timer-api
+++ b/scripts/switch-timer-api
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
index 6e8fec41a1..39ce584a32 100755
--- a/scripts/texi2pod.pl
+++ b/scripts/texi2pod.pl
@@ -1,4 +1,4 @@
-#! /usr/bin/perl -w
+#! /usr/bin/env perl
=20
 #   Copyright (C) 1999, 2000, 2001, 2003 Free Software Foundation, Inc.
=20
@@ -22,6 +22,8 @@
 # markup to Perl POD format.  It's intended to be used to extract
 # something suitable for a manpage from a Texinfo document.
=20
+use warnings;
+
 $output =3D 0;
 $skipping =3D 0;
 %sects =3D ();
--=20
2.11.0
