Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BFCC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06792085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06792085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYbc-0004K7-AD
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:40:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQYaq-0003sD-QX
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQYap-0003g1-Uj
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQYap-0003eo-Om
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:39:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB7F6309E96F;
	Tue, 14 May 2019 14:39:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B8B608AC;
	Tue, 14 May 2019 14:39:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E5D7E11385E4; Tue, 14 May 2019 16:39:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190510134203.24012-4-lvivier@redhat.com>
	<871s16jmfr.fsf@dusky.pond.sub.org>
	<8ddff692-fd71-1902-5a61-d4d6680bed0e@redhat.com>
Date: Tue, 14 May 2019 16:39:38 +0200
In-Reply-To: <8ddff692-fd71-1902-5a61-d4d6680bed0e@redhat.com> (Laurent
	Vivier's message of "Mon, 13 May 2019 12:26:47 +0200")
Message-ID: <87r291drrp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 14 May 2019 14:39:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] virtio-rng: change default backend
 to rng-builtin
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	qemu-devel@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> writes:

> On 10/05/2019 18:36, Markus Armbruster wrote:
>> Laurent Vivier <lvivier@redhat.com> writes:
>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>   backends/rng-builtin.c         |  8 +++-----
>>>   hw/virtio/virtio-rng.c         |  2 +-
>>>   include/hw/virtio/virtio-rng.h |  4 ++--
>>>   include/sysemu/rng-builtin.h   | 17 +++++++++++++++++
>>>   qemu-options.hx                |  5 ++---
>>>   5 files changed, 25 insertions(+), 11 deletions(-)
>>>   create mode 100644 include/sysemu/rng-builtin.h
> ...
>>> diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
>>> index 922dce7caccf..f9b6339b19a4 100644
>>> --- a/include/hw/virtio/virtio-rng.h
>>> +++ b/include/hw/virtio/virtio-rng.h
> ...
>>>   #define TYPE_VIRTIO_RNG "virtio-rng-device"
>>> @@ -26,7 +26,7 @@ struct VirtIORNGConf {
>>>       RngBackend *rng;
>>>       uint64_t max_bytes;
>>>       uint32_t period_ms;
>>> -    RngRandom *default_backend;
>>> +    RngBuiltin *default_backend;
>>
>> This member appears to be superfluous.  As far as I can tell, it's only
>> used in the part of virtio-rng.c visible above.  If you replace it by a
>> local variable there (in a separate patch, perhaps), this patch will
>> become simpler.  In particular, you won't need to create rng-builtin.h.
>>
>
> I don't understand how we can remove the rng-builtin.h as we need its
> macros for "RNG_BUILTIN(object_new(TYPE_RNG_BUILTIN))". Could you
> explain?

You're right, you'll still need TYPE_RNG_BUILTIN.  You don't actually
need RNG_BUILTIN(), because you can make the local variable Object *.
Bonus: saves a couple of OBJECT().

If nothing but TYPE_RNG_BUILTIN is left in rng-builtin.h, I'd stick it
into rng.h instead.

