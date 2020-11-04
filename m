Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21DBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D609F22277
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCDaD/Rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D609F22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaCBE-0006yq-QV
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 01:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaCAd-0006Zc-HH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 01:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaCAc-0000ZI-1F
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 01:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604470881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCcTM3XW1gZx4JJqlX3rAt8CbcbfFKZsYeLnd0L+hdU=;
 b=gCDaD/Rc8cylPcXhYYOJDvaNkvAOsb2uvpxEmdc1Ne4Wmyqw8R6D0VHocgYT0bBWnYeIrn
 8tFwzLxxw25ncfCAF8jbTsrHBgMWyOzccRqum+w9lOp8U0Dncm2/HadwAturJ2W1vUgS4s
 RFprMCmvyPWfjxvkiViofKv4qi7Wv5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461--sPfsZwhOcmbLEa97tlW1A-1; Wed, 04 Nov 2020 01:21:19 -0500
X-MC-Unique: -sPfsZwhOcmbLEa97tlW1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F02910E2181;
 Wed,  4 Nov 2020 06:21:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD4360E1C;
 Wed,  4 Nov 2020 06:21:09 +0000 (UTC)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <70b50ba2-f0e8-4cf7-b5ff-14178e03d595@redhat.com>
 <01ec47fa-4e0d-1be9-e4e6-312b9d810d74@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8f79c67c-3851-06a3-8646-403041a793c5@redhat.com>
Date: Wed, 4 Nov 2020 07:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <01ec47fa-4e0d-1be9-e4e6-312b9d810d74@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/2020 21.41, Philippe Mathieu-Daudé wrote:
> On 11/3/20 7:43 PM, Thomas Huth wrote:
>> On 03/11/2020 17.46, Philippe Mathieu-Daudé wrote:
[...]
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index 3b15ae5c302..6ee098ec53c 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -262,6 +262,17 @@ build-user-plugins:
>>>      MAKE_CHECK_ARGS: check-tcg
>>>    timeout: 1h 30m
>>>  
>>> +build-system-ubuntu-without-default-devices:
>>> +  <<: *native_build_job_definition
>>> +  variables:
>>> +    IMAGE: ubuntu2004
>>> +    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-xen --disable-tools --disable-docs
>>> +    MAKE_CHECK_ARGS: check-build
>>
>> AFAIK "check-build" is pretty much a no-op since the convertion to meson ...
>> could you maybe replace with a set of qtest targets that work, to make sure
>> that we do not regress here? E.g.:
>>
>> MAKE_CHECK_ARGS: check-qtest-avr check-qtestcris check-qtest-m68k
>> check-qtest-microblaze check-qtest-mipsel check-qtest-moxie ...
> 
> qtests don't work with --without-default-devices, as we don't check
> for (un-)available devices.

Sure, "make check-qtest" does not work, I know. But some targets work fine,
e.g. "make check-qtest-avr", and that's what I've suggested. By testing
those targets, we can make sure that the qtests don't regress any further
with --without-default-devices.

> I'll try check-unit.

I think that does not have much benefit since it should be independent of
the devices and is tested in the other pipelines already?

 Thomas


