Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3033CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F42721872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F42721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3Nc-0002ne-J9
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iO3DT-0007K1-2z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iO3DP-0000hN-SG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iO3DN-0000Yo-Uw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:17:30 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AA7381F01
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 17:17:27 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id x9so1585427wrq.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mykVdOgmocfFRC8diGfS9iMn+BvNzZ/8oBO7MssQwek=;
 b=D5YfDtPKpKNZNd1CLfaWsQcYCLHret44WwcOYHNWRD6ZeTXt9exRUhhvr4uNlN44jx
 +VuehtgFIH6KPrV7jVp/DYU20KvcLQx2YhlOIsaaaHkm824386jyAWj2k/rmFZ9Z+zDG
 JDMKixQ41LAjG9cyUeilqdKzYTIOMZ+AJqMEI5yIwJBtxSp4tcQP97tPgmX1FCFqrqcj
 OlX3gF7s8LyP5oAerY3TpJlauF4mcnwFjxrsJdTiYRhl7gTA6n4Ck6lVewVFSGav+aif
 ltLIa7ZlHCnCZY8gukH5Tf0i7IdbMul7340Ul6rms3emugIomQwZOQb3tF1zF4fdM8gE
 BSWg==
X-Gm-Message-State: APjAAAWcRiBA5JudtUuWbANm4iljrLJC+hP84ncgtQEnu+S8VYG2xu8R
 LNJmkU79iKHFvhwXgIAJ0D5yLSG28LMdzp2whgVxraVVVUty5f0HM7t4VpEaQDiBybPTjH+7RK+
 p/YJ8cRGeL/7ztjg=
X-Received: by 2002:a5d:6787:: with SMTP id v7mr4213231wru.392.1572023845933; 
 Fri, 25 Oct 2019 10:17:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+Eo34IgtB7OcgkkAwGx3bhyxQj40aBzYlR8jQa0BxnmqB775qEg9J9e6hVm5Goinezvwosg==
X-Received: by 2002:a5d:6787:: with SMTP id v7mr4213203wru.392.1572023845676; 
 Fri, 25 Oct 2019 10:17:25 -0700 (PDT)
Received: from [192.168.43.238] (51.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.51])
 by smtp.gmail.com with ESMTPSA id w17sm3091171wra.34.2019.10.25.10.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 10:17:25 -0700 (PDT)
Subject: Re: [PATCH 00/11] tests/acceptance: Fix 64-bit MIPS target tests
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <CAL1e-=hMJmmRzD8iQdKji__RKPbGrV0fGNciz2bgLjkhmC2v6Q@mail.gmail.com>
 <CAL1e-=g+bayWb81M1r0kxf-RU6H=WxKSvXT5TxyuDpVMbuG-KQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7fa0f06c-5076-3016-ac26-26b31e2b720d@redhat.com>
Date: Fri, 25 Oct 2019 19:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=g+bayWb81M1r0kxf-RU6H=WxKSvXT5TxyuDpVMbuG-KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 6:46 PM, Aleksandar Markovic wrote:
> On Thu, Oct 24, 2019 at 11:23 AM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>> ping for Cleber and Eduardo
>>
> 
> I applied patches 7, 8, 9, 10, and 11 to MIPS queue.

Thanks Aleksandar!

