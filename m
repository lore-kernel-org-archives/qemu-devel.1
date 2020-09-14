Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65EA21548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD0XYTqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65EA21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHioo-00081K-NW
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHimY-0004JT-24
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:20:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHimV-0002I4-1k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600068006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4sn5oseDgw7B3Rd8G5MywchzL7bQboy8dnich6G/0M=;
 b=LD0XYTqM7Koy93bGIvHZNgrBuFlTCcNsjaJ4C6e+4UOnCnjwkOQfrlsTklDwoe1K6BxoUH
 kvaelUHctD7BUDGLKcGp96qZsTu8Dm2WIxN/kHLTVHjsW2nrG+Zczb7PT/tK8otZx8ymSQ
 jRr0H4SuxtGiQ+PbaiCZxoJA72hitBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-cnTvTJT8PA29XXtRxYOmww-1; Mon, 14 Sep 2020 03:20:04 -0400
X-MC-Unique: cnTvTJT8PA29XXtRxYOmww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E29A5800683
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:20:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7689A60CD1;
 Mon, 14 Sep 2020 07:20:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EBD56113865F; Mon, 14 Sep 2020 09:20:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/qmp-cmd-test: Use inclusive language
References: <20200912074922.26103-1-thuth@redhat.com>
 <81133ec5-e147-f71c-addd-9e71977ee35a@redhat.com>
Date: Mon, 14 Sep 2020 09:20:01 +0200
In-Reply-To: <81133ec5-e147-f71c-addd-9e71977ee35a@redhat.com> (Paolo
 Bonzini's message of "Sat, 12 Sep 2020 10:36:46 +0200")
Message-ID: <87mu1s4yfy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/09/20 09:49, Thomas Huth wrote:
>> We simply want to ignore certain queries here, so let's rather
>> use the term 'ignore' to express this intention.
>> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qtest/qmp-cmd-test.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
>> index 3109a9fe96..18069a82fa 100644
>> --- a/tests/qtest/qmp-cmd-test.c
>> +++ b/tests/qtest/qmp-cmd-test.c
>> @@ -82,9 +82,9 @@ static void test_query(const void *data)
>>      qtest_quit(qts);
>>  }
>>  
>> -static bool query_is_blacklisted(const char *cmd)
>> +static bool ignore_query(const char *cmd)

Okay, although I'd prefer query_is_ignored(), to signal "this is a
predicate", whereas ignore_query() suggests the function ignores
queries.

>>  {
>> -    const char *blacklist[] = {
>> +    const char *ignorelist[] = {
>
> Just "ignored", it's obviously a list.

Yes, that's better.

"blacklist" contains "list" not because "list" is important, but because
it's an actual word that makes the variable's purpose immediately
obvious.  "ignored" is an acceptable replacement, and is less clumsy
than "ignorelist".

>
> Paolo
>
>>          /* Not actually queries: */
>>          "add-fd",
>>          /* Success depends on target arch: */
>> @@ -101,8 +101,8 @@ static bool query_is_blacklisted(const char *cmd)
>>      };
>>      int i;
>>  
>> -    for (i = 0; blacklist[i]; i++) {
>> -        if (!strcmp(cmd, blacklist[i])) {
>> +    for (i = 0; ignorelist[i]; i++) {
>> +        if (!strcmp(cmd, ignorelist[i])) {
>>              return true;
>>          }
>>      }
>> @@ -179,7 +179,7 @@ static void add_query_tests(QmpSchema *schema)
>>              continue;
>>          }
>>  
>> -        if (query_is_blacklisted(si->name)) {
>> +        if (ignore_query(si->name)) {
>>              continue;
>>          }
>>  
>> 


