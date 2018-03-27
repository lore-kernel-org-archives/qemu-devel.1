Received: from eggs.gnu.org ([2001:4830:134:3::10]:35645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msd-0005aT-7V
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msY-0007HD-BT
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0msY-0007Gu-7L
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:02 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 27 Mar 2018 12:34:49 +0100
Message-Id: <20180327113452.19613-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] e1000 migration changes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Ed, Jason,
  This set of patches change the e1000 migration code to make
it easier to keep with compatibility with older versions in backwards
migration;  but I do need some advice whether I need to do more as well.

I think the first and second patch are fairly uncontrovercial and I
would like them for 2.12, since it'll make any future changes easier.
The third one changes the default behaviour, so again I'd prefer it but
lets see what you think.

My question however, without knowing the internals of the e1000, is
whether when ommitting the subsection, should the code in 2.12 be
changing the data it sends back in the main section of data?

Dave

  

Dr. David Alan Gilbert (3):
  e1000: Convert v3 fields to subsection
  e1000: wire new subsection to property
  e1000: Old machine types, turn new subsection off

 hw/net/e1000.c      | 46 ++++++++++++++++++++++++++++++++++------------
 include/hw/compat.h |  4 ++++
 2 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.14.3
