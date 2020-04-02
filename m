Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2267C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7232072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7232072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwIV-0000eh-Mp
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJwGw-0007MI-JN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJwGu-0003I3-QR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:36:25 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:19105)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJwGu-0002uj-JW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:36:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DB388747E0F;
 Thu,  2 Apr 2020 11:36:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B34C1747DF8; Thu,  2 Apr 2020 11:36:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B221C747DFF;
 Thu,  2 Apr 2020 11:36:13 +0200 (CEST)
Date: Thu, 2 Apr 2020 11:36:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Questionable aspects of QEMU Error's design
In-Reply-To: <a3ca8c60-dd83-ea7b-c268-0c94e441bb52@virtuozzo.com>
Message-ID: <alpine.BSF.2.22.395.2004021132270.75834@zero.eik.bme.hu>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <a3ca8c60-dd83-ea7b-c268-0c94e441bb52@virtuozzo.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020, Vladimir Sementsov-Ogievskiy wrote:
> 01.04.2020 23:15, Peter Maydell wrote:
>> On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrote:
>>> 
>>> QEMU's Error was patterned after GLib's GError.  Differences include:
>>
>>  From my POV the major problem with Error as we have it today
>> is that it makes the simple process of writing code like
>> device realize functions horrifically boilerplate heavy;
>> for instance this is from hw/arm/armsse.c:
>>
>>          object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>>                                   "memory", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>>              return;
>>          }
>>          object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>>              return;
>>          }
>>          object_property_set_bool(cpuobj, true, "realized", &err);
>>          if (err) {
>>              error_propagate(errp, err);
>>              return;
>>          }
>> 
>> 16 lines of code just to set 2 properties on an object
>> and realize it. It's a lot of boilerplate and as
>> a result we frequently get it wrong or take shortcuts
>> (eg forgetting the error-handling entirely, calling
>> error_propagate just once for a whole sequence of
>> calls, taking the lazy approach and using err_abort
>> or err_fatal when we ought really to be propagating
>> an error, etc). I haven't looked at 'auto propagation'
>> yet, hopefully it will help?
>
> Yes, after it the code above will look like this:
>
> ... some_func(..., errp)
> {
>    ERRP_AUTO_PROPAGATE(); # magic macro at function start, and no "Error 
> *err" definition
>
> ...
>          object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                   "memory", errp);
>          if (*errp) {
>              return;
>          }
>          object_property_set_link(cpuobj, OBJECT(s), "idau", errp);
>          if (*errp) {
>              return;
>          }
>          object_property_set_bool(cpuobj, true, "realized", errp);
>          if (*errp) {
>              return;
>          }
> ...
> }
>
> - propagation is automatic, errp is used directly and may be safely 
> dereferenced.

Not much better. Could it be something like:

     ERRP_RET(object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                       "memory", errp));
     ERRP_RET(object_property_set_link(cpuobj, OBJECT(s), "idau", errp));
     ERRP_RET(object_property_set_bool(cpuobj, true, "realized", errp));

Regards,
BALATON Zoltan

