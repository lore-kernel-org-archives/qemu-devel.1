Received: from eggs.gnu.org ([2001:4830:134:3::10]:33493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVg-0004qC-IK
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVW-0001kN-LA
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:16 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2017 08:02:06 -0400
Message-Id: <20170727120210.6943-2-crosa@redhat.com>
In-Reply-To: <20170727120210.6943-1-crosa@redhat.com>
References: <20170727120210.6943-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] configure: remove duplicate single quotes
 on config.log header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Cleber Rosa <crosa@redhat.com>

The generation of the informational header on config.log contains two
pairs of single quotes, which seems unintentional, and looks like
this:

  # QEMU configure log Thu Jul 26 08:17:15 EDT 2017
  # Configured with: './configure' '--target-list=x86_64-softmmu'

With this change, the quotes comprehend the entire command line:

  # QEMU configure log Mon Jul 26 08:17:35 EDT 2017
  # Configured with: './configure --target-list=x86_64-softmmu'

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 configure | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configure b/configure
index 987f59b..344d6d2 100755
--- a/configure
+++ b/configure
@@ -35,9 +35,7 @@ rm -f config.log
 
 # Print a helpful header at the top of config.log
 echo "# QEMU configure log $(date)" >> config.log
-printf "# Configured with:" >> config.log
-printf " '%s'" "$0" "$@" >> config.log
-echo >> config.log
+echo "# Configured with: '$0 $@'" >> config.log
 echo "#" >> config.log
 
 print_error() {
-- 
2.9.4
