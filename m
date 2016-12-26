Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gadrenayan@gmail.com>) id 1cLQep-0003PU-31
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 03:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gadrenayan@gmail.com>) id 1cLQej-000184-LR
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 03:29:18 -0500
MIME-Version: 1.0
From: Gadre Nayan <gadrenayan@gmail.com>
Date: Mon, 26 Dec 2016 13:59:13 +0530
Message-ID: <CAKJ7aR7kDde_KrCMojwdU1kaSvK+zw_wM49__EcA+=kO+fT+Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Qemu NVME ubuntu 16.04 setup problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, linux-nvme@lists.infradead.org

Hi,

I am trying to test SPDK on a Virtual Machine with NVME support. I do not
have NVME cards on the Host hence wanted to simulate the Hardware, I have
install nvmeqemu (https://github.com/nvmeqemu/nvmeqemu) for that purpose.


I installed Ubuntu 16.04 server on this, however when I use the "-smp 2"
options for qemu the VM boots but becomes unresponsive after some time, I
require the smp 2 switch because dpdk requires atleast 2 cores I guess for
compilation ( I got errors regarding some in-lining issues when I tried to
install dpdk with just 1 core.)

So Has anyone tried working on getting this setup up and running.

Please suggest.
Thanks
Nayan Gadre.
