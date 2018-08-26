Received: from eggs.gnu.org ([2001:4830:134:3::10]:60099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082h-Da
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006z3-Bz
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:31 +0300
Message-Id: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/9] Misc reopen-related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

as part of my blockdev-reopen work here's a new set of patches. This
doesn't implement yet the core functionality of the new reopen
command, but it does fix a few things that help us pave the way.
I believe that the next series after this one will be the last.

The main change is the removal of child references from the options
and explicit_options QDicts. This was already discussed in the
previous series[1], and here's the implementation.

Regards,

Berto

[1] https://lists.gnu.org/archive/html/qemu-block/2018-08/msg00474.html

Alberto Garcia (9):
  qemu-io: Fix writethrough check in reopen
  file-posix: x-check-cache-dropped should default to false on reopen
  block: Remove child references from bs->{options,explicit_options}
  block: Don't look for child references in append_open_options()
  block: Allow child references on reopen
  file-posix: Forbid trying to change unsupported options during reopen
  block: Allow changing 'discard' on reopen
  block: Allow changing 'detect-zeroes' on reopen
  block: Allow changing 'force-share' on reopen

 block.c               | 146 +++++++++++++++++++++++++++++++++++---------------
 block/file-posix.c    |   9 +++-
 include/block/block.h |   2 +
 qemu-io-cmds.c        |   2 +-
 4 files changed, 113 insertions(+), 46 deletions(-)

-- 
2.11.0
