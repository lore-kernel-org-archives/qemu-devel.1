Received: from eggs.gnu.org ([2001:4830:134:3::10]:55589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYTAJ-0001Nk-B6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYTAF-0006LW-8j
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dYTAF-0006Jy-2t
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:19:59 -0400
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
Date: Fri, 21 Jul 2017 11:19:52 +0300
MIME-Version: 1.0
In-Reply-To: <1500533554.6553.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org

On 20/07/2017 9:52, Gerd Hoffmann wrote:
> On Wed, 2017-07-19 at 16:20 +0300, Aleksandr Bezzubikov wrote:
>> Now PCI bridges (and PCIE root port too) get a bus range number in
>> system init,
>> basing on currently plugged devices. That's why when one wants to
>> hotplug another bridge,
>> it needs his child bus, which the parent is unable to provide.
>> The suggested workaround is to have vendor-specific capability in
>> RedHat generic pcie-root-port
>> that contains number of additional bus to reserve on BIOS PCI init.
> 

Hi Gerd,
Thanks for looking into this.

> Where is the qemu patch for this?
> 

On the way, Aleksandr is working on it, should
be ready soon.

> What about window sizes?  IIRC there was a plan to provide allocation
> hints for them too ...

Yes, is in my TODO list, however not as part of Aleksandr's series
which aims to provide PCIe-PCI bridge hotplug support.
I should mention that for this case both Windows and Linux guests
(modern OSes) trigger correctly IO/MEM resource re-balancing
process and succeeds to complete the hotplug operation.

Thanks,
Marcel

> 
> cheers,
>    Gerd
> 
