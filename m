Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A14C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489F020772
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkYN8IUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489F020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUgi-00065R-Iq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgUfr-0004vF-BO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:47:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgUfq-0007ju-2E
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QtcHo1ZEzCmeYGP8qf1ZmMmL1maQ/30XDoUkBSwX7zM=;
 b=VkYN8IUDGB1utk0UMPKfIOW7uWd5brBhdmfNfXQ+KkBvzctYIG4T4xgXHet9GHhKe8dSnL
 A/KnZkN9u8o4QNwzGC2FzQcfOQoxM0WIdaXd6OEc1IWlGQvmymuUsHnZHHwoFrr28/35je
 wScqsJdlxoa4Mf2iOEmZbwUYICTkI3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-Fw2KFJZON8CIgmWRSg39uA-1; Wed, 03 Jun 2020 10:47:05 -0400
X-MC-Unique: Fw2KFJZON8CIgmWRSg39uA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3B6835BB9;
 Wed,  3 Jun 2020 14:47:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 837EB1001925;
 Wed,  3 Jun 2020 14:46:56 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] fuzz: Skip QTest serialization
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200529221450.26673-1-alxndr@bu.edu> <m2v9k9wqae.fsf@oracle.com>
 <20200602134050.k7s6wjwlzxarrc72@mozz.bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d512f0e3-3a1c-f6de-9969-684d39e7fc39@redhat.com>
Date: Wed, 3 Jun 2020 16:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200602134050.k7s6wjwlzxarrc72@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Darren Kenny <darren.kenny@oracle.com>, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/06/2020 15.40, Alexander Bulekov wrote:
> Thank you Darren.
> 
> On 200602 1428, Darren Kenny wrote:
>>
>> Hi Alex,
>>
>> In general the series looks good, so:
>>
>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>>
>> But not sure how to handle the patchew output though, not sure if it is
>> really a concern or not, since do/while won't work that context.
>>
> 
> Yes - I was not really sure how to deal with those failures, so I sent
> the patch anyway. Maybe someone else knows a workaround.
> -Alex

Don't worry, the checkpatch script is known to generate false
warnings/errors in some cases. If you've got such a case, simply state
it as a reply to the mail from patchew, and then the message from
patchew can be simply ignored.

By the way, I'm finally back to the state where I can pick up qtest
patches again (btw2, thanks for Stefan for picking up all the fuzzer
patches in the past months). So question: With your two patches here,
the patch from Philippe is not required anymore, right?

 Thanks,
  Thomas


>> On Friday, 2020-05-29 at 18:14:48 -04, Alexander Bulekov wrote:
>>> In the same vein as Philippe's patch:
>>>
>>> https://patchew.org/QEMU/20200528165303.1877-1-f4bug@amsat.org/
>>>
>>> This uses linker trickery to wrap calls to libqtest functions and
>>> directly call the corresponding read/write functions, rather than
>>> relying on the ASCII-serialized QTest protocol.
>>>
>>> v2: applies properly
>>>
>>> v3: add missing qtest_wrappers.c file and fix formatting in fuzz.c
>>>
>>> Alexander Bulekov (2):
>>>   fuzz: skip QTest serialization
>>>   fuzz: Add support for logging QTest commands
>>>
>>>  tests/qtest/fuzz/Makefile.include |  21 +++
>>>  tests/qtest/fuzz/fuzz.c           |  20 ++-
>>>  tests/qtest/fuzz/fuzz.h           |   3 +
>>>  tests/qtest/fuzz/qtest_wrappers.c | 252 ++++++++++++++++++++++++++++++
>>>  4 files changed, 295 insertions(+), 1 deletion(-)
>>>  create mode 100644 tests/qtest/fuzz/qtest_wrappers.c
>>>
>>> -- 
>>> 2.26.2
> 


