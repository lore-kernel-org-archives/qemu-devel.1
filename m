Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4704BC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 02:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD5820815
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 02:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5wOarGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD5820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJqGL-0007uS-2A
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 22:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJqFR-0007J7-7M
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 22:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJqFN-0007kX-LN
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 22:38:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJqFN-0007kG-EH
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 22:38:09 -0400
Received: by mail-pl1-x644.google.com with SMTP id c3so7341717plo.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 19:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D8Eya947rZ0JCXRfgxfF495Xpgx6R5TUSx37SBQzrGQ=;
 b=f5wOarGCwcWoUmQ6SkBud7aT7AKNeRBC1t5LqM3R+Y2nkMCzgYmpY8L+4dQgRHRg//
 YNvAOS/WmeJjrKn482ZkEOcGAW3SAeWxIAI6j+2FO6UclthfSs1Fv/Ru8B6saFitvGkK
 CBYXCO6wfKADnGTrDKt9XoLdDk6SVnykgmlzfT8w06yoI9vuBShP+Lf/C3027Bj8UAON
 8YyTO4b2k4yOgqOY0liPWMEzI5RGUFMLhHq+TBaEK7mu3wel83zUrLW/l4jihV94HH7w
 1Ky0kNnL28CIrh6aaIOQZPqXLoRtcB3ZRmKe6heSQjtHEldeFLo5/GvU3QkbY+O7vT43
 wBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D8Eya947rZ0JCXRfgxfF495Xpgx6R5TUSx37SBQzrGQ=;
 b=tVkBscQPlFf9GiqrSV63i7BX9m3hsKr+CICeHWy4uHDf2RSkq6awHsr6Yvwpm+5spA
 bVzZBXNhcN3/vgAGCEa1Jn21wghgP+lefvjqnR4H95KNBJ7D6HJlMhYowBX6RFCNF7S3
 PK9xkRnGY8BBcaHKD0BW0xLq+Kb+jmspGEWM1sC0Zae0c76UILMK9MP8Rg0qS+wV3UaO
 MHeVp6wlNQKDuMXSGozH/65ngpBQ5it9n9W66cYAeesFg0GymrQ441pySC8eT3WzgfFf
 5owhblsuhCKaQuH78hUPoS/nJxWluzTqojSEpDlE9wtnbxRFNZAydnIAcVlKtpzIFyzG
 XZDQ==
X-Gm-Message-State: APjAAAXNRLbD2B6oIC5V+QcipMDcO0aDug9luaT946/T6FJJtUSTZGZn
 RyZqNwaLFFmhjXW+zKTZoKIClg==
X-Google-Smtp-Source: APXvYqxesPEGRiUZmN9KrJwWaNpHfdX0PIfR+//tgCTv1y1XZJI3HrYLNoMMA3rLmBBuHjZc5zIfGQ==
X-Received: by 2002:a17:902:b60a:: with SMTP id
 b10mr28924640pls.130.1571020687787; 
 Sun, 13 Oct 2019 19:38:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d6sm15544148pgj.22.2019.10.13.19.38.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Oct 2019 19:38:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-2-richardw.yang@linux.intel.com>
 <41a924dc-f91b-c03b-4f82-570757105798@linaro.org>
 <20191014010142.GA29752@richard>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4036820a-f357-9e67-7e58-cbb9186d0ef4@linaro.org>
Date: Sun, 13 Oct 2019 19:38:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014010142.GA29752@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: fam@euphon.net, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, den@openvz.org,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 ehabkost@redhat.com, sw@weilnetz.de, dgilbert@redhat.com,
 yuval.shaia@oracle.com, alex.williamson@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-ppc@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/19 6:01 PM, Wei Yang wrote:
>> No, please.
>>
>> (1) The compiler does not know that qemu_*host_page_size is a power of 2, and
>> will generate a real division at runtime.  The same is true for
>> TARGET_PAGE_SIZE when TARGET_PAGE_BITS_VARY.
>>
> 
> Confused
> 
> The definition of ROUND_UP is:
> 
> #define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))

Ah, my bad, I did confuse this with QEMU_ALIGN_UP.

Hmm.

	lea	-1(n, size), t
	neg	size
	and	size, t

vs

	mov	mask, t
	not	t
	add	n, t
	and	mask, t

which is what I proposed here

>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04526.html

I'm ok with your version.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


