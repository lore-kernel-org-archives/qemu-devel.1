Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA6C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F6A20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7bDlf64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F6A20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip87K-0000Xf-9r
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ip86c-00006J-Ru
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ip86b-0007Cv-EP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:58:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ip86b-0007Bt-Ah
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578477504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sycsqZJGVnQw+EqUeY+kh0XYMo8ue/f6Kld1hcvxz8=;
 b=d7bDlf641fthW2KYfWr2bq1BONQGNJNoc9gJ3j6jAMT2VZEhUzvXlkfHwvB1Y3CjGxKBzw
 lc51ch227gYJeOf6iT+/oxuYUL0XXbLr+LSg5coWHRZmiJCQS4i5vDZbUN4HjJuWdaM8G7
 8p1nQ+9lejzQWrq6ALvJ0Vq3qed7CnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Hy-c3osQPSqa5RsUENJZtg-1; Wed, 08 Jan 2020 04:58:23 -0500
X-MC-Unique: Hy-c3osQPSqa5RsUENJZtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15834800D54;
 Wed,  8 Jan 2020 09:58:22 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D59E5C241;
 Wed,  8 Jan 2020 09:58:17 +0000 (UTC)
Subject: Re: discuss about pvpanic
To: Paolo Bonzini <pbonzini@redhat.com>, zhenwei pi <pizhenwei@bytedance.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
 <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
Date: Wed, 8 Jan 2020 10:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, "yelu@bytedance.com" <yelu@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 10:36 AM, Paolo Bonzini wrote:
> On 08/01/20 09:25, zhenwei pi wrote:
>> Hey, Paolo
>>
>> Currently, pvpapic only supports bit 0(PVPANIC_PANICKED).
>> We usually expect that guest writes ioport (typical 0x505) in panic_notifier_list callback
>> during handling panic, then we can handle pvpapic event PVPANIC_PANICKED in QEMU.
>>
>> On the other hand, guest wants to handle the crash by kdump-tools, and reboots without any
>> panic_notifier_list callback. So QEMU only knows that guest has rebooted (because guest
>> write 0xcf9 ioport for RCR request), but QEMU can't identify why guest resets.
>>
>> In production environment, we hit about 100+ guest reboot event everyday, sadly we
>> can't separate the abnormal reboot from normal operation.
>>
>> We want to add a new bit for pvpanic event(maybe PVPANIC_CRASHLOADED) to represent the guest has crashed,
>> and the panic is handled by the guest kernel. (here is the previous patch https://lkml.org/lkml/2019/12/14/265)
>>
>> What do you think about this solution? Or do you have any other suggestions?
> 
> Hi Zhenwei,
> 
> the kernel-side patch certainly makes sense.  I assume that you want the
> event to propagate up from QEMU to Libvirt and so on?  The QEMU patch
> would need to declare a new event (qapi/misc.json) and send it in
> handle_event (hw/misc/pvpanic.c).  For Libvirt I'm not familiar, so I'm
> adding the respective list.

Adding an event is fairly easy, if everything you want libvirt to do is 
report the event to upper layers. I volunteer to do it. Question is, how 
qemu is going to report this, whether some attributes to GUEST_PANICKED 
event or some new event. But more important is to merge the change into 
kernel.

Michal


