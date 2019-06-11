Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D7C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4157820896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4157820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hakAT-0005bv-Nv
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 13:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hak2n-0007Kl-1U
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hajvc-00065v-Dp
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:47:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hajvc-0005vB-6e
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:47:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D5CD6378
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 16:46:56 +0000 (UTC)
Received: from redhat.com (ovpn-117-129.ams2.redhat.com [10.36.117.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A09A05DA99;
 Tue, 11 Jun 2019 16:46:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20190529164819.GL2882@work-vm> (David Alan Gilbert's message of
 "Wed, 29 May 2019 17:48:20 +0100")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-8-quintela@redhat.com>
 <20190529164819.GL2882@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 11 Jun 2019 18:46:51 +0200
Message-ID: <87y328nk78.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 11 Jun 2019 16:46:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/8] multifd: Add zlib compression
 support
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
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  hw/core/qdev-properties.c |  2 +-
>>  migration/migration.c     |  9 ++++++++
>>  migration/migration.h     |  1 +
>>  migration/ram.c           | 47 +++++++++++++++++++++++++++++++++++++++
>>  qapi/migration.json       |  2 +-
>>  tests/migration-test.c    |  6 +++++
>>  6 files changed, 65 insertions(+), 2 deletions(-)
>> 

>>  /* This value needs to be a multiple of qemu_target_page_size() */
>>  #define MULTIFD_PACKET_SIZE (512 * 1024)
>> @@ -663,6 +664,12 @@ typedef struct {
>>      uint64_t num_pages;
>>      /* syncs main thread and channels */
>>      QemuSemaphore sem_sync;
>> +    /* stream for compression */
>> +    z_stream zs;
>> +    /* compressed buffer */
>> +    uint8_t *zbuff;
>> +    /* size of compressed buffer */
>> +    uint32_t zbuff_len;
>
> Does this set need to be in a union or something so that you select
> them for different compression types?

Yeap.  Done.

>
>>  }  MultiFDSendParams;
>>  
>>  typedef struct {
>> @@ -698,6 +705,12 @@ typedef struct {
>>      uint64_t num_pages;
>>      /* syncs main thread and channels */
>>      QemuSemaphore sem_sync;
>> +    /* stream for compression */
>
> de-compression?

Changed.  I think that "compression methods" mean both, but who I am to
discuss with a native speaker O:-)

>>          socket_send_channel_create(multifd_new_send_channel_async, p);
>> +        zs->zalloc = Z_NULL;
>> +        zs->zfree = Z_NULL;
>> +        zs->opaque = Z_NULL;
>> +        if (deflateInit(zs, migrate_compress_level()) != Z_OK) {
>> +            printf("deflate init failed\n");
>> +            return -1;
>> +        }
>> +        /* We will never have more than page_count pages */
>> +        p->zbuff_len = page_count * qemu_target_page_size();
>> +        p->zbuff_len *= 2;
>
> Should the ops gain a 'save_init' and 'load_init' so that you can
> only do this lot if the compression is enabled?

send_setup()/send_cleanup()
recv_setup()/recv_cleanup()

I have tried to be consistent ....

>
>> +        p->zbuff = g_malloc0(p->zbuff_len);
>
> I'd prefer g_try_malloc and do failure given it's not a tiny buffer.

I can change, no problem there.
Changing prototypes to get an Error *.


Thanks, Juan.

