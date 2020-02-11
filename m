Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A0C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 06:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D72720708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 06:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D72720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1OdW-0007ij-9u
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 01:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1Ocf-0007HG-Mq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1Oca-00070L-6o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:02:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:3884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1j1OcZ-0006eJ-Sh
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:02:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Feb 2020 22:02:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; 
 d="scan'208,217";a="221824516"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.249.174.64])
 ([10.249.174.64])
 by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 22:02:02 -0800
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>,
 linux-kernel@vger.kernel.org
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
Date: Tue, 11 Feb 2020 14:02:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------D7483FB5B3A21C0D59ACC0F5"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
--------------D7483FB5B3A21C0D59ACC0F5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/11/2020 12:02 PM, Jason Wang wrote:
>
> On 2020/2/11 上午11:35, Liu, Jing2 wrote:
>>
>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>
>>> On 2020/2/10 下午5:05, Zha Bin wrote:
>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>
>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of 
>>>> using
>>>> virtio over mmio devices as a lightweight machine model for modern
>>>> cloud. The standard virtio over MMIO transport layer only supports one
>>>> legacy interrupt, which is much heavier than virtio over PCI transport
>>>> layer using MSI. Legacy interrupt has long work path and causes 
>>>> specific
>>>> VMExits in following cases, which would considerably slow down the
>>>> performance:
>>>>
>>>> 1) read interrupt status register
>>>> 2) update interrupt status register
>>>> 3) write IOAPIC EOI register
>>>>
>>>> We proposed to add MSI support for virtio over MMIO via new feature
>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>>
>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>> Bit 1 is 0: device uses non-sharing and fixed vector per event 
>>>> mapping.
>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>
>>>
>>> I believe dynamic mapping should cover the case of fixed vector?
>>>
>> Actually this bit *aims* for msi sharing or msi non-sharing.
>>
>> It means, when msi sharing bit is 1, device doesn't want vector per 
>> queue
>>
>> (it wants msi vector sharing as name) and doesn't want a high 
>> interrupt rate.
>>
>> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>>
>> So they are opposite not superset.
>>
>> Thanks!
>>
>> Jing
>
>
> I think you need add more comments on the command.
>
> E.g if I want to map vector 0 to queue 1, how do I need to do?
>
> write(1, queue_sel);
> write(0, vector_sel);

That's true. Besides, two commands are used for msi sharing mode,

VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.

"To set up the event and vector mapping for MSI sharing mode, driver 
SHOULD write a valid MsiVecSel followed by 
VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command to 
map the configuration change/selected queue events respectively.  " (See 
spec patch 5/5)

So if driver detects the msi sharing mode, when it does setup vq, writes 
the queue_sel (this already exists in setup vq), vector sel and then 
MAP_QUEUE command to do the queue event mapping.

For msi non-sharing mode, no special action is needed because we make 
the rule of per_vq_vector and fixed relationship.

Correct me if this is not that clear for spec/code comments.

Thanks!

Jing


>
> ?
>
> Thanks
>
>
>>
>>
>>> Thanks
>>>
>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>>
>

--------------D7483FB5B3A21C0D59ACC0F5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/11/2020 12:02 PM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com">
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
            virtio over mmio devices as a lightweight machine model for
            modern
            <br>
            cloud. The standard virtio over MMIO transport layer only
            supports one
            <br>
            legacy interrupt, which is much heavier than virtio over PCI
            transport
            <br>
            layer using MSI. Legacy interrupt has long work path and
            causes specific
            <br>
            VMExits in following cases, which would considerably slow
            down the
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
            We proposed to add MSI support for virtio over MMIO via new
            feature
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
            Bit 1 is 1: device uses sharing mode and dynamic mapping.
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
        It means, when msi sharing bit is 1, device doesn't want vector
        per queue
        <br>
        <br>
        (it wants msi vector sharing as name) and doesn't want a high
        interrupt rate.
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
    <p>That's true. Besides, two commands are used for msi sharing mode,<br>
    </p>
    <p><span class="fontstyle0">VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and
        VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.</span></p>
    <p><span class="fontstyle0"><span class="fontstyle0">"To set up the
          event and vector mapping for MSI sharing mode, driver SHOULD
          write a valid </span><span class="fontstyle2">MsiVecSel </span><span
          class="fontstyle0">followed by
          VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE
          command to map the configuration change/selected queue events
          respectively.</span>  " (See spec patch 5/5)</span></p>
    <p><span class="fontstyle0"></span> So if driver detects the msi
      sharing mode, when it does setup vq, writes the queue_sel (this
      already exists in setup vq), vector sel and then MAP_QUEUE command
      to do the queue event mapping.</p>
    <p>For msi non-sharing mode, no special action is needed because we
      make the rule of per_vq_vector and fixed relationship.</p>
    <p>Correct me if this is not that clear for spec/code comments.<br>
    </p>
    <p>Thanks!</p>
    <p>Jing</p>
    <p><br style=" font-style: normal; font-variant: normal;
        font-weight: normal; letter-spacing: normal; line-height:
        normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </p>
    <blockquote type="cite"
      cite="mid:ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com">
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
  </body>
</html>

--------------D7483FB5B3A21C0D59ACC0F5--

