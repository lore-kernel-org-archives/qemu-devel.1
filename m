Received: from eggs.gnu.org ([209.51.188.92]:35900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gs8yY-0005MG-Cr
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gs8yX-0003bj-8M
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:26:02 -0500
References: <20190117025115.81178-1-aik@ozlabs.ru>
	<fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
	<b82674e7-cc41-6bba-2f9e-9882bfd7afbd@ozlabs.ru>
	<20190207081830.4dcbb822@x1.home>
	<295fa9ca-29c1-33e6-5168-8991bc0ef7b1@ozlabs.ru>
	<20190207202620.23e9c063@x1.home>
	<20190208052849.GB6434@umbus.fritz.box>
	<20190208085235.12583ada@x1.home>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <dc337d19-974e-f96b-5d18-767bca620a5b@gmail.com>
Date: Fri, 8 Feb 2019 14:25:50 -0200
MIME-Version: 1.0
In-Reply-To: <20190208085235.12583ada@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr_pci,
 vfio: NVIDIA V100 + P9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>



On 2/8/19 1:52 PM, Alex Williamson wrote:
>> Hm.  If the GPU memory is really separate from main RAM, which it
>> sounds like, I don't think it makes sense to account it against the
>> same locked memory limit as regular RAM.
> That's true, if the user owns the device and the device provides the
> memory backing, it doesn't seem like it should count against the user's
> locked memory limit.  That'd make things easy for libvirt.  Thanks,

Sounds good.

Is this a QEMU (or even kernel) side change? If so, and we choose to go
through with it, I'll wait for a new spin of this series to see what must
be done in Libvirt to proper support it.


Thanks,


DHB
