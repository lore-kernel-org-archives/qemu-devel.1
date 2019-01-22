Received: from eggs.gnu.org ([209.51.188.92]:46777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm4W8-0003C7-L7
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm4IG-0006hO-5R
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:13:16 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gm4IF-0006g9-Uz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:13:16 -0500
Received: by mail-lj1-x231.google.com with SMTP id k19-v6so88171lji.11
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:13:15 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 22 Jan 2019 14:12:54 -0800
Message-Id: <20190122221256.20883-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] hw/xtensa: xtfpga board improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series adds two improvements for the XTFPGA board:
- use BSP core reset vector to place mini bootloader, because AP
  cores may have different reset vector address;
- expose actual core frequency in the FPGA register instead of the
  fixed 10MHz value.

Max Filippov (2):
  hw/xtensa: xtfpga: fix bootloader placement in SMP
  hw/xtensa: xtfpga: use core frequency

 hw/xtensa/xtfpga.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.11.0
