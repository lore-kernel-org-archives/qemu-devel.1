Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98644C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644232339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7M6gy1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644232339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ZLL-0000yY-CQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 18:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZKD-0008R9-5i
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZKC-0002JD-2I
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:43:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0ZKB-0002IU-SS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:43:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id h3so2153028pls.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 15:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HQUQyKuU5/Gj0sFIL6zI1J+vGgpytIZ3DKoBoqcJIt4=;
 b=M7M6gy1TiVE8CUKf3/xYexDjuUfcEyvsMHxHwJoWqrsTagvuQwk9MkHpkwCdIzkJJX
 OpH5kYjIM75K5CCdSd+K90LROejGBJ9FaznaBey6hJ0igguJhySIv5LO7TUDbBdOuLjk
 qn+0F9LgAxn9OKOKn/7UVhHay008iDBM57ArLConWnWxMo1G2YZs2x5MlW4AJqzutAPs
 gXc2SdGJtM52CFsKV8y9GwWVK69qL1VJ778o9E4Ghw1TYCrQ2vqVvJ5WVin5uqBN7J+5
 FoRLNTP4/Me59lhuqQbiqEgaq92p69M4v6DyV75IuRAMWCpXIRdXR3hQJdYL41CTBUAW
 Qx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HQUQyKuU5/Gj0sFIL6zI1J+vGgpytIZ3DKoBoqcJIt4=;
 b=WP7xZkFjVbYnsRZrMGf5fae1ooMwbPu7MkIq8sGTuwA1xx6zDfNdp+zLx1SP8cLHYG
 U5NRNzRVW31hNqnYOQMpp0DCbyLJjAPCjAyIC7XsRBDTzjhugm0Nc51dwSIYxJXTIkD3
 fdF6QDOaWm/6KnqERdwmXzgbmLJOEBXagF5psEav9+QdHD7j2bx3nTwKXwDGOu1mLdC+
 seS4C3kUen3yCUrT3rizIESUS5UqYTDGGGGkymm7qO7tg2xq1hoLvVFZxo7EeBfrGqIK
 D6a5bNktNUOer0Zy67voSktVl78/OjaNMctZhieIUstXMSBphwtNN7FUr4joHJy/3y0n
 mzsA==
X-Gm-Message-State: APjAAAVt0KUKUx4Dtfu4feX5fVNrH630KSaE/8i+Lp8nEUT3TIqcu7Ge
 MzE0bhJxwHtymxgTvQK7GvUS6w==
X-Google-Smtp-Source: APXvYqyWlqjTO2/YlWh2C5uIdBRC0YZCI+Gw74mfzHWh0qQjUSBzkM5rDwrCFAbQzaT91pz40Rnpkg==
X-Received: by 2002:a17:902:449:: with SMTP id
 67mr37236350ple.105.1566427406640; 
 Wed, 21 Aug 2019 15:43:26 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m34sm817849pje.5.2019.08.21.15.43.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 15:43:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190821092252.26541-1-david@redhat.com>
 <20190821092252.26541-3-david@redhat.com>
 <dc42887a-f991-1fe0-36a7-a7804bc4a939@linaro.org>
 <60d60d82-0407-9549-09b8-ff35218a4e71@redhat.com>
 <8973f904-c171-bcdd-3f6e-5e18cb37035c@linaro.org>
 <1c0c597d-c851-4116-184e-6b35fae08011@redhat.com>
 <d46f1b05-ef1f-cf82-f49c-ef9eb814c10e@linaro.org>
 <5bbdc8de-2526-2091-3d87-4c0945ce9442@redhat.com>
 <a8b1436d-a634-d767-8861-460c50acecb2@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ba9c379e-28a6-eb02-7f42-64a8bf76e589@linaro.org>
Date: Wed, 21 Aug 2019 15:43:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a8b1436d-a634-d767-8861-460c50acecb2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/tcg: Introduce
 probe_read_access()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 3:31 PM, Richard Henderson wrote:
>> Yes, that's what I mean, TARGET_PAGE_SIZE, but eventually crossing a
>> page boundary. The longer I stare at the MVCL code, the more broken it
>> is. There are more nice things buried in the PoP. MVCL does not detect
>> access exceptions beyond the next 2k. So we have to limit it there
>> differently.
> That language is indeed odd.
> 
> The only reading of that paragraph that makes sense to me is that the hardware
> *must* interrupt MVCL after every 2k bytes processed.  The idea that the user
> can magically write to a read-only page simply by providing length = 2MB and
> page that is initially writable is dumb.  I cannot imagine that is a correct
> reading.
> 
> Getting clarification from an IBM engineer on that would be good; otherwise I
> would just ignore that and proceed as if all access checks are performed.
> 

FWIW, splitting the operation at every aligned 2k boundary is exactly what the
Hercules emulator does:

    len3 = NOCROSS2KL(addr1,len1) ? len1 : (int)(0x800 - (addr1 & 0x7FF));
    len4 = NOCROSS2KL(addr2,len2) ? len2 : (int)(0x800 - (addr2 & 0x7FF));
    len = len3 < len4 ? len3 : len4;
    /* Use concpy to ensure Concurrent block update consistency */
    concpy (regs, dest, source, len);

After this it writes back the lengths and addresses to the
register file, and then if necessary loops back to the address
translation step.


r~

