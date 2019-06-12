Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848B9C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D93820896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D93820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCCE-0004SN-Ke
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbBod-0003py-3r
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbBob-0002FE-U4
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:33:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbBob-0001zK-N0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:33:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so8116652wml.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 15:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QfJC6QDlrpiTTjJGcCfP6jz904i+9FIkxt5558dM2uI=;
 b=s+44FzSRTs3dj5OCicuruqZNzE95ufHNAnVW0TCNy9sJRxno0R8/SppAZwEHpHnBwg
 kW+FvIgfobJh+BmTvBKEwqUUk1eKkMQEn4TFgtcxP4AoqGu1un6LJv3sPK0NglmOZuGV
 ug93bSyM+iFad1Ixhp3XWZSLAqSlEg0vgpa3Pb0ClpQWg64tEQkVrG1wksex08zMyhWC
 CFzRs5++8EY78mUaSp7lsuowi8NuDA5xL6TPNAWfgRROkTM42p9OYbqpV2Q0/otQ6Evb
 x8umbRrB4AyqbkqIgzLKfkd4ZfyCkCopc2lh6vzvYKysg5fbsbXUBuRyAI8vz91zR/jb
 53Mw==
X-Gm-Message-State: APjAAAWpuLUsNaOHJgfDxgJ1X9x66X0mv8rtoFriA3Xuk0NB0jd3ZYdI
 zediGx82XMWqC55A1ztZzQoAcg==
X-Google-Smtp-Source: APXvYqwXvxXmS94aOYr4tXrCLHwcp1M7EbOaVorNmeZBez5M7HVcDZL5+XDz7hdj03Fbd89gZSLoyg==
X-Received: by 2002:a1c:968c:: with SMTP id y134mr896883wmd.122.1560378829704; 
 Wed, 12 Jun 2019 15:33:49 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id u23sm851194wmj.33.2019.06.12.15.33.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 15:33:49 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190611171456.23444-1-ehabkost@redhat.com>
 <20190611171456.23444-7-ehabkost@redhat.com>
 <d107483c-eba8-f6fc-8e3a-ad0a86472d07@redhat.com>
 <20190612205242.GQ5927@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1d745328-0fbf-2e05-d066-f721d65be4c4@redhat.com>
Date: Thu, 13 Jun 2019 00:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612205242.GQ5927@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PULL 6/6] travis: Make check-acceptance job more
 verbose
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/19 10:52 PM, Eduardo Habkost wrote:
> On Wed, Jun 12, 2019 at 10:49:18PM +0200, Philippe Mathieu-Daudé wrote:
>> On 6/11/19 7:14 PM, Eduardo Habkost wrote:
>>> It will help us debug issues when tests fail.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  .travis.yml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index b053a836a3..a08a7b7278 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -225,7 +225,7 @@ matrix:
>>>      # Acceptance (Functional) tests
>>>      - env:
>>>          - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>>> -        - TEST_CMD="make check-acceptance"
>>> +        - TEST_CMD="make AVOCADO_SHOW=test check-acceptance"
>>>        addons:
>>>          apt:
>>>            packages:
>>>
>>
>> Cleber, can you help figuring what's wrong here?
>>
>> https://travis-ci.org/qemu/qemu/jobs/544805900
>>
>> The tests seems successfull, is it possible the verbose logging returns
>> error to the shell even if the test succeed?
> 
> That's exactly what this patch does.  On my next pull request I
> will replace this with Cleber's patch that dumps the error log
> only if tests failed.

Ah OK, this is annoying because now all Travis builds are marked as
failed. Maybe Peter can apply your patch directly to master as a build fix?

