Received: from eggs.gnu.org ([2001:4830:134:3::10]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQAe8-00074a-Kb
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQAe4-00055V-7j
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQAe3-00054f-VA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:56:28 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
	<c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
	<29018087-c00b-abb2-47e6-4ebfc954ff1f@linux.vnet.ibm.com>
	<b1bf85e6-20b8-a77c-d20b-ffc6fe570e9b@redhat.com>
Message-ID: <0ead8e59-be76-f80a-3266-2df20ebb5581@redhat.com>
Date: Wed, 28 Jun 2017 12:56:18 +0200
MIME-Version: 1.0
In-Reply-To: <b1bf85e6-20b8-a77c-d20b-ffc6fe570e9b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 28.06.2017 10:02, Thomas Huth wrote:
> On 28.06.2017 09:28, Viktor Mihajlovski wrote:
>> On 27.06.2017 23:40, Thomas Huth wrote:
>> [...]
>>>>> - Is it OK to require loading an .INS file first? Or does anybody
>>>>>   have a better idea how to load multiple files (kernel, initrd,
>>>>>   etc. ...)?
>>>> It would be nice to support PXE-style boot, because the majority of boot
>>>> servers is set up that way. A straightforward way would be to do a PXE
>>>> emulation by attempting to download a pxelinux.cfg from the well-known
>>>> locations, parsing the content (menu) and finally load the kernel,
>>>> initrd and set the kernel command line as specified there. (I know, but
>>>> you're already parsing the INS-File).
>>>
>>> Please, don't mix up PXE and pxelinux (since you've used both terms in
>>> above paragraph). Assuming that you're only talking about pxlinux config
>>> files... are they that common on s390x already? Using the pxelinux
>>> config file syntax sounds like we would be completely bound to only
>>> loading Linux guests to me, since the boot loader has to know where to
>>> load the initrd and how to patch the kernel so that it can find the initrd.
>>> Using .INS files sounds more flexible to me instead, since you can also
>>> specify the addresses here - so you can theoretically also load other
>>> guest kernels, and that's IMHO the better approach since a firmware
>>> should stay as generic as possible.
>>>
>> In order to be consumable, the network boot should support the most
>> common configurations. I would think that most network boot servers are
>> setup as PXE boot servers using pxelinux configs.
> 
> Are you really sure about the popularity of pxelinux? It's just one
> flavor of secondary stage network boot loaders - which also only exist
> on x86 so far, as far as I know.

And it seems like it also only works with legacy BIOSes, i.e. you can
not use it on EFI-only systems, if I've got that right:

https://github.com/openSUSE/kiwi/wiki/Setup-PXE-boot-with-EFI-Using-GRUB2

So I guess the significance of pxelinux will very likely decrease in
the next years...

 Thomas
