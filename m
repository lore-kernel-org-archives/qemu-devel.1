Received: from eggs.gnu.org ([2001:4830:134:3::10]:51499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eEA5h-0005IU-S8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eEA5g-0006R8-Qt
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:27:37 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eEA5g-0006Pn-KJ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:27:36 -0500
Received: by mail-wm0-x241.google.com with SMTP id t139so13332557wmt.1
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 00:27:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1b862cf2-2fee-3243-cb54-2780ace6f25b@profihost.ag>
	<971cc10f-7930-9830-0528-27e8faac7282@redhat.com>
	<748c4d0d-f84b-303d-f9a6-bafa6037d669@profihost.ag>
	<f4b0cb70-7f86-f7cf-bb89-3a9f7ae15dc2@redhat.com>
	<4c2913e2-5946-47db-cced-a5702538bc3b@profihost.ag>
	<dc3bf74f-fbd6-573d-0d7c-d456469fcf1d@profihost.ag>
	<9c8673a5-faf7-ca9c-27d3-398df4223d6a@redhat.com>
	<f362d043-7293-65b7-734b-c8372a5f16c3@profihost.ag>
	<54326bae-831d-dfb8-151e-534d3a100c2c@redhat.com>
	<ab53e4ae-4c38-9520-b076-96318b6c09b5@profihost.ag>
	<61b97624-bd55-655f-f8e2-ea1699c25d51@redhat.com>
	<b110639a-3752-56b5-fe50-741c53048c15@redhat.com>
	<34a1bec2-403e-8de1-d3dd-661865c6dceb@redhat.com>
	<a80dde99-460c-15e9-26ba-e5e8a2c0ae5e@redhat.com>
	<9afb46e3-c1d4-e9af-0f45-4c4b6d2c30f4@profihost.ag>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78c57855-0554-cae6-bede-470a6ccb420e@redhat.com>
Date: Mon, 13 Nov 2017 09:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <9afb46e3-c1d4-e9af-0f45-4c4b6d2c30f4@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 11/11/2017 19:59, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> Am 10.11.2017 um 05:18 schrieb Jason Wang:
>>
>>
>> On 2017年11月08日 19:22, Jason Wang wrote:
>>>
>>>
>>> On 2017年11月08日 18:46, Paolo Bonzini wrote:
>>>> On 08/11/2017 09:21, Jason Wang wrote:
>>>>>
>>>>> On 2017年11月08日 17:05, Stefan Priebe - Profihost AG wrote:
>>>>>> Am 08.11.2017 um 08:54 schrieb Jason Wang:
>>>>>>> On 2017年11月08日 15:41, Stefan Priebe - Profihost AG wrote:
>>>>>>>> Hi Paolo,
>>>>>>>>
>>>>>>>> Am 06.11.2017 um 12:27 schrieb Paolo Bonzini:
>>>>>>>>> On 06/11/2017 12:09, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>> HI Paolo,
>>>>>>>>>>
>>>>>>>>>> could this patchset be related?
>>>>>>>>> Uh oh, yes it should.  Jason, any ways to fix it?  I suppose we
>>>>>>>>> need to
>>>>>>>>> disable UFO in the newest machine types, but do we also have to do
>>>>>>>>> (software) UFO in vhost-net and QEMU for migration compatibility?
>>>>>>>> Any news on this?
>>>>>>>>
>>>>>>>> Greets,
>>>>>>> Since we probe UFO support, it will be disabled automatically on
>>>>>>> device
>>>>>>> startup.
>>>>>>>
>>>>>>> For the issue of migration, I think the only way is trying to fix
>>>>>>> it in
>>>>>>> kernel.
>>>>>> But 4.14 is around the corner and the patchset is already included.
>>>>>> Shouldn't this get fixed before 4.14 is released?
>>>>> We will try to seek a solution as soon as possible. If we can't catch
>>>>> 4.14, we will do it for stable for sure.
>>>> Jason, can you write to netdev and Cc Linus and me?
>>>
>>> Paolo, see this https://www.spinics.net/lists/netdev/msg465454.html
>>>
>>> Just notice this today since I'm not on the cc list.
>>
>> An update:
>>
>> After some discussions on netdev, we will try to bring UFO back
>> partially for just TAP. Willem promise to fix this. 4.14 is too late
>> consider the fix is not trivial, it will go through stable tree.
> 
> OK is it save to just revert the UFO patchset for my local branch?

Yes, it is.

Paolo
