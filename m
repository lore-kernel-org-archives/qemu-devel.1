Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B3C04AB6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E333C20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E333C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVmZT-0007k1-7B
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 20:35:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hVmYS-0007Df-9f
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hVmYR-0000LX-8q
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:34:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:42176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hVmYR-0000KJ-0O
	for qemu-devel@nongnu.org; Tue, 28 May 2019 20:34:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 May 2019 17:34:53 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga006.jf.intel.com with ESMTP; 28 May 2019 17:34:51 -0700
Date: Wed, 29 May 2019 08:34:22 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190529003422.GB24428@richard>
References: <20190528014703.21030-1-richardw.yang@linux.intel.com>
	<20190528014703.21030-2-richardw.yang@linux.intel.com>
	<87muj780dc.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muj780dc.fsf@trasno.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: multifd_save_setup always
 return 0
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 10:11:11AM +0200, Juan Quintela wrote:
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  migration/migration.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d0a0f68f11..3aae4f2734 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3336,12 +3336,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>          return;
>>      }
>>  
>> -    if (multifd_save_setup() != 0) {
>> -        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>> -                          MIGRATION_STATUS_FAILED);
>> -        migrate_fd_cleanup(s);
>> -        return;
>> -    }
>> +    multifd_save_setup();
>>      qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
>>                         QEMU_THREAD_JOINABLE);
>>      s->migration_thread_running = true;
>
>Nack.
>
>On the compression patches that are on list, multifd_save_setup()
>returns -1 if there is a problem when we allocate a zbuff.

You mean there are some patches in mail list?

-- 
Wei Yang
Help you, Help me

