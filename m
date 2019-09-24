Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1571BC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5AB20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5AB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrvn-00025k-LM
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCru1-0001NU-B8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCrtz-0003c1-RD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:59:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCrtz-0003bm-Jp
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8B938980F9;
 Tue, 24 Sep 2019 20:59:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D91260852;
 Tue, 24 Sep 2019 20:59:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 10A9A113864E; Tue, 24 Sep 2019 22:59:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 21/25] qapi: Avoid redundant definition references in
 error messages
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-22-armbru@redhat.com>
 <1e6435a5-b059-ba0a-f881-8c7512560df1@redhat.com>
Date: Tue, 24 Sep 2019 22:59:09 +0200
In-Reply-To: <1e6435a5-b059-ba0a-f881-8c7512560df1@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 13:46:37 -0500")
Message-ID: <87zhit76n6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 24 Sep 2019 20:59:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/24/19 8:28 AM, Markus Armbruster wrote:
>> Many error messages refer to the offending definition even though
>> they're preceded by an "in definition" line.  Rephrase them.
>
> This is the cleanup promised earlier in the series.
>
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py                        | 113 +++++++-----------
>>  tests/qapi-schema/alternate-array.err         |   2 +-
>
>>  def check_command(expr, info):
>> -    name = expr['command']
>>      args = expr.get('data')
>>      boxed = expr.get('boxed', False)
>>  
>>      if boxed and args is None:
>>          raise QAPISemError(info, "'boxed': true requires 'data'")
>> -    check_type(args, info, "'data' for command '%s'" % name,
>> -               allow_dict=not boxed)
>> -    check_type(expr.get('returns'), info,
>> -               "'returns' for command '%s'" % name,
>> -               allow_array=True)
>> +    check_type(expr.get('data'), info, "'data'", allow_dict=not boxed)
>> +    check_type(expr.get('returns'), info, "'returns'", allow_array=True)
>
> Why are you repeating expr.get('dat') here instead of reusing args?  I
> guess it adds consistency with the expr.get('returns') in the next line.

Don't remember, might have been an accident.  If I want consistency, I
guess I should add rets = expr.get('returns').

>>  
>>  
>>  def check_event(expr, info):
>> -    name = expr['event']
>>      args = expr.get('data')
>>      boxed = expr.get('boxed', False)
>>  
>>      if boxed and args is None:
>>          raise QAPISemError(info, "'boxed': true requires 'data'")
>> -    check_type(args, info, "'data' for event '%s'" % name,
>> -               allow_dict=not boxed)
>> +    check_type(expr.get('data'), info, "'data'", allow_dict=not boxed)
> Again, why not reuse args?
>
>
>> +++ b/tests/qapi-schema/args-member-case.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/args-member-case.json: In command 'no-way-this-will-get-whitelisted':
>> -tests/qapi-schema/args-member-case.json:2: member of 'data' for command 'no-way-this-will-get-whitelisted' uses uppercase in name 'Arg'
>> +tests/qapi-schema/args-member-case.json:2: 'data' member 'Arg' uses uppercase in name 'Arg'
>
> Better, but still feels redundant for calling out 'Arg' twice.  Maybe
> you further clean this one later?

check_type()'s error messages interpolate @source received from by
caller.  Need to review all its messages and callers.

>> +++ b/tests/qapi-schema/enum-member-case.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/enum-member-case.json: In enum 'NoWayThisWillGetWhitelisted':
>> -tests/qapi-schema/enum-member-case.json:4: member of enum 'NoWayThisWillGetWhitelisted' uses uppercase in name 'Value'
>> +tests/qapi-schema/enum-member-case.json:4: 'data' member uses uppercase in name 'Value'
>
> Here's a similar error about uppercase that does not have the
> redundancy, for comparison.
>
>
>> +++ b/tests/qapi-schema/union-branch-case.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/union-branch-case.json: In union 'Uni':
>> -tests/qapi-schema/union-branch-case.json:2: member of union 'Uni' uses uppercase in name 'Branch'
>> +tests/qapi-schema/union-branch-case.json:2: 'data' member 'Branch' uses uppercase in name 'Branch'
>
> Another related one.
>
>> +++ b/tests/qapi-schema/union-optional-branch.err
>> @@ -1,2 +1,2 @@
>>  tests/qapi-schema/union-optional-branch.json: In union 'Union':
>> -tests/qapi-schema/union-optional-branch.json:2: member of union 'Union' uses invalid name '*a'
>> +tests/qapi-schema/union-optional-branch.json:2: 'data' member '*a' uses invalid name '*a'
>
> Similar type of redundancy, but this time not related to uppercase.

Same problem, different function: check_name_str().

> Overall an improvement.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

