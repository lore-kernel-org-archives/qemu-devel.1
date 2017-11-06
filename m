Received: from eggs.gnu.org ([2001:4830:134:3::10]:48794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBe2A-0005LI-DG
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBe25-0004bq-Ak
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:49:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBe25-0004bQ-4q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:49:29 -0500
References: <1b862cf2-2fee-3243-cb54-2780ace6f25b@profihost.ag>
	<971cc10f-7930-9830-0528-27e8faac7282@redhat.com>
	<748c4d0d-f84b-303d-f9a6-bafa6037d669@profihost.ag>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4b0cb70-7f86-f7cf-bb89-3a9f7ae15dc2@redhat.com>
Date: Mon, 6 Nov 2017 10:49:20 +0100
MIME-Version: 1.0
In-Reply-To: <748c4d0d-f84b-303d-f9a6-bafa6037d669@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] kvm: virtio-net: saved image requires TUN_F_UFO
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, qemu-devel <qemu-devel@nongnu.org>

On 06/11/2017 10:48, Stefan Priebe - Profihost AG wrote:
> Hi Paolo,
> 
> Am 06.11.2017 um 10:40 schrieb Paolo Bonzini:
>> On 06/11/2017 10:38, Stefan Priebe - Profihost AG wrote:
>>> Hello,
>>>
>>> i've upgraded some servers from kernel 4.4 to 4.12 - both running Qemu
>>> 2.9.1.
>>>
>>> If i migrate a VM from a host running kernel 4.4 to a host running 4.12
>>> i get:
>>>
>>> kvm: virtio-net: saved image requires TUN_F_UFO support
>>> kvm: Failed to load virtio-net-device:tmp
>>> kvm: Failed to load virtio-net:virtio
>>> kvm: error while loading state for instance 0x0 of device
>>> '0000:00:12.0/virtio-net'
>>> kvm: load of migration failed: Invalid argument
>>>
>>>
>>> while migrating from 4.12 to 4.4 works fine.
>>>
>>> Can anybody help? Is this expected?
>>
>> Can you check why peer_has_ufo failed (in hw/net/virtio-net.c)?
> 
> May be - how can i archieve this? Patching the code is not a problem if
> you can give me a hint.
> 
>> Also, did this ioctl fail when the tap device was set up on the 4.12 destination?
>> int tap_probe_has_ufo(int fd)
>> {
>>     unsigned offload;
>>
>>     offload = TUN_F_CSUM | TUN_F_UFO;
>>
>>     if (ioctl(fd, TUNSETOFFLOAD, offload) < 0)
>>         return 0;
>>
>>     return 1;
>> }
> 
> Should there be any kernel output or how can i detect / check it?

For both, the simplest answer is probably just using printf.

Paolo
