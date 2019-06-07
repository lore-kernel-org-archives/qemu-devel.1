Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A74C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA7D208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA7D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZG3Z-0002l6-C1
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZFYQ-0004bR-Vw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZFYO-0000Fj-Ko
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:09:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZFYO-0008CU-EJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:09:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so2075677wmm.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GVeg+F/oSsc3/hiw/iwde5xgYSN0MLXB4PT/JL+VCCE=;
 b=Z7cBijFnvSvldOQ4pNA03MO/8643GuqiUiEJzop+UZ9nIllv7BSbvzfIfljkRCYIR8
 +SFiURIbjtiMh0VoddILgXVd5P6V0lJNNW6rE5BZL3jsifh/+uHdfCDryHBL+a2862TQ
 eOBZofRbErWKIR+VKrcnHv6XGVU/AXYDJiONSyZVQeA622qhuC3JdoTqWF0eODip5/lj
 cdDdtmMbihzpp88KiTH51SM0FWq5/krLtKuPHy8BwFWy8+agCPtPBSbp6blouGj5hdyG
 Dx6tcrOxGazYou/BhCzawIpPwtaqq/mLY+qyDI3iiivr50PegUhZEMeUYRopKxdMGnkk
 8t6w==
X-Gm-Message-State: APjAAAUQ4fW1tu7wt+xDTHgKmbQZxpz1VLumy0oRBIN/OwbEhW2+Ifxe
 +JbE6UjV3A+Yp/1ElrJszGVnZg==
X-Google-Smtp-Source: APXvYqxnKQlg45zMnVRZ2H2YQQEHcLHOyMd+1/DPthL/GktoOZS3vYH8+Ax91EsR3R7JqVIEAK00ig==
X-Received: by 2002:a1c:407:: with SMTP id 7mr4118130wme.113.1559916535503;
 Fri, 07 Jun 2019 07:08:55 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id t198sm2483444wmt.2.2019.06.07.07.08.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:08:55 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-17-ysato@users.sourceforge.jp>
 <6e4b77b4-f05c-74e8-e128-1555ead951fc@redhat.com>
 <04a5b9b8-7b33-5ad9-f8e1-f5752ec97607@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cf65570e-7606-9678-8479-17b7111d417a@redhat.com>
Date: Fri, 7 Jun 2019 16:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04a5b9b8-7b33-5ad9-f8e1-f5752ec97607@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v17 16/24] Add rx-softmmu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 4:03 PM, Richard Henderson wrote:
> On 6/7/19 8:44 AM, Philippe Mathieu-Daudé wrote:
>> Again:
>>
>> Please squash in:
>>
>> -- >8 --
>> --- a/include/exec/poison.h
>> +++ b/include/exec/poison.h
>> @@ -26,6 +26,7 @@
>>  #pragma GCC poison TARGET_PPC
>>  #pragma GCC poison TARGET_PPC64
>>  #pragma GCC poison TARGET_ABI32
>> +#pragma GCC poison TARGET_RX
>>  #pragma GCC poison TARGET_S390X
>>  #pragma GCC poison TARGET_SH4
>>  #pragma GCC poison TARGET_SPARC
> 
> Done.  Any I've picked up all of your r-b tags.

Thanks Richard!

