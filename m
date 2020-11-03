Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D44C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39512223BF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6oNFu4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39512223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZr9D-0001MD-4M
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 02:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kZr8O-0000vY-1q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kZr8K-0000GX-Fa
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604390013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OReGQGPq2LPfjWqY7Sf1zA0L0CvlVuZ/IHluTTwHy/o=;
 b=R6oNFu4aZtc4ojbv7qJjuOkVAucEefkRejwQhwlIrRHsK35Ohi2BbEsPzC7DRov0yrVC+6
 YadPEnUvcOh9cBZzzRrYe9zaHH4AkdCEDTUzVzfLfkekjbXWhSxdftZuptPGgNnuhujvpD
 vyte7EOa1gDFDtLPnLDMcHsyfGadR/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-THuVJj0IPdaE6OAR2xEP9w-1; Tue, 03 Nov 2020 02:53:31 -0500
X-MC-Unique: THuVJj0IPdaE6OAR2xEP9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C2528015C3;
 Tue,  3 Nov 2020 07:53:28 +0000 (UTC)
Received: from [10.72.13.208] (ovpn-13-208.pek2.redhat.com [10.72.13.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8FDE21E8A;
 Tue,  3 Nov 2020 07:52:51 +0000 (UTC)
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <95432b0c-919f-3868-b3f5-fc45a1eef721@redhat.com>
 <CAJSP0QX_=dbDB2k7H-6D19ns1_HuM2P5ZMtUrFN9H7WU8aDXCg@mail.gmail.com>
 <1cf6b664-63cc-7b57-0a2c-4d4f979d4950@redhat.com>
 <20201102101308.GA42093@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c007455d-b9fc-32d5-a58c-fd8d17794996@redhat.com>
Date: Tue, 3 Nov 2020 15:52:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102101308.GA42093@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
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
 Darren Kenny <darren.kenny@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Liran Alon <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/2 下午6:13, Stefan Hajnoczi wrote:
> On Mon, Nov 02, 2020 at 10:51:18AM +0800, Jason Wang wrote:
>> On 2020/10/30 下午9:15, Stefan Hajnoczi wrote:
>>> On Fri, Oct 30, 2020 at 12:08 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> On 2020/10/30 下午7:13, Stefan Hajnoczi wrote:
>>>>> On Fri, Oct 30, 2020 at 9:46 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>> On 2020/10/30 下午2:21, Stefan Hajnoczi wrote:
>>>>>>> On Fri, Oct 30, 2020 at 3:04 AM Alex Williamson
>>>>>>> <alex.williamson@redhat.com> wrote:
>>>>>>>> It's great to revisit ideas, but proclaiming a uAPI is bad solely
>>>>>>>> because the data transfer is opaque, without defining why that's bad,
>>>>>>>> evaluating the feasibility and implementation of defining a well
>>>>>>>> specified data format rather than protocol, including cross-vendor
>>>>>>>> support, or proposing any sort of alternative is not so helpful imo.
>>>>>>> The migration approaches in VFIO and vDPA/vhost were designed for
>>>>>>> different requirements and I think this is why there are different
>>>>>>> perspectives on this. Here is a comparison and how VFIO could be
>>>>>>> extended in the future. I see 3 levels of device state compatibility:
>>>>>>>
>>>>>>> 1. The device cannot save/load state blobs, instead userspace fetches
>>>>>>> and restores specific values of the device's runtime state (e.g. last
>>>>>>> processed ring index). This is the vhost approach.
>>>>>>>
>>>>>>> 2. The device can save/load state in a standard format. This is
>>>>>>> similar to #1 except that there is a single read/write blob interface
>>>>>>> instead of fine-grained get_FOO()/set_FOO() interfaces. This approach
>>>>>>> pushes the migration state parsing into the device so that userspace
>>>>>>> doesn't need knowledge of every device type. With this approach it is
>>>>>>> possible for a device from vendor A to migrate to a device from vendor
>>>>>>> B, as long as they both implement the same standard migration format.
>>>>>>> The limitation of this approach is that vendor-specific state cannot
>>>>>>> be transferred.
>>>>>>>
>>>>>>> 3. The device can save/load opaque blobs. This is the initial VFIO
>>>>>>> approach.
>>>>>> I still don't get why it must be opaque.
>>>>> If the device state format needs to be in the VMM then each device
>>>>> needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).
>>>>>
>>>>> Let's invert the question: why does the VMM need to understand the
>>>>> device state of a _passthrough_ device?
>>>> For better manageability, compatibility and debug-ability. If we depends
>>>> on a opaque structure, do we encourage device to implement its own
>>>> migration protocol? It would be very challenge.
>>>>
>>>> For VFIO in the kernel, I suspect a uAPI that may result a opaque data
>>>> to be read or wrote from guest violates the Linux uAPI principle. It
>>>> will be very hard to maintain uABI or even impossible. It looks to me
>>>> VFIO is the first subsystem that is trying to do this.
>>> I think our concepts of uAPI are different. The uAPI of read(2) and
>>> write(2) does not define the structure of the data buffers. VFIO
>>> device regions are exactly the same, the structure of the data is not
>>> defined by the kernel uAPI.
>>
>> I think we're talking about different things. It's not about the data
>> structure, it's about whether to data that reads from kernel can be
>> understood by userspace.
>>
>>
>>> Maybe microcode and firmware loading is an example we agree on?
>>
>> I think not. They are bytecodes that have
>>
>> 1) strict ABI definitions
>> 2) understood by userspace
> No, they can be proprietary formats that neither the Linux kernel nor
> userspace can parse. For example, look at linux-firmware
> (https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/about/)
> it's just a collection of binary blobs. The format is not necessarily
> public. The only restriction on that repo is that the binary blob must
> be redistributable and users must be allowed to run them (i.e.
> proprietary licenses can be used).


I think not. Obviously each firmware should have its own ABI no matter 
whether its public or proprietary. For proprietary firmware, it should 
be understood by the proprietary userspace counterpart.


>
> Or look at other passthrough device interfaces like /dev/i2c or libusb.
> They expose data to userspace without requiring a defined format. It's
> the same as VFIO.


Again, it should have an ABI there (either device or spec) no matter 
whether or not it's a transport layer. And there will be an endpoint in 
the userspace know all the format.


>
> In addition, look at kernel uAPIs where userspace acts simply as a data
> transport for opaque data (e.g. where a userspace helper facilitates
> communication but has no visibility of the data). I imagine that memory
> encryption relies on this because the host kernel and userspace do not
> have access to encrypted memory or associated state - but they need to
> help migrate them to other hosts.


Which uAPI do you mean here?


>
> I hope these examples show that such APIs don't pose a problem for the
> Linux uAPI and are already in use. VFIO device state isn't doing
> anything new here.


I feel that you tried to explain "why it can be" but not "why it must 
be". Trying to find one or two subsystems that have opaque uAPI without 
ABI (though I suspect there will be one) may not convince here.

Thanks


>
>>>>>>>      A device from vendor A cannot migrate to a device from
>>>>>>> vendor B because the format is incompatible. This approach works well
>>>>>>> when devices have unique guest-visible hardware interfaces so the
>>>>>>> guest wouldn't be able to handle migrating a device from vendor A to a
>>>>>>> device from vendor B anyway.
>>>>>> For VFIO I guess cross vendor live migration can't succeed unless we do
>>>>>> some cheats in device/vendor id.
>>>>> Yes. I haven't looked into the details of PCI (Sub-)Device/Vendor IDs
>>>>> and how to best enable migration but I hope that can be solved. The
>>>>> simplest approach is to override the IDs and make them part of the
>>>>> guest configuration.
>>>> That would be very tricky (or requires whitelist). E.g the opaque of the
>>>> src may match the opaque of the dst by chance.
>>> Luckily identifying things based on magic constants has been solved
>>> many times in the past.
>>>
>>> A central identifier registry prevents all collisions but is a pain to
>>> manage. Or use a 128-bit UUID and self-allocate the identifier with an
>>> extremely low chance of collision:
>>> https://en.wikipedia.org/wiki/Universally_unique_identifier#Collisions
>>
>> I may miss something. I think we're talking about cross vendor live
>> migration.
>>
>> Would you want src and dest have same UUID or not?
>>
>> If they have different UUIDs, how could we know we can live migrate between
>> them.
>>
>> If they have the same UUID, what's the rule of forcing the the vendors to
>> choose same UUID (a spec)?
> I will send a separate email that describes how VFIO live migration can
> work in more detail. I think it's possible to do it with existing ioctl
> interface that Kirti has proposed and still prevent the risk of
> incorrectly interpreting data that you have pointed out.
>
> The document that I'm sending will allow us to discuss in more detail
> and make the approach clearer.
>
> Stefan


