Received: from eggs.gnu.org ([2001:4830:134:3::10]:35576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cgQLF-0007h3-65
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cgQLC-0005B3-15
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:23:57 -0500
Received: from [59.151.112.132] (port=2761 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cgQLB-000580-J2
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:23:53 -0500
References: <58AC14C1.60603@cn.fujitsu.com>
	<20170221090745.7aea1461@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58AD3036.2010204@cn.fujitsu.com>
Date: Wed, 22 Feb 2017 14:31:18 +0800
MIME-Version: 1.0
In-Reply-To: <20170221090745.7aea1461@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] seek help for AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 02/22/2017 12:07 AM, Alex Williamson wrote:
> On Tue, 21 Feb 2017 18:21:53 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> Hi,
>>
>> First, sorry for such a long time delay on the AER job. I was on 12 days
>> holiday, and start to work on the patch 2 weeks ago, because I use a
>> newer version kernel(4.10 rc8) to start off the work, several tiny
>> problems slow me.
>>
>> Now I meet a confusing issue on aer_inject module. When I use aer_inject
>> command before, it says:
>>
>>     Error: Failed to write, No such device
>>
>> then in dmesg, it says:
>>
>>     pcieport 0000:00:09.0: aer_inject: AER device not found
>>
>> and then I add some debug line in find_aer_device_iter() to check
>> device->bus-name, find that it is "pci", so that is why I can't inject,
>> it should have been "pci_express". But everything is same as before
>> except a newer host kernel.
>>
>> I still don't have a clue on this problem for almost 2 days, could you help?
> 
> If it only happens with a new host kernel, I would suggest finding a
> kernel where it works and bisecting between working and non-working
> kernels to find the commit that introduced the change.  You may have
> found a regression in the kernel that should be reported upstream.
> Thanks,
> 
> Alex
> 

Finally find the reason, I missed a kernel command line parameter
pcie_ports=native. Sorry for the noise.

It seems when make install the kernel, it will blow away the content of
old grub.cfg, so that I cannot check the parameters used in previous kernel.

-- 
Sincerely,
Cao jin
