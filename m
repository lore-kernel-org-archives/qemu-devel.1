Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB8AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCEB2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsgw+TS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCEB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k31Zh-0007y7-Gb
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 14:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k31YU-0007Uh-0l
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:20:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48305
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k31YR-0007W1-DL
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596565248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=go1TqDzbdwFRRDyocHzk4+xGxnHrqNZP/ZhUo1gsg8I=;
 b=bsgw+TS7+JuClo39yoti9oxohNd1ot2//pfCscKeSrtAYOSGDw2d0a4v8KHDV115LhK6aW
 NOVeWj2qKTez909rLv8DM5md6P2BZeY8adpwmNbRFDqHHr+m6VfRmd1zaBcUzSsMT3w9UA
 fqATFuAqkjO84Q0OlmLTtgNNOKsKQkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-mnbA2dbjOHmHNaCfCv8tuw-1; Tue, 04 Aug 2020 14:20:44 -0400
X-MC-Unique: mnbA2dbjOHmHNaCfCv8tuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75DC410059BA;
 Tue,  4 Aug 2020 18:20:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CE802857F;
 Tue,  4 Aug 2020 18:20:34 +0000 (UTC)
Subject: Re: [PATCH 08/11] stubs/notify-event: Mark qemu_notify_event() stub
 as "weak"
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-9-thuth@redhat.com>
 <1cd4b50f-7195-ac05-cd37-c7681747fbf3@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cecf29fe-f079-ba44-2096-27a049a9647d@redhat.com>
Date: Tue, 4 Aug 2020 20:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1cd4b50f-7195-ac05-cd37-c7681747fbf3@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/2020 19.50, Richard Henderson wrote:
> On 8/4/20 10:00 AM, Thomas Huth wrote:
>> Otherwise there is a linker error with MinGW while compiling the tests:
>>
>>   LINK    tests/test-timed-average.exe
>>  libqemuutil.a(main-loop.o): In function `qemu_notify_event':
>>  /builds/huth/qemu/util/main-loop.c:139: multiple definition of
>>   `qemu_notify_event'
>>  tests/test-timed-average.o:/builds/huth/qemu/tests/../stubs/notify-event.c:5:
>>   first defined here
>>  collect2: error: ld returned 1 exit status
>>  /builds/huth/qemu/rules.mak:124: recipe for target
>>   'tests/test-timed-average.exe' failed
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  stubs/notify-event.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> That doesn't make sense.  Since the symbol is satisfied from main-loop.c, it
> should not be pulled in from libqemuutil.a.
> 
> What's really happening here?

Honestly, I don't have a clue. But since commit ebedb37c8d2aa4775, both
the code from util/ and from stubs/ are put into the same library,
libqemuutil.a, which is causing the trouble here, I guess.
Maybe the linker pulled in the code from the stub first, then some other
part used another function from  util/main-loop.c which caused the
linker to pull in main-loop.o, too, so that it finally found that there
is a clash? ... but that's just a plain guess, of course. Paolo (as
author of commit ebedb37c8d2), do you have an idea what might be going
on here?

 Thomas


