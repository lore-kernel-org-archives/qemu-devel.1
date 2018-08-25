Received: from eggs.gnu.org ([2001:4830:134:3::10]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ftehz-0002GM-Pj
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 15:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ftehu-00060A-Fs
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 15:58:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ftehu-0005z2-6r
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 15:58:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id v17-v6so10155505wrr.9
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 12:58:49 -0700 (PDT)
References: <1533796458-22306-1-git-send-email-whois.zihan.yang@gmail.com>
	<af1df9c5-852e-82ab-a1bb-854a4ce6a24e@gmail.com>
	<CAKwiv-gVDxJWm4Oc+sSmsfdawLoo0F8L5n6xMznk9ixkCLR0yA@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <f7926420-ccd7-6821-f18d-794eb3a96105@gmail.com>
Date: Sat, 25 Aug 2018 22:58:46 +0300
MIME-Version: 1.0
In-Reply-To: <CAKwiv-gVDxJWm4Oc+sSmsfdawLoo0F8L5n6xMznk9ixkCLR0yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v4 3/6] i386/acpi-build: describe new pci
 domain in AML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 08/19/2018 05:00 AM, Zihan Yang wrote:
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> 于2018年8月18日周六 上午1:49写道：
>>
>>
>> On 08/09/2018 09:34 AM, Zihan Yang wrote:
>>> Describe new pci segments of host bridges in AML as new pci devices,
>>> with _SEG and _BBN to let them be in DSDT.
>>>
>>> Besides, bus_nr indicates the bus number of pxb-pcie under pcie.0 bus,
>>> but since we put it into separate domain, it should be zero,
>> Why should it be 0? Isn't possible we start another domain from bus_nr> 0?
> In the last version, I got a misunderstanding about bus_nr, and you pointed me
> out that we should start from bus 0 when in new domain. I can support this
> start_bus in later patch, but I wonder when would we want to start a domain
> from bus_nr > 0? I'm not quite familiar with the use case.

That is a good point. I can't think of a reason to start a new PCI
domain with a bus number  >0 , but is it possible.
So if it doesn't complicate the implementation we don't
want this kind of limitation.
On the other hand, if it makes the code too complicated,
we can argue for requiring it.


Thanks,
Marcel

[...]
