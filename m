Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C81DC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1D024125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRerFzyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1D024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46tA-00041g-17
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j46qh-0008OH-AT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j46qg-0006gj-BC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:39:55 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j46qg-0006g2-4f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:39:54 -0500
Received: by mail-pj1-x1042.google.com with SMTP id m7so826449pjs.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=njsTuUEpaWvTTSk1tiT4WBz4P0CJRsdNPQsRYS7w/8I=;
 b=SRerFzyW0KXsHFEhD1lYBPGwVw7d70igPoEXQNKuB4tPQ4Zz9bcPlkxfoTOGHbD4rP
 VV3giuBWdtaBLmaiMGNvO/fLN0mlMHtYmYNRWlyIT2rV0YcH6vScBHjtvA0/DsdTIBQo
 HXI8o/1NOgU+341xEOjHg9rWBy7NPdFh/+6Bxge3XkNOSxJaJh3sSODY1pEQexAN9i8k
 hDGJzA8eAKO3nDWvoH3Z4mbFBdDfVE+4lheXDU4UwHc6RgIYtwYYnVTdKaTXw4ryQYWc
 AduoIuVYMZzDw3ARRT7IsWhXfA3LqApLV+x3iKzza+meFJoZwWT+Gb5fL+9Q+5dSLA39
 Nqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=njsTuUEpaWvTTSk1tiT4WBz4P0CJRsdNPQsRYS7w/8I=;
 b=rTJREMEOT2Yf6GOqusltIpVAS4WO10q4My6dc8C3NOpp1f5vT2XI1xsZFB78fHdM4I
 2Qw4YQS5JBtMmdATjPfiwlSxNpM0kFipFR4tqQKnN00cFqymx0y+RHWGTkmcgcHuk1t8
 vaZbVbhzCS0iN3qTFVzToYZW4LGZXAedYRJay0SoOnyDb4KveVr+ZBj2W6QpR9CY0m+s
 lq6hqaIMvm0iATbbCntjY0ZsHpnGeBd5EHJbyxY/iZS+/515cBwkr2/JfqHXUw28Ygd5
 Md8HCjvjppEX8iTPSWlfBQJfazmUTIyVXDly8bEwE+a5Hp8L0dwMzBHiWvwrJY/3TUKr
 jOqA==
X-Gm-Message-State: APjAAAX7Zll39+eoes772G9oAvcsM+5nmwQ0xGvK2jeuHidyi3rxE8Rv
 qS3RA66S4Lo9Ak/zE1E7V4e1yg==
X-Google-Smtp-Source: APXvYqy2Jax9UiCl1s8hOzBtnVMhLoUEyfUaJZYKra7be3MHKeXarNdIx7MNc84vy4szk++ZV1qGmw==
X-Received: by 2002:a17:90a:1e63:: with SMTP id
 w90mr3953276pjw.36.1582047592779; 
 Tue, 18 Feb 2020 09:39:52 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 ep2sm3951243pjb.31.2020.02.18.09.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:39:52 -0800 (PST)
Subject: Re: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200218132023.22936-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d668ee65-ffbc-0305-8256-b84751d209bd@linaro.org>
Date: Tue, 18 Feb 2020 09:39:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218132023.22936-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 5:20 AM, Philippe Mathieu-Daudé wrote:
> This commit was produced with the included Coccinelle script
> scripts/coccinelle/as-rw-const.patch.
> 
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Based-on: <20200218112457.22712-1-peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

