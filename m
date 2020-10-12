Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BBA206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2QOP1SB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BBA206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRotZ-0006so-LX
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 23:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kRot0-0006Tk-7K
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kRosx-00085U-AE
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602474749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6orbCPQT4FingZ/S5kxXT3V9s81rUKXFxrfBRSbe7ZA=;
 b=N2QOP1SB3y/qyfIXZCdkuoZKtnDevHuvPjA/sYedtU+HlyErkoF9lGSdLF34YTj7fcCGtr
 ni2mwriDX21kWiSHr3D7AFnhPKUAwe9qFJqx8lp9XWNjOmqIWWu7nuKxc8x2+rRHqI2OXp
 UIy6SmrDdB/CVAvpQtS1V7IXvV2xDEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-3IFK8apFPUCoGfRAnWMIug-1; Sun, 11 Oct 2020 23:52:27 -0400
X-MC-Unique: 3IFK8apFPUCoGfRAnWMIug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0471835B47;
 Mon, 12 Oct 2020 03:52:25 +0000 (UTC)
Received: from [10.72.13.74] (ovpn-13-74.pek2.redhat.com [10.72.13.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D648310013D7;
 Mon, 12 Oct 2020 03:52:06 +0000 (UTC)
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
 <20200929085751.GA181609@stefanha-x1.localdomain>
 <20200929055110-mutt-send-email-mst@kernel.org>
 <20200929183824.GC191675@stefanha-x1.localdomain>
 <20200930034807-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fcc7cdd8-fb94-8325-ad50-ccbfd9d3f95d@redhat.com>
Date: Mon, 12 Oct 2020 11:52:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930034807-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: lulu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org,
 raphael.norwitz@nutanix.com, maxime.coquelin@redhat.com, kraxel@redhat.com,
 Felipe Franciosi <felipe@nutanix.com>, marcandre.lureau@redhat.com,
 Nikos Dragazis <ndragazis@arrikto.com>, changpeng.liu@intel.com,
 Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/30 下午4:07, Michael S. Tsirkin wrote:
> On Tue, Sep 29, 2020 at 07:38:24PM +0100, Stefan Hajnoczi wrote:
>> On Tue, Sep 29, 2020 at 06:04:34AM -0400, Michael S. Tsirkin wrote:
>>> On Tue, Sep 29, 2020 at 09:57:51AM +0100, Stefan Hajnoczi wrote:
>>>> On Tue, Sep 29, 2020 at 02:09:55AM -0400, Michael S. Tsirkin wrote:
>>>>> On Mon, Sep 28, 2020 at 10:25:37AM +0100, Stefan Hajnoczi wrote:
>>>>>> Why extend vhost-user with vDPA?
>>>>>> ================================
>>>>>> Reusing VIRTIO emulation code for vhost-user backends
>>>>>> -----------------------------------------------------
>>>>>> It is a common misconception that a vhost device is a VIRTIO device.
>>>>>> VIRTIO devices are defined in the VIRTIO specification and consist of a
>>>>>> configuration space, virtqueues, and a device lifecycle that includes
>>>>>> feature negotiation. A vhost device is a subset of the corresponding
>>>>>> VIRTIO device. The exact subset depends on the device type, and some
>>>>>> vhost devices are closer to the full functionality of their
>>>>>> corresponding VIRTIO device than others. The most well-known example is
>>>>>> that vhost-net devices have rx/tx virtqueues and but lack the virtio-net
>>>>>> control virtqueue. Also, the configuration space and device lifecycle
>>>>>> are only partially available to vhost devices.
>>>>>>
>>>>>> This difference makes it impossible to use a VIRTIO device as a
>>>>>> vhost-user device and vice versa. There is an impedance mismatch and
>>>>>> missing functionality. That's a shame because existing VIRTIO device
>>>>>> emulation code is mature and duplicating it to provide vhost-user
>>>>>> backends creates additional work.
>>>>> The biggest issue facing vhost-user and absent in vdpa is
>>>>> backend disconnect handling. This is the reason control path
>>>>> is kept under QEMU control: we do not need any logic to
>>>>> restore control path data, and we can verify a new backend
>>>>> is consistent with old one.
>>>> I don't think using vhost-user with vDPA changes that. The VMM still
>>>> needs to emulate a virtio-pci/ccw/mmio device that the guest interfaces
>>>> with. If the device backend goes offline it's possible to restore that
>>>> state upon reconnection. What have I missed?
>>> The need to maintain the state in a way that is robust
>>> against backend disconnects and can be restored.
>> QEMU is only bypassed for virtqueue accesses. Everything else still
>> goes through the virtio-pci emulation in QEMU (VIRTIO configuration
>> space, status register). vDPA doesn't change this.
>>
>> Existing vhost-user messages can be kept if they are useful (e.g.
>> virtqueue state tracking). So I think the situation is no different than
>> with the existing vhost-user protocol.
>>
>>>> Regarding reconnection in general, it currently seems like a partially
>>>> solved problem in vhost-user. There is the "Inflight I/O tracking"
>>>> mechanism in the spec and some wording about reconnecting the socket,
>>>> but in practice I wouldn't expect all device types, VMMs, or device
>>>> backends to actually support reconnection. This is an area where a
>>>> uniform solution would be very welcome too.
>>> I'm not aware of big issues. What are they?
>> I think "Inflight I/O tracking" can only be used when request processing
>> is idempotent? In other words, it can only be used when submitting the
>> same request multiple times is safe.
> Not inherently it just does not attempt to address this problem.
>
>
> Inflight tracking only tries to address issues on the guest side,
> that is, making sure the same buffer is used exactly once.
>

As discussed, if we design virito ring carefully, there's probably no 
need for using extra metadata for inflight tracking.

And I remember that the current inflight tracking doesn't support packed 
virtqueue.

Thanks


