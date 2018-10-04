Received: from eggs.gnu.org ([2001:4830:134:3::10]:46303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LK-0005d0-VL
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LH-0002Xn-LY
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:13 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:47 -0400
Message-Id: <20181004161852.11673-6-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] docs/devel/testing.rst: add missing
 newlines after code block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

The line immediate following a ".. code::" block is considered
to contains arguments to the "code directive".  The lack of a
new line gives me during at parse time:

   testing.rst:63: (ERROR/3) Error in "code" directive:
   maximum 1 argument(s) allowed, 3 supplied.

   .. code::
     make check-unit V=1

   testing.rst:120: (ERROR/3) Error in "code" directive:
   maximum 1 argument(s) allowed, 3 supplied.

   .. code::
     make check-qtest V=1

Let's add the missing newlines, both for consistency and to
avoid the parsing errors.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 727c4019b5..9355ad49f2 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -61,6 +61,7 @@ variable (which affects memory reclamation and catches invalid pointers better)
 and gtester options. If necessary, you can run
 
 .. code::
+
   make check-unit V=1
 
 and copy the actual command line which executes the unit test, then run
@@ -118,6 +119,7 @@ and using gdb on the test is still simple to do: find out the actual command
 from the output of
 
 .. code::
+
   make check-qtest V=1
 
 which you can run manually.
-- 
2.17.1
