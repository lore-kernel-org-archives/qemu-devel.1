Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E2C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194B820838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d637y/je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194B820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00XT-0006V3-9P
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1j00WV-0005H3-SE
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1j00WU-0002uR-Eu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:06:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58623
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1j00WU-0002se-9W
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581069965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=k+4cGtgl7jGJC27n3G+jLfGut+cDsEX571E6Li8feiM=;
 b=d637y/jebIUVR8g5wLzgBhdtS0qgyU8zNRbWEqKrMTTxEXJG1loIj30VdS2fqU9HSv/idG
 EMyulEdtiuyDFfdUsuuvMBZYOS7RudcZwhe1OIFfuL5w2fq+xyEUz+8sm0YP+8eT3vsdyo
 4F5izuD3J/ZNV4qG0+2QkXTcp2iozXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-A127C-_oM6OnaGKbQVBj8Q-1; Fri, 07 Feb 2020 05:05:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 933E0800D5C;
 Fri,  7 Feb 2020 10:05:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-143.ams2.redhat.com [10.36.116.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D6715C545;
 Fri,  7 Feb 2020 10:05:54 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
From: Thomas Huth <thuth@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7d45bde8-21bf-387d-bcd6-544373b327ce@redhat.com>
Date: Fri, 7 Feb 2020 11:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: A127C-_oM6OnaGKbQVBj8Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/2020 09.37, Thomas Huth wrote:
> On 03/02/2020 04.23, Cleber Rosa wrote:
>> This is a crude and straightforward mapping of Peter's
>> "remake-merge-builds" and "pull-buildtest" scripts.
>>
>> Some characteristics were removed for simplicity sake (but eventually
>> will), including:
>>  * number of simultaneous make jobs
>>  * make's synchronous output, not needed because of previous point
>>  * out-of-tree builds
>>
>> This covers the "x86-64 Linux with a variety of different build
>> configs"[1].  I've personally tested all of them, and only had
>> issues with the "notcg" job[2], but it seems to be a test specific
>> issue with the nested KVM I was using.
>>
>> [1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
>> [2] - https://paste.centos.org/view/1dd43a1c
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 116 insertions(+)
> 
> Thanks for doing this! The patch looks basically fine to me, but some
> comments below...
> 
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index d2c7d2198e..eb4077e2ab 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -2,6 +2,8 @@ include:
>>    - local: '/.gitlab-ci-edk2.yml'
>>  
>>  build-system1:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>>   before_script: &before_scr_apt
>>   - apt-get update -qq
>>   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev genisoimage
>> @@ -17,6 +19,8 @@ build-system1:
>>   - make -j2 check
>>  
>>  build-system2:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>>   before_script:
>>    *before_scr_apt
>>   script:
>> @@ -31,6 +35,8 @@ build-system2:
>>   - make -j2 check
>>  
>>  build-disabled:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>>   before_script:
>>    *before_scr_apt
>>   script:
>> @@ -47,6 +53,8 @@ build-disabled:
>>   - make -j2 check-qtest SPEED=slow
>>  
>>  build-tcg-disabled:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>>   before_script:
>>    *before_scr_apt
>>   script:
>> @@ -67,6 +75,8 @@ build-tcg-disabled:
>>              248 250 254 255 256
>>  
>>  build-user:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>>   before_script:
>>    *before_scr_apt
>>   script:
>> @@ -78,6 +88,8 @@ build-user:
>>   - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
>>  
>>  build-clang:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>>   before_script:
>>    *before_scr_apt
>>   script:
>> @@ -92,6 +104,8 @@ build-clang:
>>   - make -j2 check
>>  
>>  build-tci:
>> + rules:
>> + - if: '$CI_COMMIT_REF_NAME != "staging"'
>>   before_script:
>>    *before_scr_apt
>>   script:
> 
> Question to Peter/Alex/Stefan/Howevermergespullreqsinthefuture:
> 
> Should the above jobs really be skipped for pull requests, or would it
> be ok to include them there, too? (in the latter case, the above changes
> could just be dropped)

At least most of the hunks could be dropped - we should likely keep the
one for the job that runs additional iotests (i.e.
"build-tcg-disabled"), since the block layers folks don't want to see
additional iotests as a blocker for pull requests (we've had a lengthy
discussion about this last summer...)

>> +
>> +ubuntu-18.04.3-x86_64-notcg:
[...]
>> Question for Peter: Would it be ok to drop this job and simply always
>> use the "build-tcg-disabled" job that is already available in
>> .gitlab-ci.yml ?

If we do not run "build-tcg-disabled" for PRs, then this job should not
be dropped, of course.

 Thomas


