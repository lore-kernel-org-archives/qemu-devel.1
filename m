Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D1C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1992168B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTzH/BT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1992168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHeNx-0005xn-CN
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 22:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kHeNQ-0005X3-QO
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 22:37:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53113
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kHeNO-00046N-Ed
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 22:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600051072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p41djT1KiaSJoNrkt8M3SwmAe+yeUQ+8/x5FL7VuLm4=;
 b=WTzH/BT152jQ+cuT61eTaTnqwyRSkMxyvJEF8BKIzCoxezI/cAdUxh3+iwXzZFObihIlCd
 yFp8xILR2Zw2Msqie7hxE145Qb/QMXtetACY0MlDh0n9pL0CXo1YIxA7mRbz97kNKtvvPp
 0LjUft8JiOSe99tJVS2U7rUEVA1sxhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-L3P3OBJGMdq-VxZuejyjtA-1; Sun, 13 Sep 2020 22:37:49 -0400
X-MC-Unique: L3P3OBJGMdq-VxZuejyjtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943A7801AC2;
 Mon, 14 Sep 2020 02:37:47 +0000 (UTC)
Received: from [10.72.13.25] (ovpn-13-25.pek2.redhat.com [10.72.13.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F3FA5D9E2;
 Mon, 14 Sep 2020 02:37:40 +0000 (UTC)
Subject: Re: [RFC 1/4] memory: add memory_region_init_io_with_dev interface
To: Li Qiang <liq3ea@gmail.com>, Alexander Bulekov <alxndr@bu.edu>
References: <20200908164157.47108-1-liq3ea@163.com>
 <20200908164157.47108-2-liq3ea@163.com>
 <48a99ece-d808-f860-2551-0fec05ec5b01@redhat.com>
 <20200909044856.lvk77pcfvt567ub6@sirius.home.kraxel.org>
 <CAKXe6S+s-hV2dcK=xVd4jrfNEYH0DvwkAkj5ooyrutA-vGJsdw@mail.gmail.com>
 <20200909142816.qd3cunwmpwxzf3dd@mozz.bu.edu>
 <CAKXe6SKfm8otRMHW5p+u_evr_XoctyM_HO42ouXhM11DbWbaCA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b4546b1-d138-2110-0b18-dea7f2e8b188@redhat.com>
Date: Mon, 14 Sep 2020 10:37:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKfm8otRMHW5p+u_evr_XoctyM_HO42ouXhM11DbWbaCA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 22:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Li Qiang <liq3ea@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/10 下午10:37, Li Qiang wrote:
> Alexander Bulekov <alxndr@bu.edu> 于2020年9月9日周三 下午10:28写道：
>> On 200909 1258, Li Qiang wrote:
>>> Gerd Hoffmann <kraxel@redhat.com> 于2020年9月9日周三 下午12:49写道：
>>>> On Wed, Sep 09, 2020 at 10:15:47AM +0800, Jason Wang wrote:
>>>>> On 2020/9/9 上午12:41, Li Qiang wrote:
>>>>>> Currently the MR is not explicitly connecting with its device instead of
>>>>>> a opaque. In most situation this opaque is the deivce but it is not an
>>>>>> enforcement. This patch adds a DeviceState member of to MemoryRegion
>>>>>> we will use it in later patch.
>>>>>
>>>>> I don't have a deep investigation. But I wonder whether we could make sure
>>>>> of owner instead of adding a new field here.
>>>> Should be possible.  There is object_dynamic_cast() which can be used to
>>>> figure whenever a given owner object is a device.
>>>>
>>> I found most caller of 'memory_region_init_io' will set the owner to
>>> the device object.
>>> But some of them will just set it to NULL. Do will have a clear rule
>>> that the device's MR
>>> 'owner' should be the device object? If yes, we can use this field.
>>>
>> Those seem to be devices that havent't been QOM-imfied yet?  Maybe those
>> devices are unlikely to be affected by these issues, though...
>>
> No it seems not related QOM-ified.
>
>> For i386, it seems like parallel, port80, portF0, pckbd, and xen_pvdevice .. ?
>> I'm guessing none of these do DMA.
>>
> In fact xen_pvdevice is MMIO but the handlers does nothing.
>
> There are some other example than i386 such as the riscv in
> hw/riscv/sifive_uart.c
>
> If we have a rule to force the 'MR's owner to the device then we can
> fix these NULL owner MR.
>
> Thanks,
> Li Qiang


I guess maybe we can start from the ones whose owner is a device and 
convert the rest on top (if necessary)?

Thanks


>
>> +CC Stefan, since he replied to the other thread.
>>
>>> Thanks,
>>> Li Qiang
>>>
>>>> take care,
>>>>    Gerd
>>>>


