Received: from eggs.gnu.org ([2001:4830:134:3::10]:39363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eCLMh-0004tv-J0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eCLMe-0005gf-6h
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:05:39 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:60612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eCLMd-0005gF-Rf
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:05:36 -0500
References: <1b862cf2-2fee-3243-cb54-2780ace6f25b@profihost.ag>
	<971cc10f-7930-9830-0528-27e8faac7282@redhat.com>
	<748c4d0d-f84b-303d-f9a6-bafa6037d669@profihost.ag>
	<f4b0cb70-7f86-f7cf-bb89-3a9f7ae15dc2@redhat.com>
	<4c2913e2-5946-47db-cced-a5702538bc3b@profihost.ag>
	<dc3bf74f-fbd6-573d-0d7c-d456469fcf1d@profihost.ag>
	<9c8673a5-faf7-ca9c-27d3-398df4223d6a@redhat.com>
	<f362d043-7293-65b7-734b-c8372a5f16c3@profihost.ag>
	<54326bae-831d-dfb8-151e-534d3a100c2c@redhat.com>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <ab53e4ae-4c38-9520-b076-96318b6c09b5@profihost.ag>
Date: Wed, 8 Nov 2017 09:05:31 +0100
MIME-Version: 1.0
In-Reply-To: <54326bae-831d-dfb8-151e-534d3a100c2c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


Am 08.11.2017 um 08:54 schrieb Jason Wang:
> 
> 
> On 2017年11月08日 15:41, Stefan Priebe - Profihost AG wrote:
>> Hi Paolo,
>>
>> Am 06.11.2017 um 12:27 schrieb Paolo Bonzini:
>>> On 06/11/2017 12:09, Stefan Priebe - Profihost AG wrote:
>>>> HI Paolo,
>>>>
>>>> could this patchset be related?
>>> Uh oh, yes it should.  Jason, any ways to fix it?  I suppose we need to
>>> disable UFO in the newest machine types, but do we also have to do
>>> (software) UFO in vhost-net and QEMU for migration compatibility?
>> Any news on this?
>>
>> Greets,
> 
> Since we probe UFO support, it will be disabled automatically on device
> startup.
> 
> For the issue of migration, I think the only way is trying to fix it in
> kernel.

But 4.14 is around the corner and the patchset is already included.
Shouldn't this get fixed before 4.14 is released?

Stefan
> 
> Thanks
