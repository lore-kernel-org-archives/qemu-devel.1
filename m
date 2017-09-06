Received: from eggs.gnu.org ([2001:4830:134:3::10]:40656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dpU5r-0000Hf-My
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dpU5r-0007Ga-18
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 02:45:47 -0400
Date: Wed, 6 Sep 2017 12:15:32 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA8JxuM-ddQVTBfgnSDD2fD+kz_RNShdNDqMqVH=zOKBfw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1709061202500.13418@wniryva>
References: <20170905112152.8851-1-ppandit@redhat.com>
	<CAFEAcA8B4EwXCPSBsftt=QkAuH8jCBbK23-uU7NA7G3k6ADHLw@mail.gmail.com>
	<7FD21DDFE9A3784693E393AF276FE7D21F17E49E@DGGEMA501-MBX.china.huawei.com>
	<CAFEAcA8JxuM-ddQVTBfgnSDD2fD+kz_RNShdNDqMqVH=zOKBfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel]
 =?gb2312?b?tPC4tDogW1BBVENIXSBpbnRjOiBhcm1fZ2ljdjM6?=
 =?gb2312?b?IGxpbWl0IEdJQ1IgaXByaW9yaXR5IGluZGV4?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: niuguoxiang <niuguoxiang@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

+-- On Tue, 5 Sep 2017, Peter Maydell wrote --+
| The code cannot be reached with a non-aligned value,
| because we register these functions via the gic_ops[]
| MemoryRegionops in hw/intc/arm_gicv3.c, and since we
| do not specify .valid.unaligned=true there, the memory.c
| code will throw out attempts at unaligned accesses.

  I see, thank you for the clarification; ie. within the range

   GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1f:

'offset' would be GICR_IPRIORITYR +0, +4, +8 ... 0x1c?

Maybe the patch could still be considered, not as bug fix though.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
