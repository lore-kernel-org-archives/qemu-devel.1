Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42202C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC562084F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ13PM47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC562084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE2TR-00067j-WC
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:56:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hE2Sb-0005dG-Mw
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hE2SZ-0002R4-PE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:55:33 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hE2SY-0002Dk-91
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:55:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id t21so413065pfh.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 18:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fGbxOQD3PnFOkRcgFoWVYbtlOoh1UaRp1qoGdg/7zOc=;
	b=qZ13PM47VU23eFkXGD1Kw9osL7Up7ORLPz56/+4RRJIxFnvmG9zqOhsHKFLzovDshq
	QTy0wU8eBfKF3SHq2StwTR+J8byhAeSyIp16oU9K08vzplGJNq9VEu6Cc1JP+zn86bxf
	KyO9NhNeW/3kR4x3UfOcgJ1Co98H9e0IxWCtPyqECek6LGdSS1koEdKIOL9Tc3+oEjCR
	a//+B4kGSxiCmiZooI0kOjs5ACHLt2uuHXvTh/l2kYhJUnBed3BwR7zhvQDzkh4ccFlJ
	rCapDFNNcEh1XoGGtAiJLJKiYyTQFt/OlB0NnRpMCA2dd2mJ72jLeCVDz63nsLWgwDZo
	ju5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fGbxOQD3PnFOkRcgFoWVYbtlOoh1UaRp1qoGdg/7zOc=;
	b=bFQe2t0APABvIUId62rXYscCFUzeDzbYA8kvaHg8mR6LinKnlGMjiFu5JiU8cTCKAZ
	dK9ECylK3kTB/6pVt6cwe2ruO3WoVIKtTlzOshiYcSCGVpx6KEHMpMGjEkgrUcQnDEPA
	3PJ+fbZJNEhUk1PM9UMf1lYbYWcNprTay3N/EFBeytEzS6c1j5/iaxNOKxmlPbSH7mpo
	QiKdmJQY43++wakj/VkdOc6odVYkKwb9WaN5Bu3MMCU3DrKd5cEQ1rQFAqBE7HoilSfl
	1y9EojvJUQzs4MMsjD4I+2MCzsBuPO1Vcgprirg7HpaY/7mJrfSA6wUShe26v1beI3Ud
	Lk1g==
X-Gm-Message-State: APjAAAW5D0AklTqdF9MWXWVWd8cQMNrQyReMQCvHkAzuUPTy6M8Ro5mF
	gkYASNNecwY96hzmlOCROKQWz7qrgMQ=
X-Google-Smtp-Source: APXvYqyJkaZznnKot52p2L6Nb4qgLnwANfSj2vvShJJLzMtWeZvW/1T/iX1+rRFgh4+AxFgkJqNnFg==
X-Received: by 2002:a65:6545:: with SMTP id a5mr27300347pgw.264.1554861326401; 
	Tue, 09 Apr 2019 18:55:26 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	p17sm44918681pfn.157.2019.04.09.18.55.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 18:55:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190118213122.22865-1-richard.henderson@linaro.org>
	<20190118213122.22865-48-richard.henderson@linaro.org>
	<86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
	<c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
	<2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
	<d0735945-f5de-5ddc-327a-53eaec40d0d1@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <48937430-bbb1-6c26-3fae-6cc841580555@linaro.org>
Date: Tue, 9 Apr 2019 15:55:21 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d0735945-f5de-5ddc-327a-53eaec40d0d1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v6 48/49] linux-user: Split out ioctl
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410015521.olV0ztJ4pkyUwthXPYDcCI05EOFRh6nBr8G_OlpV2dw@z>

On 4/9/19 1:30 PM, Richard Henderson wrote:
> On 4/9/19 1:15 PM, Richard Henderson wrote:
>> On 2/13/19 3:46 AM, Laurent Vivier wrote:
>>> In fact it happens with sid, with ppc64 too, but not with m68k and sh4.
>>>
>>> And only with "unshare --pid --fork".
>>>
>>> Without "unshare", the result is:
>>>
>>>   Unsupported ioctl: cmd=0x80047476
>>>   bash: cannot set terminal process group (11507): Function not implemented
>>>   bash: no job control in this shell
>>>   Unsupported ioctl: cmd=0x80087467
>>>   Unsupported ioctl: cmd=0x80087467
>>>   Unsupported ioctl: cmd=0x802c7415
>>
>> I'm just now getting back to this, and cannot replicate the issue
> 
> ... Oh nevermind.  I should be expecting no "unsupported" at all, since that's
> what we get with master.

The cause is that "cmd" accidentally changed from "int" in the do_ioctl
parameter list to "abi_ulong" as a local variable in impl_ioctl.  This caused a
table lookup failure on any ioctl with bit 31 set, for 64-bit guests.


r~

