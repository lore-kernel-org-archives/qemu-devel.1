Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B86C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300FD20644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300FD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsS5j-0001TE-G4
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsS4n-0000bc-Vr
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsS4l-0005gM-M0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:22:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsS4l-0005g7-GJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:21:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so46275009wmc.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 06:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=11knbtKg9D7lDyZ7djLFNUWHlMTQpJi4rNSlbSzTtJg=;
 b=F/VhMZQaK3sia4otzxiWarY1j8CFskzcehGqVMr5CogLNzCqlm7uCC3YUihTMYC5wZ
 +4INKPXGnHDFU2iO5v0p9w4L+d6wscR7q3ye/OC8Fh/es6UuhB2rNes+OnuEf0S9LZl6
 ajg+seRVz5fTfvCT8z4XF3ugWOK79BPlpMIsaZhiU7SN1ERf/2LQfE0kuhLJCv+lWvdP
 GJyf/br9Dxe14kMAOnpubkJmsSBGtc7hQmS/iVXU0TODtxlcEtYvJXUACBvZj7dIN2c8
 2FCYcoUDaPolT+eoYkWnV2WIVJWhLM39RU08FKverNS8yB+mnAfErbqHhXxBruj1wsfS
 wWoA==
X-Gm-Message-State: APjAAAX21l2ZofHEsaFFxxe4yTe8QN1tWxFO/1RMOYACTIPjp+wZdxYc
 IqE3YlskE2i0CNjIh5wQROiwzw==
X-Google-Smtp-Source: APXvYqxR+xVoVkXWJcO3OUc6+9aZe3RuVy28OxFqyXwOvbJ4F6yrBo10CPngGWlYAL+iSd4xQW/ykQ==
X-Received: by 2002:a1c:c005:: with SMTP id q5mr64778879wmf.59.1564492918295; 
 Tue, 30 Jul 2019 06:21:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id q193sm50148358wme.8.2019.07.30.06.21.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 06:21:57 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <20190730123759.21723-3-pbonzini@redhat.com>
 <ed8416f5-852c-872c-eb05-8850a6aa216d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <033bdaf4-c620-6cf0-f406-c622303c9fd5@redhat.com>
Date: Tue, 30 Jul 2019 15:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ed8416f5-852c-872c-eb05-8850a6aa216d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/tcg: cleanup Makefile inclusions
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/19 14:44, Philippe Mathieu-Daudé wrote:
> On 7/30/19 2:37 PM, Paolo Bonzini wrote:
> [...]
>> Drop the usage of TARGET_BASE_ARCH, which is ignored by everything except
>> x86_64 and aarch64.  Fix x86 tests by using -cpu max and, while
>> at it, standardize on QEMU_OPTS for aarch64 tests too.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> [...]
>> --- a/tests/tcg/Makefile.include
>> +++ b/tests/tcg/Makefile.qemu
>> @@ -2,20 +2,23 @@
>>  #
>>  # TCG tests (per-target rules)
>>  #
>> -# This Makefile fragment is included from the per-target
>> -# Makefile.target so will be invoked for each linux-user program we
>> -# build. We have two options for compiling, either using a configured
>> -# guest compiler or calling one of our docker images to do it for us.
>> +# This Makefile fragment is included from the build-tcg target, once
>> +# for each target we build. We have two options for compiling, either
>> +# using a configured guest compiler or calling one of our docker images
>> +# to do it for us.
>>  #
>>  
>>  # The per ARCH makefile, if it exists, holds extra information about
>>  # useful docker images or alternative compiler flags.
>>  
>> --include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
>> --include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>> +include $(TARGET_DIR)config-target.mak
>> +include $(SRC_PATH)/rules.mak
>> +include $(wildcard \
>> +	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
>> +	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
>>  
> 
> It is still used here... Else we could clean ./configure way more.

Yes, I only made that part go away in the next patch to keep it simple
(the next patch gets rid of Makefile.include altogether, so I didn't
want to add churn in this one).  But it would not clean ./configure much
since TARGET_BASE_ARCH is used by QEMU itself.

Paolo

