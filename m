Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E553C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F60321850
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6hNyy43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F60321850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1Dy-0001PD-H5
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1Dk-0000fP-RZ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1Dj-000854-Mx
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:29:20 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43967)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr1Dj-00083c-BU
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:29:19 -0400
Received: by mail-pl1-x643.google.com with SMTP id 4so17850572pld.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HYkm/+YuRwdgQlTX7h7Sc0MGkhzdaPPqGlIAQEZn/Mg=;
 b=X6hNyy43iImL1gGlKELMROj/8QrOqZyK1sMdpynJjRT38vf77tB43nVRDOoAERpjZL
 iS98ML3FmCC+DGPOH/Z1jm2CBBwH2b134trIacB8iTyad+B4th2ziW6epN/yrt6S+oSr
 Yt6yXv6wWqwocQPlbfrRIFaDsO6qOZtbkze73y4bl8P+EFZx0u4BXaqZN/z55qMiLy2l
 vqHibOP/tB0+OxDG0o/7zSqjeegtFe0gnGswJNo6wFMBRaOzYWOHAwaxTP797wwIg/RB
 zitQBxa6aT7OYxmwCIbTvNy+JGxUSv54bTlrduPiz5EnJRd70TxnfxoftAhNC/GDgs0C
 xlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HYkm/+YuRwdgQlTX7h7Sc0MGkhzdaPPqGlIAQEZn/Mg=;
 b=lofu6XZ/5Mu01luckIxQNfo2494lTbQm7zP2YgDZXwCug+SgQKBhOoKX4Qp3kEyCs7
 O1L2aaOxZ4TGTstkEaqbvts9IQ8MfVfS9ZjXlf4z/FbAjQfVhnouPDnxOmgdeaT8ENKj
 BIPvaO18OvrLygR1DingXIRgeALXT54yYJIlyYyFLRxxfVEELZYngdzuMyZQyI72NUwN
 /ZAvgYun27y1nfM8sF7WHRi0A7YE+WbwxyNct+qB1lg5pHrAIbNBKq1BBJ0bXkY2FDdo
 O2vwu5W21sFHT5Maarl2V9q9wtqFr1c8Bj2lYQLLx8qwKiSXu6UL3HrLGgdAf3n91I46
 cMAA==
X-Gm-Message-State: APjAAAU+eZFIT/Xr1XAlyh2CwH4Hmocak10cVM6O9yZXZ4dMDtNsCF9D
 YGJrb5KXJKLUWQeTs6II4A14og==
X-Google-Smtp-Source: APXvYqwfJHX0llJYhPthp+Vyof6h6XXQb6bjuc/14DrJXGVipkBHNgOla6wimefmoyBX+weNmI8ViQ==
X-Received: by 2002:a17:902:aa5:: with SMTP id
 34mr100001631plp.166.1564151358166; 
 Fri, 26 Jul 2019 07:29:18 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id 196sm57357139pfy.167.2019.07.26.07.29.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 07:29:17 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, tony.nguyen@bt.com,
 qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123667210.66446@bt.com>
 <3a893408-e864-cb3b-d86c-b6cf7b50cc39@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <51237717-fcfa-0f3d-f635-7d12481a7625@linaro.org>
Date: Fri, 26 Jul 2019 07:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3a893408-e864-cb3b-d86c-b6cf7b50cc39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v5 11/15] memory: Single byte swap along
 the I/O path
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 laurent@vivier.eu, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 2:26 AM, Paolo Bonzini wrote:
> On 26/07/19 08:47, tony.nguyen@bt.com wrote:
>> +        op = SIZE_MEMOP(size);
>> +        if (need_bswap(big_endian)) {
>> +            op ^= MO_BSWAP;
>> +        }
> 
> And this has the same issue as the first version.  It should be
> 
> 	op = SIZE_MEMOP(size) | (big_endian ? MO_BE : MO_LE);
> 
> and everything should work.  If it doesn't (and indeed it doesn't :)) it
> means you have bugs somewhere else.

As I mentioned against patch 9, which also touches this area, it should be
using the MemOp that is already passed in to this function instead of building
a new one from scratch.

But, yes, any failure in that would mean bugs somewhere else.  ;-)


r~

