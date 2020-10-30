Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6410FC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53DF20728
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwlwR14s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53DF20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQn8-0007EE-KI
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kYQle-0006Fl-1t
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kYQlb-0006IK-OU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604050335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vacKzFLjAgBMRC0sfc/6xFS8Mjhht4elSItz3TPcakU=;
 b=OwlwR14sHo1gmINlyyV94V8GW+dDsrQWW/117++5tK4sKjcd401gvEpaLzd3GkSUUmZ6VS
 MME71qDSiZW51pd9bR7G1DGaq5crTNyj9t6+RdAuqt9+6EeMTfvMYaTz9HO7IQC3kpgyyY
 fQ2XZsIxZKBiHL47trAGjqGrPwWeQJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-boUItFu6OT-c4PQxQAwB7w-1; Fri, 30 Oct 2020 05:32:13 -0400
X-MC-Unique: boUItFu6OT-c4PQxQAwB7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96BD0100585;
 Fri, 30 Oct 2020 09:32:10 +0000 (UTC)
Received: from [10.72.12.248] (ovpn-12-248.pek2.redhat.com [10.72.12.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9354C19C71;
 Fri, 30 Oct 2020 09:31:41 +0000 (UTC)
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Alex Williamson <alex.williamson@redhat.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0b098087-86aa-11d1-058d-db43d0f89db8@redhat.com>
Date: Fri, 30 Oct 2020 17:31:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029210407.33d6f008@x1.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/30 上午11:04, Alex Williamson wrote:
> On Fri, 30 Oct 2020 09:11:23 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2020/10/29 下午11:46, Alex Williamson wrote:
>>> On Thu, 29 Oct 2020 23:09:33 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>   
>>>> On 2020/10/29 下午10:31, Alex Williamson wrote:
>>>>> On Thu, 29 Oct 2020 21:02:05 +0800
>>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>>      
>>>>>> On 2020/10/29 下午8:08, Stefan Hajnoczi wrote:
>>>>>>> Here are notes from the session:
>>>>>>>
>>>>>>> protocol stability:
>>>>>>>         * vhost-user already exists for existing third-party applications
>>>>>>>         * vfio-user is more general but will take more time to develop
>>>>>>>         * libvfio-user can be provided to allow device implementations
>>>>>>>
>>>>>>> management:
>>>>>>>         * Should QEMU launch device emulation processes?
>>>>>>>             * Nicer user experience
>>>>>>>             * Technical blockers: forking, hotplug, security is hard once
>>>>>>> QEMU has started running
>>>>>>>             * Probably requires a new process model with a long-running
>>>>>>> QEMU management process proxying QMP requests to the emulator process
>>>>>>>
>>>>>>> migration:
>>>>>>>         * dbus-vmstate
>>>>>>>         * VFIO live migration ioctls
>>>>>>>             * Source device can continue if migration fails
>>>>>>>             * Opaque blobs are transferred to destination, destination can
>>>>>>> fail migration if it decides the blobs are incompatible
>>>>>> I'm not sure this can work:
>>>>>>
>>>>>> 1) Reading something that is opaque to userspace is probably a hint of
>>>>>> bad uAPI design
>>>>>> 2) Did qemu even try to migrate opaque blobs before? It's probably a bad
>>>>>> design of migration protocol as well.
>>>>>>
>>>>>> It looks to me have a migration driver in qemu that can clearly define
>>>>>> each byte in the migration stream is a better approach.
>>>>> Any time during the previous two years of development might have been a
>>>>> more appropriate time to express your doubts.
>>>> Somehow I did that in this series[1]. But the main issue is still there.
>>> That series is related to a migration compatibility interface, not the
>>> migration data itself.
>>
>> They are not independent. The compatibility interface design depends on
>> the migration data design. I ask the uAPI issue in that thread but
>> without any response.
>>
>>
>>>   
>>>> Is this legal to have a uAPI that turns out to be opaque to userspace?
>>>> (VFIO seems to be the first). If it's not,  the only choice is to do
>>>> that in Qemu.
>>> So you're suggesting that any time the kernel is passing through opaque
>>> data that gets interpreted by some entity elsewhere, potentially with
>>> proprietary code, that we're in legal jeopardy?  VFIO is certainly not
>>> the first to do that (storage and network devices come to mind).
>>> Devices are essentially opaque data themselves, vfio provides access to
>>> (ex.) BARs, but the interpretation of what resides in that BAR is device
>>> specific.  Sometimes it's defined in a public datasheet, sometimes not.
>>> Suggesting that we can't move opaque data through a uAPI seems rather
>>> absurd.
>>
>> No, I think we are talking about different things. What I meant is the
>> data carried via uAPI should not opaque userspace. What you said here is
>> a good example for this actually. When you expose BAR to userspace,
>> there should be driver that knows the semantics of BAR running in the
>> userspace, so it's not opaque to userspace.
>
> But the thing running in userspace might be QEMU, which doesn't know
> the semantics of the BAR, it might not be until a driver in the guest
> that we have something that understands the BAR semantics beyond opaque
> data.  We might have nested guests, so it could be passed through
> multiple userspaces as opaque data.  The requirement make no sense.


I don't see the difference. From kernel perspective they are all 
userspace drivers regardless whether it's a guest or not. No matter how 
many levels in the middle, there will always be a final endpoint that 
know clearly about the semantics of the BAR. The intermediate level just 
transports the uAPI to upper levels.


>
>
>>>>> Note that we're not talking about vDPA devices here, we're talking
>>>>> about arbitrary devices with arbitrary state.  Some degree of migration
>>>>> support for assigned devices can be implemented in QEMU, Alex Graf
>>>>> proved this several years ago with i40evf.  Years later, we don't have
>>>>> any vendors proposing device specific migration code for QEMU.
>>>> Yes but it's not necessarily VFIO as well.
>>> I don't know what this means.
>>
>> I meant we can't not assume VFIO is the only uAPI that will be used by Qemu.
>   
> And we don't, DPDK, SPDK, various other userspaces exist.  All can take
> advantage of the migration uAPI that we've developed rather than
> implementing device specific code in their projects.


Obviously, for device that has higher level of abstraction like virtio, 
using a bus level device model for migration is a burden.


>   I'm not sure how
> this is strengthening your argument for device specific migration code
> in QEMU, which would need to be replicated in every other userspace.


Any reason for such replication? Except for the devices that have well 
known interface like virtio, each device should have unique 
attributes/behaviors that needs to be dealt with during live migration.


>   As
> opaque data with a well defined protocol, each userspace can implement
> support for this migration protocol once and it should work independent
> of the device or vendor.  It only requires support in the code
> implementing the device, which is already necessarily device specific.
>
>
>>>>> Clearly we're also trying to account for proprietary devices where even
>>>>> for suspend/resume support, proprietary drivers may be required for
>>>>> manipulating that internal state.  When we move device emulation
>>>>> outside of QEMU, whether in kernel or to other userspace processes,
>>>>> does it still make sense to require code in QEMU to support
>>>>> interpretation of that device for migration purposes?
>>>> Well, we could extend Qemu to support property module (or have we
>>>> supported that now?). And then it can talk to property drivers via
>>>> either VFIO or vendor specific uAPI.
>>> Yikes, I thought out-of-process devices was exactly the compromise
>>> being developed to avoid QEMU supporting proprietary modules and ad-hoc
>>> vendor specific uAPIs.
>>
>> We can't even prevent this in kernel, so I don't see how possible we can
>> make it for Qemu.
>
> The kernel is a different beast, it already supports loadable modules
> and due to whatever pressures or market demands of the past, it allows
> non-GPL use of symbols necessary for some of those modules.


So this just answer my question. It's not hard to forecast Qemu may end 
up with similar pressure in the future. The request is simple, connect a 
guest with a vendor specific proprietary uAPI.


>    QEMU has
> no module support outside of non-mainline forks.  Clearly there is
> pressure to support sub-process and proprietary device emulation and
> it's our choice how we enable that.  This vfio over socket approach is
> the mechanism we're trying to enable to avoid proprietary modules in
> QEMU proper.


VFIO user is not the first, vhost-user can do this already. I would 
rather consider VFIO-user to cover the case that vhost-user can't cover. 
And if possible, we should encourage to use vhost-user.


>
>
>>> I think you're actually questioning even the
>>> premise of developing a standardized API for out-of-process devices
>>> here.  Thanks,
>>
>> Actually not, it's just question in my mind when looking at VFIO
>> migration compatibility patches, since vfio-user is being proposed, it's
>> a good time to revisit them.
>
> A migration compatibility interface has not been determined for vfio.
> We currently rely on the vendor drivers to provide their own internal
> validation and harmlessly reject migration from an incompatible device.


So it looks like vendor needs to implement their own migration protocol 
instead of the well defined ones in qemu? I think migration guys may 
share more experiences of how challenge it would be.


> It would be great if we could make progress on this, but it's a
> difficult problem, and one that I hope we can further address once we
> have a base level of migration support.


One thing that is missed in this summary is the way to detect migration 
compatibility. We can't not simply depend on migration failure I guess.


>
> It's great to revisit ideas, but proclaiming a uAPI is bad solely
> because the data transfer is opaque, without defining why that's bad,


Well, it should be sufficient if the opaque uAPI itself is against the 
Linux uAPI/ABI design principles. The side effect is obvious, 
maintainability, debug-ability and compatibility.


> evaluating the feasibility and implementation of defining a well
> specified data format rather than protocol, including cross-vendor
> support, or proposing any sort of alternative is not so helpful imo.


I don't get here, why proposing alternative is not helpful consider 
we're in the early stage?


>
> Note that we also migrate guest memory as opaque data; we don't require
> knowing the data structures it holds or how regions are used, we simply
> look for changes and transfer the new data.  That's not so different
> from a vendor driver passing us a blob of data as "information it needs
> to replicate the device state at the target."  Thanks,


That's complete different, for guest memory, it's:

1) not read from any uAPI
2) not opaque for guest itself

But what qemu expect to read from VFIO uAPI is completely opaque to any 
of the upper layer.

Thanks


>
> Alex
>
>


