Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF19C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0868321A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0868321A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iArHI-0007X9-5N
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iArGK-0006eK-IS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iArGI-0001TO-Qu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iArGA-0001OT-Ik; Thu, 19 Sep 2019 03:53:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC77FC057EC0;
 Thu, 19 Sep 2019 07:53:48 +0000 (UTC)
Received: from [10.36.117.104] (ovpn-117-104.ams2.redhat.com [10.36.117.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E8F95C548;
 Thu, 19 Sep 2019 07:53:25 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <c4a95138-3c08-0563-d567-aa1828de7e39@redhat.com>
 <9d7ae167-c77c-4d8a-bbbc-c33a03a115e5@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <0764e9fc-b0ff-12c7-fffb-adf68706383b@redhat.com>
Date: Thu, 19 Sep 2019 09:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9d7ae167-c77c-4d8a-bbbc-c33a03a115e5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 19 Sep 2019 07:53:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.09.19 09:41, Vladimir Sementsov-Ogievskiy wrote:
> 19.09.2019 10:32, David Hildenbrand wrote:
>> On 18.09.19 15:02, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> Here is a proposal (three of them, actually) of auto propagation for
>>> local_err, to not call error_propagate on every exit point, when we
>>> deal with local_err.
>>>
>>> It also may help make Greg's series[1] about error_append_hint smaller.
>>>
>>> See definitions and examples below.
>>>
>>> I'm cc-ing to this RFC everyone from series[1] CC list, as if we like
>>> it, the idea will touch same code (and may be more).
>>>
>>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03449.html
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   include/qapi/error.h | 102 +++++++++++++++++++++++++++++++++++++++++++
>>>   block.c              |  63 ++++++++++++--------------
>>>   block/backup.c       |   8 +++-
>>>   block/gluster.c      |   7 +++
>>>   4 files changed, 144 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>> index 3f95141a01..083e061014 100644
>>> --- a/include/qapi/error.h
>>> +++ b/include/qapi/error.h
>>> @@ -322,6 +322,108 @@ void error_set_internal(Error **errp,
>>>                           ErrorClass err_class, const char *fmt, ...)
>>>       GCC_FMT_ATTR(6, 7);
>>>   
>>> +typedef struct ErrorPropagator {
>>> +    Error **errp;
>>> +    Error *local_err;
>>> +} ErrorPropagator;
>>> +
>>> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
>>> +{
>>> +    if (prop->local_err) {
>>> +        error_propagate(prop->errp, prop->local_err);
>>> +    }
>>> +}
>>> +
>>> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
>>> +
>>> +/*
>>> + * ErrorPropagationPair
>>> + *
>>> + * [Error *local_err, Error **errp]
>>> + *
>>> + * First element is local_err, second is original errp, which is propagation
>>> + * target. Yes, errp has a bit another type, so it should be converted.
>>> + *
>>> + * ErrorPropagationPair may be used as errp, which points to local_err,
>>> + * as it's type is compatible.
>>> + */
>>> +typedef Error *ErrorPropagationPair[2];
>>> +
>>> +static inline void error_propagation_pair_cleanup(ErrorPropagationPair *arr)
>>> +{
>>> +    Error *local_err = (*arr)[0];
>>> +    Error **errp = (Error **)(*arr)[1];
>>> +
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +    }
>>> +}
>>> +
>>> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagationPair,
>>> +                                 error_propagation_pair_cleanup);
>>> +
>>> +/*
>>> + * DEF_AUTO_ERRP
>>> + *
>>> + * Define auto_errp variable, which may be used instead of errp, and
>>> + * *auto_errp may be safely checked to be zero or not, and may be safely
>>> + * used for error_append_hint(). auto_errp is automatically propagated
>>> + * to errp at function exit.
>>> + */
>>> +#define DEF_AUTO_ERRP(auto_errp, errp) \
>>> +    g_auto(ErrorPropagationPair) (auto_errp) = {NULL, (Error *)(errp)}
>>> +
>>> +
>>> +/*
>>> + * Another variant:
>>> + *   Pros:
>>> + *     - normal structure instead of cheating with array
>>> + *     - we can directly use errp, if it's not NULL and don't point to
>>> + *       error_abort or error_fatal
>>> + *   Cons:
>>> + *     - we need to define two variables instead of one
>>> + */
>>> +typedef struct ErrorPropagationStruct {
>>> +    Error *local_err;
>>> +    Error **errp;
>>> +} ErrorPropagationStruct;
>>> +
>>> +static inline void error_propagation_struct_cleanup(ErrorPropagationStruct *prop)
>>> +{
>>> +    if (prop->local_err) {
>>> +        error_propagate(prop->errp, prop->local_err);
>>> +    }
>>> +}
>>> +
>>> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagationStruct,
>>> +                                 error_propagation_struct_cleanup);
>>> +
>>> +#define DEF_AUTO_ERRP_V2(auto_errp, errp) \
>>> +    g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
>>> +    Error **auto_errp = \
>>> +        ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) ? \
>>> +        &__auto_errp_prop.local_err : \
>>> +        (errp);
>>> +
>>> +/*
>>> + * Third variant:
>>> + *   Pros:
>>> + *     - simpler movement for functions which don't have local_err yet
>>> + *       the only thing to do is to call one macro at function start.
>>> + *       This extremely simplifies Greg's series
>>> + *   Cons:
>>> + *     - looks like errp shadowing.. Still seems safe.
>>> + *     - must be after all definitions of local variables and before any
>>> + *       code.
>>> + *     - like v2, several statements in one open macro
>>> + */
>>> +#define MAKE_ERRP_SAFE(errp) \
>>> +g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
>>> +if ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) { \
>>> +    (errp) = &__auto_errp_prop.local_err; \
>>> +}
>>
>>
>> Using that idea, what about something like this:
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 8bfb6684cb..043ad69f8b 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -58,22 +58,42 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>       return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
>>   }
>>   
>> +typedef struct ErrorPropagator {
>> +    Error **errp;
>> +    Error *local_err;
>> +} ErrorPropagator;
>> +
>> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
>> +{
>> +    if (prop->local_err) {
>> +        error_propagate(prop->errp, prop->local_err);
>> +    }
>> +}
>> +
>> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
>> +
>> +#define DEFINE_LOCAL_ERRP(_errp) \
>> +g_auto(ErrorPropagator) (__auto_errp_prop) = {.errp = (_errp)}; \
>> +Error **local_errp = &__auto_errp_prop.local_err
>> +
>>   static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
>>                                 Error **errp)
>>   {
>> +    DEFINE_LOCAL_ERRP(errp);
>>       S390CPU *cpu = S390_CPU(object_new(typename));
>> -    Error *err = NULL;
>>   
>> -    object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
>> -    if (err != NULL) {
>> +    object_property_set_int(OBJECT(cpu), core_id, "core-id", local_errp);
>> +    if (*local_errp != NULL) {
>>           goto out;
>>       }
>> -    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
>> +    object_property_set_bool(OBJECT(cpu), true, "realized", local_errp);
>>   
>>   out:
>>       object_unref(OBJECT(cpu));
>> -    if (err) {
>> -        error_propagate(errp, err);
>> +    if (*local_errp) {
>>           cpu = NULL;
>>       }
>>       return cpu;
>>
>>
> 
> So it's DEF_AUTO_ERRP_V2 with first parameter hardcoded to be local_errp.
> I still prefer MAKE_ERRP_SAFE(), to not introduce extra variables.
> 

I lost track of the different approaches ;)

The local variable will most probably optimized out by the compiler. I
dislike MAKE_ERRP_SAFE(), as it mixes defining a new variable with code.

-- 

Thanks,

David / dhildenb

