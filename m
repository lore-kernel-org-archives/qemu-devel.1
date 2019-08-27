Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829D3C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6B02173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTDcga59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6B02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2eq4-0008U8-GN
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 13:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2enn-0006wA-PA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2enl-0001K3-EW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:58:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2enl-0001JW-6x
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:58:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id d1so13014954pgp.4
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IR/LVlKLVtsAv0HGIZ14cVfqiV3gGy8f08HrO5FgZ24=;
 b=ZTDcga599VXj/zgC7YrV8V2Y2NXWOjOXtAab7giJDuipDbzbut1/UHoNtbSy+eq9CV
 OeZHbIvX/g92Z2TXwq/ZjGYS9Q8dZXpYZvGnEvqgjsTUZ5IKPmfHmEIueokP/VuzJbX5
 34aknz4QhLmcHoxw1UkB/m/fWh8PZAwgWQY45AW4FJVrr/caDUoP+Sfl1YgxUkimAUcl
 OoxlyN9mS9z0fPom8yuBp++q8CamLNKtAXWSegAsJzN793LMqtbWLUdI2RN3Jx/HiQ7f
 A354jRbi4vdNo4Ucl4ayOgpydXK3I4QqEMVo4YAZDtyWsuyN96c4TeFBKOSzgiMne5o3
 Swug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IR/LVlKLVtsAv0HGIZ14cVfqiV3gGy8f08HrO5FgZ24=;
 b=GXGfYfK1QbVInZPCToTBH+1+mZxJyFevtO+KQu5Uv9fu9kfhCKleBJGY5tbr17eqrR
 6D+fa5Ku4b5ddYgAKglvJISWTUunBfeT54PmUc36lZUFrnHIS1GiAEELz7BlyeFDLtWy
 vEVk+Brbvg+QRsqUk/DzGXIfBhbjVF+KjQuWHja98w8RXkz0rBDtY9YMFb2pIN63M+IG
 PTVSltOzOG2dY2FsuSwvYCJRTycD361dc+Apv+1OOGl1+pwnndA3GXMfQvlCkmQoToEP
 IlpZGCo5aIsH7b9gPDElqfYhXwQrNY7X9KUgPP0y4osJ+dGUXsy9iScswr5I5c6kcltV
 XJ9w==
X-Gm-Message-State: APjAAAUcQfMWpJhaB0ZVRc5p/NU2ArX1Qsn/8zDaJpJ6tWb/ZRt9cwJ0
 VyTt4D0p8Jp2xjXK/qKZSIJNMQ==
X-Google-Smtp-Source: APXvYqwkAsMxO84lRwuKg3b/AUcJS75nJbeuH0nVR5sgIyZ1cfBUiAqv0XTDpcMY1ssV2fvBn5PwcQ==
X-Received: by 2002:aa7:9a81:: with SMTP id w1mr27480516pfi.24.1566925116045; 
 Tue, 27 Aug 2019 09:58:36 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v22sm13167199pgk.69.2019.08.27.09.58.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 09:58:34 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190826075112.25637-1-david@redhat.com>
 <97734c60-12ef-274e-96ea-ebaa48e01935@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3a0506c1-8c45-d933-1fed-6cd0a02cddde@linaro.org>
Date: Tue, 27 Aug 2019 09:58:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <97734c60-12ef-274e-96ea-ebaa48e01935@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/7] tcg: probe_write()
 refactorings
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 9:09 AM, David Hildenbrand wrote:
>> David Hildenbrand (7):
>>   s390x/tcg: Use guest_addr_valid() instead of h2g_valid() in
>>     probe_write_access()
>>   s390x/tcg: Fix length calculation in probe_write_access()
>>   tcg: Factor out CONFIG_USER_ONLY probe_write() from s390x code
>>   tcg: Enforce single page access in probe_write()
>>   mips/tcg: Call probe_write() for CONFIG_USER_ONLY as well
>>   hppa/tcg: Call probe_write() also for CONFIG_USER_ONLY
>>   s390x/tcg: Pass a size to probe_write() in do_csst()
>>
>>  accel/tcg/cputlb.c        |  2 ++
>>  accel/tcg/user-exec.c     | 17 +++++++++++++++++
>>  include/exec/exec-all.h   |  4 ++--
>>  target/hppa/op_helper.c   |  2 --
>>  target/mips/op_helper.c   |  8 +++-----
>>  target/s390x/mem_helper.c | 13 ++-----------
>>  6 files changed, 26 insertions(+), 20 deletions(-)
>>
> 
> Richard, in case there is no more feedback, will you take these patches
> via your tree?

I can do.


r~

