Received: from eggs.gnu.org ([2001:4830:134:3::10]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fidSm-0006Eb-Ar
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1fidSj-0004Zn-AW
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:25:40 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com
	([104.47.37.65]:53758
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1fidSi-0004WH-V6
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:25:37 -0400
From: Sai Pavan Boddu <saipava@xilinx.com>
Date: Thu, 26 Jul 2018 10:25:32 +0000
Message-ID: <MWHPR02MB2478B45F18C19453BE8B54B2CA2B0@MWHPR02MB2478.namprd02.prod.outlook.com>
References: <MWHPR02MB247893FCAFB6011E0CB1AACBCA540@MWHPR02MB2478.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB247893FCAFB6011E0CB1AACBCA540@MWHPR02MB2478.namprd02.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tb_flush during softreset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Edgar Iglesias <edgari@xilinx.com>

Hi,

Still looking if anyone can comment on this, Thanks.

Regards,
Sai Pavan

From: Sai Pavan Boddu
Sent: Wednesday, July 25, 2018 1:34 PM
To: qemu-devel@nongnu.org
Cc: Edgar Iglesias <edgari@xilinx.com>
Subject: tb_flush during softreset

Hi,

We are seeing issue when fetching tb cache, any suggestions for debug would=
 be helpful.

Issue: Post soft reset of the core, bootloader(running over different cpu) =
reloads the program memory and releases the reset. At that point CPU crashe=
s after first tb cache fetch.

Note: cpu's have mmu disabled. So no tlb_flush_pages are called.

Question: Is tb_flush called when bootloader has written to program memory =
of the target cpu ?

Thanks & Regards,
Sai Pavan
