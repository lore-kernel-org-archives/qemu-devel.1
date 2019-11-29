Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A03C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32A121781
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPkvUIVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32A121781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabpq-0000Ce-1i
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iabLj-0000uV-6Z
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iabLb-00076o-U4
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:09:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iabLN-0006v3-2K
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575014973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=i6mODMKzHLcFZc7atK8pZ0aym6OtQ3BRKt0+fWq/cLw=;
 b=TPkvUIVQ/mgqHpfv7BN7o04t6tHWs+j8oaNcnKC4o1tJEYWj9QzalW+Ny50DHWqvVQjipo
 oVV6QH8FvTjhk29n2aTVZEN0CQrP90+DOxeuDllQ6/kRuMCAUYoc/OjTv3ccbkzht8/5An
 cqXE9/AaDPpGjqsiJtyCatnTnnRndyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-kKkep36ZMFCeLApah1V2xw-1; Fri, 29 Nov 2019 03:09:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91DC9800D54;
 Fri, 29 Nov 2019 08:09:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C0660901;
 Fri, 29 Nov 2019 08:09:25 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] travis.yml: Run tcg tests with tci
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191128153525.2646-1-thuth@redhat.com>
 <20191128153525.2646-3-thuth@redhat.com>
 <672f7c1a-71d6-5dfa-101a-ed3070be0b05@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <81dcaadd-8941-a192-bb15-5791f0d8e17b@redhat.com>
Date: Fri, 29 Nov 2019 09:09:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <672f7c1a-71d6-5dfa-101a-ed3070be0b05@weilnetz.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: kKkep36ZMFCeLApah1V2xw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/2019 22.06, Stefan Weil wrote:
> Am 28.11.19 um 16:35 schrieb Thomas Huth:
> 
>> So far we only have compile coverage for tci. But since commit
>> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
>> for INDEX_op_ld16u_i64") has been included now, we can also run the
>> "tcg" and "qtest" tests with tci, so let's enable them in Travis now.
>> Since we don't gain much additional test coverage by compiling all
>> targets, and TCI is broken e.g. with the Sparc targets, we also limit
> 
> 
> As far as I know it is broken with Sparc hosts (not Sparc targets).

It was definitely hanging with sparc64-softmmu:

 https://travis-ci.com/huth/qemu/jobs/261335163

... but since you've mentioned that it should work with the 32-bit
sparc-softmmu, I'll give it another try with sparc-softmmu.

>> the target list to a reasonable subset now (which should still get
>> us test coverage by tests/boot-serial-test for example).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .travis.yml | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index c09b6a0014..de7559e777 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -215,10 +215,11 @@ matrix:
>>          - TEST_CMD=""
>>  
>>  
>> -    # We manually include builds which we disable "make check" for
>> +    # Check the TCG interpreter (TCI)
>>      - env:
>> -        - CONFIG="--enable-debug --enable-tcg-interpreter"
>> -        - TEST_CMD=""
>> +        - CONFIG="--enable-debug --enable-tcg-interpreter --disable-containers
> 
> 
> You could also --disable-kvm. It should not be needed, and disabling it
> might need less build resources.

Good idea. KVM is not usable by default in Travis, so we should not
accidentally use it for the tests that specify "accel=kvm:tcg", but in
case that changes with a future version of the environment, we should
maybe be prepared.

>> +            --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
>> +        - TEST_CMD="make check-qtest check-tcg V=1"
>>  
>>  
>>      # We don't need to exercise every backend with every front-end
> 
> 
> Thank you for adding these tests.
> 
> Tested-by: Stefan Weil <sw@weilnetz.de>

 Thanks,
  Thomas


