Received: from eggs.gnu.org ([2001:4830:134:3::10]:59009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g6waL-0004oK-CL
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g6waG-0001nb-9u
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:41:57 -0400
Date: Mon, 1 Oct 2018 12:41:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181001114146.GA2508@work-vm>
References: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-console downgrade the virtio-pci-blk
 performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Feng Li <lifeng1519@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, qemu-discuss@nongnu.org, qemu-devel@nongnu.org, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>

* Feng Li (lifeng1519@gmail.com) wrote:
> Hi,
> I found an obvious performance downgrade when virtio-console combined
> with virtio-pci-blk.
> 
> This phenomenon exists in nearly all Qemu versions and all Linux
> (CentOS7, Fedora 28, Ubuntu 18.04) distros.
> 
> This is a disk cmd:
> -drive file=iscsi://127.0.0.1:3260/iqn.2016-02.com.test:system:fl-iscsi/1,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native
> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on
> 
> If I add "-device
> virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5  ", the virtio
> disk 4k iops (randread/randwrite) would downgrade from 60k to 40k.
> 
> In VM, if I rmmod virtio-console, the performance will back to normal.
> 
> Any idea about this issue?
> 
> I don't know this is a qemu issue or kernel issue.

It sounds odd;  can you provide more details on:
  a) The benchmark you're using.
  b) the host and the guest config (number of cpus etc)
  c) Why are you running it with iscsi back to the same host - why not
     just simplify the test back to a simple file?

Dave

> 
> Thanks in advance.
> -- 
> Thanks and Best Regards,
> Alex
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
