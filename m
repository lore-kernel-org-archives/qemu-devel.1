Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36170C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFDC2086D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFDC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hakIp-00065q-Al
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 13:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hak38-0008EI-2F
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hak36-0005B1-9W
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hak36-0005AG-11
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:55:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93DFC85538;
 Tue, 11 Jun 2019 16:54:52 +0000 (UTC)
Received: from redhat.com (ovpn-117-129.ams2.redhat.com [10.36.117.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EA3B60BF1;
 Tue, 11 Jun 2019 16:54:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <20190521031110.GB24543@richard> (Wei Yang's message of "Tue, 21
 May 2019 11:11:10 +0800")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-9-quintela@redhat.com>
 <20190521031110.GB24543@richard>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 11 Jun 2019 18:54:49 +0200
Message-ID: <87ftognjty.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 16:54:54 +0000 (UTC)
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> On Wed, May 15, 2019 at 02:15:44PM +0200, Juan Quintela wrote:
>>This is still a work in progress, but get everything sent as expected
>>and it is faster than the code that is already there.
>
> Generally, I prefer to merge this one with previous one.

Done, sir O:-)

For the WIP part, it was easier to have the bits that didn't change and
the ones that I was working with.

>>@@ -1145,7 +1239,11 @@ static void *multifd_send_thread(void *opaque)
>>     /* initial packet */
>>     p->num_packets = 1;
>> 
>>-    multifd_send_state->ops = &multifd_none_ops;
>>+    if (migrate_use_multifd_zlib()) {
>>+        multifd_send_state->ops = &multifd_zlib_ops;
>>+    } else {
>>+        multifd_send_state->ops = &multifd_none_ops;
>>+    }
>
> Again, to manipulate a global variable in each thread is not a good idea.

Fixed.

> This would be better to use an array to assign ops instead of *if*. In case
> you would have several compress methods, the code would be difficult to read.

it is going to end:

   if (migrate_use_multifd_zlib()) {
       multifd_send_state->ops = &multifd_zlib_ops;
   if (migrate_use_multifd_zstd()) {
       multifd_send_state->ops = &multifd_zstd_ops;
   } else {
       multifd_send_state->ops = &multifd_none_ops;
   }

We can use:

multifd_send_state->ops = multifd_ops[migrate_multifd_method(void)];

About what is easier to read .....  it depends on taste.

Will change anyways.

Thanks, Juan.

