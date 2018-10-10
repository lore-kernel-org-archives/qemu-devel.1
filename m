Received: from eggs.gnu.org ([2001:4830:134:3::10]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gAElw-0002wd-Sv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gAEls-00023N-Km
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gAElq-0001zg-Bo
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:43:27 -0400
Message-ID: <a9cf5e6c09eed752b123d5de842bdc3264e37117.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 10 Oct 2018 15:43:19 +0200
In-Reply-To: <3F86795E-6F41-4C86-91C6-21E8312F5E4B@eideticom.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<3F86795E-6F41-4C86-91C6-21E8312F5E4B@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Bates <sbates@raithlin.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Keith Busch <keith.busch@intel.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>, "Richard
	W.M. Jones" <rjones@redhat.com>

On Wed, 2018-10-10 at 13:11 +0000, Stephen  Bates wrote:
> I also tried these out but I was interested in seeing if I could create NVMe models inside the new PCIe subsystem (for both the virt and sifive_u machines). The sifive_u machine did not work at all (so I'll leave that one for now). The virt machine successfully mapped in the NVMe devices and the OS driver was able to probe the nvme driver against them. However something seems to be broken with interrupts as I see messages like these in the OS dmesg:
> 
> [   62.852000] nvme nvme0: I/O 856 QID 1 timeout, completion polled
> [   64.832000] nvme nvme1: I/O 819 QID 1 timeout, completion polled
> [   64.836000] nvme nvme1: I/O 820 QID 1 timeout, completion polled
> [   64.840000] nvme nvme1: I/O 821 QID 1 timeout, completion polled
> [   64.844000] nvme nvme1: I/O 822 QID 1 timeout, completion polled
> [   64.848000] nvme nvme0: I/O 856 QID 1 timeout, completion polled
> [   64.852000] nvme nvme0: I/O 857 QID 1 timeout, completion polled
> 
> These imply the driver hit an admin queue timeout but when it reaped the NVMe admin completion queue it found commands were done but no interrupt was detected by the OS.

So it looks like you at least got to the point where the guest OS
would find PCIe devices... Can you share the output of 'lspci' as
well as the configuration you used when building your bbl?

> I plan to also try with a e1000 network interface model tomorrow and see how that behaves....

Please do :)

-- 
Andrea Bolognani / Red Hat / Virtualization
