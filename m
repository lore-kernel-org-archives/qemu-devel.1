Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD298CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E0121897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E0121897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOTy-00034q-Oc
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iLORV-0000Y3-Gf
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iLORS-0002lz-9Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iLORS-0002kR-1V
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:21:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6DCB89F308;
 Fri, 18 Oct 2019 09:20:59 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FAB15C1B5;
 Fri, 18 Oct 2019 09:20:56 +0000 (UTC)
Subject: Re: [PATCH v3] migration: Support QLIST migration
To: quintela@redhat.com
References: <20191015125045.5006-1-eric.auger@redhat.com>
 <87r23bpzhb.fsf@trasno.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <65164a03-8d9b-9bb7-85ca-b49ffb90bb68@redhat.com>
Date: Fri, 18 Oct 2019 11:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87r23bpzhb.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 18 Oct 2019 09:20:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Juan,

On 10/17/19 10:06 AM, Juan Quintela wrote:
> Eric Auger <eric.auger@redhat.com> wrote:
>> Support QLIST migration using the same principle as QTAILQ:
>> 94869d5c52 ("migration: migrate QTAILQ").
>>
>> The VMSTATE_QLIST_V macro has the same proto as VMSTATE_QTAILQ_V.
>> The change mainly resides in QLIST_RAW_INSERT_TAIL implementation.
>>
>> Tests also are provided.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Hi
> 
> 
> How long are these lists normally?  I think that the INSERT_TAIL is the
> wrong approach.  If lists can be long, it is much better to just insert
> at the beggining and as last operation, reverse things, no?>
>> +#define QLIST_RAW_INSERT_TAIL(head, elm, entry) do {                           \
>> +        void *iter, *last = NULL;                                              \
>> +        *QLIST_RAW_NEXT(elm, entry) = NULL;                                    \
>> +        if (!*QLIST_RAW_FIRST(head)) {                                         \
>> +            *QLIST_RAW_FIRST(head) = elm;                                      \
>> +            *QLIST_RAW_PREVIOUS(elm, entry) = head;                            \
>> +            break;                                                             \
>> +        }                                                                      \
>> +        for (iter = *QLIST_RAW_FIRST(head);                                    \
>> +             iter; last = iter, iter = *QLIST_RAW_NEXT(iter, entry))           \
>> +            { }                                                                \
>> +        *QLIST_RAW_NEXT(last, entry) = elm;                                    \
>> +        *QLIST_RAW_PREVIOUS(elm, entry) = last;                                \
> 
> I think that you normally want to do this two instructions in the
> reverse order, just in case (famous last words).
> 
> 
>> +static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
>> +                     const VMStateField *field)
>> +{
>> +    int ret = 0;
>> +    const VMStateDescription *vmsd = field->vmsd;
>> +    /* size of a QLIST element */
>> +    size_t size = field->size;
>> +    /* offset of the QLIST entry in a QLIST element */
>> +    size_t entry_offset = field->start;
>> +    int version_id = field->version_id;
>> +    void *elm;
>> +
>> +    trace_get_qlist(field->name, vmsd->name, vmsd->version_id);
>> +    if (version_id > vmsd->version_id) {
>> +        error_report("%s %s",  vmsd->name, "too new");
>> +        return -EINVAL;
>> +    }
>> +    if (version_id < vmsd->minimum_version_id) {
>> +        error_report("%s %s",  vmsd->name, "too old");
>> +        return -EINVAL;
>> +    }
>> +
>> +    while (qemu_get_byte(f)) {
>> +        elm = g_malloc(size);
>> +        ret = vmstate_load_state(f, vmsd, elm, version_id);
>> +        if (ret) {
>> +            error_report("%s: failed to load %s (%d)", field->name,
>> +                         vmsd->name, ret);
>> +            g_free(elm);
>> +            return ret;
>> +        }
>> +        QLIST_RAW_INSERT_TAIL(pv, elm, entry_offset);
> 
> Here we insert at the beggining.
> 
>> +    }
> 
> Here we reverse?
> 
> We move from O(n^2) to O(2n), much better, no?
> As said, except if the lists are normally very short.

Yes I agree with you. I derived the QTAILQ code without much thinking
about perf. Also in my case I expect the list to be short.

But as we want this code to be useful for other cases, I rewrote as you
suggested.

Thank you for your review.

Eric

> 
> 
> The rest of the patch looks ok to me.
> 
> Later, Juan.
> 

