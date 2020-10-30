Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3943C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC4A2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGRdjr0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC4A2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTEt-0003UC-Qk
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kYTD7-00024m-69
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kYTD4-0004NM-TF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604059723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjYnscnO6MufMZXMrY785giU+3EzwTNz7gf7J2EQfjY=;
 b=XGRdjr0j4ylYurUY8hjS5yaL6qGgIxTp5BPILJIxgAP0XN/JaUvUbNr1gsa/bnRsA45Q/q
 vANPH7iG9X3LXRfWXbzifWXoUbunx5wCgUjFdeZZiMwOWS2gcZZMseMeScWA6ICMzzjO3e
 9AJeGVoF4Ymxk/VtBYT7zMPPQrGcGd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307--SABktP6PTuwnPcmP4ikEQ-1; Fri, 30 Oct 2020 08:08:39 -0400
X-MC-Unique: -SABktP6PTuwnPcmP4ikEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5D75835B8E;
 Fri, 30 Oct 2020 12:08:35 +0000 (UTC)
Received: from [10.72.12.248] (ovpn-12-248.pek2.redhat.com [10.72.12.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E9155C1CF;
 Fri, 30 Oct 2020 12:07:45 +0000 (UTC)
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <95432b0c-919f-3868-b3f5-fc45a1eef721@redhat.com>
Date: Fri, 30 Oct 2020 20:07:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel <qemu-devel@nongnu.org>,
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
 Liran Alon <liran.alon@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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


On 2020/10/30 下午7:13, Stefan Hajnoczi wrote:
> On Fri, Oct 30, 2020 at 9:46 AM Jason Wang <jasowang@redhat.com> wrote:
>> On 2020/10/30 下午2:21, Stefan Hajnoczi wrote:
>>> On Fri, Oct 30, 2020 at 3:04 AM Alex Williamson
>>> <alex.williamson@redhat.com> wrote:
>>>> It's great to revisit ideas, but proclaiming a uAPI is bad solely
>>>> because the data transfer is opaque, without defining why that's bad,
>>>> evaluating the feasibility and implementation of defining a well
>>>> specified data format rather than protocol, including cross-vendor
>>>> support, or proposing any sort of alternative is not so helpful imo.
>>> The migration approaches in VFIO and vDPA/vhost were designed for
>>> different requirements and I think this is why there are different
>>> perspectives on this. Here is a comparison and how VFIO could be
>>> extended in the future. I see 3 levels of device state compatibility:
>>>
>>> 1. The device cannot save/load state blobs, instead userspace fetches
>>> and restores specific values of the device's runtime state (e.g. last
>>> processed ring index). This is the vhost approach.
>>>
>>> 2. The device can save/load state in a standard format. This is
>>> similar to #1 except that there is a single read/write blob interface
>>> instead of fine-grained get_FOO()/set_FOO() interfaces. This approach
>>> pushes the migration state parsing into the device so that userspace
>>> doesn't need knowledge of every device type. With this approach it is
>>> possible for a device from vendor A to migrate to a device from vendor
>>> B, as long as they both implement the same standard migration format.
>>> The limitation of this approach is that vendor-specific state cannot
>>> be transferred.
>>>
>>> 3. The device can save/load opaque blobs. This is the initial VFIO
>>> approach.
>>
>> I still don't get why it must be opaque.
> If the device state format needs to be in the VMM then each device
> needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).
>
> Let's invert the question: why does the VMM need to understand the
> device state of a _passthrough_ device?


For better manageability, compatibility and debug-ability. If we depends 
on a opaque structure, do we encourage device to implement its own 
migration protocol? It would be very challenge.

For VFIO in the kernel, I suspect a uAPI that may result a opaque data 
to be read or wrote from guest violates the Linux uAPI principle. It 
will be very hard to maintain uABI or even impossible. It looks to me 
VFIO is the first subsystem that is trying to do this.


>
>>>    A device from vendor A cannot migrate to a device from
>>> vendor B because the format is incompatible. This approach works well
>>> when devices have unique guest-visible hardware interfaces so the
>>> guest wouldn't be able to handle migrating a device from vendor A to a
>>> device from vendor B anyway.
>>
>> For VFIO I guess cross vendor live migration can't succeed unless we do
>> some cheats in device/vendor id.
> Yes. I haven't looked into the details of PCI (Sub-)Device/Vendor IDs
> and how to best enable migration but I hope that can be solved. The
> simplest approach is to override the IDs and make them part of the
> guest configuration.


That would be very tricky (or requires whitelist). E.g the opaque of the 
src may match the opaque of the dst by chance.


>
>> For at least virtio, they will still go with virtio/vDPA. The advantages
>> are:
>>
>> 1) virtio/vDPA can serve kernel subsystems which VFIO can't, this is
>> very important for containers
> I'm not sure I understand this. If the kernel wants to use the device
> then it doesn't use VFIO, it runs the kernel driver instead.


Current spec is not suitable for all type of device. We've received many 
feedbacks that virtio(pci) might not work very well. Another point is 
that there could be vendor that don't want go with virtio control path. 
Mellanox mlx5 vdpa driver is one example. Yes, they can use mlx5_en, but 
there are vendors that want to build a vendor specific control path from 
scratch.


>
> One part I believe is missing from VFIO/mdev is attaching an mdev
> device to the kernel. That seems to be an example of the limitation
> you mentioned.


Yes, exactly.


>
>> 2) virtio/vDPA is bus independent, we can present a virtio-mmio device
>> which is based on vDPA PCI hardware for e.g microvm
> Yes. This is neat although microvm supports PCI now
> (https://www.kraxel.org/blog/2020/10/qemu-microvm-acpi/).
>
>> I'm not familiar with NVME but they should go with the same way instead
>> of depending on VFIO.
> There are pros/cons with both approaches. I'm not even sure all VIRTIO
> hardware vendors will use vDPA. Two examples:
> 1. A tiny VMM with strict security requirements. The VFIO approach is
> less complex because the VMM is much less involved with the device.


I suspect VFIO could be more secure. It exposes a lot of hardware 
details while vDPA is trying to hide.


> 2. A vendor shipping a hardware VIRTIO PCI device as a PF - no SR-IOV,
> no software VFs, just a single instance. A passthrough PCI device is a
> much simpler way to deliver this device than vDPA + vhost + VMM
> support.


It could be simple but note that there's no live migration support in 
the spec. So it can't be live migrated. We could extend the spec for 
sure, but there're vendor that has already implemented the virtio plus 
their vendor specific extensions for live migration.


>
> vDPA is very useful but there are situations when the VFIO approach is
> attractive too.


Note that it's probably better to differ virtio from vDPA. For virtio 
control path compatible device, we should keep it work in both 
subsystems. For the rest vDPA devices (control path is not virtio), 
exposing them via VFIO doesn't help much or even impossible (e.g the 
abstraction requires the communication with PF).

Thanks


>
> Stefan
>


