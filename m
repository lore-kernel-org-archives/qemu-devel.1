Received: from eggs.gnu.org ([2001:4830:134:3::10]:49209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Richard.Relph@amd.com>) id 1e5YFZ-0005N3-Kg
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Richard.Relph@amd.com>) id 1e5YFW-0002ev-HE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:26:13 -0400
Received: from mail-by2nam03on0050.outbound.protection.outlook.com
	([104.47.42.50]:3180
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Richard.Relph@amd.com>)
	id 1e5YFV-0002bG-UQ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:26:10 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com>
	<82d6b8f0-7101-1d59-5489-43b66107fbe0@amd.com>
	<20171018071906-mutt-send-email-mst@kernel.org>
	<20171018191847.GF3225@work-vm>
	<20171019043254-mutt-send-email-mst@kernel.org>
From: Richard Relph <richard.relph@amd.com>
Message-ID: <668a4c8b-2309-1d43-edf5-6768c3008574@amd.com>
Date: Fri, 20 Oct 2017 09:26:02 -0500
MIME-Version: 1.0
In-Reply-To: <20171019043254-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

On 10/18/17 8:35 PM, Michael S. Tsirkin wrote:
> On Wed, Oct 18, 2017 at 08:18:48PM +0100, Dr. David Alan Gilbert wrote:
>> * Michael S. Tsirkin (mst@redhat.com) wrote:
>>> On Fri, Sep 08, 2017 at 10:48:10AM -0500, Brijesh Singh wrote:
>>>>>>       > 11. GO verifies the measurement and if measurement matches then it may
>>>>>>       >  give a secret blob -- which must be injected into the guest before
>>>>>>       >  libvirt starts the VM. If verification failed, GO will request cloud
>>>>>>       >  provider to destroy the VM.
>>>
>>> I realised I'm missing something here: how does GO limit the
>>> secret to the specific VM? For example, what prevents hypervisor
>>> from launching two VMs with the same GO's DH, getting measurement
>>> from 1st one but injecting the secret into the second one?
>>
>> Isn't that the 'trusted channel nonce currently associated with the
>> guest' in the guest context?
>>
>> Dave
> 
> Let me try to clarify the question. I understand that sometimes a key
> is shared between VMs. If this is allowed, it seems that a hypervisor
> can run any number of VMs with the same key. An unauthorised VM
> will not get a measurement that guest owner authorizes, but
> can the hypervisor get secret intended for an authorized VM and
> then inject it into an unauthorized one sharing the same key?

Michael,
     Yes, that's possible. This is why we recommend against a guest 
owner authorizing key sharing. There's no way for the guest owner to 
control what other guests the HV might install using the same key and 
mapping the same memory to.
     So a security-conscious customer, especially in a cloud 
environment, should never enable key sharing.

Richard

> 
>>> Thanks,
>>>
>>> -- 
>>> MST
>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
