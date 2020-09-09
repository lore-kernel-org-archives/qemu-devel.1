Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259D6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848D6208FE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZ6iFpY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848D6208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFv0z-0000Lu-Np
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFv0T-0008FT-4n
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:59:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFv0R-0001LG-2J
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599638342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4uSQGdoRsSAiFqoK3F0zPTssl7zRwLzQPfJeFuOw8w=;
 b=CZ6iFpY13WAE4bwGgHEJ9xzqIcno2yJ+y/r5G5jfP5A1I5gunSa5OYE+2ZV08SYzYGw73Z
 kqiKAngI6woOlCgYilz2folAd1SqPbPenE1WgrVXzt0Cs2729mDufN9drRnKxQlZirGfQ5
 7uJGTCuSpgDDjz7MQ3huAnoXzmwtoFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-G1nQvv-KOOymGzNqCt6Ohg-1; Wed, 09 Sep 2020 03:59:00 -0400
X-MC-Unique: G1nQvv-KOOymGzNqCt6Ohg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 153E3800471;
 Wed,  9 Sep 2020 07:58:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 608CC1002D5F;
 Wed,  9 Sep 2020 07:58:57 +0000 (UTC)
Subject: Re: [PATCH] Simplify the .gitignore file
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200907174255.179652-1-thuth@redhat.com>
 <2f1b8cb5-6639-a530-1467-28fb6a89c926@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dfa64d8f-6625-957e-71ab-41a569ea9819@redhat.com>
Date: Wed, 9 Sep 2020 09:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2f1b8cb5-6639-a530-1467-28fb6a89c926@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/2020 14.50, Eric Blake wrote:
> On 9/7/20 12:42 PM, Thomas Huth wrote:
>> Now that we always do out-of-tree builds (and the in-tree builds are
>> faked via a "build" directory), we can simplify out .gitignore file
> 
> s/out/our/
> 
>> quite a bit.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   .gitignore | 158 -----------------------------------------------------
>>   1 file changed, 158 deletions(-)
>>
> 
> I like the idea.  As Phillipe pointed out, there are still a few files
> that may be created by merely running './configure' or common editor
> droppings or workflow setups that are still worth ignoring, but as most
> of these truly no longer appear during a fresh checkout, it makes sense
> to clean it up.
> 
> Someone who still wants to use 'fake in-tree' builds and creates
> symlinks for themselves will no longer have those symlinks ignored by
> this pruned file, but can edit their own .git/info/exclude file to match
> their preferences.
> 
>> diff --git a/.gitignore b/.gitignore
>> index 4ccb9ed975..bb916594eb 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,165 +1,7 @@
>>   /GNUmakefile
>>   /build/
> 
> Our 'fake in-tree' build uses just 'build', but ignoring '/build*/'
> might be wiser to automatically ignore all other variations on the theme
> of a subdirectory per build.

At least I am doing my out-of-tree builds completely outside of the
source tree. I think if someone wants to use directories within the
source tree for this, they can also simply add them to their private
.gitignore / .git/info/exclude file instead, then you're also more
flexible with the naming.

 Thomas


