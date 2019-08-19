Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDAFC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A212082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A212082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzd4K-00051X-VS
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 04:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1hzd30-00043J-PX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hzd2z-000152-My
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hzd2z-00012i-Gv
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:29:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32B4D7F743
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:29:47 +0000 (UTC)
Received: from redhat.com (ovpn-116-68.ams2.redhat.com [10.36.116.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA9D41E1;
 Mon, 19 Aug 2019 08:29:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20190814145800.GM2920@work-vm> (David Alan Gilbert's message of
 "Wed, 14 Aug 2019 15:58:00 +0100")
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-4-quintela@redhat.com>
 <20190814145800.GM2920@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 19 Aug 2019 10:29:44 +0200
Message-ID: <87mug5k16v.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 19 Aug 2019 08:29:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/6] migration: Make sure that all multifd
 channels have been created
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> If we start the migration before all have been created, we have to
>> handle the case that one channel still don't exist.  This way it is
>> easier.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> @@ -3486,6 +3492,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>      ram_control_before_iterate(f, RAM_CONTROL_SETUP);
>>      ram_control_after_iterate(f, RAM_CONTROL_SETUP);
>>  
>> +    /* We want to wait for all threads to have started before doing
>> +     * anything else */
>> +    for (int i = 0; i < migrate_multifd_channels(); i++) {
>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
>> +
>> +        qemu_sem_wait(&p->started);
>> +        trace_multifd_send_thread_started(p->id);
>> +    }
>
> What happens if there's an error during startup and either we cancel or
> the migration fails and we try and cleanup - how do we get out of this
> loop?

Good catch.

Will think a way to do it.

Thanks.


> Dave
>
>>      multifd_send_sync_main();
>>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>>      qemu_fflush(f);
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 886ce70ca0..dd13a5c4b1 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -95,6 +95,7 @@ multifd_send_sync_main_wait(uint8_t id) "channel %d"
>>  multifd_send_terminate_threads(bool error) "error %d"
>>  multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
>>  multifd_send_thread_start(uint8_t id) "%d"
>> +multifd_send_thread_started(uint8_t id) "channel %d"
>>  ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
>>  ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
>>  ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
>> -- 
>> 2.21.0
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

