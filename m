Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D6FC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE8B20675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 09:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE8B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60723 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSefy-0000IA-Nv
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 05:33:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSef0-0008Nt-Vn
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSeez-0008Oo-1F
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:32:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hSeew-0008LT-KB
	for qemu-devel@nongnu.org; Mon, 20 May 2019 05:32:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so13760227wrl.6
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LLCrZO7EmB3i6xSFUk8gwlceAXLSqAr5XMu5wPQ74qY=;
	b=PZKzR405H9AAIsCxlmxOW97/ljVTpQOKz7itBJ0JfU7vTJemjiGelmzOSusJ7KhseL
	0m8Hmuf+x6aMv9+dhEyizO0XA2PrMlGeqAtjBmiafp+cSWlD8OLuAqZmmVs6OhtJC1x0
	jC+aV6nHtsY4Gi9z1eSdm/MWlTIfiBI1lRo+Mr1uq2x8MpK6gHWm7qTfLRlvfCcfjexh
	Fc9maqMp0EzA656TkDlRhtACdUq/S4YUTGfzvJK4UAFLcXDY0n/cPf0fv/ZsJqcuyI6t
	pcAnTMRz7lgxYeaaB5cXuRaOliOeRzHk46cW6ho/qbG1fMyGv4MI4vSIhqMuDDRVERre
	F+GQ==
X-Gm-Message-State: APjAAAXnJY3zVQF8KiIufLUam1R0rbfk9OO5aEpHUoKZ3P70UplMHNfr
	cw+e+wMqFOwSQbN8vRK6gcuLAm30zho=
X-Google-Smtp-Source: APXvYqxrFgmZHcl5BHIjJ0L2PQt+894JjuE1mOL5GdTG/mnLSurlXAJdOXMqjAgfv4qpqFIopS59vw==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr7644292wru.142.1558344754827; 
	Mon, 20 May 2019 02:32:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	y4sm12149031wmj.20.2019.05.20.02.32.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 02:32:34 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
	<1557003754-26473-2-git-send-email-atar4qemu@gmail.com>
	<d28ed626-f7f8-53df-208a-cbf6c06e3cc9@ilande.co.uk>
	<CACXAS8BU-OamhTL03QNuukiKvy+vpdu8VRB4gWPe2+zz2nEymA@mail.gmail.com>
	<5306bcc1-e308-05eb-9ce5-79553cee3a23@ilande.co.uk>
	<CACXAS8AAXTy1xiQp2ftjEqhkXkbn-QG6Z=6AfKFCqJhT7eDF7Q@mail.gmail.com>
	<643f0224-1230-33c8-8b4c-a5c688872b4e@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d5e4293-788d-e799-342b-ea3ce8a0c244@redhat.com>
Date: Mon, 20 May 2019 11:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <643f0224-1230-33c8-8b4c-a5c688872b4e@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 1/3] lsi53c895a: hide 53c895a registers
 in 53c810
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/05/19 16:12, Mark Cave-Ayland wrote:
>> Initially I implemented it exactly as you suggest, via mask. But then
>> I thought that memory_region_init_alias makes aliasing more obvious.
>> I don't have a strong opinion on this one though.
>>
>> @Paolo, what do you think?
> My general feeling is that memory region aliases are more aimed at mapping areas into
> different address spaces. In this particular case it seems to me that the memory
> region for both devices is still 256 bytes, but it's just that internally the address
> decoder ignores bit 7 on the 810.

It's the same for me; whatever makes the code simpler is good.  RAM
regions need to use aliases in order to simulate ignored bits in the
decoder, so it's okay to use that for MMIO as well.  On the other hand,
it's true that a simple "&" does the job just as well.

Paolo

