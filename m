Received: from eggs.gnu.org ([2001:4830:134:3::10]:36932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRHae-0004PX-Hk
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRHad-0004qn-H8
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:38:04 -0400
Date: Fri, 8 Jun 2018 10:37:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180608133745.GH7451@localhost.localdomain>
References: <20180608122952.2009-1-ehabkost@redhat.com>
	<20180608122952.2009-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608122952.2009-2-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! python: futurize -f
 libfuturize.fixes.fix_print_with_import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jun 08, 2018 at 09:29:43AM -0300, Eduardo Habkost wrote:
> Change all Python code to use print as a function.
> 
> This is necessary for Python 3 compatibility.
> 
> Done using:
> 
>   $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f libfuturize.fixes.fix_print_with_import $py
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
[...]
>  tests/docker/docker.py                   | 11 +--
[...]

This patch needs an update:

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index a18cfcbe94..306e14cf69 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -400,11 +400,11 @@ class ProbeCommand(SubCommand):
         try:
             docker = Docker()
             if docker._command[0] == "docker":
-                print "yes"
+                print("yes")
             elif docker._command[0] == "sudo":
-                print "sudo"
+                print("sudo")
         except Exception:
-            print "no"
+            print("no")
 
         return
 
-- 
2.18.0.rc1.1.g3f1ff2140

-- 
Eduardo
