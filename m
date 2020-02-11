Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A5C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 04:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C0E2072C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 04:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S387Mwab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C0E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Mmb-0002T8-CU
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 23:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1Mlu-00024N-C9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 23:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1Mls-0000NP-FU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 23:03:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38079
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1Mls-000054-7D
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 23:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581393785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQwP5yBQiPBYF1dt476zTOkcra/qaHWjGFa0BnYAY9Y=;
 b=S387MwabuRkNC4AH8yjImNeQ57YdR1JU0AcRme3vGdPrAQaH+u8DrhqRTFcV7ncz5RqF5d
 YRX24vaT9Anurp6iO4QDBuVT0eNhDBnxACN/dxQuqOfw5Tl9pPaDUr+M0TR4ul1R5BcEvl
 9001ulGuBRVAjB/KZk8dpk7x1oT0hsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-kMVZNqVNOdyeGT4OBNfS1Q-1; Mon, 10 Feb 2020 23:03:02 -0500
X-MC-Unique: kMVZNqVNOdyeGT4OBNfS1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A1F418A8C81;
 Tue, 11 Feb 2020 04:03:00 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD54589F24;
 Tue, 11 Feb 2020 04:02:51 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To: "Liu, Jing2" <jing2.liu@linux.intel.com>,
 Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
Date: Tue, 11 Feb 2020 12:02:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>
> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>
>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>
>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of usi=
ng
>>> virtio over mmio devices as a lightweight machine model for modern
>>> cloud. The standard virtio over MMIO transport layer only supports on=
e
>>> legacy interrupt, which is much heavier than virtio over PCI transpor=
t
>>> layer using MSI. Legacy interrupt has long work path and causes=20
>>> specific
>>> VMExits in following cases, which would considerably slow down the
>>> performance:
>>>
>>> 1) read interrupt status register
>>> 2) update interrupt status register
>>> 3) write IOAPIC EOI register
>>>
>>> We proposed to add MSI support for virtio over MMIO via new feature
>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>
>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>> Bit 1 is 0: device uses non-sharing and fixed vector per event mappin=
g.
>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>
>>
>> I believe dynamic mapping should cover the case of fixed vector?
>>
> Actually this bit *aims* for msi sharing or msi non-sharing.
>
> It means, when msi sharing bit is 1, device doesn't want vector per que=
ue
>
> (it wants msi vector sharing as name) and doesn't want a high=20
> interrupt rate.
>
> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>
> So they are opposite not superset.
>
> Thanks!
>
> Jing


I think you need add more comments on the command.

E.g if I want to map vector 0 to queue 1, how do I need to do?

write(1, queue_sel);
write(0, vector_sel);

?

Thanks


>
>
>> Thanks
>>
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>


