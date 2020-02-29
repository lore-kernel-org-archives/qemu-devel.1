Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37609C3F2D4
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 04:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EAE246AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 04:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9JoycDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EAE246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7u6b-000250-65
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 23:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7u62-0001dc-Tc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7u62-0002X4-1N
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:51:26 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7u61-0002Wb-RK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 23:51:25 -0500
Received: by mail-pg1-x542.google.com with SMTP id d9so2575242pgu.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 20:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b1vgtRm+0Z2pErhaY4iZcDmXb5sTzG44YMqccXpT2Qc=;
 b=p9JoycDfIepjzSdo3v9WID3IEFYIReKpmvZRn+mlxITtEMa/lQpCnB5F30xOnjjV8j
 CfCkjUrLNDuB7JVJ5h4g/H97CwP1slRAPWeRyFTHxftY+SLu84FYhyXwVngKpvm9jjUd
 vABhZ+klvVslWoCtbtWszhp6RGZZuqWEUcuaVflUffgIvRXXG/5dWEwDw+l6XK3xt18R
 pHwuCggp7J/UJJC54jeaSoUwCBW1ni3EbH1N+lZUkquzCAntIA5HLpfO0BbLfUGqBjx9
 mpEaXQDamx8EcjGQK1/oj01kEYy9dP8oR+hAgYwB8eqT2jCO9c+vWANIEg5s/QdrzwwE
 DqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b1vgtRm+0Z2pErhaY4iZcDmXb5sTzG44YMqccXpT2Qc=;
 b=klI60a5x3MKuybC0P0TAv4tLdDi/uAo7IJRQLjfKzMvmkEJEpifqNfZ47Ti1VRaANG
 LiMINEnSlb8VwkeijuPl7nOvP6DXxABmoFgTidhTiu/IKPOovoHI4OpQay88MT7axR5f
 WI24QCm52q/BtnYVhB6l9xs+o+IEUb0WEdBtPI8bv8uuBP74ipHetZGWSAaf+Oal1+Xb
 cwj99RofERAhYMl4fpK0HS6kjczPJ0p/vQanTIObh4XYBkoN7W5ZUvGfD65bSl9tYyOB
 i1807mghL9A8gc6j8PPFuZCkRg/QUBr8jLnkgH0SOi7Zn4RF8w1IkuBhfFm3P0z4U7mM
 xPKw==
X-Gm-Message-State: APjAAAWDiTW31GlOdi6qIujck7fdqoh7qRfz/bqSW1bU1GEk8c1PRbRn
 TlwkDBs4V6K6pBmOtQ5SDmpxSg==
X-Google-Smtp-Source: APXvYqyBcLe3LKEnh7SELb64hzrpEEQLOldLcXPrXwUuwo+RHekfXhih1zo7uEqdsNvI6h9zXg6VNw==
X-Received: by 2002:a63:30c4:: with SMTP id w187mr8310779pgw.239.1582951884594; 
 Fri, 28 Feb 2020 20:51:24 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c18sm11654662pgw.17.2020.02.28.20.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 20:51:23 -0800 (PST)
Subject: Re: [PATCH v3 03/21] linux-user, hppa: add syscall table generation
 support
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200225121553.2191597-1-laurent@vivier.eu>
 <20200225121553.2191597-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d458456e-de24-e461-15f8-3343cd6034de@linaro.org>
Date: Fri, 28 Feb 2020 20:51:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225121553.2191597-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 4:15 AM, Laurent Vivier wrote:
>    hppa)
>      mttcg="yes"
> +    TARGET_SYSTBL_ABI=common,64

We only support hppa32.   We don't even emulate a 64-bit cpu.

Of course... I wasn't even aware that linux had any support for a 64-bit
userland for hppa, which was one of the reasons why I hadn't bothered doing the
cpu -- no easy way to test.


r~

