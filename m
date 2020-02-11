Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E192AC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B818C20733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B818C20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1MLx-0001tr-1I
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 22:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1ML0-0001Fe-Cd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1j1MKz-0006Yj-3v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:35:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:12173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1j1MKy-0006Qx-QL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:35:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Feb 2020 19:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,427,1574150400"; d="scan'208";a="221791265"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.249.174.64])
 ([10.249.174.64])
 by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 19:35:43 -0800
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To: Jason Wang <jasowang@redhat.com>, Zha Bin <zhabin@linux.alibaba.com>,
 linux-kernel@vger.kernel.org
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
Date: Tue, 11 Feb 2020 11:35:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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


On 2/11/2020 11:17 AM, Jason Wang wrote:
>
> On 2020/2/10 下午5:05, Zha Bin wrote:
>> From: Liu Jiang<gerry@linux.alibaba.com>
>>
>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>> virtio over mmio devices as a lightweight machine model for modern
>> cloud. The standard virtio over MMIO transport layer only supports one
>> legacy interrupt, which is much heavier than virtio over PCI transport
>> layer using MSI. Legacy interrupt has long work path and causes specific
>> VMExits in following cases, which would considerably slow down the
>> performance:
>>
>> 1) read interrupt status register
>> 2) update interrupt status register
>> 3) write IOAPIC EOI register
>>
>> We proposed to add MSI support for virtio over MMIO via new feature
>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>
>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
>> uses msi_sharing[1] to indicate the event and vector mapping.
>> Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>
>
> I believe dynamic mapping should cover the case of fixed vector?
>
Actually this bit *aims* for msi sharing or msi non-sharing.

It means, when msi sharing bit is 1, device doesn't want vector per queue

(it wants msi vector sharing as name) and doesn't want a high interrupt 
rate.

So driver turns to !per_vq_vectors and has to do dynamical mapping.

So they are opposite not superset.

Thanks!

Jing


> Thanks
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

