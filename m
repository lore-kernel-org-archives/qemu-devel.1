Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FC8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D4C20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 03:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eB0RCYrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D4C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqpTb-0000DZ-Gd
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 23:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqpSg-0008Fb-1Q
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 23:00:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqpSd-0000Ht-OZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 23:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593658826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fF1e0J/wkkS+yx09wgyL0DGPMavkInXqoDfhZCFboN4=;
 b=eB0RCYrs2oWjFDJpmSFKI3/yvXNS1tCvkE+17mMAQpFaLsBP1TWTRvEKB/qaAw9PG3Rvx+
 RmZNRxvE+TujLdIilvoV/0ohDJmiZQJILDsGcuylobsfeG/bdIsC/1e+S9VSqt+ojw1VDm
 czC21O8SA3LEpeuTPcYL03jCHrP3zX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-zAXyHy5QPgWXPeZwv59g9w-1; Wed, 01 Jul 2020 23:00:22 -0400
X-MC-Unique: zAXyHy5QPgWXPeZwv59g9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5045107ACCA;
 Thu,  2 Jul 2020 03:00:21 +0000 (UTC)
Received: from [10.72.13.248] (ovpn-13-248.pek2.redhat.com [10.72.13.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB81373FD2;
 Thu,  2 Jul 2020 03:00:09 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
References: <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <1b4eaaaf-c2ab-0da8-afb4-1b7b4221e6cf@redhat.com>
 <20200630052148-mutt-send-email-mst@kernel.org>
 <49f547e1-dd87-7abe-1075-9dcece75b641@redhat.com>
 <20200630152050.GC3138@xz-x1>
 <d9dd8662-33e3-03fe-f227-f519858534e0@redhat.com>
 <20200701121626.GD40675@xz-x1>
 <f4d031fc-6951-be63-991c-c5689274dbf1@redhat.com>
 <20200701124111.GF40675@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5407442b-f4a8-b41b-f386-e0c68ae58058@redhat.com>
Date: Thu, 2 Jul 2020 11:00:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701124111.GF40675@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 23:00:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/1 下午8:41, Peter Xu wrote:
> On Wed, Jul 01, 2020 at 08:30:07PM +0800, Jason Wang wrote:
>>> I overlooked myself that the IR region will be there even if ir=off.
>>
>> Yes, but the point stands still but the issue is still if ir=off.
>>
>>
>>>     So I
>>> think the assert should stand.
>>
>> Do you mean vhost can't trigger the assert()? If yes, I don't get how it
>> can't.
> Yes.  vhost can only trigger the translate() via memory API.  No matter whether
> ir is on/off, the memory region is always enabled, so any access to 0xfeexxxxx
> from memory API should still land at s->mr_ir, afaict, rather than the dmar region.


Right.

Thanks

>


