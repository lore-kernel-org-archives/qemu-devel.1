Received: from eggs.gnu.org ([2001:4830:134:3::10]:41478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ciEFx-0003Zz-J2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ciEFu-0007IN-Gp
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:53:57 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:35615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ciEFu-0007II-AQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:53:54 -0500
Received: by mail-pg0-x22f.google.com with SMTP id b129so39388138pgc.2
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 21:53:54 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1e54cf74-2ad1-7f26-27ba-fb662be92573@ozlabs.ru>
Date: Mon, 27 Feb 2017 16:53:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] exec: Respect as_tranlsate_internal length clamp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

Hi!

I was asked to backport a fix for a CVE to our of our powerkvm products.
This one:

https://exchange.xforce.ibmcloud.com/vulnerabilities/111187

===
qemu-cve20158817-dos (111187)   reported Mar 1, 2016

Qemu, built to use address_space_translate to map an address to a
MemoryRegionSection, is vulnerable to a denial of service, when doing
pci_dma_read/write calls. A remote authenticated attacker from within the
local network could exploit this vulnerability to cause the guest instance
to crash.
===

There is a link to this one [1]:
http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=c3c1bb99d1c11978d9ce94d1bdcf0705378c1459

Which was reverted with a sensible explanation [2]:
http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=4025446f0ac6213335c22ec43f3c3d8362ce7286

However it is still in the tree as [3]:
http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=23820dbfc79d1c9dce090b4c555994f2bb6a69b3

The only difference between [1] and [3] is a fixed typo in the subject,
other than that they are identical.

Is not the explanation from [2] correct any more and [3] is a correct final
fix? Or [3] should not be in the tree at all?

Thanks!


-- 
Alexey
