Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E8EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECB62072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK6oKHtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECB62072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionzv-0002oB-Dj
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ionof-0007Sg-43
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ionod-00056Q-V2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:18:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58804
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ionod-000562-R8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578399511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JgyFu4VXRE74ffDYkkKrGkqXkGP7ShHcOWSArhXziiE=;
 b=IK6oKHtURajHR/Bi5oMXtvjHgQvbPG4ir0JeM9PPKKoLfHE3XR3RHDYU+DL1C5wF1oFJlp
 kMP3xzQQxVmW37bo2+qyh01be27dnL8YxnNRI8ogH6YoK1oB5/67Beusz1TZnwxWBVkDEg
 rN4fUnr+Zr8UIgyCHr6KZfhHLpCcxpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Q-k02HL5OHaITs_DXKZPiw-1; Tue, 07 Jan 2020 07:18:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E298107ACC5;
 Tue,  7 Jan 2020 12:18:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A4927FB53;
 Tue,  7 Jan 2020 12:18:20 +0000 (UTC)
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
Date: Tue, 7 Jan 2020 13:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Q-k02HL5OHaITs_DXKZPiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 11.14, Paolo Bonzini wrote:
> On 07/01/20 11:03, Thomas Huth wrote:
>>>  
>>>  vm = QEMUMachine(iotests.qemu_prog)
>>> -vm.add_args('-machine', 'accel=kvm:tcg')
>>> +vm.add_args('-accel', 'kvm', '-accel', 'tcg')
>> Looking at this, I wonder whether we really want the "-accel" option to
>> prioritize the accelerators in the order of appearance? A lot of other
>> CLI tools give the highest priority to the last parameter instead, e.g.
>> "gcc -O3 -O1" compiles with -O1, and not with -O3.
>>
>> Also I think it might be quite common that there are shell scripts which
>> call "qemu-system-xxx -accel xyz $*" ... and if we don't invert the
>> priorities of -accel, it will be impossible to override -accel in that
>> case...
> 
> Hmm, it does match "-machine accel=kvm:tcg" and in general I think it's
> more self-explanatory.  However, it is indeed less friendly to scripts.
>  On one hand those could be changed to place "-accel xyz" after $* (or
> better "$@"), on the other hand we could also add a priority option to
> "-accel".  What do you think?

I don't think we need a separate priority parameter here. But IMHO it's
 really rather common practice to prioritize the last option. So while
it might be more "self-explanatory" to a CLI newbie if the first
occurrence got the highest priority, it might be rather confusing
instead for a CLI veteran...?

What do others on the list here think about this?

 Thomas


