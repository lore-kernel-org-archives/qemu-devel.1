Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672B120720
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfvf17wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672B120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKYO-0007Xl-K8
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joKXj-00075P-4q
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 01:35:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joKXg-0006s0-0v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 01:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593063317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dr5SKImgbcgI3JxzmYsOhtXhIZ97qnoj39zzg20udnk=;
 b=Dfvf17wAzCsSPUMSdgbwIv0kX24IFE8T980HpgaiVGuNq9Wb2eGlv+YL1ASwREhmejzjRj
 MAQnTW3dV3xhetjMqxfeiaF96gqJsBFS3RzyFZ5HE8RIwf/CMklzeHviksPvVcZs93O5Nj
 gXOCyZiROq7MpKAZS7oEjHfXWYdLFGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-pXIDMI7TMtyNAAbK0XR-0g-1; Thu, 25 Jun 2020 01:35:13 -0400
X-MC-Unique: pXIDMI7TMtyNAAbK0XR-0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D620718585A2;
 Thu, 25 Jun 2020 05:35:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D9685C1D4;
 Thu, 25 Jun 2020 05:35:08 +0000 (UTC)
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200623145506.439100-1-mst@redhat.com>
 <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
 <5d3c4773-5aa2-e80d-68c7-a94eac8a7422@redhat.com>
 <66821238-4da7-ec35-4bb7-6dc46bcbca1d@redhat.com>
 <99caf774-fec0-08e4-3565-228d9a0c688b@redhat.com>
 <e4ba1b70-9bad-05a0-fa4e-6e9a610d4c9c@redhat.com>
 <c0fca999-411b-a097-0513-32c7a5e3ff99@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <58046dcc-0ae7-780c-1b49-e56b3458ea46@redhat.com>
Date: Thu, 25 Jun 2020 07:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c0fca999-411b-a097-0513-32c7a5e3ff99@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 18.26, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 6/24/20 12:21 PM, Philippe Mathieu-Daudé wrote:
>> On 6/24/20 7:04 AM, Thomas Huth wrote:
>>> On 23/06/2020 19.35, Philippe Mathieu-Daudé wrote:
>>>> On 6/23/20 7:07 PM, Thomas Huth wrote:
>>>>> On 23/06/2020 17.39, Philippe Mathieu-Daudé wrote:
>>>>>> On 6/23/20 4:56 PM, Michael S. Tsirkin wrote:
>>>>>>> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
>>>>>>> since that change makes unit tests much slower for all developers, while it's not
>>>>>>> a robust way to fix migration tests. Migration tests need to find
>>>>>>> a more robust way to discover a reasonable bandwidth without slowing
>>>>>>> things down for everyone.
>>>>>>
>>>>>> Please also mention we can do this since 1de8e4c4dcf which allow
>>>>>> marked the s390x job as "unstable" and allow it to fail.
>>>>>>
>>>>>> But if nobody is going to look at it, instead lets disable
>>>>>> it until someone figure out the issue:
>>>>>>
>>>>>> -- >8 --
>>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>>> index 74158f741b..364e67b14b 100644
>>>>>> --- a/.travis.yml
>>>>>> +++ b/.travis.yml
>>>>>> @@ -507,6 +507,7 @@ jobs:
>>>>>>
>>>>>>       - name: "[s390x] Clang (disable-tcg)"
>>>>>>         arch: s390x
>>>>>> +      if: false # Temporarily disabled due to issue testing migration
>>>>>> (see commit 6d1da867e65).
>>>>>>         dist: bionic
>>>>>>         compiler: clang
>>>>>>         addons:
>>>>>
>>>>> Sorry, but that looks wrong. First, the disable-tcg test does not run
>>>>> the qtests at all. So this is certainly the wrong location here.
>>>>
>>>> Indeed, this is the previous job:
>>>>
>>>> -- >8 --
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index 74158f741b..b399e20078 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -464,6 +464,7 @@ jobs:
>>>>           - CONFIG="--disable-containers
>>>> --target-list=ppc64-softmmu,ppc64le-linux-user"
>>>>
>>>>       - name: "[s390x] GCC check-tcg"
>>>> +      if: false # Temporarily disabled due to issue testing migration
>>>> (see commit 6d1da867e65).
>>>>         arch: s390x
>>>>         dist: bionic
>>>>         addons:
>>>> ---
>>>>
>>>>> Second,
>>>>> if just one of the qtests is failing, please only disable that single
>>>>> failing qtest and not the whole test pipeline.
>>>>
>>>> Last time we talked about this Dave was against that option:
>>>>
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg690085.html
>>>>
>>>
>>> Was he? Citing his reply to the mail from your URL:
>>>
>>>   "Before we take the hammer to it, could you try reducing it's initial
>>> bandwidth"
>>>
>>> So all I can see is that he first wanted to try something different than
>>> disabling the test. And now,  instead of using a small hammer to disable
>>> just this test, you now even use a very *big* hammer to disable *all*
>>> tests. That's just a very bad idea. Please don't.
> 
> You asked on IRC the CI failures history:
> 
> https://travis-ci.org/github/philmd/qemu/jobs/663607963
> https://travis-ci.org/github/philmd/qemu/jobs/663622229
> https://travis-ci.org/github/philmd/qemu/jobs/663642522
> 
> "No output has been received in the last 10m0s, this potentially
> indicates a stalled build or something wrong with the build itself."

Ok, but none of these hangs seem to be related to the migration test. I 
assume that's just a generic unreliability of the builder machines, 
which should have been addresses with Alex' patch 1de8e4c4dcf2af8e1 ?

  Thomas


