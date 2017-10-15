Received: from eggs.gnu.org ([2001:4830:134:3::10]:38465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e3fHI-0003yE-6G
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 05:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e3fHF-0003Sg-2n
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 05:32:12 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:44102)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e3fHE-0003R8-O7
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 05:32:09 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
	by mail1.hostfission.com (Postfix) with ESMTP id 1A60E407A8
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 20:32:03 +1100 (AEDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2017 20:32:02 +1100
From: geoff@hostfission.com
Message-ID: <5548e41a5668ec0cba9543139327e035@hostfission.com>
Subject: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi All,

I am writing some code that needs to share a block of ram between a 
Windows guest and Linux host. For this I am using the ivshmem device and 
I have written a very primitive driver for windows that allows a single 
application to request to memory map the pci bar (shared memory) into 
the program's context using DeviceIoControl.

This is all working fine, but the next problem is I need the driver to 
be signed. In it's current state I would not even suggest it be signed 
as it was just hacked together to test my concept, but now I know it's 
viable I would be willing to invest whatever time is required to write a 
driver that would be acceptable for signing.

The ideal driver would be general purpose and could be leveraged for any 
user mode application use, not just my specific case. It would need to 
implement the IRQ/even features of ivshmem and possibly even some kind 
of security to prevent unauthorized use by rogue applications (shared 
secret configured on the chardev?).

I have several qustions:

   1) Has someone done this? I can't find any reference to a windows 
driver for this device anywhere.
   2) If I was to pursue writing this driver, how would be the best way 
to go about it so as to ensure that it is in a state that it could be 
signed with the RedHat vendor key?
   3) What is the likelihood of having such a driver signed?
   4) Is there a preferred git host for such a driver?

Kind Regards
-Geoff
