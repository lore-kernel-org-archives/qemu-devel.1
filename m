Received: from eggs.gnu.org ([2001:4830:134:3::10]:35380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermxx-0007Sc-0T
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermxt-0000hY-Ue
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermxt-0000gt-Qi
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BD8F4023112
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 15:51:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  2 Mar 2018 16:51:08 +0100
Message-Id: <20180302155110.5481-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] change q35 default NIC to e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, berrange@redhat.com

The Intel 82574 NIC has better performance and more features than
the aging e1000 (aka 82540), for example MSI-X.  This patch chooses it
by default for the Q35 machine type.

Drivers for 82574 were added first to Linux 2.6.27 (2008) and Windows
2008 R2.  This does mean that Windows 2008 will not work anymore with Q35
machine types and a default "-net nic -net xxx" network configuration;
it did work before because it does have an AHCI driver.  However, Windows
2008 has been declared out of main stream support in 2015.  It will
get out of extended support in 2020.  Windows 2008 R2 has the same end
of support dates and, since the two are basically Vista vs. Windows 7,
R2 probably is more popular.

Opinions?

Paolo

Paolo Bonzini (2):
  net: add e1000e model to the "simple" -net/-nic options
  q35: change default NIC to e1000e

 hw/i386/pc.c         | 5 +++--
 hw/i386/pc_piix.c    | 2 +-
 hw/i386/pc_q35.c     | 2 +-
 hw/pci/pci.c         | 2 ++
 include/hw/i386/pc.h | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.14.3
