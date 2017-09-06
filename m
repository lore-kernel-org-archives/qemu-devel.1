Received: from eggs.gnu.org ([2001:4830:134:3::10]:48994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dpO0T-0007Fk-Cc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dpO0P-000076-W1
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:15:49 -0400
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com
	([104.47.37.59]:7584
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dpO0P-00006D-ME
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 20:15:45 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 5 Sep 2017 17:11:58 -0700
Message-ID: <cover.1504656490.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 0/2]  Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com

There are numorous QEMU machines that only have a single or a handful of
valid CPU options. To simplyfy the management of specificying which CPU
is/isn't valid let's create a property that can be set in the machine
init. We can then check to see if the user supplied CPU is in that list
or not.

This is just a quick setup, if this method is agreed apon I can add a
nice macro to add the valid CPU options (similar to SET_MACHINE_COMPAT)
and improve the error messages. I just wanted to get some input before I
spent too much time on that.

Alistair Francis (2):
  machine: Add a valid_cpu_types property
  netduino2: Specify the valid CPUs

 hw/arm/netduino2.c  |  5 +++++
 hw/core/machine.c   | 27 +++++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 3 files changed, 33 insertions(+)

-- 
2.11.0
