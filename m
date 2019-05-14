Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B050C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E822420675
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HqMDsDX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E822420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50779 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQa8W-0000Vw-5e
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:18:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQa54-0006Af-Jb
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQa51-0005gu-S2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:15:06 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQa51-0005eL-1z
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:15:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id b76so964815pfb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=f+ihmt7uz/vPBIVvH0CQvYowvzdq4bUkA1K9sLwv9tI=;
	b=HqMDsDX53loQOfb1OjElNYER2G6Xijd5rN0LPkP3ZAkaRWvqfkaYvOYfZkzrUApmZw
	CjCR2qJ9GihTQYjIclVvbtxD9OX54WU56x6astinmnPoS/tyq/Wcvo5HJ5KpZYZbqw1c
	iWYNftgrJS72iJ95LlOeqqtRFg2rYD6x9v+ptciEOuzU38QZBftM9pW7J1OLjulqmJra
	CDBFe4Jy0RQYYHA8ojtedjg8xiBkcOxas6fUOFWidnnYnqMQX3VZtIc6tEbOGdoveCpv
	wQpuN9w3UFbaHK4hnOw/B2H2mTUFvmwmsi6VRt/BB8kNGDf82/EcHs/+2DiQLiJKKGEp
	TlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=f+ihmt7uz/vPBIVvH0CQvYowvzdq4bUkA1K9sLwv9tI=;
	b=DQLkrAm2Rkteiq2m37A1IPuv0atRRC+SxAkKdfxjaadoxKendOxXBM78wMJAY9xKFi
	Mm7menZrkGhoSjunT32rru7kqupB4HK6WNPNR+b6ICnpruECWGSIZjr1oPgyQ97m5i/F
	xlchcL6nKZyCGa3VQ0/bV7AjSnXvQHBCYUlxYWhVAgw+/5Itg0BsRfmsDPG7eJ3nZNYy
	OP314dMiWIruyTnLChu+aBdPSTrmRMM/lACKBJ5bBpuZqb/OMjIUYkl1nuj+XtS9ITcP
	GV39xgLmVAMb7fMY4/K+p+AishhZBkYc85IS5k8N7BTbVXeUHA7QTbEU2/t8s93/TfPq
	jmDQ==
X-Gm-Message-State: APjAAAVD8e9aRmH8qLiv574Og6kLA3WOxwBPe6shakkPobfBQB5/EZ4u
	0KavkUSm3WECGj/wfxa5y3E6T1AypHo=
X-Google-Smtp-Source: APXvYqwMnl/4bXxMw+0g8sUPS1qCafjGyO2jfwCmciybPG+VesaEzuZzEH0oEfBhcKh/jDlnznhKcw==
X-Received: by 2002:a63:2a89:: with SMTP id
	q131mr37836913pgq.359.1557850500864; 
	Tue, 14 May 2019 09:15:00 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	z11sm13446720pfg.187.2019.05.14.09.14.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:15:00 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
	<877eatdq3w.fsf@dusky.pond.sub.org> <20190514152331.GJ25916@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d050fa9d-8e4b-7b87-31e5-05a7fa78feb9@linaro.org>
Date: Tue, 14 May 2019 09:14:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514152331.GJ25916@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Add qemu_getrandom and
 ARMv8.5-RNG etc
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 8:23 AM, Daniel P. Berrangé wrote:
> On Tue, May 14, 2019 at 05:15:31PM +0200, Markus Armbruster wrote:
>> "make check-unit" fails for me:
>>
>>   TEST    check-unit: tests/test-crypto-tlscredsx509
>> Unexpected error in object_new_with_propv() at /work/armbru/qemu/qom/object.c:674:
>> invalid object type: tls-creds-x509
>>
>> and
>>
>>   TEST    check-unit: tests/test-io-channel-tls
>> Unexpected error in object_new_with_propv() at /work/armbru/qemu/qom/object.c:674:
>> invalid object type: tls-creds-x509
>>
>> I haven't looked further.
> 
> I have a nasty feeling it is caused by
> 
>   Subject: [PATCH v6 02/25] crypto: Merge crypto-obj-y into libqemuutil.a
> 
> The QOM objects are not directly used by most of the code. We rely on
> the constructor registering the QOM object and then we request an
> instance of it via the type name. So there's no direct function calls
> from any code into the crypto object impls.
> 
> When we put the crypto objects into libqemuutil.a the linker is not
> intelligent enough to see the constructor and so thinks all these
> QOM object impls are unused and discards them when linking the final
> binary.

Yes, that would do it.  We would need something in the test that forces the
objects into the link.  Without having yet looked at the test cases, any ideas?


r~


