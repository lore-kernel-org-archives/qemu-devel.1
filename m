Received: from eggs.gnu.org ([2001:4830:134:3::10]:41348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dEIWL-0007vv-PF
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dEIWL-0003ZN-2p
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:55:25 -0400
References: <CADNMjEBdXZeOonsKNf9LpFKK0NFUzAth=CDaSj8q22k+o=ZEFA@mail.gmail.com>
	<539d9960-d554-032f-3e88-b2531743a0a1@redhat.com>
	<CADNMjECLPFyZp1Rm_M4KuSqnY1cp7k0T38=zmWidYvinrutFPQ@mail.gmail.com>
	<20170526114023.GI7211@noname.str.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4626709f-2af0-ae9e-089d-089c918cfe44@redhat.com>
Date: Fri, 26 May 2017 12:55:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170526114023.GI7211@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block]  Behavior of QMP "query-block"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Bruno Alvisio <bruno.alvisio@gmail.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>



On 05/26/2017 07:40 AM, Kevin Wolf wrote:
> Am 25.05.2017 um 20:44 hat Bruno Alvisio geschrieben:
>> Hello John,
>>
>> Thanks. Yes, typo when I wrote the e-mail.
>>
>> It might be possible that XEN does that (I will ask in the XEN forum). However,
>> I have noticed that it is not the case for all of the VMs I have launched. In
>> some of them I can query the block devices even after a long time the VM has
>> been running.
>>
>> I was wondering if the device is removed in case the disk is corrupted or
>> something. When I mention it runs normally, I can log into ithe VM and perform
>> read/write operations such creating files.
>>
>> Also, is there an easy way to log all qemu events so that I can see what might
>> be going on with the 'ide' device?
> 
> There is one completely crazy thing that Xen does with respect to disks.
> Instead of having support for their PV disks (i.e. virtio-blk, just
> different) in the BIOS, they add _both_ an IDE disk and a PV disk to the
> VM, so that the bootloader or non-PV-aware guest OSes can access the IDE
> disk, for which they most certainly do have drivers. As soon as a driver
> for the PV disk is loaded, however, that driver calls a hypervisor
> function that removes all the IDE disks from the VM and leaves only the
> PV ones there, so that the PV-aware guest doesn't see two same disks.
> 
> I suspect that what you're seeing initially is the IDE disks, and when
> the PV driver is loaded, they disappear.
> 
> Kevin
> 

Sure, but does that mean that you'd see *no* block devices via a query
afterwards?
