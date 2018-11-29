Received: from eggs.gnu.org ([2001:4830:134:3::10]:58447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1gSGpR-0002Rc-QO
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 02:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1gSGpN-0002m0-Pv
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 02:33:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:29817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1gSGpI-0001g3-KY
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 02:33:35 -0500
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <62de590c-b752-1946-1a53-b0e94a4022d3@linux.intel.com>
Date: Thu, 29 Nov 2018 15:32:21 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [Question] Hotplug rescan/remove by manual
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: jing2.liu@intel.com

Hi guys,
When I tested hotplug on pci.0 on pc platform, it seems that we have to
echo 1 > /sys/bus/pci/rescan manually in guest? Is this a non-complete 
feature because of something like gpe interrupt issue?
For hot-unplug, I uses echo 1 > /sys/bus/pci/<device>/remove but this
seems only remove the device in guest but we still can see it in qemu 
monitor by "info pci". I guess this is not a right way to unplug. I'm
not sure if I missed something?

Looking forwards to your response.
Thanks!

Jing
