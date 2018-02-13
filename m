Received: from eggs.gnu.org ([2001:4830:134:3::10]:43339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elk4u-0006iZ-O0
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elk4u-0003UU-4Z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:33:36 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Feb 2018 17:33:22 -0600
Message-Id: <20180213233324.5096-1-eblake@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] s/size/entries/ when dealing with
 non-byte units
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com, mreitz@redhat.com

I mentioned this while reviewing Berto's series on L2 slice handling;
this is a first cut at patches that I think are worth doing throughout
the qcow2 code base if we like the idea.

Eric Blake (2):
  qcow2: Prefer 'entries' over 'size' for non-byte values in spec
  qcow2: Prefer 'entries' over 'size' during cache creation

 docs/interop/qcow2.txt |  4 ++--
 block/qcow2.h          |  4 ++--
 block/qcow2.c          | 21 +++++++++++----------
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.14.3
