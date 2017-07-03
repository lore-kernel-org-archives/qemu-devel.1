Received: from eggs.gnu.org ([2001:4830:134:3::10]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dS2XK-0005VP-L8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dS2XJ-0004lt-Ro
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:41:14 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:35620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dS2XJ-0004lD-JT
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:41:13 -0400
Received: by mail-pg0-x22f.google.com with SMTP id j186so96214486pge.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 07:41:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKSfGUCWRMEZLazPibjMeJo9pV5SxdWK9p+4_prr9hAeWpU7nw@mail.gmail.com>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<20170630020622-mutt-send-email-mst@kernel.org>
	<ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
	<20170703142711.0a1db036@nial.brq.redhat.com>
	<CAKSfGUCWRMEZLazPibjMeJo9pV5SxdWK9p+4_prr9hAeWpU7nw@mail.gmail.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Mon, 3 Jul 2017 17:41:12 +0300
Message-ID: <CAKSfGUCDaPFi=1MBxFkfz1ZtZfkfYneSVtxh=ydOAS0jtPsSJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

Do we have any surely working scenario of pci-bridge's SHPC usage? Because
first of all I've tried to use SHPC to avoi involving any ACPI code, but it
didn't look functioning even for ordinary pci-bridge, that's why after
talking to Marcel I left SHPC idea.

2017-07-03 16:58 GMT+03:00 Alexander Bezzubikov <zuban32s@gmail.com>:

> Hmm, I've failed to make SHPC (from current master) work on any modern
> Linux guests.
>
> 2017-07-03 15:27 GMT+03:00 Igor Mammedov <imammedo@redhat.com>:
>
>> On Fri, 30 Jun 2017 10:25:05 +0300
>> Marcel Apfelbaum <marcel@redhat.com> wrote:
>>
>> [...]
>> >
>> > So for the modern systems not supporting PCI ACPI hotplug
>> > we don't need pci-bridges anyway, but for the older ones
>> > the ACPI code of the pci-bridge will be loaded into the
>> > ACPI namespace only if a pci-bridge is actually hot-plugged.
>>
>> just note that the set of 'older' guest OSes is limited to
>> one that do not support SHPC (i.e. to EOLed WinXP & co)
>> as for linux and more modern Windows SHPC hotplug should
>> just work without our ACPI hack (which taxes low memory
>> to keep acpi tables for bridges).
>>
>> So I'm in favor of Michael's suggestion to leave ACPI PCI
>> only in PC machine for old WinXP guests and to keep Q35
>> clean, where linux or newer Windows guests could just
>> use standard SHPC.
>>
>> [...]
>>
>
>
>
> --
> Alexander Bezzubikov
>



-- 
Alexander Bezzubikov
