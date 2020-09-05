Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B22C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 12:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D485420757
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 12:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/eIB6/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D485420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEX6y-0000lZ-P9
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 08:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEX5q-0000Cg-2c
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 08:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEX5n-00063C-Rn
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 08:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599308089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fyc/9GNu/RXoGRX5w1TUTUXb9aDsmXlqQ5Tj+/QI9Mc=;
 b=K/eIB6/V04Bm+KoHW0Fdj141Pu9hT2gmx2vlI8K72h67JjlWNjkdnEgDmYjIgD5DBDthfd
 OlO4qJTiP/8OA3yb0uzNyju61AEeTLC+BpMSwKqMo+7P6cz/wdTn7pYJqyQjEEQ6CACFGj
 ENQCROWs1KC8NSf8012ayD1O9X3Jiyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-pqHZTsbBMcGU5YGgA7AQNQ-1; Sat, 05 Sep 2020 08:14:46 -0400
X-MC-Unique: pqHZTsbBMcGU5YGgA7AQNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1F7281F01E;
 Sat,  5 Sep 2020 12:14:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-27.ams2.redhat.com [10.36.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6E0B7C549;
 Sat,  5 Sep 2020 12:14:43 +0000 (UTC)
Subject: Re: [PATCH 2/2] travis.yml: Drop the Python 3.5 and 3.6 builds
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200805184926.15071-1-thuth@redhat.com>
 <2be38eb3-483a-2539-a1e4-2d4e532328cd@redhat.com>
Message-ID: <83f076b3-42fd-5fad-06bd-ba49c382157a@redhat.com>
Date: Sat, 5 Sep 2020 14:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2be38eb3-483a-2539-a1e4-2d4e532328cd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 08:14:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/08/2020 08.54, Thomas Huth wrote:
> On 05/08/2020 20.49, Thomas Huth wrote:
>> Python 3.5 is already the default in Ubuntu Xenial (which we use for
>> most jobs on Travis), and Python 3.6 is the default on Ubuntu Bionic
>> (which we use for the s390x jobs on Travis for example already), so
>> explicitely defining tests for Python 3.5 and 3.6 seems redundant.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .travis.yml | 17 -----------------
>>  1 file changed, 17 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 18290bc51d..b4c603f0ec 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -258,23 +258,6 @@ jobs:
>>          - TEST_CMD=""
>>  
>>  
>> -    # Python builds
>> -    - name: "GCC Python 3.5 (x86_64-softmmu)"
>> -      env:
>> -        - CONFIG="--target-list=x86_64-softmmu"
>> -        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
>> -      language: python
>> -      python: 3.5
>> -
>> -
>> -    - name: "GCC Python 3.6 (x86_64-softmmu)"
>> -      env:
>> -        - CONFIG="--target-list=x86_64-softmmu"
>> -        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
>> -      language: python
>> -      python: 3.6
>> -
>> -
>>      # Using newer GCC with sanitizers
>>      - name: "GCC9 with sanitizers (softmmu)"
>>        addons:
>>
> 
> Ping?

Ping^2 ?

 Thomas


