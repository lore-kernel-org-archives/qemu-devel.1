Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D6C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E83B2168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahgdcYN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E83B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j25NZ-0001yj-Ds
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j25My-0001Vo-19
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j25Mx-0006gV-2s
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:40:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j25Mw-0006dc-Vq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581565250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLoANijvRLORZWmUnjUSah1ms3I1fKun4Z6zhHRZ0bE=;
 b=ahgdcYN4ddpDEIHNXTXDRq1J5Zt2CRF9vhiy9eD6o49TUkCHvlR+wge9gMK6Gc+MlKPaM9
 97R4ZLsmIMdRjDWbzue6/V+w4u+jtkEwxBICuLoHy2pp2nFgYK+Zv+b4FItMsTR8vS+xO+
 ZiLsXaQejLrRr7eVOx83PzKC2+6Q+WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-kbzM4A79OCOj7Zb202X7AA-1; Wed, 12 Feb 2020 22:40:49 -0500
X-MC-Unique: kbzM4A79OCOj7Zb202X7AA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C33F1857345;
 Thu, 13 Feb 2020 03:40:47 +0000 (UTC)
Received: from [10.72.13.212] (ovpn-13-212.pek2.redhat.com [10.72.13.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 044085C132;
 Thu, 13 Feb 2020 03:40:38 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
 <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
 <20200212041554-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d4123292-88e8-0879-7474-ca5f7f9f801f@redhat.com>
Date: Thu, 13 Feb 2020 11:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200212041554-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, "Liu, Jing2" <jing2.liu@linux.intel.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/12 =E4=B8=8B=E5=8D=885:16, Michael S. Tsirkin wrote:
>>> Thanks for the advice.:)
>>>
>>> Actually when looking into pci, the queue_msix_vector/msix_config is =
the
>>> msi vector index, which is the same as the mmio register MsiVecSel
>>> (0x0d0).
>>>
>>> So we don't introduce two extra registers for mapping even in sharing
>>> mode.
>>>
>>> What do you think?
>>>
>> I'm not sure I get the point, but I still prefer the separate vector_s=
el
>> from queue_msix_vector.
>>
>> Btw, Michael propose per vq registers which could also work.
>>
>> Thanks
>>
> Right and I'd even ask a question: do we need shared MSI at all?


I guess it is still needed at least for the current virtio code.=20
Technically we may have thousands queues.

Thanks


> Is it somehow better than legacy interrupt? And why?
> Performance numbers please.
>


