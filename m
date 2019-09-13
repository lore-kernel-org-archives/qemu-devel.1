Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4AF21479
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4AF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nKh-00072K-7d
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8nJi-0006Zl-7r
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8nJg-0007bF-9R
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:16:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8nJg-0007ah-4J
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:16:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4508793C4;
 Fri, 13 Sep 2019 15:16:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB65A60C44;
 Fri, 13 Sep 2019 15:16:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E590113865F; Fri, 13 Sep 2019 17:16:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-15-armbru@redhat.com>
 <608a5ab7-eed6-6f09-95e2-5c28bdeec158@redhat.com>
Date: Fri, 13 Sep 2019 17:16:50 +0200
In-Reply-To: <608a5ab7-eed6-6f09-95e2-5c28bdeec158@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 11:50:32 -0500")
Message-ID: <87lfus8bvh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 13 Sep 2019 15:16:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 14/16] docs/devel/qapi-code-gen: Rewrite
 introduction to schema
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/10/19 1:37 AM, Markus Armbruster wrote:
>> The introduction to the QAPI schema is somewhat rambling.  Rewrite for
>> clarity.
>
> The curse of additions over time.  Thanks for tackling this.
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/qapi-code-gen.txt | 106 ++++++++++++++++-------------------
>>  1 file changed, 47 insertions(+), 59 deletions(-)
>> 
>
>> +=== Schema syntax ===
>> +
>> +Syntax is loosely based on JSON (http://www.ietf.org/rfc/rfc8259.txt).
>> +Differences:
>> +
>> +* Comments: start with a hash character (#) that is not part of a
>> +  string, and extend to the end of the line.
>> +
>> +* Strings are enclosed in 'single quotes', not "double quotes".
>> +
>> +* Strings are restricted to ASCII.  All control characters must be
>> +  escaped, even DEL.
>
> Or rather, control characters are not permitted.  (May affect the
> earlier 7/16...)

I neglected to update this for v2.  Will change to "Strings are
restricted to printable ASCII, and escape sequences to just '\\'.

>> +
>> +* Numbers are not supported.
>
> Yet. But if we allow default values, it won't be much longer before we
> get there.  (Doesn't affect this patch)
>
>> +
>> +A QAPI schema consists of a series of top-level expressions (JSON
>> +objects).  Their order does not matter.
>
> Does the order of 'include' and/or 'pragma' matter?

Pragma no, because their scope is the complete schema.

Include no, as long as order doesn't matter for anything else.

Hmm, there's one thing that cares for order: generated documentation is
in source order.

Hmm^2, subsection "Documentation comments" doesn't mention doc
generation at all, and we also lack a dsubsection on it under section
"Code generation".

I'll see what I can do for v3.

> Touchups seem minor enough that I trust you, so you can add:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

