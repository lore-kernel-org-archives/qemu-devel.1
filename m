Received: from eggs.gnu.org ([2001:4830:134:3::10]:44736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1dmLD7-0008Vg-IC
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1dmLD6-0001DO-GZ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:40:17 -0400
MIME-Version: 1.0
In-Reply-To: <1503928405-19960-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1503928405-19960-1-git-send-email-s1seetee@linux.vnet.ibm.com>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Mon, 28 Aug 2017 20:10:13 +0530
Message-ID: <CAGZKiBoMUtEiaPiLEdeAUaWaAadk1s=VF8kAwc_QGHbUSQxdvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] qemu crashes when a negative number
 used for 'maxcpus'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Seeteena,

On Mon, Aug 28, 2017 at 7:23 PM, Seeteena Thoufeek <
s1seetee@linux.vnet.ibm.com> wrote:

> ---Steps to Reproduce---
>
> When passed a negative number to 'maxcpus' parameter, Qemu aborts
> with a core dump.
>
> Run the following command with maxcpus argument as negative number
>
> ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machine
> pseries,accel=kvm,kvm-type=HV -m size=200g -device virtio-blk-pci,
> drive=rootdisk -drive file=/home/images/pegas-1.0-ppc64le.qcow2,
> if=none,cache=none,id=rootdisk,format=qcow2 -monitor telnet
> :127.0.0.1:1234,server,nowait -net nic,model=virtio -net
> user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=1,
> threads=1,maxcpus=-12
>
> (process:12149): GLib-ERROR **: gmem.c:130: failed to allocate
>  18446744073709550568 bytes
>
> Trace/breakpoint trap
>
> Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>

In the bugzilla, I was only suggesting to post the fix upstream and it
doesn't mean a Reviewed-by.  You might want to remove this in your next
version.

Regards,
Bharata.
