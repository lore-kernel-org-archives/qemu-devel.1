Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FFBC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8546B22273
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFTTFaLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8546B22273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXXK-0001Sv-D0
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIXVp-0000E2-0k
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:30:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIXVn-00059E-1H
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600263013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVXSwwNnEOJ6PYMIHkBWnIuDw/24xBZcjo+F53VZf+Q=;
 b=JFTTFaLy4UubqXgb2xB8cwsxUCFtwLqTyxy73EZljpxeFChmjtisHZjvF8jUt1sitPzA7b
 3EkIOl+8Vk8CZTBlmaUlf7ppD11EU9UQL4KSsy7JwRNi7QPRgws71C2elgIxUeWGrjCtU9
 UITU3PSqwvAzfql0hLOkQOhmBBj06q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-MOoisktWNGuXVxAyJ5qfOw-1; Wed, 16 Sep 2020 09:30:12 -0400
X-MC-Unique: MOoisktWNGuXVxAyJ5qfOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE4F180B71A;
 Wed, 16 Sep 2020 13:30:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C07AD67CEF;
 Wed, 16 Sep 2020 13:30:09 +0000 (UTC)
Subject: Re: [RFC PATCH] travis.yml: Drop the default softmmu builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200805185403.15227-1-thuth@redhat.com>
 <c1927c74-da26-a17d-e92e-1e052540733f@redhat.com>
 <dcf9c72a-069a-d853-594c-64a3a9187358@redhat.com> <87lfh9zwim.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7a19d97-391b-46d7-65c4-9fb17e321e64@redhat.com>
Date: Wed, 16 Sep 2020 15:30:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87lfh9zwim.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/2020 15.22, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 05/09/2020 14.15, Thomas Huth wrote:
>>> On 05/08/2020 20.54, Thomas Huth wrote:
>>>> The total runtime of all Travis jobs is very long and we are testing
>>>> all softmmu targets in the gitlab-CI already - so we can speed up the
>>>> Travis testing a little bit by not testing the softmmu targets here
>>>> anymore.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  Well, ok, we do not test all the softmmu targets on gitlab-CI with
>>>>  that same ancient version of Ubuntu ... but do we still care about
>>>>  testing all softmmut targets on Ubuntu Xenial at all? ... at least
>>>>  according to our support policy, we do not care about Xenial anymore.
>>>>
>>>>  .travis.yml | 14 --------------
>>>>  1 file changed, 14 deletions(-)
>>>>
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index 6695c0620f..18290bc51d 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -123,20 +123,6 @@ jobs:
>>>>          - CONFIG="--disable-system --static"
>>>>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
>>>>  
>>>> -
>>>> -    # we split the system builds as it takes a while to build them all
>>>> -    - name: "GCC (main-softmmu)"
>>>> -      env:
>>>> -        - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
>>>> -        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
>>>> -
>>>> -
>>>> -    - name: "GCC (other-softmmu)"
>>>> -      env:
>>>> -       - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
>>>> -        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
>>>> -
>>>> -
>>>>      # Just build tools and run minimal unit and softfloat checks
>>>>      - name: "GCC check-softfloat (user)"
>>>>        env:
>>>>
>>>
>>> Ping?
>>
>> Ping^2 ... Alex, Philippe, any opinions on this patch?
> 
> I'm agnostic on this. Is it worth slightly reducing our coverage for ~50
> minutes of runtime out of 10 hours? I guess it would be a bit greener.

For the last Travis run that succeeded for me, I've got:

 Ran for 1 hr 48 min 32 sec
 Total time 7 hrs 58 min 6 sec

That means the total run time was less than 2h, it's just the total
summed up time of all jobs that is ~8h.

Since both Gitlab und Cirrus jobs finish within one hour, it would be
very convenient to have Travis also finish within one hour, so once
you've pushed your branches to gitlab and github, you could be sure to
get an answer from these three CI systems within 1 hour.

> Acked-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

  Thomas


