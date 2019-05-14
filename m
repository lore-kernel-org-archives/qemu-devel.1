Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A13C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A82B20862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A82B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZMo-0005CR-AE
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:29:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQZLs-0004iu-BB
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQZLr-00063K-GF
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hQZLr-00062g-Ai
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:28:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8DC5821D9;
	Tue, 14 May 2019 15:28:22 +0000 (UTC)
Received: from [10.40.205.6] (unknown [10.40.205.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 967515C542;
	Tue, 14 May 2019 15:28:15 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20190514075602.7674-1-lvivier@redhat.com>
	<20190514075602.7674-4-lvivier@redhat.com>
	<87sgthcb43.fsf@dusky.pond.sub.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f9a8dfdb-1089-ee5f-8552-15dca2df4df7@redhat.com>
Date: Tue, 14 May 2019 17:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87sgthcb43.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 14 May 2019 15:28:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/3] virtio-rng: change default backend
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
Cc: "=?UTF-8?Q?Daniel_P.Berrang=c3=a9?=" <berrange@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2019 17:24, Markus Armbruster wrote:
> Laurent Vivier <lvivier@redhat.com> writes:
> 
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   backends/rng-builtin.c         |  8 +++-----
>>   hw/virtio/virtio-rng.c         |  2 +-
>>   include/hw/virtio/virtio-rng.h |  4 ++--
>>   include/sysemu/rng-builtin.h   | 17 +++++++++++++++++
>>   qemu-options.hx                |  5 ++---
>>   5 files changed, 25 insertions(+), 11 deletions(-)
>>   create mode 100644 include/sysemu/rng-builtin.h
>>
>> diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
>> index b1264b745407..27675301933b 100644
>> --- a/backends/rng-builtin.c
>> +++ b/backends/rng-builtin.c
>> @@ -7,17 +7,15 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "sysemu/rng.h"
>> +#include "sysemu/rng-builtin.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qmp/qerror.h"
>>   #include "qemu/main-loop.h"
>>   #include "qemu/guest-random.h"
>>   
>> -#define TYPE_RNG_BUILTIN "rng-builtin"
>> -#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTIN)
>> -
>> -typedef struct RngBuiltin {
>> +struct RngBuiltin {
>>       RngBackend parent;
>> -} RngBuiltin;
>> +};
>>   
>>   static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
>>   {
> 
> Rebase on top of the PATCH 3.5 I just posted gets rid of patch hunks
> from here...
> 

I will resend the series including your patch.

Thanks,
Laurent

