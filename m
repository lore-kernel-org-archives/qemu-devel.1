Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE4BC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5FC217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5FC217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKMPF-00044l-65
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 08:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iKMOa-0003c7-0K
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iKMOY-0000F3-W5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iKMOY-0000Eo-Ql
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:57:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00937BB9C2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 12:57:46 +0000 (UTC)
Received: from redhat.com (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB71060C80;
 Tue, 15 Oct 2019 12:57:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/2] migration: Boost SaveStateEntry.instance_id to 64 bits
In-Reply-To: <20191015085705.GB3073@work-vm> (David Alan Gilbert's message of
 "Tue, 15 Oct 2019 09:57:05 +0100")
References: <20191015075444.10955-1-peterx@redhat.com>
 <20191015075444.10955-2-peterx@redhat.com> <87lftmqtvi.fsf@trasno.org>
 <20191015085705.GB3073@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 15 Oct 2019 14:57:40 +0200
Message-ID: <87h84aqi7v.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 15 Oct 2019 12:57:46 +0000 (UTC)
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
Reply-To: quintela@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > It was "int" and used as 32bits fields (see save_section_header()).
>> > It's unsafe already because sizeof(int) could be 2 on i386, I think.
>> > So at least uint32_t would suite more.  While it also uses "-1" as a
>> > placeholder of "we want to generate the instance ID automatically".
>> > Hence a more proper value should be int64_t.
>> >
>> > This will start to be useful after next patch in which we can start to
>> > convert a real uint32_t value as instance ID.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> 
>> Hi
>> 
>> Being more helpful,  I think that it is better to just:
>> 
>> * change instance_id to be an uint32_t (notice that for all architectures
>>   that we support, it is actually int32_t).
>> 
>> * export calculate_new_instance_id() and adjust callers that use -1.
>> 
>> or
>> 
>> * export a new function that just use the calculate_new_instance_id()
>
> Do you mean that we end up with two functions, one that does it
> automatically, and one that takes an ID?

That is one option.

The other is that we export calculate_new_instance_id(), and we use that
instead of -1.

Later, Juan.

