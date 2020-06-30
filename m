Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE5B206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/l2kE2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE5B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGD3-0003Db-JJ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqGCO-0002oA-J5
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:21:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqGCM-0003is-BB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593523277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WAehMWpPkdwYhky74OJw6magtJ/6dPo0hExUZCz/Hes=;
 b=h/l2kE2a76fq/lZfgg63mpVeskDQn0hzGZ8Qb8mr2NV8VBYuIheYYPWwbzgvhs/nAMHuLN
 Ym+zdAUpTxhKHDDHEYdq1+LPkP3NukHNajveUbj3Kv0Vtvc8Spgr2QWFQyokliIwLkA/DH
 1+chCfbMlYVVYfKQO/+T26m4rCap8Xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-0w1dtS_jMeuQLEAYdPT_PA-1; Tue, 30 Jun 2020 09:20:16 -0400
X-MC-Unique: 0w1dtS_jMeuQLEAYdPT_PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46029108BD09
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 13:20:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-46.ams2.redhat.com [10.36.112.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F03B95D9E7;
 Tue, 30 Jun 2020 13:20:06 +0000 (UTC)
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200623145506.439100-1-mst@redhat.com>
 <20200630090717-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3fefaeb3-0972-2ab4-6e00-aae78357ec3d@redhat.com>
Date: Tue, 30 Jun 2020 15:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200630090717-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/2020 15.07, Michael S. Tsirkin wrote:
> On Tue, Jun 23, 2020 at 10:57:02AM -0400, Michael S. Tsirkin wrote:
>> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
>> since that change makes unit tests much slower for all developers, while it's not
>> a robust way to fix migration tests. Migration tests need to find
>> a more robust way to discover a reasonable bandwidth without slowing
>> things down for everyone.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> What's the conclusion here? Should I merge this?

Fine for me (from the s390x side). The test should not run with TCG in 
the CI for s390x ... if it still does, we have to have another closer 
look at the check there instead.

  Thomas


> 
>> ---
>>   tests/qtest/migration-test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index dc3490c9fa..21ea5ba1d2 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>>        * without throttling.
>>        */
>>       migrate_set_parameter_int(from, "downtime-limit", 1);
>> -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
>> +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
>>   
>>       /* To check remaining size after precopy */
>>       migrate_set_capability(from, "pause-before-switchover", true);
>> -- 
>> MST
> 
> 


