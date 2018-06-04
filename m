Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fPuEu-0001i0-81
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fPuEr-0003Q9-4N
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:29:56 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fPuEq-0003Pg-RD
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 14:29:53 -0400
Received: by mail-wm0-x242.google.com with SMTP id r125-v6so70072wmg.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 11:29:52 -0700 (PDT)
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
Date: Mon, 4 Jun 2018 21:29:48 +0300
MIME-Version: 1.0
In-Reply-To: <20180604042928-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net

Hi Michael,

On 06/04/2018 04:38 AM, Michael S. Tsirkin wrote:
> On Sun, Jun 03, 2018 at 12:27:49PM +0300, Marcel Apfelbaum wrote:
>> Moving to QEMU 3.0 seems like a good opportunity for such a change.
>>
>> I440FX is really old and does not support modern features like IOMMU.
>> Q35's SATA emulation is faster than pc's IDE, native PCI express hotplug
>> is cleaner than ACPI based one and so on...
>>
>> Also the libvirt guys added very good support for the Q35 machine (thanks!).
>>
>> Management software should always specify the machine type and for the
>> current setups, adding '-machine pc' to the command line is not such a
>> big deal.
>>
>> In time the pc machine will fade out and we will probably stop adding
>> new versions at some point.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> For command line users, I think changing the default isn't nice.
>
> Yes it's easy to add -machine pc but there's no documentation
> that tells you to do so.

We can add something do the help.

>   Add to that shortcuts like -cdrom
> stop working,

Maybe is fixable.

> hotplug needs extra bridges to work,

Adding a pci express root port in case hotplug is desired should
not be too hard.
>   and one
> can see that while management tool users benefit from q35,
> command line users will suffer.
>
> Can't we add a tag for management without changing the command line
> default? How about "management-default"? "recommended"? "latest"?

This will help maybe, but was not the point.
We have two x86 machine types, meaning some features
will be developed/tested for pc, while others for q35.
At some point we will loose track of what is working
for each machine.

The PC machine command line is simpler and it supports older guest OSes,
so we should keep it, of course; but I am not sure
we should add more features to it.

I see marking Q35 as the default machine a first step.

Thanks,
Marcel
