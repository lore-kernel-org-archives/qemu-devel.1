Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199BEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD8F21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD8F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlk5-0001b3-6z
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:18:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTljD-0001I0-Jg
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTljC-0001Ze-KN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:17:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hTljC-0001ZJ-FM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:17:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id c77so5400262wmd.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=j0aSH/ytZr4gDVznb+LgKCovl5NCFXBoMRejvjrp3NA=;
	b=MhTwYVf4FSNeaSiXDynE5fscSRLdmD2CsC+qDtJqnRilLE+6i3T0xm6PKqF0t9ixDR
	erNZ7a5MLTtkzNAnDCxV0dRe8DSQs5QLeF2C/a8LM45F116C13rzCMNwyNx9VSuZLPII
	D7Sj9Fo3H5MdlkX2gCnGvqUmokr9Yo5JCXMTd5JYhdWao3X6lubP9KAPhlNnBGgIDClR
	rcF/fyYPx0oenzjrgVuspNivg+zjyexUmhrENI6tCV+kfi4f/wspzW6umsDCYS3hM4yS
	HApQVkgE9cfC1i0pdBsP77+Cixy17paTs2kbswbPB4LgHbfm1kUYBW5asfzxlrPORVID
	iY/Q==
X-Gm-Message-State: APjAAAV3JCRZh/iL7U8RTDXbraZBQVxJ75sPfF+Gi3HgBv0ts9mGLTu9
	u48G6oFgIKoeM9AaNvdIG4b1ZA==
X-Google-Smtp-Source: APXvYqzO38WAvSyjbQtPHPN+M8CENZcucjGiPe4uNWq3onoPXyRD0qEaPajH6TNHXAiC3DeFYXpU2Q==
X-Received: by 2002:a1c:c015:: with SMTP id q21mr6320697wmf.75.1558610261469; 
	Thu, 23 May 2019 04:17:41 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	a11sm29454304wrx.31.2019.05.23.04.17.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 04:17:41 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-2-richard.henderson@linaro.org>
	<20190523110736.GD20973@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <26e22686-0b89-0b94-88f6-68e11b939697@redhat.com>
Date: Thu, 23 May 2019 13:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523110736.GD20973@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/3] capstone: Adjust include of capstone.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 1:07 PM, Daniel P. Berrangé wrote:
> On Wed, May 22, 2019 at 10:42:27PM -0400, Richard Henderson wrote:
>> Since v4.0, capstone.h has moved to <capstone/capstone.h>.
> 
> NB this was a regression bug in capstone pkg-config file which has been
> fixed upstream
> 
>    https://github.com/aquynh/capstone/pull/1276
> 
> In Fedora we pulled in the fix to our v4.0 builds and I'd suggest
> other distros should do the same

Are you suggesting to not include this patch? It is less invasive to
distributions that package QEMU but don't package libcapstone.

> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/disas/capstone.h | 4 ++++
>>  configure                | 6 ++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
>> index e29068dd97..90631d84a9 100644
>> --- a/include/disas/capstone.h
>> +++ b/include/disas/capstone.h
>> @@ -3,7 +3,11 @@
>>  
>>  #ifdef CONFIG_CAPSTONE
>>  
>> +#ifdef CONFIG_CAPSTONE_CAPSTONE_H
>> +#include <capstone/capstone.h>
>> +#else
>>  #include <capstone.h>
>> +#endif
>>  
>>  #else
>>  
>> diff --git a/configure b/configure
>> index d2fc346302..eec7f061c3 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5021,6 +5021,9 @@ case "$capstone" in
>>    system)
>>      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
>>      LIBS="$($pkg_config --libs capstone) $LIBS"
>> +    if check_include capstone/capstone.h; then
>> +      capstone_capstone_h=yes
>> +    fi
>>      ;;
>>  
>>    no)
>> @@ -7197,6 +7200,9 @@ if test "$ivshmem" = "yes" ; then
>>  fi
>>  if test "$capstone" != "no" ; then
>>    echo "CONFIG_CAPSTONE=y" >> $config_host_mak
>> +  if test "$capstone_capstone_h" != "no" ; then
>> +    echo "CONFIG_CAPSTONE_CAPSTONE_H=y" >> $config_host_mak
>> +  fi
>>  fi
>>  if test "$debug_mutex" = "yes" ; then
>>    echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
> 
> Regards,
> Daniel
> 

