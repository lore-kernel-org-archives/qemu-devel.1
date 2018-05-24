Received: from eggs.gnu.org ([2001:4830:134:3::10]:58803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLn3D-0003C0-MG
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLn3C-00069h-Rp
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:00:51 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fLn3C-00069H-Lt
	for qemu-devel@nongnu.org; Thu, 24 May 2018 06:00:50 -0400
Received: by mail-wm0-x241.google.com with SMTP id n10-v6so3504012wmc.1
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 03:00:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <420701e8-5d6c-d8a7-60cb-5065ef7fbdc9@gmail.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<dd40007d-b63b-d965-505f-11ff0748e54f@redhat.com>
	<20180523023944-mutt-send-email-mst@kernel.org>
	<e027866e-9740-0866-f1c4-45b8181a6f71@redhat.com>
	<CAKwiv-jMKSUYusO4S4HR5HCMXLxGNrpYwywm1dWBWsFKMEGzpg@mail.gmail.com>
	<420701e8-5d6c-d8a7-60cb-5065ef7fbdc9@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu, 24 May 2018 18:00:48 +0800
Message-ID: <CAKwiv-hsDU0VJoDcuM=bgKGMnjepOTbupBjzCHzid_8osj53Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, alex.williamson@redhat.com, eauger@redhat.com, drjones@redhat.com, wei@redhat.com

2018-05-24 1:33 GMT+08:00 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>:
>
>> * IOMMUs cannot span domains either, so bringing new domains introduces
>> the need
>>   to add a VT-d DHRD or vIOMMU per PCIe domain
>
>
> Not really, you may have PCI domains not associated to an vIOMMU. As a first
> step,
> you should not deal with it. The IOMMU can't span over multiple domains,
> yes.
>

OK, I'll leave IOMMU part at present.

>> * 64-bit space is crowded and there are no standards within QEMU for
>> placing per
>>   domain 64-bit MMIO and MMCFG ranges
>
>
> Yes, but we do have some layout for the "over 4G" area and we can continue
> building on it.

That sounds good.

>> * NUMA modeling seems to be a stronger motivation than the limitation of
>> 256 but
>>   nubmers, that each NUMA node holds its own PCI(e) sub-hierarchy
>
>
> No, the 256 devices limitation is the biggest issue we are trying to solve.

Great, the initial purpose still holds.

> You are on the right path, this discussion is meant to help you understand
> wider concerns
> and make you aware of different constrains we didn't think about.
>
> Good luck with the next version!

It is indeed very helpful. I'll try to deal with (at least most of) the issues
int v2. Thanks for your valuable reviews!

Zihan
