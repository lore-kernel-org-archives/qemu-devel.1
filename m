Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D5AC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D60F20673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqZ9NC9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D60F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoW8-0008Hw-MP
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCnhZ-0002Cg-E2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCnhX-0006WM-Os
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCnhX-0006Vc-Ee
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id v4so1679129pff.6
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dcF8WTJf1FdsqtK7JaRa15A8rHmVQlOZFjgElD0eE3c=;
 b=zqZ9NC9Xc38c9xYG5BzIoDuGSLSc4NTCD5wmcJ3syAEOSesf3jVbkM/BJ5L59GpUVD
 iZxWFpsPUSeSzAYCAQ1jd32kwZqyRJoO6tbveb5FroftgIytq4snqmC1+b5HaYbAvzsp
 L/nOo9Key5QodpZc/1Hhys1uetQYgCg264dPHDAzdWgfJpdaQY9Iz+oz0jUj9b5+mCPu
 otUS/45nd6+EA2s1eyEMxsANeSeZiEcRRI8ri/nqpaXUFsO3aw/QzgiqXAJmY0OuG0Oz
 t/1W8DajLrBOC6ZXsvPje2NO5JONEfE01hCRhKR5HfjVmIcmRRwEDVGhQIc8+ptKbt4/
 5hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dcF8WTJf1FdsqtK7JaRa15A8rHmVQlOZFjgElD0eE3c=;
 b=rC7ioGkct4rpRyjwb83ySyYfl3lWhIPglX4DwhLRKpdsXkrIr/DxTxhW4t7tkr10k+
 ParUR7TAWjNOsQM3tM9LwUgquOa0myCqZdtRwo6cpw3OjNxIMw3ZNKUzoi0BnAZQEKHM
 fdJ8hX6JDRCMIT4M3stTvIltRVjHAf3/NCYyVdrGF+A7ZLNMPFRTASR7JBJ1cRsaVj7G
 15Lf5zHnK7MM3YtpPNkBT8e+3fTSw7cp3RxK50sNAGumVw5mxi6Q8eK6NmiEgSGIiu14
 kr0RGOv+54k8sxL+AaaIG8eD882vKbJ742AW1TRj7IGGnZ+U6ONDzNzxirv6JuLOUQN0
 Zjmw==
X-Gm-Message-State: APjAAAXiTKiOrNmpCwaWyiFi5ReBzb+2NmHlKNmBfgmmIgdxGU9I58dQ
 Gtr1oX6OOdXNJhK4KnAeiGxutg==
X-Google-Smtp-Source: APXvYqxkYF/neM1b7MxNLc4sqqTjzltzXLWjA1tFjKhep/c+/a0LY9L6s9z0GgZDd1FHhwsTbYn3vw==
X-Received: by 2002:a62:e916:: with SMTP id j22mr2866488pfh.210.1569342606374; 
 Tue, 24 Sep 2019 09:30:06 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id q204sm5751112pfq.176.2019.09.24.09.30.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 09:30:05 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 2/4] Memory: Enable writeback for given
 memory region
To: Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org
References: <20190910095610.4546-1-beata.michalska@linaro.org>
 <20190910095610.4546-3-beata.michalska@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e5e66d9c-16ee-a700-7608-69ec19c32b47@linaro.org>
Date: Tue, 24 Sep 2019 09:30:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910095610.4546-3-beata.michalska@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 2:56 AM, Beata Michalska wrote:
> +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length);
> +
> +/* Clear whole block of mem */
> +#define qemu_ram_block_writeback(rb)    \
> +    qemu_ram_writeback(rb, 0, rb->used_length)
> +

Inline function, with its typechecking, is preferred.


r~

