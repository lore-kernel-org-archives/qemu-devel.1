Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B819CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 16:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE23920869
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 16:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyirwtuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE23920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLrxT-0000xQ-V5
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 12:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLrwW-0000Gz-G0
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 12:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLrwV-0003d5-D3
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 12:51:04 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:38294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLrwU-0003cP-Uj
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 12:51:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id h195so5731268pfe.5
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FxDFqE3eG+O7GtEVvkolZdOkFCN/7fVr/VO3XBoBZn8=;
 b=YyirwtuBPyg1e/y/hKcNhqPBF8c9c+joPHINpZFv0kmE1fV8HxCONY5EZBlMo14UPv
 G/oxcawuON8meLk7MsLJUu9JWj06N+tB8Dk+aQHdtjhQIzCjkP6FOsvVKqE5aRgkEHjg
 7xOuj7wjmobVjrb2jtDbuMO5jg+ThiZB68pS29NOQbX80sqDCiqketw2CqC2TXAQHLST
 dlkxpEIFTydA+eJF98At0yttTh3PD2rlyg3+N2as9NB66kjYgjz13FH/yEFch9nFFd2U
 9WrDmwJ6UFrxpwZJexH9E0j+iKFwXVAtSurlKfgInnSInYa3J0nd7L501JcOf+nBDmOS
 Rydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FxDFqE3eG+O7GtEVvkolZdOkFCN/7fVr/VO3XBoBZn8=;
 b=fnkRUWG+DJZ6KOeL+PnChE5ATb7rFEV8vN6uvq40tAmv30EmgM11hVZEgKzUjBTvct
 4SF1aRmE0J2L3dVPNivLV089NSElztFQN0e1Xrx61tdTXBHNx6LxyzxTepfXkXvESPbE
 tuTkMBIOtn5h/U6/Cqa5aIZxnvqkouHke1BIgRxScGGTX/DD3+yV+NFmeYQjaTojSvsd
 HgtxTvhRqFgpP6k+JqM9B7yowx0a+eHBxwDivjoflkW2s/jECzDcMjk8uL+T8rbHlvU4
 YoORko0/PRL71JrqJ0+mh0A92xyPambF9a/nJOchBnLGn7MTXY4KMp24U2u+/wdQsAVC
 Zlqw==
X-Gm-Message-State: APjAAAUs1Ug+iQPZGxmMDGXKy06pIXd/PY6EwYHVbDCppy448yiqnjNA
 Hp9PSfxAGUNwOx8pfgxIxkTlhw==
X-Google-Smtp-Source: APXvYqwNKzgpRNCEdWbd7arSsVFj9HchCFHcPXq8AlEUHd5pRvrbZ/MOkgwtqzlIE+Yaddd0GpzHQQ==
X-Received: by 2002:a63:ef57:: with SMTP id c23mr16181401pgk.436.1571503861406; 
 Sat, 19 Oct 2019 09:51:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f128sm10494778pfg.143.2019.10.19.09.50.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Oct 2019 09:51:00 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] hw/arm/bcm2836: Create VideoCore address space
 in the SoC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191017225800.6946-1-f4bug@amsat.org>
 <20191017225800.6946-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <09a2fc8b-9ea2-84a2-bb88-39cf72334c4e@linaro.org>
Date: Sat, 19 Oct 2019 09:50:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017225800.6946-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 3:57 PM, Philippe Mathieu-Daudé wrote:
> +        static const char *alias_name[] = {
> +            NULL, "cached-coherent", "cached", "uncached"
> +        };

While respinning,

  static const char * const alias_name[]

r~

