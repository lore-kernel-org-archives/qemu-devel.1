Received: from eggs.gnu.org ([2001:4830:134:3::10]:41820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cg7TB-0005gA-IF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cg7T6-0001Yd-KS
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:14:53 -0500
Received: from [59.151.112.132] (port=28262 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cg7T6-0001VY-89
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:14:48 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58AC14C1.60603@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 18:21:53 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] seek help for AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi,

First, sorry for such a long time delay on the AER job. I was on 12 days
holiday, and start to work on the patch 2 weeks ago, because I use a
newer version kernel(4.10 rc8) to start off the work, several tiny
problems slow me.

Now I meet a confusing issue on aer_inject module. When I use aer_inject
command before, it says:

    Error: Failed to write, No such device

then in dmesg, it says:

    pcieport 0000:00:09.0: aer_inject: AER device not found

and then I add some debug line in find_aer_device_iter() to check
device->bus-name, find that it is "pci", so that is why I can't inject,
it should have been "pci_express". But everything is same as before
except a newer host kernel.

I still don't have a clue on this problem for almost 2 days, could you help?

The topology is my host is:

+-09.0-[06]--+-00.0 Intel Corporation 82576 Gigabit Network Connection
| \-00.1 Intel Corporation 82576 Gigabit Network Connection

-- 
Sincerely,
Cao jin
