Received: from eggs.gnu.org ([2001:4830:134:3::10]:43131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vinodchegu@gmail.com>) id 1cxfao-00030z-Jd
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vinodchegu@gmail.com>) id 1cxfan-000153-Av
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:07:18 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:33938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vinodchegu@gmail.com>)
	id 1cxfan-00013s-6H
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 16:07:17 -0400
Received: by mail-oi0-x22a.google.com with SMTP id g204so88029098oib.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 13:07:15 -0700 (PDT)
MIME-Version: 1.0
From: Vinod Chegu <vinodchegu@gmail.com>
Date: Mon, 10 Apr 2017 13:07:14 -0700
Message-ID: <CACpTSGuo31hQf6gEto2oFVW7WPuaVqEURQRm+mfjKuXyaFN_cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] quick question about live VM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

A very basic question...

In a vanilla KVM env. (i.e. non open stack etc) when  a VM is live migrated
to another host does the MAC address of the vNICs and the DHCP IP address
for these interfaces remain the same ?

Thought the answer was a yes as the goal is to minimize disruption to the
apps etc. in the VM, but wanted to double check (couldn't verify as I don't
have a ready test env handy at the moment).

BTW, please assume that the MAC address for the vNIC interfaces were not
explicitly specified at the time of VM creation.

Thanks
Vinod
