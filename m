Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF0EC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA2C2070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R029GEXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA2C2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipC8M-0001LX-CH
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ipC7J-0000GC-BP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ipC7I-0006Vi-DB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:15:25 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:44140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ipC7E-0006RS-3k; Wed, 08 Jan 2020 09:15:20 -0500
Received: by mail-qt1-x841.google.com with SMTP id t3so2839687qtr.11;
 Wed, 08 Jan 2020 06:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kz008dI/5ko0RwiX0dhQgdEcmtnuOK5w/ZgYy3z+lwg=;
 b=R029GEXGaMEgUS+37qzV7CpBVvb7c/7H75pxTxHG1SbSeX7OoIPeP67Vt4sEWrAizF
 nGlIsN9oBip4+JD6Z1MjzBNgwBY5imYl+z7uKRTHrXdyhe80oP+Ph/PEa8QCIDHcrcCI
 NeEbHszFcU/nMmuxsHN8qOrne88widQfjpk2VY3nZNZjRQITNVAIWXCbwiG8ZXVYcZnJ
 xaoptATzayB4k+BJdWAANL6lkq9iVXdGXkyYH54woeGi1DMYxnpZ71AcZgziWQD8sfbY
 vkSlRSqyTuAmCLxqwIJ/V5yj6yjSaUPlHGmYS6nBR8K2Y34vUpxoof/KrgenHFrVhM1S
 Yulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kz008dI/5ko0RwiX0dhQgdEcmtnuOK5w/ZgYy3z+lwg=;
 b=rGsxYUt1u45/dWZf/alIKWRA1+f1u7Pq4qPWB4ysh3/O7yWK/ucS+w4rVipDuCUiY7
 Vf//fIY0YKxaq5ReH2kgOfM1mUojsIpHWy2XW/Ozh+5HEf9Q8ZElGYOM4WIZtwjIWHUp
 U8sq5i+OjnGahcyNA2dx+RflKsXThYcia9VXrff24Lm4NLWSka/n3BiXF3e32kw76QYP
 8ePgY0HP4DToKGvGbxBIlkS4rlxcgprCqfmcz/RyjKkYrka7rA9N9pxK5/xL7++z1T9q
 6tqmfT/khBdSvhx8iYwYWWjVKRRFzF48HIihinbg0nnqC5PJ6NUKJjkZA+1oWbTOH/GN
 NdWQ==
X-Gm-Message-State: APjAAAWLDOSI/7tSQHQ/PhbdGJAoikpU7G35RYZmmnD72LxPVTdQHaX2
 2e1BA60dgpySR4uQb9xGf/81y93O
X-Google-Smtp-Source: APXvYqxLc56IdG+CQRyXL/VzTBEKTWMj5xA8IY75UvWu9Acn0u02JoHPzlIorYuy2pUewCCsRTyo1Q==
X-Received: by 2002:aed:3fce:: with SMTP id w14mr3938372qth.0.1578492919000;
 Wed, 08 Jan 2020 06:15:19 -0800 (PST)
Received: from ?IPv6:2804:431:c7c6:655b:9e1c:e865:3705:e1df?
 ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id n4sm1593482qti.55.2020.01.08.06.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:15:18 -0800 (PST)
Subject: Re: [PATCH v1 37/59] s390x/event-facility.c: remove unneeded labels
To: Cornelia Huck <cohuck@redhat.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-38-danielhb413@gmail.com>
 <20200108134608.17c8c76c.cohuck@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <53cb4209-ed1c-0847-edf6-2dac868ee6dc@gmail.com>
Date: Wed, 8 Jan 2020 11:15:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108134608.17c8c76c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/8/20 9:46 AM, Cornelia Huck wrote:
> On Mon,  6 Jan 2020 15:24:03 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 

[..]

> I think read_event_data() is still a bit confusing, even if we get rid
> of the 'out:' label, as the flow remains the same. How about something
> like the following, which makes it clear that we handle the sccb events
> for unconditional read and for a selective read with a valid mask:

The code reading is better with your suggestion indeed.

I'll re-send this patch with this new read_event_data() flow.


Thanks,


DHB

