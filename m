Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A612C3B188
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 03:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F0C20842
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 03:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F0C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1j7u-0000Qr-GI
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 22:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1j7B-0008Hi-D5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1j79-0000KG-Av
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:55:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:20586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1j1j78-0000FD-Nk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 22:55:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 19:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
 d="scan'208,217";a="281124532"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.254.46.75])
 ([10.254.46.75])
 by FMSMGA003.fm.intel.com with ESMTP; 11 Feb 2020 19:54:55 -0800
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>,
 linux-kernel@vger.kernel.org
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
Date: Wed, 12 Feb 2020 11:54:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------44FD458F3BC9286B8F433811"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------44FD458F3BC9286B8F433811
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/11/2020 3:40 PM, Jason Wang wrote:
>
> On 2020/2/11 下午2:02, Liu, Jing2 wrote:
>>
>>
>> On 2/11/2020 12:02 PM, Jason Wang wrote:
>>>
>>> On 2020/2/11 上午11:35, Liu, Jing2 wrote:
>>>>
>>>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>>>
>>>>> On 2020/2/10 下午5:05, Zha Bin wrote:
>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>
>>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of 
>>>>>> using
>>>>>> virtio over mmio devices as a lightweight machine model for modern
>>>>>> cloud. The standard virtio over MMIO transport layer only 
>>>>>> supports one
>>>>>> legacy interrupt, which is much heavier than virtio over PCI 
>>>>>> transport
>>>>>> layer using MSI. Legacy interrupt has long work path and causes 
>>>>>> specific
>>>>>> VMExits in following cases, which would considerably slow down the
>>>>>> performance:
>>>>>>
>>>>>> 1) read interrupt status register
>>>>>> 2) update interrupt status register
>>>>>> 3) write IOAPIC EOI register
>>>>>>
>>>>>> We proposed to add MSI support for virtio over MMIO via new feature
>>>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>>>>
>>>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio 
>>>>>> MSI
>>>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>>>> Bit 1 is 0: device uses non-sharing and fixed vector per event 
>>>>>> mapping.
>>>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>>>
>>>>>
>>>>> I believe dynamic mapping should cover the case of fixed vector?
>>>>>
>>>> Actually this bit *aims* for msi sharing or msi non-sharing.
>>>>
>>>> It means, when msi sharing bit is 1, device doesn't want vector per 
>>>> queue
>>>>
>>>> (it wants msi vector sharing as name) and doesn't want a high 
>>>> interrupt rate.
>>>>
>>>> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>>>>
>>>> So they are opposite not superset.
>>>>
>>>> Thanks!
>>>>
>>>> Jing
>>>
>>>
>>> I think you need add more comments on the command.
>>>
>>> E.g if I want to map vector 0 to queue 1, how do I need to do?
>>>
>>> write(1, queue_sel);
>>> write(0, vector_sel);
>>
>> That's true. Besides, two commands are used for msi sharing mode,
>>
>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>>
>> "To set up the event and vector mapping for MSI sharing mode, driver 
>> SHOULD write a valid MsiVecSel followed by 
>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command 
>> to map the configuration change/selected queue events respectively.  
>> " (See spec patch 5/5)
>>
>> So if driver detects the msi sharing mode, when it does setup vq, 
>> writes the queue_sel (this already exists in setup vq), vector sel 
>> and then MAP_QUEUE command to do the queue event mapping.
>>
>
> So actually the per vq msix could be done through this. 

Right, per vq msix can also be mapped by the 2 commands if we want.

The current design benefits for those devices requesting per vq msi that 
driver

doesn't have to map during setup each queue,

since we define the relationship by default.


> I don't get why you need to introduce MSI_SHARING_MASK which is the 
> charge of driver instead of device. 

MSI_SHARING_MASK is just for identifying the msi_sharing bit in 
readl(MsiState) (0x0c4). The device tells whether it wants msi_sharing.

MsiState register: R

le32 {
     msi_enabled : 1;
     msi_sharing: 1;
     reserved : 30;
};

> The interrupt rate should have no direct relationship with whether it 
> has been shared or not.

>
> Btw, you introduce mask/unmask without pending, how to deal with the 
> lost interrupt during the masking then?
>
>
>> For msi non-sharing mode, no special action is needed because we make 
>> the rule of per_vq_vector and fixed relationship.
>>
>> Correct me if this is not that clear for spec/code comments.
>>
>
> The ABI is not as straightforward as PCI did. Why not just reuse the 
> PCI layout?
>
> E.g having
>
> queue_sel
> queue_msix_vector
> msix_config
>
> for configuring map between msi vector and queues/config

Thanks for the advice. :)

Actually when looking into pci, the queue_msix_vector/msix_config is the 
msi vector index, which is the same as the mmio register MsiVecSel (0x0d0).

So we don't introduce two extra registers for mapping even in sharing mode.

What do you think?


>
> Then
>
> vector_sel
> address
> data
> pending
> mask
> unmask
>
> for configuring msi table?

PCI-like msix table is not introduced to device and instead simply use 
commands to tell the mask/configure/enable.

Thanks!

Jing

>
> Thanks
>
>
>> Thanks!
>>
>> Jing
>>
>>
>>>
>>> ?
>>>
>>> Thanks
>>>
>>>
>>>>
>>>>
>>>>> Thanks
>>>>>
>>>>>
>>>>>
>>>>> ---------------------------------------------------------------------
>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>>
>>>>
>>>
>

--------------44FD458F3BC9286B8F433811
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/11/2020 3:40 PM, Jason Wang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      On 2020/2/11 下午2:02, Liu, Jing2 wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2/11/2020 12:02 PM, Jason Wang wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 2020/2/11 上午11:35, Liu, Jing2 wrote:
          <br>
          <blockquote type="cite">
            <br>
            On 2/11/2020 11:17 AM, Jason Wang wrote:
            <br>
            <blockquote type="cite">
              <br>
              On 2020/2/10 下午5:05, Zha Bin wrote:
              <br>
              <blockquote type="cite">From: Liu
                Jiang<a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a>
                <br>
                <br>
                Userspace VMMs (e.g. Qemu microvm, Firecracker) take
                advantage of using
                <br>
                virtio over mmio devices as a lightweight machine model
                for modern
                <br>
                cloud. The standard virtio over MMIO transport layer
                only supports one
                <br>
                legacy interrupt, which is much heavier than virtio over
                PCI transport
                <br>
                layer using MSI. Legacy interrupt has long work path and
                causes specific
                <br>
                VMExits in following cases, which would considerably
                slow down the
                <br>
                performance:
                <br>
                <br>
                1) read interrupt status register
                <br>
                2) update interrupt status register
                <br>
                3) write IOAPIC EOI register
                <br>
                <br>
                We proposed to add MSI support for virtio over MMIO via
                new feature
                <br>
                bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt
                performance.
                <br>
                <br>
                With the VIRTIO_F_MMIO_MSI feature bit supported, the
                virtio-mmio MSI
                <br>
                uses msi_sharing[1] to indicate the event and vector
                mapping.
                <br>
                Bit 1 is 0: device uses non-sharing and fixed vector per
                event mapping.
                <br>
                Bit 1 is 1: device uses sharing mode and dynamic
                mapping.
                <br>
              </blockquote>
              <br>
              <br>
              I believe dynamic mapping should cover the case of fixed
              vector?
              <br>
              <br>
            </blockquote>
            Actually this bit *aims* for msi sharing or msi non-sharing.
            <br>
            <br>
            It means, when msi sharing bit is 1, device doesn't want
            vector per queue
            <br>
            <br>
            (it wants msi vector sharing as name) and doesn't want a
            high interrupt rate.
            <br>
            <br>
            So driver turns to !per_vq_vectors and has to do dynamical
            mapping.
            <br>
            <br>
            So they are opposite not superset.
            <br>
            <br>
            Thanks!
            <br>
            <br>
            Jing
            <br>
          </blockquote>
          <br>
          <br>
          I think you need add more comments on the command.
          <br>
          <br>
          E.g if I want to map vector 0 to queue 1, how do I need to do?
          <br>
          <br>
          write(1, queue_sel);
          <br>
          write(0, vector_sel);
          <br>
        </blockquote>
        <br>
        That's true. Besides, two commands are used for msi sharing
        mode,
        <br>
        <br>
        VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and
        VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
        <br>
        <br>
        "To set up the event and vector mapping for MSI sharing mode,
        driver SHOULD write a valid MsiVecSel followed by
        VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
        command to map the configuration change/selected queue events
        respectively.  " (See spec patch 5/5)
        <br>
        <br>
        So if driver detects the msi sharing mode, when it does setup
        vq, writes the queue_sel (this already exists in setup vq),
        vector sel and then MAP_QUEUE command to do the queue event
        mapping.
        <br>
        <br>
      </blockquote>
      <br>
      So actually the per vq msix could be done through this. </blockquote>
    <p>Right, per vq msix can also be mapped by the 2 commands if we
      want.  <br>
    </p>
    <p>The current design benefits for those devices requesting per vq
      msi that driver</p>
    <p> doesn't have to map during setup each queue, <br>
    </p>
    <p>since we define the relationship by default.</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">I don't
      get why you need to introduce MSI_SHARING_MASK which is the charge
      of driver instead of device. </blockquote>
    <p>MSI_SHARING_MASK is just for identifying the msi_sharing bit in
      readl(MsiState) (0x0c4). The device tells whether it wants
      msi_sharing.<br>
    </p>
    <p><span class="fontstyle0">MsiState register: R<br>
      </span></p>
    <p><span class="fontstyle0">le32 {<br>
            msi_enabled : 1;<br>
            msi_sharing: 1;<br>
            reserved : 30;<br>
        };</span> <br style=" font-style: normal; font-variant: normal;
        font-weight: normal; letter-spacing: normal; line-height:
        normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </p>
    <blockquote type="cite"
      cite="mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">The
      interrupt rate should have no direct relationship with whether it
      has been shared or not.
      <br>
    </blockquote>
    <br>
    <blockquote type="cite"
      cite="mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      Btw, you introduce mask/unmask without pending, how to deal with
      the lost interrupt during the masking then?
      <br>
      <br>
      <br>
      <blockquote type="cite">For msi non-sharing mode, no special
        action is needed because we make the rule of per_vq_vector and
        fixed relationship.
        <br>
        <br>
        Correct me if this is not that clear for spec/code comments.
        <br>
        <br>
      </blockquote>
      <br>
      The ABI is not as straightforward as PCI did. Why not just reuse
      the PCI layout?
      <br>
      <br>
      E.g having
      <br>
      <br>
      queue_sel
      <br>
      queue_msix_vector
      <br>
      msix_config
      <br>
      <br>
      for configuring map between msi vector and queues/config
      <br>
    </blockquote>
    <p>Thanks for the advice. :)</p>
    <p>Actually when looking into pci, the queue_msix_vector/msix_config
      is the msi vector index, which is the same as the mmio register
      MsiVecSel (0x0d0).</p>
    <p>So we don't introduce two extra registers for mapping even in
      sharing mode. <br>
    </p>
    <p>What do you think?<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      Then
      <br>
      <br>
      vector_sel
      <br>
      address
      <br>
      data
      <br>
      pending
      <br>
      mask
      <br>
      unmask
      <br>
      <br>
      for configuring msi table?
      <br>
    </blockquote>
    <p>PCI-like msix table is not introduced to device and instead
      simply use commands to tell the mask/configure/enable.</p>
    <p>Thanks!</p>
    <p>Jing<br>
    </p>
    <blockquote type="cite"
      cite="mid:45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com">
      <br>
      Thanks
      <br>
      <br>
      <br>
      <blockquote type="cite">Thanks!
        <br>
        <br>
        Jing
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <br>
          ?
          <br>
          <br>
          Thanks
          <br>
          <br>
          <br>
          <blockquote type="cite">
            <br>
            <br>
            <blockquote type="cite">Thanks
              <br>
              <br>
              <br>
              <br>
---------------------------------------------------------------------
              <br>
              To unsubscribe, e-mail:
              <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
              <br>
              For additional commands, e-mail:
              <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>
              <br>
              <br>
            </blockquote>
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------44FD458F3BC9286B8F433811--

