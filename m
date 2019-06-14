Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AD7C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9068B21473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9068B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrPT-0006y1-Sm
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hbq5c-0001rH-W4
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hbq5a-0000Yn-JI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:34:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hbq5a-0000Mx-E9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DAAF308FBA0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:33:37 +0000 (UTC)
Received: from redhat.com (ovpn-116-92.ams2.redhat.com [10.36.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C365460CA3;
 Fri, 14 Jun 2019 17:33:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20190614112636.GC2785@work-vm> (David Alan Gilbert's message of
 "Fri, 14 Jun 2019 12:26:36 +0100")
References: <20190612105323.7051-1-quintela@redhat.com>
 <20190612105323.7051-6-quintela@redhat.com>
 <20190614112636.GC2785@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 14 Jun 2019 19:33:34 +0200
Message-ID: <87k1dof4wh.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 14 Jun 2019 17:33:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 5/6] migration: Make no compression
 operations into its own structure
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
>> It will be used later.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> + */
>> +static int nocomp_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **errp)
>> +{
>> +    if (p->flags != 0) {
>> +        error_setg(errp, "multifd %d: flags received %x flags expected %x",
>> +                   p->id, MULTIFD_FLAG_ZLIB, p->flags);
>
> Can you just explain that a bit - the 'received' seems to be constant
> while the expected is p->flags - is that the right way around?
> Why would you expect FLAG_ZLIB in nocomp?

When I changed printf's to error_setg I did a bit *too much* of copy
paste.  Then I decided to put consistently received/expected in all
messages and clearly I failed.

Fixing, Thanks.

