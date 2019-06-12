Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF20FC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BCD2086A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BCD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haylO-0000jS-GY
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55711)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hayh5-0007iD-8N
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hayh1-0001o0-1H
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1haygz-0001ml-68
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:33:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5C387DD03
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 08:33:06 +0000 (UTC)
Received: from redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D7B0600CC;
 Wed, 12 Jun 2019 08:33:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20190529171552.GM2882@work-vm> (David Alan Gilbert's message of
 "Wed, 29 May 2019 18:15:53 +0100")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-9-quintela@redhat.com>
 <20190529171552.GM2882@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 12 Jun 2019 10:33:03 +0200
Message-ID: <877e9rnqyo.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 08:33:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 8/8] multifd: rest of zlib compression
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> This is still a work in progress, but get everything sent as expected
>> and it is faster than the code that is already there.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 104 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index fdb5bf07a5..efbb253c1a 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -747,6 +747,100 @@ MultifdMethods multifd_none_ops = {
>>      .recv_pages = none_recv_pages
>>  };
>>  
>> +/* Multifd zlib compression */
>> +
>
> Comment the return value?

Once there, commented all the functions.

>> +static int zlib_send_prepare(MultiFDSendParams *p, uint32_t used)
>> +{
>> +    struct iovec *iov = p->pages->iov;
>> +    z_stream *zs = &p->zs;
>> +    uint32_t out_size = 0;
>> +    int ret;
>> +    int i;
>
> uint32_t to match 'used' ?

Done

>> +    for (i = 0; i < used; i++) {
>> +        uint32_t available = p->zbuff_len - out_size;
>> +        int flush = Z_NO_FLUSH;
>> +
>> +        if (i == used  - 1) {
>> +            flush = Z_SYNC_FLUSH;
>> +        }
>> +
>> +        zs->avail_in = iov[i].iov_len;
>> +        zs->next_in = iov[i].iov_base;
>> +
>> +        zs->avail_out = available;
>> +        zs->next_out = p->zbuff + out_size;
>> +
>> +        ret = deflate(zs, flush);
>> +        if (ret != Z_OK) {
>> +            printf("problem with deflate? %d\n", ret);
>
> If it's an error it should probably be at least an fprintf(stderr or
> err_ something.

We don't have any error arround really, we need one. Searching for it.

> Should this also check that the avail_in/next_in has consumed the whole
> of the input?

I am not checking because _it_ is supposed to b doing it right.  We can
test it through, specially in reception.

>> +            qemu_mutex_unlock(&p->mutex);
>
> Can you explain and/or comment whyit's unlocked here in the error path?

Uh, oh ....

Leftover for when it was done inline inside the main function.
Removed.

>> +            return -1;
>> +        }
>> +        out_size += available - zs->avail_out;
>> +    }
>> +    p->next_packet_size = out_size;
>
> Some traces_ wouldn't hurt.

Humm, you are right here.

Thanks, Juan.

