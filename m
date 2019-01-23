Received: from eggs.gnu.org ([209.51.188.92]:49319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gm8tC-0007Cd-JV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gm8tA-0006jm-La
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:07:42 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sourav.jb1988@gmail.com>)
	id 1gm8t4-00061R-Hh
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:07:37 -0500
Received: by mail-wr1-x42b.google.com with SMTP id p4so652021wrt.7
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 19:07:25 -0800 (PST)
MIME-Version: 1.0
From: ksourav <sourav.jb1988@gmail.com>
Date: Wed, 23 Jan 2019 08:37:13 +0530
Message-ID: <CAAJhNetR-8z37JuOmFDRuq3JfG_S03VDZkciqiKh_kieoqxQ1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] object owner argument of memory_region_init_ram
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

I am trying to learn how qemu implements different soc.
While reading the source code, I found that in some socs, object owner
is passed as NULL to the routine memory_region_init_ram() (for example
in nrf51 soc) and in some socs(for example in Allwinner A10) an
object(non NULL) is passed to memory_region_initi_ram().
When I checked docs/devel/memory.txt, I found below lines.
"For regions that "have no owner" (NULL is passed at creation time), the
machine object is actually used as the owner."
Is the machine object refers to the actual board instance that will
use the soc? For example microbit in case of nrf51 soc ?
Is there any reason of not passing object as owner or in other words,
when do we pass NULL or an object to memory_region_initi_ram() ?

Thanks & Regards
kumar sourav
