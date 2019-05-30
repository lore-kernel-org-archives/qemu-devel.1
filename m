Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA391C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E8525C8C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E8525C8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWMm9-0000cD-Mf
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 11:15:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWMlL-0000Cl-I3
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWMlK-00055v-Bv
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:14:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hWMlK-00055b-6R
	for qemu-devel@nongnu.org; Thu, 30 May 2019 11:14:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so4496176wrx.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 08:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nOwJqWMavcmIIxJHkA0x8vpT22Wy3JHgV12yq/5e1J0=;
	b=RJn2IVnjJaPe2dEiC4SGpL+Q62vvKqBgFJ0BuL7bo8Hf5JcGUALn5BWA1OC/eECQTl
	9nCZ+XQA9PTZ3KCaae77y3FyCVzSAFjaHWRZwY0d8nvycP7pp2ygq51xriiBQuYpBxa0
	UP9LIPQQXTHdra9XtP1ZJLNazvj509rfjZolHSD9SOoAMoLH8bBQPMA2u1P65Mhb5U8c
	bUTqPwkXsDiThKZoYKabu/+XK/ZlC1NDIdNxebo3JapQKKVgZ7ZiPveq32mKqfcRteBZ
	wzl6jdoSb5JhQ3qqJCqr6BlXjUMigt5HPe7go/WhVLqQh+2Xn3rQ62mTgjWKYisIU2+B
	WBYA==
X-Gm-Message-State: APjAAAU0WdtvQu70N0MxSUKdKJh4luoR4wn6V/xdGJgnuAlp9AgCVPBM
	quC9ceo+3SdC5G9wxTicFcxIDw==
X-Google-Smtp-Source: APXvYqw5ihjqHl3hffHHHgBsgRhAw06Rt/iEH6lMeThVMas1N6q8xQLjiHHhlv9ZQVEKKf3w/42Rmg==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr2321249wri.213.1559229276978; 
	Thu, 30 May 2019 08:14:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f91e:ffe0:9205:3b26?
	([2001:b07:6468:f312:f91e:ffe0:9205:3b26])
	by smtp.gmail.com with ESMTPSA id
	d10sm3245837wrh.91.2019.05.30.08.14.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 08:14:36 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
	<CAFEAcA-Cbot1POVcbAzXhaLqNJpi6M_0z18=YoB7vyqY3PekUg@mail.gmail.com>
	<878suqsnb1.fsf@zen.linaroharston>
	<CAFEAcA-6Wh00+TG7r3Oeh_+Mn4Vcj0RdTjRL3sAQHtEeUm0mEw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ed26bf7-4746-0f8f-89a8-0d536527fb70@redhat.com>
Date: Thu, 30 May 2019 17:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6Wh00+TG7r3Oeh_+Mn4Vcj0RdTjRL3sAQHtEeUm0mEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL 00/28] testing/next (system tests, docker,
 iotests)
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/19 16:02, Peter Maydell wrote:
> On Tue, 28 May 2019 at 14:47, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Sounds like we should include the sanitizer build in our normal setup.
>> We currently only do:
>>
>>   ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread
>>   -fuse-ld=gold"
>>
>> with gcc-7. What are the clang configure runes you are using?
> 
> I use
> '../../configure' '--cc=clang' '--cxx=clang++' '--enable-gtk'
> '--extra-cflags=-fsanitize=undefined  -fno-sanitize=shift-base
> -Werror'
> 
> (which we document at https://wiki.qemu.org/Testing#clang_UBSan)

Oh, so this is ubsan!  It is not covered by Patchew, which however found
some issues in the Address Sanitizer build that were uncovered by
check-block.

Logs are available at
https://patchew.org/logs/20190530101603.22254-1-alex.bennee@linaro.org/testing.asan/?type=message.

Paolo

