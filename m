Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLr-0007IM-QU
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLn-0004d0-OL
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:11 -0500
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com
	([104.47.36.115]:20112
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLn-0004c7-DY
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:07 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:28 -0800
Message-Id: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/8] WHPX updates based on the 17095 insider
 sdk.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

This change set includes fixes for two breaking changes that were introduced
in the Windows Insider SDK 17095. First, the casing of the headers/libs changed
such that a direct reference out of Windows Kits will fail during compile on
case sensitive file systems. Second, a few API's were modified to improve
performance and changes are required to QEMU to maintain ability to build on
such platforms.

The rest of the changes are around improvements/fixes to the accelerator to
increase performance and correctness.

Thanks,
Justin Terry

Justin Terry (VM) (8):
  Fixing WHPX casing to match SDK
  Resolves WHPX breaking changes in SDK 17095
  Remove unnecessary WHPX __debugbreak();
  Fix WHPX additional lock acquisition
  Fix WHPX typo in 'mmio'
  Fix WHPX issue leaking tpr values
  WHXP Removes the use of WHvGetExitContextSize
  WHPX improve interrupt notification registration

 configure              | 10 ++++----
 target/i386/whpx-all.c | 70 +++++++++++++++++---------------------------------
 2 files changed, 28 insertions(+), 52 deletions(-)

-- 
2.13.6
