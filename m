Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ABEC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E7B20644
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vV7GIoWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E7B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVwdS-0002uv-Fd
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:20:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVwbD-0001FN-Vr
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVwbD-0000Cp-6f
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:18:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVwbD-0000B6-1h
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:18:27 -0400
Received: by mail-oi1-x241.google.com with SMTP id u64so1714949oib.1
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hAvC/D45/2uiZwixvpVR6548hrJnES/2dn1S4Qr1tKE=;
	b=vV7GIoWpxZ+RM/bfeppS2/msDA948tLxicUx4BfSlrGj03ufM9dAsvAZn5ussZt782
	YOe9NbAQZNzNaZqS384OpFsoR/qvj1XK7QJp52GOkVpXvwJP9lCzeHoRTP19AXaTDVRy
	ApOJR1TiLtEJ8ltGKZfKfxLwqj+oF6cYPOszJKzExPrSCJTivVEmpzyp4L31vnOUvU7D
	Q0zHUUWXHIR5xONv8GSd3PvY85rrqbecQs/YQQPTyFpBQBBRj8qyXbZ7/4Id2Jbphrip
	UKRcc+se1o1R3ERVY6DTvQUzwh6yhyQ5bUqv2rMfVzD/C7MLgU0melKgx/sUQVJ5VMBk
	DSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hAvC/D45/2uiZwixvpVR6548hrJnES/2dn1S4Qr1tKE=;
	b=hQe/T2AgH/NoYIgREpjcXI1AUwBGn160Kms8o/6tfMItmNVk8mFYtmJrRNd9cC1DKQ
	Yy2a+ZM/RyQwg/LUOGUOdG1MRY+bJP6CMIPsLPunMpWlQtrHTHFGlL462jFNSO2tkc0r
	bEAfUsnqSNmoyOhPcti7vl7z7luNrxSmZ6MlozrViz/74FaEMzuBb2INIgyfz7P3x8v8
	BEUl+lbfO+2S2ah71wKEw28mPKbQoGMlvpd5Yfg2yo3z4rRGSju73dLH96373iXdKnPK
	u0xozfo/w/lVkMneS7bEQHT2a1X590c9zwtP3Dj8cCbjXdsUuzdbi0sDSeAQGchlaC/J
	ATlw==
X-Gm-Message-State: APjAAAWh8lFnOeNHdw++j7x4ch6rS/wtzPzWDUJjqG1MmR3IMiZiH9t0
	kBWEidht7ayZ9j7yX2Y0tn5wnQ==
X-Google-Smtp-Source: APXvYqwoWDeJ/LanYWAW4w+OAPI+mATU9AlXkq57MrmCzklCQ2RXfy52Qy8p1Rs/64HNsFAtFFlFgQ==
X-Received: by 2002:aca:4883:: with SMTP id v125mr6041112oia.76.1559128702919; 
	Wed, 29 May 2019 04:18:22 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	d204sm6493780oif.3.2019.05.29.04.18.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:18:21 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190529072726.7875-1-david@redhat.com>
	<20190529072726.7875-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <486e1998-0c28-cca8-6c80-4064eb2a8b8a@linaro.org>
Date: Wed, 29 May 2019 06:18:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529072726.7875-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 1/2] s390x: Align vector registers to 16
 bytes
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 2:27 AM, David Hildenbrand wrote:
> 11e2bfef7990 ("tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store")
> revealed that the vregs are not aligned to 16 bytes. Align them to
> 16 bytes, to avoid segfault'ing on x86.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

