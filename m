Received: from eggs.gnu.org ([2001:4830:134:3::10]:56966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joeclifford@gmail.com>) id 1e43zC-0002Zi-Lb
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joeclifford@gmail.com>) id 1e43z8-0006Oo-Gt
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:55:10 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:53981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joeclifford@gmail.com>)
	id 1e43z8-0006OQ-Ad
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:55:06 -0400
Received: by mail-pg0-x232.google.com with SMTP id s2so6616812pge.10
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 04:55:06 -0700 (PDT)
References: <1505913885.24609.8.camel@redhat.com>
	<2b739056-081b-593a-6344-50b60d04872b@redhat.com>
	<1505917879.24609.11.camel@redhat.com>
	<394d5515-c9a0-578d-1daf-8af1328f0b4b@redhat.com>
	<3f8964dc-3fd4-1f0d-c6c6-46afe78a085d@redhat.com>
	<54b31df5-8eff-2312-346e-3fd9a78cab8e@redhat.com>
	<6b52b0f6-6e89-461c-8094-35214b67c628@redhat.com>
From: Joe Clifford <joeclifford@gmail.com>
Message-ID: <4486e68f-a857-5b54-5c0c-d83437f63f1f@gmail.com>
Date: Mon, 16 Oct 2017 12:54:56 +0100
MIME-Version: 1.0
In-Reply-To: <6b52b0f6-6e89-461c-8094-35214b67c628@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm_set_phys_mem: assertion failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Auger Eric <eric.auger@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com

On 16/10/17 12:23, David Hildenbrand wrote:
> On 04.10.2017 17:48, Laszlo Ersek wrote:
>> Hi,
>>
>> On 09/21/17 16:28, Auger Eric wrote:
>>> Hi David,
>>> On 20/09/2017 16:34, David Hildenbrand wrote:
>>>> On 20.09.2017 16:31, Gerd Hoffmann wrote:
>>>>>    Hi,
>>>>>
>>>>>> Dropping from os section:
>>>>>>
>>>>>> <loader readonly="yes"
>>>>>> type="pflash">/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-
>>>>>> efi.fd</loader>
>>>>>> <nvram
>>>>>> template="/usr/share/edk2.git/ovmf-x64/OVMF_VARS-pure-
>>>>>> efi.fd">/var/lib/libvirt/qemu/nvram/fedora-org-drm-qxl-
>>>>>> base_VARS.fd</nvram>
>>>>>
>>>>> Bad idea I guess.
>>>>>
>>>>>> 1) Does the assert trigger right at startup? Or how is it triggered?
>>>>>
>>>>> Yes, right at startup, before OVMF is done initializing.
>>>>> So probably something in OVMF triggers it.
>>>>
>>>> I'll try to include ovmf to reproduce it.
>>>>
>>>>>
>>>>>> 2) Does your setup work when dopping the assertion?
>>>>>
>>>>> Can try tomorrow.
>>> I encounter the problem on ARM too. My setup works when dropping the
>>> assertion.
>>>
>>> Thanks
>>>
>>> Eric
>>>>
>>>> I think that assertion might not be stable, because properties (romd
>>>> mode) might not be stable and can change. So if it works without the
>>>> assert, dropping it is the right thing to do.
>>
>> There seems to be a new issue report on LaunchPad about the same
>> (f357f564be0b) commit, stating that the removal of the assertion does
>> not help:
>>
>> https://bugs.launchpad.net/qemu/+bug/1721221
>>
>> (Just trying to connect the dots here; I have no comments on the commit
>> otherwise. CC'ing Joe who has filed the LP report.)
>>
>> Thanks
>> Laszlo
>>
> 
> Hi Joe,
> 
> do you have some time to test with the following branch?
> 
> https://github.com/davidhildenbrand/qemu/tree/kvm_slot
> 
> If it works - very good. If not, can you give me what QEMU prints (I
> added some debug output).
> 
> Looks something like this:
> 
> set_phys_mem(0): start: 0x0, size: 0x8000000, add: 1
> Add(0): start: 0x0, size: 0x8000000, ram: 0x0x7f6697e00000
> set_phys_mem(0): start: 0xfffc0000, size: 0x40000, add: 1
> Add(0): start: 0xfffc0000, size: 0x40000, ram: 0x0x7f66a7200000
> set_phys_mem(0): start: 0x0, size: 0x8000000, add: 0
> ...
> 

...and apologies for top posting! :S

Joe
