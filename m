Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0644DC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849A8221F0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRfZIVYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849A8221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGs8b-0003EO-L1
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 19:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGs7o-0002dB-54
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:06:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGs7m-00030n-Ij
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:06:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id n14so8416322pff.6
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q6UI/uig/DjMYrDQe7bZi1jIz9GyIxgfBVebcZrBLKE=;
 b=IRfZIVYpfhwXrXY83LwDJnzj13kSRidn3WBASVQEaFT3QmaNQL7Nqiwj7S42cC4Hb4
 2APTfs3x869ZIYbamBAMT17l0iPbUnn8r216QVqIYKR4pEtZYFz+h7KKss0f4AYH/aHc
 m6UjNOpPZiNrVysnQAI9zUhpFTd/SM+G8Z32UFp0Zx7SO77h7ZPyWq8iq62jhO9jOg7V
 HIrnGhb5s94V2++UL+PxlhnBmfW9Z04TwI1UEOkU34qCR/lyoxvDPI4OIH9JQsJ5wil6
 yyZZQ7abHcoi3OTjOWgAjTiuJeIURJT4RSl5yI8FQ+SXtZYCMLNcB0wSy2ua3Pjw0dX7
 IpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q6UI/uig/DjMYrDQe7bZi1jIz9GyIxgfBVebcZrBLKE=;
 b=URqmr/IAQiXfcNmSOxQgQlUXbwyMVvZMw5DjsOHkBfeJKebA1omE33b05LDAy6ztAo
 JvcDaQcNmRC1MYL94xpvyTvhA/GoE07K5r5gaaR7JMM+fPBodPG8yxqv+RM/g08cWyig
 PmnAHxnfB6Fe4lw9UfLN1vSCGwli8pBG+DHWXsEjB+6d3CqSv6hk+Hd4Xtw0puM+T+/u
 p4N+UNtqvERVijfhMfg5wc3W2tD0jMFeGNcAxVrJnSx/9zlQwAS5u7SxqSpsmiVgoMei
 Pyl2uFSBXbLDp+MJGEzTw902HojN5o1mgH95HIka1igt9r4qm3kDojnE8CK59Cvo1fej
 GbPw==
X-Gm-Message-State: AOAM532BRoXkoVcmBC+GOipg+IoBebBwHrmDM79xUf9Lc02zi2qy494I
 MKQKXeQMSsoG4ouUMXr129FwcQ==
X-Google-Smtp-Source: ABdhPJzoy8yeEZxu7fqso2+B3MTS44euBW/vovfAT/SUNId2aL3JDBzEVzRN5hSHn2OAq94f/8dy6A==
X-Received: by 2002:a62:178d:0:b029:13e:d13d:a0f8 with SMTP id
 135-20020a62178d0000b029013ed13da0f8mr4157273pfx.20.1599865593081; 
 Fri, 11 Sep 2020 16:06:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l1sm3206401pfc.164.2020.09.11.16.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 16:06:32 -0700 (PDT)
Subject: Re: [PATCH 1/7] hw/char/serial: Assert serial_ioport_read/write
 offset fits 8 bytes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200907015535.827885-1-f4bug@amsat.org>
 <20200907015535.827885-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e24b1258-f631-05bf-233a-baa592502d74@linaro.org>
Date: Fri, 11 Sep 2020 16:06:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907015535.827885-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/20 6:55 PM, Philippe Mathieu-Daudé wrote:
> The serial device has 8 registers, each 8-bit. The MemoryRegionOps
> 'serial_io_ops' is initialized with max_access_size=1, and all
> memory_region_init_io() callers correctly set the region size to
> 8 bytes:
> - serial_io_realize
> - serial_isa_realizefn
> - serial_pci_realize
> - multi_serial_pci_realize
> 
> It is safe to assert the offset argument of serial_ioport_read()
> and serial_ioport_write() is always less than 8.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/char/serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


