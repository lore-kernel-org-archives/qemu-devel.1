Received: from eggs.gnu.org ([2001:4830:134:3::10]:49818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCGI-0000TB-Q8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCGD-0006Uh-V3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:43:54 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fLCGD-0006UL-OB
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:43:49 -0400
Received: by mail-wm0-x242.google.com with SMTP id x12-v6so17896419wmc.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 11:43:49 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<CAKwiv-gmfOhM_4BZbjH4VcTh4qmRQ0GuAskJ74T+M3KMHg6_mQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <25bc34e0-3ecf-1465-cff7-6ba1a162dec1@gmail.com>
Date: Tue, 22 May 2018 21:43:45 +0300
MIME-Version: 1.0
In-Reply-To: <CAKwiv-gmfOhM_4BZbjH4VcTh4qmRQ0GuAskJ74T+M3KMHg6_mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, lersek@redhat.com



On 05/22/2018 09:03 AM, Zihan Yang wrote:
> > An interesting point is if we want to limit the MMFCG size for PXBs, 
> as we may not be
> > interested to use all the buses in a specific domain.
>
> OK, perhaps providing an option for the user to specify the desired 
> bus numbers?
>

Right, specifying the number of buses that can be used (e.g: max_busses) 
will decrease a lot
the amount of address space we have to reserve.

> > For each bus we require some address space that remains unused.
>
> Does this mean we should reserve some slots in a bus, or reduce
> the number of buses used in each domain?
>

Limit the number of buses per PCI domain (excluding PCI domain 0, of course)

> > [Adding Laszlo for his insights]
> > Looking forward to see the SeaBIOS patches :)
>
> I appreciate your reviews, I'll write the rest part as soon as possible.
>

Thanks,
Marcel

> Thanks
>
