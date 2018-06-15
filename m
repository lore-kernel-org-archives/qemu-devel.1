Received: from eggs.gnu.org ([2001:4830:134:3::10]:33374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTm6W-0007lq-9m
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTm6T-0007Ph-8N
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:37:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fTm6T-0007Pb-2n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:37:13 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <40d9df00-f80d-02a4-58ec-b407e7dd8cdb@redhat.com>
Date: Fri, 15 Jun 2018 12:37:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] valgrind problem in sun4u_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>


 Hi Mark, hi Artyom,

while using valgrind to fix some issues with the rom_ptr() function
today, I noticed that there is one more problem in sun4u_load_kernel():
The kernel_top variable can be used uninitialized in some cases:
If load_elf() fails and the kernel is loaded via load_aout() or
load_image_targphys(), the kernel_top variable is never set to a valid
value. This could cause some trouble when loading the initrd later. When
you've got some spare time, could you please have a look?

 Thanks,
  Thomas
