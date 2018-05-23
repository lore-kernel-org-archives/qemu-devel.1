Received: from eggs.gnu.org ([2001:4830:134:3::10]:35015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLXIJ-0007sx-Bb
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLXI8-0005q0-52
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:11:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fLXI7-0005p3-Sg
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:11:12 -0400
Received: by mail-wr0-x241.google.com with SMTP id w10-v6so5021125wrk.9
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:11:11 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<dd40007d-b63b-d965-505f-11ff0748e54f@redhat.com>
	<20180523023944-mutt-send-email-mst@kernel.org>
	<e027866e-9740-0866-f1c4-45b8181a6f71@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <6b3efcdf-c953-b2bc-e8f7-ac172f143d07@gmail.com>
Date: Wed, 23 May 2018 20:11:07 +0300
MIME-Version: 1.0
In-Reply-To: <e027866e-9740-0866-f1c4-45b8181a6f71@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eauger@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>



On 05/23/2018 10:32 AM, Laszlo Ersek wrote:
> On 05/23/18 01:40, Michael S. Tsirkin wrote:
>> On Wed, May 23, 2018 at 12:42:09AM +0200, Laszlo Ersek wrote:
>>> Hold on,
>>>
>>> On 05/22/18 21:51, Laszlo Ersek wrote:
>>>
>>>> It had taken years until the edk2 core gained a universal
>>>> PciHostBridgeDxe driver with a well-defined platform customization
>>>> interface, and that interface doesn't support multiple domains /
>>>> segments.
>>> after doing a bit more research: I was wrong about this. What I
>>> remembered was not the current state. Edk2 does seem to support multiple
>>> domains, with different segment numbers, ECAM base addresses, and bus
>>> number ranges.

Good news!

>>>   If we figure out a placement strategy or an easy to
>>> consume representation of these data for the firmware, it might be
>>> possible for OVMF to hook them into the edk2 core (although not in the
>>> earliest firmware phases, such as SEC and PEI).

Can you please remind me how OVMF places the 64-bit PCI hotplug window?
We may do something similar.
Let me emphasize,  I am not implying you/anybody else should work on 
that :),
I just want to be on the same page if/when the time will come.
For the moment we are looking for a POC, nothing more.

>>> In retrospect, I'm honestly surprised that so much multi-segment support
>>> has been upstreamed to the edk2 core. Sorry about the FUD. (My general
>>> points remain valid, for the record... But perhaps they no longer matter
>>> for this discussion.)
>>>
>>> (I meant to send this message soon after
>>> <http://mid.mail-archive.com/fc603491-7c41-e862-a583-2bae6f165b5a@redhat.com>,
>>> but my internet connection had to die right then.)
>>>
>>> Thanks
>>> Laszlo
>> Is there support for any hardware which we could emulate?
> I don't see any actual hw support in the edk2 project, but I'll ask.

I think we may be able to succeed with "standard" APCI declarations of
the PCI segments + placing the extra MMCONFIG ranges before the 64-bit 
PCI hotplug area.

Thanks,
Marcel

> Thanks
> Laszlo
