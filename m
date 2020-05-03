Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34913C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 17:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB33E206CD
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 17:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqYZjtAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB33E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVIBc-0000n7-2L
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 13:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVIAq-0008UE-Qr
 for qemu-devel@nongnu.org; Sun, 03 May 2020 13:13:04 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVIAp-0002tv-FY
 for qemu-devel@nongnu.org; Sun, 03 May 2020 13:13:04 -0400
Received: by mail-pl1-x643.google.com with SMTP id w3so5839448plz.5
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=osQ7iZFKf5dm9x5QhlN6zbt/yUus595FFcS0GaIK+7M=;
 b=xqYZjtAU0iCKJ2vk5weXX+8qpG5S0SSUBe8gjWLOcrIAMsmrZ7YWh/dniA8gwPhigq
 ocAamQ0L+GFDjY3TAPAd+zzVY7Cz/yZMyt+nmgR8lpv0iDvnJ6mxatz6YVyk+LDIvUEY
 ZxaTxmv1Abag8LNv4AeZivoNYagYVgjC/3XUFjRIF6jYizNd7gDC4W1Gle33IDycp4yH
 9WvH7SgDnLHgW9Qx+ZuTMxPq+rlHo/B1bXVxvIS+qgunapA5K7ChDc6q4ii6XygZnkWx
 6OY9C+XrbhO+t8NWuoCPtl70LMoCHUeD2S+mp+Ou0/69s6GDw9qd14RIU5Cl/r07MJY7
 NM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=osQ7iZFKf5dm9x5QhlN6zbt/yUus595FFcS0GaIK+7M=;
 b=ckrBgRruBR/I7PKUPI9ZjQzJM5AnF71GPq34ZC59oqTL49wpkYorgQ26owZbrxVNCW
 vr9rYSWTR8SWBhJYzD8PFzLtC3xECWkC0e5KENUp35hyLu6UcBHJsCkte0lN0wr6ezrW
 L2LROiDt2TZquN6maHy1tIhDJh96vqU4nTIGv8T3aNTEXNPP+ytZm//PGZSga9MppJEp
 kpMyIOsPZje93zzYbAmoBAGhpH0YeV+GKG8obim/Zjuq4HNDMhl80D8aytKjXm7p2x3H
 SaSo6Eds467FKlUdZBkL/se2+7ZFRphEmkMIHY9P2hcu4Mzr8y/ODs1ZIuOrQeif9+Kg
 yV0g==
X-Gm-Message-State: AGi0PuYEjPSrGdPjuVQQVZSo6+TlLLpmGCJhSA7ywA2YXaYzFtVUFRiR
 JwQRyuxg/9shQffmTLJKlvS5aw==
X-Google-Smtp-Source: APiQypLo9r+yb3PR0sJOjv4my0wOAyY+88CGmcO4+fyfAiZBwqS+k7tIu8oI/CGA+kdgC+j9mv7qHA==
X-Received: by 2002:a17:90a:8c9:: with SMTP id
 9mr11698979pjn.183.1588525981941; 
 Sun, 03 May 2020 10:13:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id x132sm6884890pfc.57.2020.05.03.10.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2020 10:13:01 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] audio/mixeng: Fix Clang 'int-conversion' warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200503113220.30808-1-f4bug@amsat.org>
 <20200503113220.30808-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <89882847-509d-098e-3379-ad4391ccccb2@linaro.org>
Date: Sun, 3 May 2020 10:12:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503113220.30808-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/3/20 4:32 AM, Philippe Mathieu-Daudé wrote:
> When building with Clang 10 on Fedora 32, we get:
> 
>     CC      audio/mixeng.o
>   audio/mixeng.c:274:34: error: implicit conversion from 'unsigned int' to 'float' changes value from 4294967295 to 4294967296 [-Werror,-Wimplicit-int-float-conversion]
>   static const float float_scale = UINT_MAX / 2.f;
>                                    ^~~~~~~~ ~
>   /usr/lib64/clang/10.0.0/include/limits.h:56:37: note: expanded from macro 'UINT_MAX'
>   #define UINT_MAX  (__INT_MAX__  *2U +1U)
>                      ~~~~~~~~~~~~~~~~~^~~
> 
> Fix by using a 64-bit float for the conversion, before casting
> back to 32-bit float.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  audio/mixeng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

No, this should be fixed properly.

First, the warning is in the !FLOAT_MIXENG branch.  IMO that means we should
not be using floating point at all, and this should be a simple integral
multiply/shift.

I had a brief look at this before the 5.0 release.  The arithmetic all through
audio looks confused to me.  There's a combination of shifting and masking
(implying a scale by 1<<32), and multiplication and division by UINT32_MAX.

I'm reasonably certain that every appearance of UINT32_MAX in this code is an
off-by-one bug, or a misuse of the constant.


r~

