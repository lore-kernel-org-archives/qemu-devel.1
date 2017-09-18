Received: from eggs.gnu.org ([2001:4830:134:3::10]:40760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <derrick.mckee@gmail.com>) id 1du15E-0006WY-QO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <derrick.mckee@gmail.com>) id 1du15D-0007b7-SC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:47:52 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:50984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <derrick.mckee@gmail.com>)
	id 1du15D-0007aB-NU
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:47:51 -0400
Received: by mail-io0-x235.google.com with SMTP id w94so4477600ioi.7
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 11:47:50 -0700 (PDT)
MIME-Version: 1.0
From: Derrick McKee <derrick.mckee@gmail.com>
Date: Mon, 18 Sep 2017 18:47:38 +0000
Message-ID: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Disk Image Read Location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

I am trying to figure out if a particular disk operation is reading from
the same location in an image file.  I am simulating a USB disk, and during
an operation the guest OS performs, I would like to know how many times the
backing image file is read.  I have identified the function
address_space_write as the function that writes the data to the guest OS
from the image, but I am not sure what to compare with past writes.  There
are AddressSpace*, MemoryRegion*, and hwaddr types in that function.  Can
any of those be used to compare image read locations?  I am hoping that if,
for example, the AddressSpace* passed into address_space_write during one
invocation equals the AddressSpace* of another invocation means that the
same location within the image file was read twice.  Any help would be
appreciated.

- Derrick McKee
-- 
Derrick McKee
Ph.D. Student at Purdue University
