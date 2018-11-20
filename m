Received: from eggs.gnu.org ([2001:4830:134:3::10]:49925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gP5Hd-00031p-Fw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gP5HY-0008Lt-Hz
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:37:37 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2295 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1gP5HY-0008HG-2K
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:37:32 -0500
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.54])
	by Forcepoint Email with ESMTP id 08209D4CEE80D
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 20:37:20 +0800 (CST)
From: Guoheyi <guoheyi@huawei.com>
Date: Tue, 20 Nov 2018 12:37:13 +0000
Message-ID: <B328F08581D714418202ABF306D3781C3B774417@dggeml509-mbx.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Can't see mouse cursor on VNC viewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi folks,

I'm using qemu 2.8 on ARM64 with KVM enabled, and TightVNC on MS Windows as=
 a VNC viewer. We can see the graphic screen on VNC viewer, but we can't se=
e the mouse cursor after we enable "Mouse Cursor -> Let remote server deal =
with cursor". When I move or click on VNC viewer screen, we can see some it=
ems are selected or highlighted, so I believe other functions of mouse are =
still there. If I switch to text console and use gpm, I can see the cursor =
in rectangle shape on the screen.

Do you have any idea of why this issue happens and how we can fix it?

Thanks,

Heyi Guo
